1. ### Meeting (Jan 28th 2022)
    ### Pre-meeting notes:
    - submit an abstract for the poster session? JSM 2022? Due Feb 1st
    - use R package to organize data analysis workflow, helps with reproducibility
    - forgot why minimizing RSS does not hurt inference
    - set seed for any random results for reproducibility
    - what should  you expect under global null? it shouldn't be 0.05 right? 
        - look up the calculation of FDR under global null
    -robust variance lead to higher FDR when x_i ~ lnorm but agrees with conventional variance when x_i ~ norm
        - in what situation is robust variance more conservative than conv var?
    - still unclear why the min p procedure did not create problems for the boston data, think through the experiments I did. 

    ### *Task list for the week*: 
    - [x] write up an abstract and send to arun 
    - [ ] share the write up with Arun 
    - [x] re-run the simulation and the organize the code for simple variables selection
        - did the single variable version for log norm vs norm 
    - [x] experiment with increasing sample size to test if robust and standard error agrees with each other 
        - does not seem like it made a difference!
        - [ ] read the reference on robust variance
    - [x] min p base variable dichotomization
        - does not work for single val but it does show 
        - does r-sq based selection for y (log or not) invalidated the results?
        - train and test do differ, FDR: 0.579 vs 0.449, how do you calculate FDR under global null?
    ### *Proposed tasks for next week*
    1. 
    2.
    3.
    ---
    #### Work day Feb 17th (2022)
    - [ ] write-up from the last meeting. Summarizing why robust FDR does not approach standard FDR for log normal distributions as the sample size increases
        - [ ] read up on the reference for sandwich variance
    - [ ] write up min p procedure for transformation in the boston dataset in latex, possibly increasing the sample size.
    - ? what is the relationship between selecting the single variable more vs. the total fdr?
    - min p procedure for dicohotomizing variables
    - should we try bootstrap variance instead of sandwich variance?
    - is there a difference between min-p and min RSS
        - no when you are doing data transformation instead of variable selection
    - what kind of optimal transformation works? goodness of fit? graphical diagnostics? max number of observations in each group?

    #### Post meeting notes
    - model as approximation I section 13: when x is heavy tailed, robust variance under cover, show the graph when x ~ normal and x ~ log normal and comment on when should you use robust vs conventional and choose max of both is the conservative option
    - for the paper add more references of paper without replicating their data 
    - conclusion:
        - different methods and how some do or don't inflate the FDR rate give example
        - sample splitting how to do it but also in what cases it fails
        - 
    ---
    #### Work day (March 18th 2022)
    - [ ] edit the variable selection section and add more references to research that does variable selection
    - [ ] complete the variable transformation section on the boston dataset and cite the sandwich variance paper on rubust error
    - [ ] min p procedure for dicohotomizing variables on real or simulated data
    - [ ] write up the remedy/conclusion section 
    - [ ] a section on sandwich variance

    questions:
    - box cox transforming for normality? 
    `From here, absorbing {\displaystyle \operatorname {GM} (y)^{2(\lambda -1)}}\operatorname {GM} (y)^{2(\lambda -1)} into the expression for {\displaystyle {\hat {\sigma }}^{2}}{\hat {\sigma }}^{2} produces an expression that establishes that minimizing the sum of squares of residuals from {\displaystyle y_{i}^{(\lambda )}}y_{i}^{(\lambda )}is equivalent to maximizing the sum of the normal log likelihood of deviations from {\displaystyle (y^{\lambda }-1)/\lambda }(y^{\lambda }-1)/\lambda  and the log of the Jacobian of the transformation.` wikipidea

    - variable selection problem as a multiple testing problem, calculate the expected fdr rate
    https://cemsiis.meduniwien.ac.at/fileadmin/user_upload/_imported/fileadmin/msi_akim/CeMSIIS/KB/volltexte/Heinzl_Tempfer_2001_CSDA.pdf
    [Model selection facts from fiction](https://www.jstor.org/stable/3533623?seq=1) discusses universal valid inference vs point-wise inference. Read and think about if there is an example for variable transformation. 
    - continue to look for an example of min-p cut point procedure
    - RSS vs R^2, RSS is equivalent to MLE but R^2 is for fit so it's the same as min-p procedure  
    1. ### Meeting (Jan 28th 2022)
    ### Pre-meeting notes:

    ### *Task list for the week*: 

    ### *Proposed tasks for next week*
    1. 
    2.
    3.
    ---
    #### Work day (2022)
    ---
    #### Work day (2022)