# 1. Open this project in RStudio and restore the R environment
#renv::restore()

library(DrugExposureDiagnostics)
library(CDMConnector)
library(dplyr)
library(DT)
library(shinycssloaders)
library(shinyWidgets)
library(ggplot2)
library(plotly)
library(shinyjs)
library(CohortCharacteristics)

# 2. Edit the variables below to create a connection and run DrugExposureDiagnostics

# The databaseId is a short (<= 20 characters)
databaseId <- "mock"

# fill in the ingredient concept ids
ingredients <- c(1125315)

# set the minimum counts: results with counts below this value will be obscured
minCellCount <- 5

cdm <- DrugExposureDiagnostics:::mockDrugExposure()

# A folder on the local file system to store results
outputDir <- here::here(paste("my-study-results-", databaseId))

# test connection details ----
nPersons <- cdm$person %>%
  dplyr::tally() %>%
  dplyr::pull(n)

print(paste(nPersons, "persons in the cdm database"))

# setup output folder and log -----
if (!file.exists(outputDir)) {
  dir.create(outputDir, recursive = TRUE)
}

source(here::here("runDrugExposureDiagnostics.R"))

# To view the shiny app run the following code
DrugExposureDiagnostics::viewResults(dataFolder = outputDir)


