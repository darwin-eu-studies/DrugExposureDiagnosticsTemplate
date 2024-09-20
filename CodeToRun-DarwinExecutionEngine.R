# This script is used as the entry point when using the Darwin Execution Engine
print(paste("working directory:", getwd()))

# get parameters and create connection details ----
# These environment variables are pass in by the Darwin Execution Engine
dbms   <- Sys.getenv("DBMS_TYPE")
checkmate::assertChoice(dbms, choices = c("postgresql", "redshift", "sql server", "snowflake", "spark"))

connectionString <- Sys.getenv("CONNECTION_STRING")
user   <- Sys.getenv("DBMS_USERNAME")
password <- Sys.getenv("DBMS_PASSWORD")
server <- Sys.getenv("DBMS_SERVER")
dbname <- Sys.getenv("DBMS_NAME")
port <- Sys.getenv("DBMS_PORT")
databaseId <- Sys.getenv("DATA_SOURCE_NAME")

if (port == "") port <- NULL

cdmVersion <- Sys.getenv("CDM_VERSION")
catalog <- Sys.getenv("DBMS_CATALOG")
cdmDatabaseSchema <- Sys.getenv("CDM_SCHEMA")
cohortDatabaseSchema <- Sys.getenv("RESULT_SCHEMA")

if (nchar(catalog) >= 1) {
  cdmDatabaseSchema <- paste(catalog, cdmDatabaseSchema, sep = ".")
  cohortDatabaseSchema <- paste(catalog, cohortDatabaseSchema, sep = ".")
}

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
nPersons <- cdm$person %>%
  dplyr::tally() %>%
  dplyr::pull(n)

print(paste(nPersons, "persons in the cdm database"))
DatabaseConnector::disconnect(connection)

# setup output folder
outputDir <- "/results"

if (!file.exists(outputDir)) {
  dir.create(outputDir, recursive = TRUE)
}

source(here::here("runDrugExposureDiagnostics.R"))

# To view the shiny app run the following code
# DrugExposureDiagnostics::viewResults(dataFolder = outputDir)

