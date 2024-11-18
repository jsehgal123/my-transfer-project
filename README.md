# README

This is **solved** dbt repo for interview purpose

Please provide answers for these following questions:
* What are each of the files for?
**We are basically running some of the SQLs specified in the models against different tables.** 

* How to run this project and what results we expect.

**For preprod**
Run script

bash dbt_run_single.sh table_config.yml preprod

Which will execute
dbt run --profiles-dir /data-domain-pipelines \
--project-dir /data-domain-pipelines/my_transfer/preprod \
--target preprod-ca_

**For Prod**
Run script
bash dbt_run_single.sh unified_config.yml prod

Which will execute

dbt run --profiles-dir /data-domain-pipelines \
--project-dir /data-domain-pipelines/my_transfer/prod \
--target prod-ca_

List some of this solution's design problems and compare to dbt projects best practices.


1. Models structure could be further improved and normalised. I see duplicate queries
2. As already mentioned, it is inefficient because it is running dbt command in loop and coould cause compute and memory inefficiency
3. Envrionment specific variables were missing
4. I dont see profiles.yml also but may be not required in this case.

Provide an alternative solution to put everything in one single dbt project that can handle all the environments(targets) and all models.

Requirements:
* because preprod and prod have different models, your solution should be able to handle different models based on the environment

**Yes, I made some changes in the table_config.yaml and add environment key so that we can select the environment**

* we only need to run one 'dbt run' per environment to build all models for that environment

**Yes, the code is doing so. We have optimised the models to support different environment and added support in dbt_project.yml**

* get rid of the dbt_command_loop.sh, preprod_table_config.yml and table_config.yml and provide a much simpler and cleaner solution

**I was not abel to get rid completely but tried to optmised it.**

Provide a new repo containing the new solution's code.  
Provide your analysis and suggestions if there are many ways to achieve the same results.