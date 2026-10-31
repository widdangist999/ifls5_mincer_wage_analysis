# IFLS5 Mincer Wage Analysis Using Stata

Returns to education, work experience, and urban–rural and gender income differences in Indonesia, estimated with the Mincer wage equation on IFLS5 (2014) data.

> Academic research project for a university final examination (UAS). Unpublished.

## Table of Contents

- [Overview](#overview)
- [Research Objectives](#research-objectives)
- [Dataset](#dataset)
- [Econometric Model](#econometric-model)
- [Project Workflow](#project-workflow)
- [Results](#results)
- [Limitations](#limitations)
- [Repository Structure](#repository-structure)
- [How to Use](#how-to-use)
- [Project Information](#project-information)
- [Connect](#connect)

---

## Overview

This project examines the relationship between educational attainment, potential work experience, and individual income in Indonesia using the **Mincer wage equation**. It estimates the association between years of schooling and income, compares urban and rural workers, and explores gender-based income disparities.

## Research Objectives

1. Examine the relationship between educational attainment and individual income.
2. Analyze the relationship between potential work experience and income.
3. Compare estimated returns to education between urban and rural areas.
4. Examine gender-based income differences across urban and rural areas.

## Dataset

| Item | Description |
|---|---|
| Dataset | Indonesia Family Life Survey, wave 5 (IFLS5) |
| Survey year | 2014 |
| Data structure | Cross-sectional |
| Total observations | 3,989 |
| Urban observations | 2,377 |
| Rural observations | 1,612 |

IFLS5 source files used:

| File | Content |
|---|---|
| `b3a_cov.dta` | Individual demographic characteristics |
| `b3a_tk2.dta` | Income-related information |
| `b3a_dl1.dta` | Educational attainment |
| `bk_sc1.dta` | Household location information |

> **Note:** Raw IFLS5 datasets are not included in this repository. Obtain them through the official IFLS data access procedures.

### Variables

| Variable | Description | Type |
|---|---|---|
| `lnpendapatan` | Natural log of monthly income (not adjusted for working hours) | Continuous |
| `schooling` | Years of schooling | Continuous (years) |
| `experience` | Potential experience = age − years of schooling − 6 | Continuous (years) |
| `experience2` | Squared potential experience | Continuous |
| `gender` | 1 = male, 0 = female | Dummy |
| `urban` | 1 = urban, 0 = rural | Dummy |

## Econometric Model

The baseline specification follows the Mincer wage equation:

$$
\ln(Y_i) = \beta_0 + \beta_1 S_i + \beta_2 EXP_i + \beta_3 EXP_i^2 + \beta_4 GENDER_i + \beta_5 URBAN_i + \epsilon_i
$$

where $Y_i$ is monthly income, $S_i$ is years of schooling, $EXP_i$ is potential experience, $GENDER_i$ is the gender indicator, $URBAN_i$ is the urban residence indicator, and $\epsilon_i$ is the error term.

Estimation: OLS with heteroskedasticity-robust standard errors (`vce(robust)`), run on the full sample and separately on urban and rural subsamples (the `URBAN` term is dropped in the split models).

## Project Workflow

1. **Data preparation**: select relevant variables from multiple datasets; identify missing and invalid observations.
2. **Cleaning and integration**: handle missing and invalid values; log-transform income; merge individual- and household-level data using identification variables.
3. **Variable construction**: years of schooling, potential experience, squared experience, urban and gender indicators.
4. **Estimation**: baseline Mincer equation by OLS with robust standard errors; separate urban and rural estimations.
5. **Diagnostics**: Variance Inflation Factor (VIF), residual distribution, skewness–kurtosis test (`sktest`).

## Results

### Regression estimates

Dependent variable: `lnpendapatan`. Robust standard errors. Significance: \*\*\* p<0.01, \*\* p<0.05, \* p<0.1.

| Variable | Full sample | Urban | Rural |
|---|---:|---:|---:|
| schooling | 0.0140\*\*\* | 0.0145\*\*\* | 0.0143\*\* |
| experience | 0.0196\*\*\* | 0.0192\*\*\* | 0.0195\*\*\* |
| experience² | −0.000372\*\*\* | −0.000376\*\*\* | −0.000347\*\*\* |
| urban | 0.1256\*\*\* | — | — |
| gender | 0.2975\*\*\* | 0.2565\*\*\* | 0.3584\*\*\* |
| constant | 12.3627\*\*\* | 12.5131\*\*\* | 12.3155\*\*\* |
| Observations | 3,989 | 2,377 | 1,612 |
| R-squared | 0.0578 | 0.0462 | 0.0667 |

### Key findings

**1. Education and income.** Schooling has a positive, statistically significant association with income. An additional year of schooling is associated with roughly **1.45% higher income in urban areas** and **1.43% in rural areas**. The urban–rural difference is not statistically significant under an approximate coefficient comparison.

**2. Work experience.** Experience is positive and squared experience is negative, indicating a concave (inverted-U) income profile. Estimated income peaks:

| Sample | Peak (years of experience) |
|---|---:|
| Full | 26.3 |
| Urban | 25.5 |
| Rural | 28.0 |

**3. Urban–rural income gap.** In the full sample, urban workers earn about **13.4% more** than rural workers, conditional on the other variables (coefficient 0.1256; exact conversion).

**4. Gender income differences.** The estimated male income advantage is larger in rural areas (exact log-to-percentage conversion):

| Sample | Coefficient | Male advantage |
|---|---:|---:|
| Urban | 0.2565 | ≈ 29.2% |
| Rural | 0.3584 | ≈ 43.1% |

An approximate comparison of the two coefficients indicates a statistically significant difference at the 5% level.

> **Important:** These are conditional income differences, not direct evidence of wage discrimination.

### Model performance

All models are jointly significant (F-test, p < 0.001), but R-squared is low (0.046–0.067). Many determinants of income (occupation, industry, working hours, ability, family background) are not captured by the included variables.

## Limitations

1. **Association, not causality.** OLS estimates do not identify a causal effect of education on income.
2. **Omitted variables.** Occupation, industry, working hours, ability, and family background are not fully controlled for.
3. **Potential experience.** Calculated from age and schooling rather than actual labor market experience.
4. **Sample selection.** Only individuals with valid reported income are included.
5. **Income measurement.** Monthly income is not adjusted for working hours, which affects comparisons across workers.
6. **Gender coefficient.** Should not be read as a direct measure of discrimination.

## Repository Structure

```text
ifls5_mincer_wage_analysis/
├── README.md
├── scripts/
│   └── mincer_wage_analysis.do
├── paper/
│   └── research_paper.pdf
└── results/
    ├── regression_results.png
    ├── diagnostic_results.png
    └── interpretation.md
```

## How to Use

1. Obtain access to IFLS5 through the official data access procedures.
2. Download the required source datasets.
3. Clone or download this repository.
4. Open `scripts/mincer_wage_analysis.do` in Stata.
5. Update the directory paths for your local environment.
6. Run the script to reproduce the data preparation and analysis.

> **Note:** Check the education coding and dataset merging procedures against the IFLS5 codebook before reproducing the analysis.

## Project Information

| Item | Detail |
|---|---|
| Project type | Academic coursework / final examination project |
| Research status | Unpublished academic research paper |
| Dataset | Indonesia Family Life Survey (IFLS5), 2014 |
| Tool | Stata |
| Method | OLS with robust standard errors |

## Connect

- **LinkedIn:** [Gist Widdan Anasis](https://www.linkedin.com/in/gist-widdan-anasis-3a0a5b39a/)
- **GitHub:** [widdangist999](https://github.com/widdangist999)
