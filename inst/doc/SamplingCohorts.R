## ----setup, include=FALSE-----------------------------------------------------
options(width = 80)
knitr::opts_chunk$set(
  cache = FALSE,
  comment = "#>",
  error = FALSE
)
someFolder <- tempdir()
packageRoot <- tempdir()
baseUrl <- "https://api.ohdsi.org/WebAPI"
library(CohortGenerator)

## ----eval = F-----------------------------------------------------------------
#  cds <- getCohortDefinitionSet(...)

## ----eval=F-------------------------------------------------------------------
#  connectionDetails <- Eunomia::getEunomiaConnectionDetails()
#  conn <- DatabaseConnector::connect(connectionDetails = connectionDetails)
#  on.exit(DatabaseConnector::disconnect(conn))
#  
#  
#  cds <- getCohortDefinitionSet(...)
#  cohortTableNames <- getCohortTableNames(cohortTable = "cohort")
#  recordKeepingFolder <- file.path(outputFolder, "RecordKeepingSamples")
#  
#  createCohortTables(
#    connectionDetails = connectionDetails,
#    cohortDatabaseSchema = "main",
#    cohortTableNames = cohortTableNames
#  )
#  
#  generateCohortSet(
#    cohortDefinitionSet = cds,
#    connection = conn,
#    cdmDatabaseSchema = "main",
#    cohortDatabaseSchema = "main",
#    cohortTableNames = cohortTableNames,
#    incremental = TRUE,
#    incrementalFolder = recordKeepingFolder
#  )

## ----eval=F-------------------------------------------------------------------
#  sampledCohortDefinitionSet <- sampleCohortDefinitionSet(
#    cohortDefinitionSet = cds,
#    connection = conn,
#    sampleFraction = 0.33,
#    seed = 64374, # OHDSI
#    cohortDatabaseSchema = "main",
#    cohortTableNames = cohortTableNames,
#    incremental = TRUE,
#    incrementalFolder = recordKeepingFolder
#  )

## ----eval=F-------------------------------------------------------------------
#  # Generate 800 samples of size n
#  sampledCohortDefinitionSet <- sampleCohortDefinitionSet(
#    cohortDefinitionSet = cds,
#    connection = conn,
#    n = 1000,
#    seed = 1:800 * 64374, # OHDSI
#    cohortDatabaseSchema = "main",
#    cohortTableNames = cohortTableNames,
#    incremental = TRUE,
#    incrementalFolder = recordKeepingFolder
#  )

