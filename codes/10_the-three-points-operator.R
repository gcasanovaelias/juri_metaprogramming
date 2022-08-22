# libraries ---------------------------------------------------------------

library(rlang)
library(tidyverse)

library(vroom)
library(here)

# data --------------------------------------------------------------------

(adult <- vroom(here("outputs", "adult.csv")))

# ... ---------------------------------------------------------------------

# the parameters can be defined (with a name and a default value) or not

# the ... parameter allows the supply of an arbitrary/not-predefined number
# of parameters

# ... allows to keep the function flexible

# the ... parameter does not only allows the supply of a number of parameters
# but also it allows the use of an arbitrary number of expressions

# function to capture the contents of ... and return them as character

# only symbols
(uncover_sym_dots <- function(...) {
  my_syms <- ensyms(...)
  map_chr(my_syms, as_string)
})

uncover_dots(a, B, c)


# expressions
(uncover_expr_dots <- function(...) {
  my_syms <- enexprs(...)
  map_chr(my_syms, expr_text)
})

uncover_expr_dots(a, B<X, c)

# remove user-defined columns

(remove_cols <- function(df, ...) {
  my_syms <- ensyms(...)
  my_cols <- map_chr(my_syms, as_string)
  stopifnot(all(my_cols %in% colnames(df)))
  remaining_cols <- setdiff(colnames(df), my_cols)
  select(df, all_of(remaining_cols))
})

attach(adult)

(df_out <- remove_cols(adult, age, education_dur, education, marital_status,
                       occupation, relationship))

# check user-defined conditions and expressions

(perform_checks <- function(df, ...) {
  my_exprs <- enexprs(...)
  map_lgl(my_exprs, .f = function(my_exprs) {
    nrow(df) == nrow(filter(df, !!my_exprs))
  })
})

perform_checks(adult, age > 0, age < 100, age < 30)
