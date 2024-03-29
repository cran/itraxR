% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/itrax_import.r
\name{itrax_import}
\alias{itrax_import}
\title{Import Itrax core-scanner result file}
\usage{
itrax_import(
  filename = "Results.txt",
  depth_top = NA,
  trim_top = 0,
  trim_bottom = 0,
  parameters = "some"
)
}
\arguments{
\item{filename}{defines the name of the datafile to parse}

\item{depth_top}{defines the coring in depth of the top of the core, in mm}

\item{trim_top}{defines the length of any trimming required of data at the top of the core, in mm}

\item{trim_bottom}{defines the length of any trimming required at the bottom of the core, in mm}

\item{parameters}{one of `all` (leave all parameters), `some` (remove some less useful parameters)}
}
\value{
a tibble of the parsed Itrax data
}
\description{
Imports and parses data from a results file created by Q-Spec software, part of the Itrax core scanner.
}
\examples{
itrax_import(
  filename = system.file("extdata",
                         "CD166_19_S1_Results.txt",
                         package = "itraxR",
                         mustWork = TRUE),
  depth_top = 0)

}
