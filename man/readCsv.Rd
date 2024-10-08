% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CsvHelper.R
\name{readCsv}
\alias{readCsv}
\title{Used to read a .csv file}
\usage{
readCsv(file, warnOnCaseMismatch = TRUE, colTypes = readr::cols())
}
\arguments{
\item{file}{The .csv file to read.}

\item{warnOnCaseMismatch}{When TRUE, raise a warning if column headings
in the .csv are not in snake_case format}

\item{colTypes}{Corresponds to the `col_types` in the `readr::read_csv` function.
  One of `NULL`, a [readr::cols()] specification, or
  a string. See `vignette("readr")` for more details.

   If `NULL`, all column types will be inferred from `guess_max` rows of the
   input, interspersed throughout the file. This is convenient (and fast),
   but not robust. If the guessed types are wrong, you'll need to increase
   `guess_max` or supply the correct types yourself.

   Column specifications created by [list()] or [cols()] must contain
   one column specification for each column.

   Alternatively, you can use a compact string representation where each
   character represents one column:
   - c = character
   - i = integer
   - n = number
   - d = double
   - l = logical
   - f = factor
   - D = date
   - T = date time
   - t = time
   - ? = guess
   - _ or - = skip

   By default, reading a file without a column specification will print a
   message showing what `readr` guessed they were. To remove this message,
   set `show_col_types = FALSE` or set `options(readr.show_col_types = FALSE)`.}
}
\value{
A tibble with the .csv contents
}
\description{
This function is used to centralize the function for reading
.csv files across the HADES ecosystem. This function will automatically
convert from snake_case in the file to camelCase in the data.frame returned
as is the standard described in:
https://ohdsi.github.io/Hades/codeStyle.html#Interfacing_between_R_and_SQL
}
