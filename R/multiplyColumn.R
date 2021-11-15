#' @title mutates a numeric column by multiplying its
#' entries by a given numeric factor.
#'
#' @description This function takes a data frame, a column name
#' (whose entries are numeric), and a numeric value. It creates
#' a new column that multiplies the entries of the specified
#' column with the input factor and returns the data frame with
#' this new column, as well as a histogram of the new column.
#'
#' @param df short for data frame, refers to the input data frame.
#' @param colname short for column name, refers to the name of
#' the column that you would like to mutate.
#' @param fac short for factor, refers to the input numeric factor.
#'
#' @return the data frame with the new column as well as a
#' histogram of the new column.
#' @examples
#' df = data.frame(matrix(rnorm(4),
#'                 ncol=2, nrow=2,
#'                 dimnames=list(NULL, c("x1", "x2"))))
#' multiplyColumn(df, "x1", 0.5)
#' multiplyColumn(df, "x2", 3)
#' @export
multiplyColumn <- function(df, colname, fac) {

  # error checking
  if(!is.data.frame(df)){
    stop("The input parameter df is ", class(df), " rather than a data frame.")
  } else if(!(colname %in% colnames(df))){
    stop(colname, "is not a column in the input data frame.")
  } else if(!is.numeric(df[[colname]])) {
    stop("The specified column needs to be numeric instead of ", class(df[[colname]]))
  } else if(sum(is.na(df[[colname]])) > 0) {
    stop("The specified column contains NA values")
  } else if(!is.numeric(fac)) {
    stop("The input factor needs to be numeric instead of ", class(fac))
  }

  # create new column
  new_colname <- paste(colname, fac, sep = "")
  tib <- dplyr::mutate(df, !!new_colname := !!as.name(colname) * fac)
  # generate histogram of the new column
  hist <- ggplot2::ggplot(tib, ggplot2::aes(x = !!as.name(new_colname))) + ggplot2::geom_histogram()
  # prepare return list
  ret <- list(tib, hist)
  return(ret)
}
