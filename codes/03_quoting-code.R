
library(rlang)

# quote: defusing a source code in an expression
# quoting prevents the code from inmediate evaluation
# It does not have "" or ''. Is not a character but an expression!

# expr() and enexpr() quote the R-code, exprs() and enexprs()

# outside a function
(quote1 <- expr(a + b))

# inside a function
(i_quote <- function(the_quote) {
  expr_quote <- enexpr(the_quote)
  print(expr_quote)
})

i_quote(the_quote = a + b)

#* Do not use expr() in functions!
#* enexpr() quotes the contained expression in a parameter
#* and not the parameter itself as expr(), that is why the former it is used 
#* in functions