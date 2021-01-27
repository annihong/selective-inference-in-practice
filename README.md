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
                                                                                                                                                              