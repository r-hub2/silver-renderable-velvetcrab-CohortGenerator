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

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
cohortDefinitionSet <- getCohortDefinitionSet(
  settingsFileName = "testdata/name/Cohorts.csv",
  jsonFolder = "testdata/name/cohorts",
  sqlFolder = "testdata/name/sql/sql_server",
  cohortFileNameFormat = "%s",
  cohortFileNameValue = c("cohortName"),
  packageName = "CohortGenerator",
  verbose = FALSE
)

cohortIds <- cohortDefinitionSet$cohortId
cohortDefinitionSet$atlasId <- cohortDefinitionSet$cohortId
cohortDefinitionSet$logicDescription <- ""

## -----------------------------------------------------------------------------
names(cohortDefinitionSet)

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
saveCohortDefinitionSet(
  cohortDefinitionSet = cohortDefinitionSet,
  settingsFileName = file.path(
    packageRoot,
    "inst/settings/CohortsToCreate.csv"
  ),
  jsonFolder = file.path(
    packageRoot,
    "inst/cohorts"
  ),
  sqlFolder = file.path(
    packageRoot,
    "inst/sql/sql_server"
  )
)

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
cohortDefinitionSet <- getCohortDefinitionSet(
  settingsFileName = file.path(
    packageRoot, "inst/settings/CohortsToCreate.csv"
  ),
  jsonFolder = file.path(packageRoot, "inst/cohorts"),
  sqlFolder = file.path(packageRoot, "inst/sql/sql_server")
)

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
# Get the Eunomia connection details
connectionDetails <- Eunomia::getEunomiaConnectionDetails()

# First get the cohort table names to use for this generation task
cohortTableNames <- getCohortTableNames(cohortTable = "cg_example")

# Next create the tables on the database
createCohortTables(
  connectionDetails = connectionDetails,
  cohortTableNames = cohortTableNames,
  cohortDatabaseSchema = "main"
)

# Generate the cohort set
cohortsGenerated <- generateCohortSet(
  connectionDetails = connectionDetails,
  cdmDatabaseSchema = "main",
  cohortDatabaseSchema = "main",
  cohortTableNames = cohortTableNames,
  cohortDefinitionSet = cohortDefinitionSet
)

## ----error=FALSE, warning=FALSE-----------------------------------------------
getCohortCounts(
  connectionDetails = connectionDetails,
  cohortDatabaseSchema = "main",
  cohortTable = cohortTableNames$cohortTable
)

## ----eval=TRUE----------------------------------------------------------------
# First construct a cohort definition set: an empty
# data frame with the cohorts to generate
cohortDefinitionSet <- CohortGenerator::createEmptyCohortDefinitionSet()

# Fill the cohort set using  cohorts included in this
# package as an example
cohortJsonFiles <- list.files(path = system.file("testdata/name/cohorts", package = "CohortGenerator"), full.names = TRUE)
for (i in 1:length(cohortJsonFiles)) {
  cohortJsonFileName <- cohortJsonFiles[i]
  cohortName <- tools::file_path_sans_ext(basename(cohortJsonFileName))
  # Here we read in the JSON in order to create the SQL
  # using [CirceR](https://ohdsi.github.io/CirceR/)
  # If you have your JSON and SQL stored differently, you can
  # modify this to read your JSON/SQL files however you require
  cohortJson <- readChar(cohortJsonFileName, file.info(cohortJsonFileName)$size)
  cohortExpression <- CirceR::cohortExpressionFromJson(cohortJson)
  cohortSql <- CirceR::buildCohortQuery(cohortExpression, options = CirceR::createGenerateOptions(generateStats = TRUE))
  cohortDefinitionSet <- rbind(cohortDefinitionSet, data.frame(
    cohortId = i,
    cohortName = cohortName,
    json = cohortJson,
    sql = cohortSql,
    stringsAsFactors = FALSE
  ))
}

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
# First get the cohort table names to use for this generation task
cohortTableNames <- getCohortTableNames(cohortTable = "stats_example")

# Next create the tables on the database
createCohortTables(
  connectionDetails = connectionDetails,
  cohortTableNames = cohortTableNames,
  cohortDatabaseSchema = "main"
)

# We can then generate the cohorts the same way as before and it will use the
# cohort statstics tables to store the results
# Generate the cohort set
generateCohortSet(
  connectionDetails = connectionDetails,
  cdmDatabaseSchema = "main",
  cohortDatabaseSchema = "main",
  cohortTableNames = cohortTableNames,
  cohortDefinitionSet = cohortDefinitionSet
)

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
insertInclusionRuleNames(
  connectionDetails = connectionDetails,
  cohortDefinitionSet = cohortDefinitionSet,
  cohortDatabaseSchema = "main",
  cohortInclusionTable = cohortTableNames$cohortInclusionTable
)

exportCohortStatsTables(
  connectionDetails = connectionDetails,
  cohortDatabaseSchema = "main",
  cohortTableNames = cohortTableNames,
  cohortStatisticsFolder = file.path(someFolder, "InclusionStats")
)

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
dropCohortStatsTables(
  connectionDetails = connectionDetails,
  cohortDatabaseSchema = "main",
  cohortTableNames = cohortTableNames
)

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
# Create a set of tables for this example
cohortTableNames <- getCohortTableNames(cohortTable = "cohort")
createCohortTables(
  connectionDetails = connectionDetails,
  cohortTableNames = cohortTableNames,
  cohortDatabaseSchema = "main",
  incremental = TRUE
)

## -----------------------------------------------------------------------------
createCohortTables(
  connectionDetails = connectionDetails,
  cohortTableNames = cohortTableNames,
  cohortDatabaseSchema = "main",
  incremental = TRUE
)

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
generateCohortSet(
  connectionDetails = connectionDetails,
  cdmDatabaseSchema = "main",
  cohortDatabaseSchema = "main",
  cohortTableNames = cohortTableNames,
  cohortDefinitionSet = cohortDefinitionSet,
  incremental = TRUE,
  incrementalFolder = file.path(someFolder, "RecordKeeping")
)

## -----------------------------------------------------------------------------
generateCohortSet(
  connectionDetails = connectionDetails,
  cdmDatabaseSchema = "main",
  cohortDatabaseSchema = "main",
  cohortTableNames = cohortTableNames,
  cohortDefinitionSet = cohortDefinitionSet,
  incremental = TRUE,
  incrementalFolder = file.path(someFolder, "RecordKeeping")
)

