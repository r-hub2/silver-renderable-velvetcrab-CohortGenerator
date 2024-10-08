% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CohortSample.R
\name{sampleCohortDefinitionSet}
\alias{sampleCohortDefinitionSet}
\title{Sample Cohort Definition Set}
\usage{
sampleCohortDefinitionSet(
  cohortDefinitionSet,
  cohortIds = cohortDefinitionSet$cohortId,
  connectionDetails = NULL,
  connection = NULL,
  tempEmulationSchema = getOption("sqlRenderTempEmulationSchema"),
  cohortDatabaseSchema,
  outputDatabaseSchema = cohortDatabaseSchema,
  cohortTableNames = getCohortTableNames(),
  n = NULL,
  sampleFraction = NULL,
  seed = 64374,
  seedArgs = NULL,
  identifierExpression = "cohortId * 1000 + seed",
  incremental = FALSE,
  incrementalFolder = NULL
)
}
\arguments{
\item{cohortDefinitionSet}{The \code{cohortDefinitionSet} argument must be a data frame with 
the following columns: \describe{
\item{cohortId}{The unique integer identifier of the cohort} 
\item{cohortName}{The cohort's name}
\item{sql}{The OHDSI-SQL used to generate the cohort}}
Optionally, this data frame may contain: \describe{
\item{json}{The Circe JSON representation of the cohort}}}

\item{cohortIds}{Optional subset of cohortIds to generate. By default this function will sample all cohorts}

\item{connectionDetails}{An object of type \code{connectionDetails} as created using the
\code{\link[DatabaseConnector]{createConnectionDetails}} function in the
DatabaseConnector package. Can be left NULL if \code{connection} is
provided.}

\item{connection}{An object of type \code{connection} as created using the
\code{\link[DatabaseConnector]{connect}} function in the
DatabaseConnector package. Can be left NULL if \code{connectionDetails}
is provided, in which case a new connection will be opened at the start
of the function, and closed when the function finishes.}

\item{tempEmulationSchema}{Some database platforms like Oracle and Impala do not truly support
temp tables. To emulate temp tables, provide a schema with write
privileges where temp tables can be created.}

\item{cohortDatabaseSchema}{Schema name where your cohort tables reside. Note that for SQL Server,
this should include both the database and schema name, for example
'scratch.dbo'.}

\item{outputDatabaseSchema}{optional schema to output cohorts to (if different from cohortDatabaseSchema)}

\item{cohortTableNames}{The names of the cohort tables. See \code{\link{getCohortTableNames}}
for more details.}

\item{n}{Sample size. Ignored if sample fraction is set}

\item{sampleFraction}{Fraction of cohort to sample}

\item{seed}{Vector of seeds to give to the R pseudorandom number generator}

\item{seedArgs}{optional arguments to pass to set.seed}

\item{identifierExpression}{Optional string R expression used to compute output cohort id. Can only use variables
cohortId and seed. Default is "cohortId * 1000 + seed", which is substituted and evaluated}

\item{incremental}{Create only cohorts that haven't been created before?}

\item{incrementalFolder}{If \code{incremental = TRUE}, specify a folder where records are
kept of which definition has been executed.}
}
\value{
sampledCohortDefinitionSet - a data.frame like object that contains the resulting identifiers and modified names of cohorts
}
\description{
Create 1 or more sample of size n of a cohort definition set

Subsetted cohorts can be sampled, as with any other subset form.
However, subsetting a sampled cohort is not recommended and not currently supported at this time.
In the case where n > cohort count the entire cohort is copied unmodified

As different databases have different forms of randomness, the random selection is computed in
R, based on the count for each cohort. This is, therefore, db platform independent

Note, this function assumes cohorts have already been generated.

Lifecycle Note: This functionality is considered experimental and not intended for use inside analytic packages
}
