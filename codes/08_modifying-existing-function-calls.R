# libraries ---------------------------------------------------------------

library(rlang)


# accessing and modifying calls like lists --------------------------------

(call_sum <- expr(sum(int_num, na.rm = FALSE)))

# accesing calls elements

call_sum[[1]]

call_sum$na.rm


# modifying everything ----------------------------------------------------

(int_nums2 <- c(NA, 1:5))
(call_sum <- expr(sum(int_nums, na.rm = FALSE)))

# replace symbol (function)
call_sum[[1]] <- sym("prod")

# replace symbol int_nums
call_sum[[2]] <- sym("int_nums2")

# replace constant
call_sum$na.rm <- TRUE

eval_tidy(call_sum)


# removing parts and adding new ones --------------------------------------

call_sum[[3]] <- NULL # remove na.rm constant
call_sum

call_sum$na.rm <- TRUE # add it again
call_sum


# modifying subcalls ------------------------------------------------------

(call_mean <- expr(mean(na.omit(int_nums), trim = 0.1)))
call_mean[[1]] # symbol
call_mean[[2]] # subcall
call_mean[[2]][[2]]

call_mean[[2]][[2]] <- sym("int_nums2")

eval_tidy(call_mean)
