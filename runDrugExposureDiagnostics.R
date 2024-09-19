library(DrugExposureDiagnostics)

resultList <- DrugExposureDiagnostics::executeChecks(cdm = cdm,
                                                    ingredients = ingredients,
                                                    subsetToConceptId = NULL,
                                                    checks = c("missing", "exposureDuration", "type", "route", "sourceConcept", "daysSupply",
                                                               "verbatimEndDate", "dose", "sig", "quantity", "diagnosticsSummary"),
                                                    minCellCount = minCellCount,
                                                    sample = 10000,
                                                    tablePrefix = NULL,
                                                    earliestStartDate = "2010-01-01",
                                                    verbose = TRUE,
                                                    byConcept = TRUE)

writeResultToDisk(resultList = resultList,
                  databaseId = databaseId,
                  outputFolder = outputDir)
