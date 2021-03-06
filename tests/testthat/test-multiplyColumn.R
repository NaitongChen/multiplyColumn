test_that("proper inputs produces expected result", {
  # creates sample data frame and expected output
  num <- c(1:10)
  string <- c("one", "two", "three", "four", "five",
              "six", "seven", "eight", "nine", "ten")
  df_test <- data.frame(num, string)
  df_test_expect <- df_test
  df_test_expect <- cbind(df_test_expect, df_test_expect$num * 5)
  colnames(df_test_expect)[3] <- "5*num"

  expect_equal(multiplyColumn(df_test, "num", 5)[[1]], df_test_expect)
})

test_that("the newly created column is still numeric", {
  # creates new column by multiplying the pop column by 0.001
  new_df <- multiplyColumn(gapminder::gapminder, "pop", 0.001)[[1]]
  expect_true(is.numeric(new_df$"0.001*pop"))
})

test_that("funciton catches errors in the input format", {
  expect_error(multiplyColumn(c("string", "string"), "column", 2), "The input parameter df is character rather than a data frame.")
  expect_error(multiplyColumn(gapminder::gapminder, "year", "string"), "The input factor needs to be numeric instead of character")
})
