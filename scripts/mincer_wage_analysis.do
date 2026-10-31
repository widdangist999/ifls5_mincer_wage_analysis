
/*
===============================================================================
Project: IFLS5 Mincer Wage Analysis
Purpose: Examine the relationship between educational attainment and
         individual income using the Mincer Wage Equation.
Data:    Indonesia Family Life Survey (IFLS5)
Tool:    Stata

Workflow:
    1. Data preparation
    2. Data cleaning
    3. Data integration
    4. Variable construction
    5. OLS regression
    6. Urban-rural comparison
    7. Diagnostic tests

Note:
    IFLS5 raw datasets are not included in this repository.
    Update the directory paths before running this script.
===============================================================================
*/

clear all
set more off
version 15.0

*===============================================================================
* 1. DIRECTORY SETUP
*===============================================================================

global raw "C:\Users\User\OneDrive\Dokumen\IFLS_5\hh14_all_dta"
global output "$raw\hasil_olah_data"

capture mkdir "$output"

*===============================================================================
* 2. DEMOGRAPHIC DATA PREPARATION
* Source: b3a_cov.dta
*===============================================================================

use "$raw\b3a_cov.dta", clear

keep hhid14 pidlink age sex

* Recode gender
recode sex (3=0) (1=1), gen(gender)

* Remove invalid age observations
drop if age >= 998 | missing(age)

keep hhid14 pidlink age gender

* Check individual identifier
duplicates report pidlink

save "$output\temp_cov.dta", replace


*===============================================================================
* 3. INCOME DATA PREPARATION
* Source: b3a_tk2.dta
*===============================================================================

use "$raw\b3a_tk2.dta", clear

keep hhid14 pidlink tk25a1

* Handle invalid income codes
replace tk25a1 = . if tk25a1 >= 999998

* Remove missing and non-positive income
drop if missing(tk25a1) | tk25a1 <= 0

* Log transformation
generate lnpendapatan = ln(tk25a1)

keep hhid14 pidlink tk25a1 lnpendapatan

duplicates report pidlink

save "$output\temp_tk.dta", replace


*===============================================================================
* 4. EDUCATION DATA PREPARATION
* Source: b3a_dl1.dta
*===============================================================================

use "$raw\b3a_dl1.dta", clear

keep hhid14 pidlink dl06 dl07

* Handle invalid and missing education codes
replace dl06 = . if dl06 >= 98
replace dl07 = . if dl07 >= 98

/*
IMPORTANT:
The schooling-year mapping below must be verified against the
IFLS5 questionnaire and codebook.

The mapping should reflect the highest education level and
completed years of schooling, not merely assumed categories.
*/

generate schooling = .

* Original education-level mapping:
* Verify these categories and years using the IFLS5 codebook.

replace schooling = 6  if dl06 == 1
replace schooling = 9  if dl06 == 2
replace schooling = 12 if dl06 == 3
replace schooling = 15 if dl06 == 4
replace schooling = 16 if dl06 == 5
replace schooling = 18 if dl06 == 6
replace schooling = 21 if dl06 == 7

* Keep valid education observations
drop if missing(schooling)

keep hhid14 pidlink dl06 dl07 schooling

duplicates report pidlink

save "$output\temp_dl.dta", replace


*===============================================================================
* 5. HOUSEHOLD LOCATION DATA PREPARATION
* Source: bk_sc1.dta
*===============================================================================

use "$raw\bk_sc1.dta", clear

keep hhid14 sc05

* Inspect household identifier duplicates
duplicates report hhid14

/*
Check whether sc05 is consistent within each household
before retaining one observation per household.
*/

bysort hhid14 (sc05): generate location_min = sc05[1]
bysort hhid14 (sc05): generate location_max = sc05[_N]

count if location_min != location_max
display "Households with inconsistent location codes: " r(N)

drop location_min location_max

* Retain one observation per household after checking consistency
duplicates drop hhid14, force

* Recode location
recode sc05 (2=0) (1=1), gen(urban)

keep hhid14 urban

save "$output\temp_htrack.dta", replace


*===============================================================================
* 6. DATA INTEGRATION
*===============================================================================

* Start with demographic data
use "$output\temp_cov.dta", clear

isid pidlink

* Merge education data
merge 1:1 pidlink using "$output\temp_dl.dta"

tabulate _merge
keep if _merge == 3
drop _merge

isid pidlink

* Merge income data
merge 1:1 pidlink using "$output\temp_tk.dta"

tabulate _merge
keep if _merge == 3
drop _merge

isid pidlink

* Merge household location
merge m:1 hhid14 using "$output\temp_htrack.dta"

tabulate _merge
keep if _merge == 3
drop _merge

* Check final dataset
describe
summarize

save "$output\Data_Final_Mincer.dta", replace


*===============================================================================
* 7. VARIABLE CONSTRUCTION
*===============================================================================

use "$output\Data_Final_Mincer.dta", clear

* Potential labor market experience
generate experience = age - schooling - 6

* Squared experience
generate experience2 = experience^2

* Education and urban interaction term
generate urban_pend = urban * schooling

* Descriptive statistics
summarize lnpendapatan schooling experience experience2 age gender urban

tabulate urban
tabulate gender

* Inspect potentially invalid experience values
count if experience < 0
display "Observations with negative experience: " r(N)

save "$output\Data_Final_Mincer.dta", replace


*===============================================================================
* 8. BASELINE MINCER WAGE REGRESSION
*===============================================================================

regress lnpendapatan schooling experience experience2 urban gender, vce(robust)

estimates store model_full

* Save regression output
capture log close
log using "$output\regression_results.txt", text replace

regress lnpendapatan schooling experience experience2 urban gender, vce(robust)
estimates store model_full

*===============================================================================
* 9. URBAN-RURAL REGRESSION
*===============================================================================

* Urban sample
regress lnpendapatan schooling experience experience2 gender ///
    if urban == 1, vce(robust)

estimates store model_urban

* Rural sample
regress lnpendapatan schooling experience experience2 gender ///
    if urban == 0, vce(robust)

estimates store model_rural

log close


*===============================================================================
* 10. DIAGNOSTIC TESTS
*===============================================================================

* Urban model diagnostics
regress lnpendapatan schooling experience experience2 gender ///
    if urban == 1

* Multicollinearity
vif

* Residual analysis
predict residual_urban if e(sample), residual

histogram residual_urban, normal ///
    title("Urban Model: Residual Distribution")

sktest residual_urban


* Rural model diagnostics
regress lnpendapatan schooling experience experience2 gender ///
    if urban == 0

* Multicollinearity
vif

* Residual analysis
predict residual_rural if e(sample), residual

histogram residual_rural, normal ///
    title("Rural Model: Residual Distribution")

sktest residual_rural


*===============================================================================
* 11. END OF ANALYSIS
*===============================================================================

display "IFLS5 Mincer Wage Analysis completed."
display "Check the output directory for results."

===============================================================================
