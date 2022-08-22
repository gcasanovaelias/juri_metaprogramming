# libraries ---------------------------------------------------------------

library(rlang)


# creating calls from scratch ---------------------------------------------

# creating calls (expressions) from its constituent parts / symbols

int_nums <- 15

call2(.fn = "mean", sym("int_nums"), trim = 0.1)

# x <- int_nums + 1
call2("<-", sym("x"), call2("+", sym("int_nums"), 1))


# parsing -----------------------------------------------------------------

# alternatively, we can create calls from characters
# we can start with a character and then parse it
# parse and interpret characters into expressions

(my_call <- parse_expr("x <- int_nums + 1"))


# deparsing ---------------------------------------------------------------

# turn an expression into a character

expr_text(my_call)


# executing ---------------------------------------------------------------

# we can trigger an execution right away using exec()
# we dont use int_nums as symbols beacuse we are interested in the values
# not in capturing the name of the provided variable

exec("mean", int_nums, trim = 0.1, na.rm = TRUE)


