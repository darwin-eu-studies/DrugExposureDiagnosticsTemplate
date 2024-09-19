# 1. Open this project in RStudio and restore the R environment
renv::restore()

# 2. Edit the variables below to create a connection and run DrugExposureDiagnostics

# The databaseId is a short (<= 20 characters)
databaseId <- "YOUR_DATABASE_ID"

# fill in the ingredient concept ids
ingredients <- c()

# setup your connection
con <- DBI::dbConnect()

# The database schema where the observational data in CDM is located
cdmDatabaseSchema <- ""

# The database schema where tables can be instantiated
writeDatabaseSchema <- ""

# set the minimum counts: results with counts below this value will be obscured
minCellCount <- 5

cdm <- CDMConnector::cdm_from_con(con,
                                  cdm_schema = cdmDatabaseSchema,
                                  write_schema = writeDatabaseSchema)

# A folder on the local file system to store results
outputDir <- here::here(paste("p3-c3-007-results-", databaseId))

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

# Review and return the csv files in the output folder

# To view the shiny app run the following code

# DrugExposureDiagnostics::viewResults(dataFolder = outputDir)


