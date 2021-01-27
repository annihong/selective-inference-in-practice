## Introduction to Data snooping/cherry picking and references to literature mentioning the dangers

## Recommendations and consequences:

(Select 3-4 most used recommendations from textbooks/papers)
- Each subsection contains references to textbooks/papers making that (or a similar) recommendation.
- Then show with a real/simulated dataset what is the consequence of such a recommendation on inference.
- We might also present the consequence as the sample size increases; this we need to discuss much later.
- Then mention what are the remedies in the literature if one wants to follow such a recommendation.
- Maybe also apply the remedy after using the recommendation and show the consequence for inference is now fixed.

### practice 1
The use of stepwise regression in inference:  
    - Individual and Organizational Characteristics Associated With Workplace Bullying of School Nurses in Virginia  
    - Clergy Use of Suicide Prevention Competencies  
    - Variables Associated With Communicative Participation After Head and Neck Cancer  
### practice 2
Lasso and post-selection inference  
    - Identification of Modifiable Social and Behavioral Factors Associated With Childhood Cognitive Performance  
(Maybe also includes PCA in here)  
### practice 3 
Using Residual diagnostics for model selection  
- log transformation  
    - transformation for linearity
    - transformation for normality
    - applied to X vs y, or both
    - when is it ok to find $\lambda$ that minimizes RSS?     
- curvature assessment and adding polynomial terms   
### practice 4 
Data removal
    - removing variables with high correlation (0.7/0.8 seems to be the threshold people use)  
    - outlier removal using cooks distance


## Discussion section

## Paper Collection (with datasets):
### Tobacco smoke exposure is an independent predictor of vitamin D deficiency in US children: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6175516/
- multiple two sample t-tests (what is the difference between two sample t-test versus hypothesis testing on the parameters?)
- multiple logistic regression, flexibilities in variable cut off (turning cont var into factors)
    - However, in a separate regression analysis (Table not shown), when tobacco smoke exposure was categorized into the 3 groups of no exposure, second hand smoker, and active smoker, tobacco smoke exposure was only predictive of vitamin D deficiency when passive smokers (cotinine level of 0.05–10 ng/mL) were compared to their unexposed counterparts (cotinine levels <0.05 ng/mL); (OR = 1.5, 95% CI 1.18–1.89). In contrast, there was no significant difference between the active smoking group (cotinine levels >10 ng/mL) as compared to those unexposed (OR = 1.14; 95% CI = 0.53–2.48), and the age* cotinine interaction was also non-significant.
- no diagnostics, no idea how correct the logistic model is   

### **LASSO:** Multimodality neuroimaging brain-age in UK biobank: relationship to biomedical, lifestyle, and cognitive factors
- https://www-sciencedirect-com.proxy.library.cmu.edu/science/article/pii/S0197458020301056#ec1
- does not have data
- lasso and bootstrap inference 
- "Another benefit here is the use of LASSO regression with bootstrapping, combining the strength of LASSO for identifying important features for prediction (by shrinking uninformative variables to zero) with the robustness of bootstrapping, which overcomes the limitation of using LASSO with highly correlated predictor variables."

### Engaging proactive control: Influences of diverse language experiences using insights from machine learning.
- downloaded but no data
- removal of outliers, linear mixed effect, LASSO

### Data-driven discovery of mid-pregnancy immune markers associated with maternal lifetime stress: results from an urban pre-birth cohort
- no access to the data nor article
- use LASSO and then OLS
- https://pubmed.ncbi.nlm.nih.gov/31664889/

### **Other**:  
Psychologically Informed Implementations of Sugary-Drink Portion Limits 
- https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5535080/
- uses logistic regression and chi sq test for inference 
- dataset: http://rosmarus.refsmmat.com/datasets/datasets/sugary-drinks/
- question: is the inference in valid here? How could you tell? it relies on the logistic model being correct. Well-specified??




## Database collections
### ICPSR: https://www-icpsr-umich-edu.proxy.library.cmu.edu/web/ICPSR/search/publications?start=0&COLLECTION=DATA&ARCHIVE=ICPSR&REF_TYPE_FACET=Journal%20Article&sort=score%20desc%2CYEAR_PUB_DATE%20desc%2CAUTHORS_SORT%20asc&rows=50&q=psychology
- a database but you can search for publications that the database has the data for  
    - https://www-icpsr-umich-edu.proxy.library.cmu.edu/web/pages/   

### Web of science : http://apps.webofknowledge.com.proxy.library.cmu.edu/full_record.do?product=WOS&search_mode=GeneralSearch&qid=2&SID=6Ev6FWnVWV5dFzMPsHt&page=1&doc=10
- directly search for articles that have associated data

### EBSCO resaerch database through CMU 
- http://web.a.ebscohost.com.proxy.library.cmu.edu/ehost/resultsadvanced?vid=6&sid=9e8d1cc7-8d52-4edd-88e6-2903962ab94c%40sessionmgr4007&bquery=lasso+regression&bdata=JmRiPXBzeWgmdHlwZT0xJnNlYXJjaE1vZGU9QW5kJnNpdGU9ZWhvc3QtbGl2ZSZzY29wZT1zaXRl

### jstor searching keywords in the abstract:
- https://www-jstor-org.proxy.library.cmu.edu/action/doAdvancedSearch?dc.psychology-discipline=on&dc.publichealth-discipline=on&dc.sociology-discipline=on&group=none&q0=regression&q1=&q2=&q3=&q4=&q5=&q6=&ed=2015&pt=&isbn=&f0=ab&c1=AND&f1=all&c2=AND&f2=all&c3=AND&f3=all&c4=AND&f4=all&c5=AND&f5=all&c6=AND&f6=all&acc=on&la=&Query=%28ab%3A%28regression%29%29+AND+disc%3A%28psychology-discipline+OR+publichealth-discipline+OR+sociology-discipline%29

### UMMS research database:
- https://escholarship.umassmed.edu/datasets/index.html

### ERIC education research database
- https://eric.ed.gov/?q=regression&ff1=subGender+Differences

## Data sources
### GSS: 
https://www.norc.org/Research/Projects/Pages/general-social-survey.aspx

### UC Irvine Machine Learning Repository  
https://archive.ics.uci.edu/ml/index.php


## Remedies for post selection inference
- Bootstrap variance
- sandwich variance
- sample splitting (train vs "test")
- derive RSS for stepwise regression under the null by permuting all the data points


# References  
## Multiple testing:  

- [Best (but oft-forgotten) practices: the multiple problems of multiplicity—whether and how to correct for many statistical tests](https://academic.oup.com/ajcn/article/102/4/721/4564678?login=true)
    
## Textbooks  
-  **Statistical Models: Theory and Practice, David Freedman**
    - This is David Freedman's book. He is very good and has a good discussion in Section 5.8 about data snooping. He also has some references to textbooks and papers.  
-  **Regression Modeling Strategies, Frank E. Harrell, Jr.**
    - popular in bio-stats

## Stepwise Regression
- [Musculoskeletal Complaints Among 11-Year-Old Children and Associated Factors: The PIAMA Birth Cohort Study](https://academic.oup.com/aje/article/174/8/877/156314?searchresult=1#1307423) 
- [Correlates of Circulating 25-Hydroxyvitamin D: Cohort Consortium Vitamin D Pooling Project of Rarer Cancers](https://academic.oup.com/aje/article/172/1/21/83122?searchresult=1#623567)
    - >A backward stepwise procedure was used, allowing only variables with a P value less than or equal to 0.10 for at least 1 category to remain in the model, while retaining age, sex, cohort, and season.
- [Propensity Score–Based Methods in Comparative Effectiveness Research on Coronary Artery Disease](https://academic.oup.com/aje/article/187/5/1064/3964396?searchresult=1#116331295)  
    - >Of the 48 studies, 15 did not report information about variable selection for the propensity score model (Table 1). Of the remaining 33 studies, 26 used a prespecified set of variables; 5 of these 26 reported using stepwise selection to determine whether to include product or nonlinear terms in the model. The remaining 7 studies, including 1 study that explicitly considered product terms, selected variables on the basis of statistical criteria for the association of covariates with treatment status (including backward or forward stepwise selection and significance testing of univariate associations). 
    - **QUESTION:** *model selection for propensity score? How does that bias inference?*
- [Derivation and Validation of a Prediction Rule for Estimating Advanced Colorectal Neoplasm Risk in Average-Risk Chinese](https://academic.oup.com/aje/article/175/6/584/84193?searchresult=1#86213523)
    - use of univariate and stepwise variable selection
    - use bootstrap for validation

- [Sunlight and Other Determinants of Circulating 25-Hydroxyvitamin D Levels in Black and White Participants in a Nationwide US Study](https://academic.oup.com/aje/article/177/2/180/163929?searchresult=1#86217613)
    - >Backwards stepwise linear regression analysis was used to select determinants in a random sample of two thirds of the participants (n = 1,000, model construction sample) and within sex, race, and season subgroups. 
    - **QUESTION**: *use random sample for variable selection but use the whole dataset for inference?*

- [Relationships between Cholesterol, Apolipoprotein E Polymorphism and Dementia: A Cross-Sectional Analysis from the PAQUID Study, Neuroepidemiology (2000)](https://www.karger.com/Article/Abstract/26249)
    - cited by transformation remedy paper
    - >All the variables significantly associated with dementia in univariate analyses (p < 0.05) were retained as explanatory variables in the multivariate analysis. A stepwise logistic regression model was used to estimate the odds ratios of the association between cholesterol and its fractions, and dementia as the dependent variable, adjusting for the potential confounders cited above

## Transformations
- [Correction of the significance level when attempting multiple transformations of an explanatory variable in generalized linear models](https://link.springer.com/article/10.1186/1471-2288-13-75)
    - Ways to correct multiple comparison in finding data transformation 

- [Log-transformation and its implications for data analysis](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4120293/)
    - Talks about different ways where log transform fall short of it's intention (make distributions more normal and reduce variability), and how it often makes interpretation and inference hard for the original dataset. 

- [Hedonic housing prices and the demand for clean air](https://www.sciencedirect.com/science/article/abs/pii/0095069678900062?via%3Dihub)
    -  > Comparing models with either median value of owner-occupied homes (MV) or Log( MV) as the dependent variable, we found that the semilog version provided a slightly better fit. Using Log( MV) as the dependent variable, 
    - > we concentrated on estimating a nonlinear term in NOX; i.e., we included NOXp in the equation, where p is an unknown parameter. The statistical fit in the equation was best when p was set equal to 2.  The exponent was estimated by performing a grid search over alternative parameter values for p in the term NOX*‘-l/( p - 1). The value for p was estimated by a grid search. 
- [A new approach to the Box–Cox transformation](https://www.frontiersin.org/articles/10.3389/fams.2015.00012/full#B37)

-[The Importance of Nonlinear Transformations Use in Medical Data Analysis](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5970282/)
-[Analysis of the effects of (de)regulation on housing prices in Spain 1977–2019](https://www-emerald-com.cmu.idm.oclc.org/insight/content/doi/10.1108/JES-01-2020-0008/full/html)  
>The Shapiro–Wilk tests of the IPP (Statistical = 0.959; p-value = 0.000) and IRP (0.946; p-value = 0.000) variables indicate nonnormality and therefore the absence of all the assumptions inherent to this distribution. The Box–Cox transformation proposes a value of λ of 0.215 and 0.612 for the indices of housing owned and rented, respectively.
    - transform y for normality
- [Determining the optimal number and location of cutoff points with application to data of cervical cancer](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0176231#abstract0) 
    - minimal p procedure for selecting location and number of cut off points
    - possible data 
    - only for survival analysis and logistic regression
    - use validation set but doesn't really make sense 
    > First, the AIC value for one cut was 503.6, and for two, 491.1, favoring the latter. Second, as shown in Table 5, the odds ratio (OR), when two cutoffs were placed, of group 3 over group 1 (OR = 19.67) was much bigger than the OR of group 2 over group 1 (OR = 4.125), also suggesting that three risk groups (two cutoffs) was more appropriate than two (one cutoff). Subsequent calculations, on the training cohort that contained randomly selected 497 patients, with both the likelihood ratio test and the AUC test, put the two cutoff points at 0.32 and 0.97 (Table 5), with the former being close to 1/3, a signal for risk in clinical guidelines [11], and the latter close to 1, the fraction of complete penetration. Validation was performed with a testing cohort of 300 patients (Table 5). Thus patients with an invasion fraction less than 0.32 were at a low risk of LVSI, those between 0.32 and 0.97, medium risk, and those higher than 0.97, high risk. This finding may be of clinical importance.

- [Finding Optimal Cut-points for Continuous Covariates with Binary and Time-to-Event Outcomes](https://www.mayo.edu/research/documents/biostat-79pdf/doc-10027230)
    - pretty comprehensive review on what people do and how to correct for p-value inflation

## General topics in reproducibility
- [Reproducibility and Replicability in Science (2019)](https://www.nap.edu/read/25303/chapter/2) 
- [Arun job talk: Valid Post-selection Inference: Why and How](https://arun-kuchibhotla.github.io/assets/others/JobTalk_covariate_selection_only.pdf)

## Other
- [The effect of decay and lexical uncertainty on processing long-distance dependencies in reading](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7750004/) 
    - has data, Baysian


                                                                                                                                                              