% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{melt_by_listcol}
\alias{melt_by_listcol}
\title{Melt Data Table by List Column}
\usage{
melt_by_listcol(dt, column)
}
\description{
Melt Data Table by List Column
}
\examples{
dt <- data.table(label = list(list("a", "b"), list("c")), count = c(1, 2))
melt_by_listcol(dt, "label")
melt_by_listcol(dt, 1)
}
\seealso{
Other helper functions: \code{\link{ch1903_to_wgs84}},
  \code{\link{clean_strings}},
  \code{\link{expand_list_by_split}},
  \code{\link{format_strings}}, \code{\link{is.empty}},
  \code{\link{na.remove}},
  \code{\link{normalize_language}},
  \code{\link{replace_values_in_list}},
  \code{\link{subset_search_results}},
  \code{\link{unique_na}}
}

