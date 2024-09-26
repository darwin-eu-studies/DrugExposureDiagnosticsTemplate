library(DrugExposureDiagnostics)
library(dplyr)

## START SETTINGS
# vector of ingredients
ingredientConceptIds <- c(1125315)
# an ingredient can have multiple drug concepts, here you can limit to the drug concepts that you want.
# If NULL, all of them will be taken into account
conceptIds <- NULL
# the checks to be run
checks <- c("missing", "exposureDuration", "type", "route", "sourceConcept", "daysSupply",
            "verbatimEndDate", "dose", "sig", "quantity", "diagnosticsSummary")
# if the output should also be calculated per concept
byConcept <- TRUE
# set the minimum counts: results with counts below this value will be obscured
minCellCount <- 5
## END Settings

# This script is used as the entry point when using the Darwin Execution Engine
print(paste("working directory:", getwd()))

# get parameters and create connection details ----
# These environment variables are pass in by the Darwin Execution Engine
dbms   <- Sys.getenv("DBMS_TYPE")
checkmate::assertChoice(dbms, choices = c("postgresql", "redshift", "sql server", "snowflake", "spark"))

databaseId <- Sys.getenv("DATA_SOURCE_NAME")

# connection setup
cdm <- CDMConnector::cdm_from_environment()

nPersons <- cdm$person %>%
  dplyr::tally() %>%
  dplyr::pull(n)

print(paste(nPersons, "persons in the cdm database"))

# setup output folder
outputDir <- "/results"

if (!file.exists(outputDir)) {
  dir.create(outputDir, recursive = TRUE)
}

source(here::here("runDrugExposureDiagnostics.R"))

# To view the shiny app run the following code
# DrugExposureDiagnostics::viewResults(dataFolder = outputDir)

