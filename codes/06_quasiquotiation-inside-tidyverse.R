# libraries ---------------------------------------------------------------

library(tidyverse)
library(rlang)

library(vroom)
library(here)


# data --------------------------------------------------------------------

(adult <- vroom(here("outputs", "adult.csv")))


# quote-unquote pattern in the tidyverse ----------------------------------

# we want to flexibly execute pull()
pull(adult, education)[1:5]

# the returned column should be provided in variable

#* The quote-unquote pattern is easier to implement in the tidyverse
#* in tidyverse functions unquoting can be done directly without quoting
#* the complete function 

(my_col <- expr(education))
pull(adult, !!my_col)[1:5]

# we don't need to create another quote with the entire expression and neither
# evaluate the expression directly with eval_tidy()

# the pull function does not need to be quoted and no additional line of code
# is necessary for execution


# same approach as outside the tidyverse ----------------------------------

# even though you can use the easier syntax in the tidyverse function it does
# not mean that we cannot use the general approach that we used in base R

(my_col <- expr(education))
(my_expr <- expr(pull(adult, !!my_col)))
eval_tidy(my_expr)[1:5]


# embracing:alternative way of unquoting in tidyverse ---------------------

(my_col <- expr(age))
pull(adult, {{ my_col }})[1:5]

