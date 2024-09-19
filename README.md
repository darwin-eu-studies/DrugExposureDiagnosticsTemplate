# How to use DrugExposureDiagnostics Template

1.  Create a new repo from this template on Github and clone it locally

2.  Replace DrugExposureDiagnostics with {Study ID}-DrugExposureDiagnostics in three places (require for execution engine)

    1.  The name of the folder/repository should be {Study ID}-DrugExposureDiagnostics instead of DrugExposureDiagnostics

    2.  Replace DrugExposureDiagnostics with {Study ID}-DrugExposureDiagnostics in the execution-config.yml file both in the studyId and entrypoint fields. Also replace the StudyTitle field with a descriptive name.

    3.  Rename or recreate the .Rproj file in this repo so that it is also {Study ID}-DrugExposureDiagnostics

4.  Commit your changes and push the updated files to github

# Running the code in RStudio
`
-   Install the latest version of renv

``` r
install.packages("renv")
```

-   Restore the project library

``` r
renv::restore()
```

Edit the variables in the codeToRun.R script below to the correct values for your environment. Execute the script in RStudio.

# Running the code in Execution Engine

-   Install and configure Execution Engine <https://darwin-eu-dev.github.io/execution-engine/install.html>
-   Download the code from Github as a zip file.
-   Rename the zip file to match the folder name in the execution-config.yml file, {Study ID}-DrugExposureDiagnostics
-   Upload the zip file to ExecutionEngine and click submit
