<div align="center">

# 📊 IFLS5 Mincer Wage Analysis Using Stata

### Returns to Education, Work Experience, and Urban–Rural & Gender Income Gaps in Indonesia

[![Stata](https://img.shields.io/badge/Stata-1A5F91?style=for-the-badge&logo=stata&logoColor=white)](https://www.stata.com/)
[![Data](https://img.shields.io/badge/Data-IFLS5_(2014)-2A78D6?style=for-the-badge)](https://www.rand.org/well-being/social-and-behavioral-policy/data/FLS/IFLS.html)
[![Method](https://img.shields.io/badge/Method-OLS_%7C_Robust_SE-6A4C93?style=for-the-badge)](#-econometric-model)
[![Status](https://img.shields.io/badge/Status-Academic_Project-success?style=for-the-badge)](#ℹ️-project-information)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/gist-widdan-anasis-3a0a5b39a/)
[![GitHub](https://img.shields.io/badge/GitHub-widdangist999-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/widdangist999)

*Academic research project for a university final examination (UAS) · Unpublished*

</div>

---

## ✨ Highlights

<div align="center">

| 🎓 Return to Education | 🏙️ Urban Wage Premium | 👩‍💼 Gender Income Gap | 📈 Experience Peak |
|:---:|:---:|:---:|:---:|
| **1.45%** urban<br>**1.43%** rural<br>per extra year of schooling | **+13.4%**<br>urban vs rural<br>*(full sample)* | **29.2%** urban<br>**43.1%** rural<br>male advantage | **25.5** yrs urban<br>**28.0** yrs rural<br>inverted-U profile |

</div>

> [!IMPORTANT]
> Income is **not adjusted for working hours** (unadjusted monthly income). This keeps informal, part-time, and irregular workers in the picture, and it is the main reason the estimated returns to education are lower than studies that standardize wages to full-time equivalents.

---

## 📑 Table of Contents

- [🔎 Overview](#-overview)
- [🎯 Research Objectives](#-research-objectives)
- [🗂️ Dataset](#️-dataset)
- [🧮 Econometric Model](#-econometric-model)
- [🔄 Project Workflow](#-project-workflow)
- [📈 Results](#-results)
- [🖼️ Figures](#️-figures)
- [⚠️ Limitations](#️-limitations)
- [📁 Repository Structure](#-repository-structure)
- [🚀 How to Use](#-how-to-use)
- [ℹ️ Project Information](#ℹ️-project-information)
- [👤 Author](#-author)

---

## 🔎 Overview

This project examines the relationship between educational attainment, potential work experience, and individual income in Indonesia using the **Mincer wage equation**. It estimates the association between years of schooling and income, compares urban and rural workers, and explores gender-based income disparities.

## 🎯 Research Objectives

1. 🎓 Examine the relationship between educational attainment and individual income.
2. ⏳ Analyze the relationship between potential work experience and income.
3. 🏙️ Compare estimated returns to education between urban and rural areas.
4. ⚖️ Examine gender-based income differences across urban and rural areas.

## 🗂️ Dataset

| Item | Description |
|---|---|
| Dataset | Indonesia Family Life Survey, wave 5 (IFLS5) |
| Survey year | 2014 |
| Data structure | Cross-sectional |
| Total observations | **3,989** |
| Urban observations | 2,377 |
| Rural observations | 1,612 |

**IFLS5 source files used**

| File | Content |
|---|---|
| `b3a_cov.dta` | Individual demographic characteristics |
| `b3a_tk2.dta` | Income-related information |
| `b3a_dl1.dta` | Educational attainment |
| `bk_sc1.dta` | Household location information |

> [!NOTE]
> Raw IFLS5 datasets are **not included** in this repository. Obtain them through the official IFLS data access procedures.

**Variables**

| Variable | Description | Type |
|---|---|---|
| `lnpendapatan` | Natural log of monthly income (not adjusted for working hours) | Continuous |
| `schooling` | Years of schooling | Continuous (years) |
| `experience` | Potential experience = age − years of schooling − 6 | Continuous (years) |
| `experience2` | Squared potential experience | Continuous |
| `gender` | 1 = male, 0 = female | Dummy |
| `urban` | 1 = urban, 0 = rural | Dummy |

## 🧮 Econometric Model

The baseline specification follows the Mincer wage equation:

$$
\ln(Y_i) = \beta_0 + \beta_1 S_i + \beta_2 EXP_i + \beta_3 EXP_i^2 + \beta_4 GENDER_i + \beta_5 URBAN_i + \epsilon_i
$$

where $Y_i$ is monthly income, $S_i$ is years of schooling, $EXP_i$ is potential experience, $GENDER_i$ is the gender indicator, $URBAN_i$ is the urban residence indicator, and $\epsilon_i$ is the error term.

**Estimation:** OLS with heteroskedasticity-robust standard errors (`vce(robust)`), run on the full sample and separately on urban and rural subsamples (the `URBAN` term is dropped in the split models).

## 🔄 Project Workflow

```mermaid
flowchart LR
    A[📥 Data Preparation] --> B[🧹 Cleaning & Integration]
    B --> C[🧱 Variable Construction]
    C --> D[📐 OLS Estimation]
    D --> E[🔬 Diagnostics]
```

1. **📥 Data preparation:** select relevant variables from multiple datasets; identify missing and invalid observations.
2. **🧹 Cleaning and integration:** handle missing and invalid values; log-transform income; merge individual- and household-level data using identification variables.
3. **🧱 Variable construction:** years of schooling, potential experience, squared experience, urban and gender indicators.
4. **📐 Estimation:** baseline Mincer equation by OLS with robust standard errors; separate urban and rural estimations.
5. **🔬 Diagnostics:** Variance Inflation Factor (VIF), residual distribution, skewness–kurtosis test (`sktest`).

## 📈 Results

### 📋 Regression estimates

Dependent variable: `lnpendapatan`. Robust standard errors. Significance: \*\*\* p<0.01, \*\* p<0.05, \* p<0.1.

| Variable | Full sample | Urban | Rural |
|---|---:|---:|---:|
| schooling | 0.0140\*\*\* | 0.0145\*\*\* | 0.0143\*\* |
| experience | 0.0196\*\*\* | 0.0192\*\*\* | 0.0195\*\*\* |
| experience² | −0.000372\*\*\* | −0.000376\*\*\* | −0.000347\*\*\* |
| urban | 0.1256\*\*\* | — | — |
| gender | 0.2975\*\*\* | 0.2565\*\*\* | 0.3584\*\*\* |
| constant | 12.3627\*\*\* | 12.5131\*\*\* | 12.3155\*\*\* |
| **Observations** | 3,989 | 2,377 | 1,612 |
| **R-squared** | 0.0578 | 0.0462 | 0.0667 |

### 🔑 Key findings

**1️⃣ Education and income.** Schooling has a positive, statistically significant association with income. An additional year of schooling is associated with roughly **1.45% higher income in urban areas** and **1.43% in rural areas**. The urban–rural difference is not statistically significant under an approximate coefficient comparison.

**2️⃣ Work experience.** Experience is positive and squared experience is negative, indicating a concave (inverted-U) income profile. Estimated income peaks:

| Sample | Peak (years of experience) |
|---|---:|
| Full | 26.3 |
| Urban | 25.5 |
| Rural | 28.0 |

**3️⃣ Urban–rural income gap.** In the full sample, urban workers earn about **13.4% more** than rural workers, conditional on the other variables (coefficient 0.1256; exact conversion).

**4️⃣ Gender income differences.** The estimated male income advantage is larger in rural areas (exact log-to-percentage conversion):

| Sample | Coefficient | Male advantage |
|---|---:|---:|
| 🏙️ Urban | 0.2565 | ≈ 29.2% |
| 🌾 Rural | 0.3584 | ≈ 43.1% |

An approximate comparison of the two coefficients indicates a statistically significant difference at the 5% level.

> [!WARNING]
> These are **conditional income differences**, not direct evidence of wage discrimination.

### 🧪 Model performance

All models are jointly significant (F-test, p < 0.001), but R-squared is low (0.046–0.067). Many determinants of income (occupation, industry, working hours, ability, family background) are not captured by the included variables.

📄 Full coefficient-by-coefficient discussion: [`results/interpretation.md`](results/interpretation.md)

## 🖼️ Figures

<div align="center">
<table>
  <tr>
    <td align="center" width="50%">
      <img src="results/figures/chart1_mincer_curve.png" alt="Experience-earnings curve, urban vs rural" width="100%"><br>
      <sub><b>Experience–earnings curve</b> (urban vs rural)</sub>
    </td>
    <td align="center" width="50%">
      <img src="results/figures/chart2_histogram_lnpendapatan.png" alt="Distribution of ln(income)" width="100%"><br>
      <sub><b>Distribution</b> of ln(income)</sub>
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <img src="results/figures/chart3_scatter_fitted.png" alt="Scatter of experience vs ln(income) with fitted Mincer curve" width="100%"><br>
      <sub><b>Scatter</b> with fitted Mincer curve</sub>
    </td>
    <td align="center" width="50%">
      <img src="results/figures/chart4_mean_income_gender_urban.png" alt="Mean monthly income by gender and region" width="100%"><br>
      <sub><b>Mean monthly income</b> by gender × region</sub>
    </td>
  </tr>
</table>
</div>

## ⚠️ Limitations

1. 🔗 **Association, not causality.** OLS estimates do not identify a causal effect of education on income.
2. 🧩 **Omitted variables.** Occupation, industry, working hours, ability, and family background are not fully controlled for.
3. ⏱️ **Potential experience.** Calculated from age and schooling rather than actual labor market experience.
4. 🎯 **Sample selection.** Only individuals with valid reported income are included.
5. 💰 **Income measurement.** Monthly income is not adjusted for working hours, which affects comparisons across workers.
6. ⚖️ **Gender coefficient.** Should not be read as a direct measure of discrimination.

## 📁 Repository Structure

```text
ifls5_mincer_wage_analysis/
├── 📄 README.md
├── 📂 scripts/
│   └── mincer_wage_analysis.do
├── 📂 paper/
│   └── research_paper.pdf
└── 📂 results/
    ├── interpretation.md
    └── 📂 figures/
        ├── chart1_mincer_curve.png
        ├── chart2_histogram_lnpendapatan.png
        ├── chart3_scatter_fitted.png
        └── chart4_mean_income_gender_urban.png
```

## 🚀 How to Use

1. 🔑 Obtain access to IFLS5 through the official data access procedures.
2. 📥 Download the required source datasets.
3. 📦 Clone or download this repository.
4. 📝 Open `scripts/mincer_wage_analysis.do` in Stata.
5. 🛠️ Update the directory paths for your local environment.
6. ▶️ Run the script to reproduce the data preparation and analysis.

> [!NOTE]
> Check the education coding and dataset merging procedures against the IFLS5 codebook before reproducing the analysis.

## ℹ️ Project Information

| Item | Detail |
|---|---|
| Project type | Academic coursework / final examination project |
| Research status | Unpublished academic research paper |
| Dataset | Indonesia Family Life Survey (IFLS5), 2014 |
| Tool | Stata |
| Method | OLS with robust standard errors |

## 👤 Author

**Gist Widdan Anasis**

- 💼 LinkedIn: [gist-widdan-anasis](https://www.linkedin.com/in/gist-widdan-anasis-3a0a5b39a/)
- 🐙 GitHub: [widdangist999](https://github.com/widdangist999)

<div align="center">

⭐ If you find this project useful, consider giving it a star.

</div>
