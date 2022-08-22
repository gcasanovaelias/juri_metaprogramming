# libraries ---------------------------------------------------------------


library(rlang)

# evaluation of quoted expressions ----------------------------------------


# let's quote the R-code in an expression first
(a <- c(1, 1, 1))
(b <- 1:3)

(quote1 <- expr(a + b))

# using tidy_eval() to evaluate quoted expressions in the global environment
eval_tidy(quote1)

# evaluation in another environment or using data frames
(my_df <- data.frame(a = c(2, 2), b = c(10, 100)))
eval_tidy(quote1, data = my_df)

(my_env <- env(a = c(3, 3), b = c(20, 200)))
eval_tidy(quote1, env = my_env)

# using objects defined in an environment and a data frame at the same time
# (quote2 <- expr(.data$a + .env$b))
(quote2 <- expr(.data[["a"]] + .env[["b"]]))
eval_tidy(quote2, data = my_df, env = my_env)

# both values and functions are looked up in the environment
(my_paste <- function(text1, text2) {paste0(text1, "$$", text2)}) # not used

(my_env <- env())
my_env[["a"]] <- "A"
my_env[["b"]] <- "B"
my_env[["my_paste"]] <- function(text1, text2) {paste0(text1, "$", text2)} #used

eval_tidy(expr(my_paste(a, b)), env = my_env)


# quosures ----------------------------------------------------------------

# Quosures: data structure that combines expressions (R-code that is quoted 
# and defused) and it's environment

# the expression and the environment that it is used to evaluate that quote

(quote1 <- expr(a + b)) # quote the expression
(my_env <- env(a = c(3, 3), b = c(20, 200)))

(my_quosure <- new_quosure(quote1, my_env))

eval_tidy(my_quosure) # evaluates the quosure's expression in it's environment

# By default, the global environment is used
x <- 111
(my_quosure <- new_quosure(expr(x + 1)))

test_fun <- function(qs) {
  x <- 222
  eval_tidy(qs)
}

test_fun(my_quosure)

get_env(my_quosure)
