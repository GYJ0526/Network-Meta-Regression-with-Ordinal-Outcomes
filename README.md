# SAS macro: NMAOrdinal

To run the proposed model under three different scenarios.

# README Document for Using SAS Macro NMAOrdinal

The SAS macro NMAOrdinal is developed for analyzing network meta-regression for ordinal outcomes discussed in Gwon et al. (2020). This macro could be generating rtf file names “RESULT.rtf” only for the primary analysis. The macro NMAOrdinal can be access by including the following lines:

%include NMAOrdinal (macroNMAOrdinal.sas);
%NMAOrdinal (CDdata=, Model=, Amatrix=);

# Inputs for NMAOrdinal

•	CDdata: Dataset with the first six columns, Product (drug name), K (trial ID), TRT (treatment arm), Response (response category), Count (the number of patients), collapsity (the status of collapsing), and additional five columns for covariates (Age, baseline mean CDAI score, publication year, number of male, and percentage of anti-TNF). Note that the variable TRT takes the value of 0 if it is from placebo arm and takes the value 1 to 6 if it is from treatment arm. The values of K should be consecutive integers starting with 1. For instance, if the total number of trials in the CDdata is 10, the values of K should be enumerated as 1, 2, …, and 10. Required.

•	Model: Indicates model number. Note that it takes a value of 1 if it is a proportional odds model without covariates, 2 if it is a proportional odds model with adjustment for covariates, and 3 if it is the proposed ordinal response network meta-regression model. Required.

•	Amatrix: Indicates a choice constant matrix to calculate the Pearson-type residuals for each treatment arm using dimension reduction technique. Note that it is a canonical matrix if the value is 1, other matrix with rank of 2 if the value is 2 or 3. Required.

Note 1: (i) The length of a drug name (Product) is less than 15 characters; (ii) The values of the variable TRT are 0 (Placebo), 1 (Adalimumab), 2 (Certolizumab), 3 (Infliximab), 4 (Natalizumab), 5 (Ustekinumab), and 6 (Vedolizumab); (iii) The values of collapsity are -1 (collapsing on <70 and 70-100 category), 0 (fully observed), 1 (collapsing on 70-100 and >100 no remission), and 2 (collapsing on 70-100, >100 no remission, and remission).

Note 2: No missing values are allowed in all datasets, CDdata1 to CDdata3.  

Note 3: Three different types of Crohn’ datasets are allowed: (i) Crohn1: extreme scenario that all remission comes from the 100 response (Set I); (ii) Crohn2: extreme scenario that all remission comes from the 70 response (Set II); (iii) Crohn3: remission is from both responses at 70 and 100 with equal ratio (Set III). If the entered dataset names are not one of (i) to (iii), the macro will produce an error message and execute.

Note 4: The values of the model number and the choice of a constant matrix A cannot be greater than 3. If the user enters the value >3 in any of the cases, the macro will produce an error message and execute.

# Outputs for NMAOrdinal

The macro automatically generates an rtf file. The rtf file includes five tables and two plots: (i) Parameter estimates; (ii) Model assessment criteria (-2 loglikelihood value, AIC, AICC, and BIC); (iii) Pairwise comparisons without multiplicity adjustments between two treatments; (iv) Pearson residuals and its chi-square test statistics; (v) Pearson residuals plot and P-values plot for goodness-of-fit; and (vi) P-scores for treatment ranking.

# Reference

**Gwon Y**, Mo M, Chen MH, Chi Z, Li J, Xia HA, and Ibrahim JG (2020). Network Meta-Regression for Ordinal Outcomes: Applications in Comparing Crohn’s Disease Treatment. *Statistics in Medicine*, 39(13), 1840-1870.
https://onlinelibrary.wiley.com/doi/10.1002/sim.8518.
