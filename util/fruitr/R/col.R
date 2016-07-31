#' Get Catalogue of Life (COL) ID
#'
#' @family COL functions
#' @export
#' @examples
#' get_col_id("Malus domestica")
get_col_id <- function(search_string) {
  url <- parse_url("http://www.catalogueoflife.org/col/webservice")
  query <- list(format = "json", name = search_string)
  json <- content(GET(url, query = query))
  if (is.list(json) && length(json$results) > 0) {
    return(json$results[[1]]$id)
  }
}

#' Get Catalogue of Life (COL) Page
#'
#' @family COL functions
#' @export
#' @examples
#' id <- get_col_id("Malus domestica")
#' str(get_col_page(id))
get_col_page <- function(id, content_only = TRUE) {
  url <- parse_url("http://www.catalogueoflife.org/col/webservice")
  query <- list(format = "json", response = "full", id = id)
  response <- GET(url, query = query)
  json <- content(response)
  if (length(json$results) > 1) {
    warning(paste0("Multiple page results for ID ", id, ". Only the top result will be returned."))
    json <- json$results[[1]]
  }
  if (length(json$accepted_name) > 0) {
    json <- json$accepted_name
  }
  json <- replace_values_in_list(json, "", NULL)
  if (content_only) {
    return(json)
  } else {
    response$content <- json
    return(response)
  }
}

#' Parse Catalogue of Life (COL) Scientific Names
#'
#' @family COL functions
#' @export
#' @examples
#' id <- get_col_id("Malus domestica")
#' json <- get_col_page(id)
#' parse_col_scientific_names(json)
parse_col_scientific_names <- function(json) {
  canonical_name <- list(list(
    name = build_col_scientific_name(json),
    rank = json$rank,
    preferred = TRUE
  ))
  synonyms <- lapply(json$synonyms, function(synonym) {
    list(
      name = build_col_scientific_name(synonym),
      rank = synonym$rank,
      preferred = FALSE
    )
  })
  return(c(canonical_name, unique(synonyms)))
}

#' Parse Catalogue of Life (COL) Common Names
#'
#' @family COL functions
#' @export
#' @examples
#' id <- get_col_id("Malus domestica")
#' json <- get_col_page(id)
#' parse_col_common_names(json)
parse_col_common_names <- function(json) {
  common_names <- lapply(json$common_names, function(x) {
    list(
      name = x$name,
      language = normalize_language(x$language),
      country = x$country
    )
  })
  return(replace_values_in_list(common_names, NULL, NA))
}

#' Build Catalogue of Life (COL) Scientific Name
#'
#' @family COL functions
#' @examples
#' id <- get_col_id("Malus domestica")
#' json <- get_col_page(id)
#' build_col_scientific_name(json)
#' str(lapply(json$synonyms, build_col_scientific_name))
build_col_scientific_name = function(json) {
  if (is.null(json$genus)) {
    return(trimws(json$name))
  } else {
    return(trimws(with(json, paste(genus, species, infraspecies_marker, infraspecies))))
  }
}