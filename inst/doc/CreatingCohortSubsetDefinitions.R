## ----setup, include=FALSE-----------------------------------------------------
options(width = 80)
knitr::opts_chunk$set(
  cache = FALSE,
  comment = "#>",
  error = FALSE
)
someFolder <- tempdir()
packageRoot <- tempdir()
library(CohortGenerator)

## ----echo=TRUE, results='hide', error=FALSE, warning=FALSE, message=FALSE-----
cohortDefinitionSet <- getCohortDefinitionSet(
  settingsFileName = "testdata/name/Cohorts.csv",
  jsonFolder = "testdata/name/cohorts",
  sqlFolder = "testdata/name/sql/sql_server",
  cohortFileNameFormat = "%s",
  cohortFileNameValue = c("cohortName"),
  packageName = "CohortGenerator",
  verbose = FALSE
)

cohortDefinitionSet$cohortId <- cohortDefinitionSet$cohortId + 1778210 # Match the cohort Ids taken from Atlas
cohortIds <- cohortDefinitionSet$cohortId
cohortDefinitionSet$atlasId <- cohortDefinitionSet$cohortId
cohortDefinitionSet$logicDescription <- ""

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
# Example, we want to have a HTN cohort that starts any time prior to the index start
# and the HTN cohort ends any time after the index start
subsetDef <- createCohortSubsetDefinition(
  name = "Patients in cohort cohort 1778213 with 365 days prior observation",
  definitionId = 1,
  subsetOperators = list(
    # here we are saying 'first subset to only those patients in cohort 1778213'
    createCohortSubset(
      name = "Subset to patients in cohort 1778213",
      # Note that this can be set to any id - if the
      # cohort is empty or doesn't exist this will not error
      cohortIds = 1778213,
      cohortCombinationOperator = "any",
      negate = FALSE,
      startWindow = createSubsetCohortWindow(
        startDay = -9999,
        endDay = 0,
        targetAnchor = "cohortStart"
      ),
      endWindow = createSubsetCohortWindow(
        startDay = 0,
        endDay = 9999,
        targetAnchor = "cohortStart"
      )
    ),

    # Next, subset to only those with 365 days of prior observation
    createLimitSubset(
      name = "Observation of at least 365 days prior",
      priorTime = 365,
      followUpTime = 0,
      limitTo = "all"
    )
  )
)

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE----------------
subsetOperations2 <- subsetDef$subsetOperators

# subset to those between aged 18 an 64
subsetOperations2[[3]] <-
  createDemographicSubset(
    name = "18 - 65",
    ageMin = 18,
    ageMax = 64
  )

subsetDef2 <- createCohortSubsetDefinition(
  name = "Patients in cohort 1778213 with 365 days prior obs, aged 18 - 64",
  definitionId = 2,
  subsetOperators = subsetOperations2
)

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
cohortDefinitionSet <- cohortDefinitionSet |>
  addCohortSubsetDefinition(subsetDef)

knitr::kable(cohortDefinitionSet[, names(cohortDefinitionSet)[which(!names(cohortDefinitionSet) %in% c("json", "sql"))]])

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
cohortDefinitionSet <- cohortDefinitionSet |>
  addCohortSubsetDefinition(subsetDef2, targetCohortIds = 1778212)

knitr::kable(cohortDefinitionSet[, names(cohortDefinitionSet)[which(!names(cohortDefinitionSet) %in% c("json", "sql"))]])

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
writeLines(c(
  paste("Cohort Id:", cohortDefinitionSet$cohortId[1]),
  paste("Name", cohortDefinitionSet$cohortName[1])
))

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
writeLines(c(
  paste("Cohort Id:", cohortDefinitionSet$cohortId[4]),
  paste("Subset Parent Id:", cohortDefinitionSet$subsetParent[4]),
  paste("Name", cohortDefinitionSet$cohortName[4])
))

## ----results='hide', error=FALSE, warning=FALSE, message=FALSE, eval = FALSE----
#  connectionDetails <- Eunomia::getEunomiaConnectionDetails()
#  createCohortTables(
#    connectionDetails = connectionDetails,
#    cohortDatabaseSchema = "main",
#    cohortTableNames = getCohortTableNames("my_cohort")
#  )
#  # ### As subsets are a big side effect we need to be clear what was generated and have good naming conventions
#  generatedCohorts <- generateCohortSet(
#    connectionDetails = connectionDetails,
#    cdmDatabaseSchema = "main",
#    cohortDatabaseSchema = "main",
#    cohortTableNames = getCohortTableNames("my_cohort"),
#    cohortDefinitionSet = cohortDefinitionSet,
#    incremental = TRUE,
#    incrementalFolder = file.path(someFolder, "RecordKeeping")
#  )

## ----eval=FALSE---------------------------------------------------------------
#  saveCohortDefinitionSet(cohortDefinitionSet,
#    subsetJsonFolder = "<path_to_my_subset_definition>"
#  )

## ----eval=FALSE---------------------------------------------------------------
#  cohortDefinitionSet <- getCohortDefinitionSet(
#    subsetJsonFolder = "<path_to_my_subset_definition>"
#  )

## ----results='hide', eval=FALSE-----------------------------------------------
#  jsonDefinition <- subsetDef$toJSON()

## ----results='hide', eval=FALSE-----------------------------------------------
#  # Save to a file
#  ParallelLogger::saveSettingsToJson(subsetDef$toList(), "subsetDefinition1.json")

