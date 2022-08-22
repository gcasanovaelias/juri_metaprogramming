
library(rlang)

# Metaprogramming: using R code to modify R code
# Tidy eval(uation) is a framework in which we can use metaprogramming in R

(numbers <- c(1:3, NA))

# capture a defused expression
(expression <- expr(sum(numbers)))

# ... evaluate it
eval_tidy(expression)

# add a parameter
expression$na.rm <- TRUE

# replace the current function
expression[[1]] <- expr(prod)

# evaluate the new expression
eval_tidy(expression)


