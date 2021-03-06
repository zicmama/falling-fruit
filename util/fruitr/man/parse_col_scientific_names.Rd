% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/col.R
\name{parse_col_scientific_names}
\alias{parse_col_scientific_names}
\title{Parse Catalogue of Life (COL) Scientific Names}
\usage{
parse_col_scientific_names(json)
}
\description{
Parse Catalogue of Life (COL) Scientific Names
}
\examples{
id <- get_col_id("Malus domestica")
json <- get_col_page(id)
parse_col_scientific_names(json)
}
\seealso{
Other COL functions: \code{\link{build_col_scientific_name}},
  \code{\link{get_col_id}}, \code{\link{get_col_page}},
  \code{\link{parse_col_common_names}}
}

