# This script is used as the entry point when using the Darwin Execution Engine
print(paste("working directory:", getwd()))

# Read properties file
props <- read.properties("run.properties")

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
writeDatabaseSchema <- Sys.getenv("RESULT_SCHEMA")

if (nchar(catalog) >= 1) {
  cdmDatabaseSchema <- paste(catalog, cdmDatabaseSchema, sep = ".")
  writeDatabaseSchema <- paste(catalog, writeDatabaseSchema, sep = ".")
}

# fill in the ingredient concept ids
ingredients <- as.numeric(unlist(strsplit(props$ingredients, ",")))

# connection setup
if (dbms == 'postgresql') {
  con <- DBI::dbConnect(RPostgres::Postgres(),
                        host = server,
                        dbname = dbname,
                        user = user,
                        password = password,
                        bigint = "integer")
} else {
  con <- DBI::dbConnect(DatabaseConnectorDriver(),
                        dbms = dbms,
                        host = server,
                        dbname = dbname,
                        user = user,
                        password = password,
                        bigint = "integer")
}

# set the minimum counts: results with counts below this value will be obscured
minCellCount <- 5

cdm <- CDMConnector::cdm_from_con(con,
                                  cdm_schema = cdmDatabaseSchema,
                                  write_schema = writeDatabaseSchema,
                                  .soft_validation = TRUE)
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

