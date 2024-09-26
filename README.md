# How to use DrugExposureDiagnostics Template

1.  Create a new repo from this template on Github and clone it locally

2.  Fill in the settings in CodeToRun-DarwinExecutionEngine.R at the top

3.  Replace DrugExposureDiagnostics with {Study ID}-DrugExposureDiagnostics in three places (require for execution engine)

    i.  The name of the folder/repository should be {Study ID}-DrugExposureDiagnostics instead of DrugExposureDiagnostics

    ii.  If you are using the Darwin Execution Engine then replace DrugExposureDiagnostics with {Study ID}-DrugExposureDiagnostics in the execution-config.yml file both in the studyId and entrypoint fields. Also replace the StudyTitle field with a descriptive name.

    iii.  Rename or recreate the .Rproj file in this repo so that it is also {Study ID}-DrugExposureDiagnostics

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

# Note on Docker images

This template can be used with Arachne (in Docker mode) or with the Darwin execution engine. Both pull docker images and run the R code inside them. The docker image used for this template is created from the dockerfile [here](https://github.com/darwin-eu/execution-engine/blob/da1679f3c653d21e4becc83087dc04d97f91bf55/execution-engine-runtime/DockerImages/darwin-base/Dockerfile#L1). It is maintained by the darwin project. The dockerfile in this reposity adds a specific set of R packages based on the renv lock file to the darwin base docker image.
