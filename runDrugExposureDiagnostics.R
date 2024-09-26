# run diagnostics and write results to disk

resultList <- DrugExposureDiagnostics::executeChecks(cdm = cdm,
                                                    ingredients = ingredientConceptIds,
                                                    subsetToConceptId = conceptIds,
                                                    checks = checks,
                                                    minCellCount = minCellCount,
                                                    sample = 10000,
                                                    tablePrefix = NULL,
                                                    earliestStartDate = "2010-01-01",
                                                    verbose = TRUE,
                                                    byConcept = byConcept)

DrugExposureDiagnostics::writeResultToDisk(resultList = resultList,
                                           databaseId = databaseId,
                                           outputFolder = outputDir)
