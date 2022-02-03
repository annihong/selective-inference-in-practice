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
    #### Work day (2022)
    ---
    #### Work day (2022)