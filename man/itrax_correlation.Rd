% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/itrax_correlation.r
\name{itrax_correlation}
\alias{itrax_correlation}
\title{Calculate a correlation matrix for Itrax result data}
\usage{
itrax_correlation(
  dataframe,
  elementsonly = TRUE,
  zeros = "addone",
  transform = TRUE,
  plot = FALSE
)
}
\arguments{
\item{dataframe}{pass the name of a dataframe parsed using \code{"itrax_import()"} or \code{"itrax_join()"}}

\item{elementsonly}{if TRUE, only chemical elements are included. If FALSE, the data is passed unfiltered, otherwise a character vector of desired variable names can be supplied}

\item{zeros}{if "addone", adds one to all values. If "limit", replaces zero values with 0.001. Otherwise a function can be supplied to remove zero values.}

\item{transform}{binary operator that if TRUE will center-log-transform the data, if FALSE will leave the data untransformed. Otherwise, a function can be supplied to transform the data.}

\item{plot}{set to true if a biplot is required as a side-effect}
}
\value{
a correlation matrix object
}
\description{
Calculates a correlation matrix for Itrax data results including normalisation and visualisation
}
\examples{
itrax_correlation(CD166_19_S1$xrf, plot = TRUE)

}
