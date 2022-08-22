# libraries ---------------------------------------------------------------
library(rlang)
library(tidyverse)
library(vroom)
library(here)

# quasiquotation? ---------------------------------------------------------

# is the action of quoting code + the existence of an unquoting operator (!!)

# unquoting: looking what is inside a quote (following indirect references)


# subset() example --------------------------------------------------------

# R's subset() lets you specify the returned column education by name
(adult <- vroom(here("outputs", "adult.csv")))

subset(adult, relationship == "Other-relative" & age == 90, education)

# How can we reference another column /symbol?? What if you want to provide 
# the returned column in a variable to be flexible??

# quote and unquote pattern -----------------------------------------------

# quoting of the replacement value in a first expression while being unquoted 
# in a second expression (the latter one being evaluated)

(my_column <- expr(education))
(my_expr <- expr(subset(adult,
                        relationship == "Other-relative" & age == 90, 
                        !!my_column)))

eval_tidy(my_expr)

# the !! unquoting-operator forces R to replace my_column by it's 
# referenced expression using !!

# quote and unquote pattern is a useful pattern to solve indirect reference


# function as an expression -----------------------------------------------

# providing the function as an expression gives much more flexibility

(general_paste <- function(expr_paste_fun, text1, text2) {
  my_expr <- enexpr(expr_paste_fun)
  full_expr <- expr((!!my_expr)(text1, text2))
  print(full_expr)
  return(eval_tidy(full_expr))
})

general_paste(expr_paste_fun = paste, text1 = "a", text2 = "b")

