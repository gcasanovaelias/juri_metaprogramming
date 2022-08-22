
library(vroom)
library(here)
library(rlang)
library(dplyr)


(adult <- vroom(here("data", "adult.data"), col_names = FALSE) |> 
    rename(age = X1, 
           workclass = X2, 
           fnlwgt = X3, 
           education = X4, 
           education_dur = X5, 
           marital_status = X6, 
           occupation = X7,
           relationship = X8, 
           race = X9, sex = X10, 
           capital_gain = X11,
           capital_loss = X12, 
           hours_per_week = X13, 
           native_country = X14,
           wage = X15))

vroom_write(adult, here("outputs", "adult.csv"))
