library(readxl)
library(dplyr)
library(tidyr)
library(reshape)
library(writexl)
library(tibble)
library(janitor)

setwd("/Users/danteburch/Graduate School")
gb_df <- read_excel("Goodbelly case dataset.xlsx")
View(gb_df)

# Data Clean Up
gb_df$Date[gb_df$Date == 40184] <- 40330
gb_df$Date[gb_df$Date == 40487] <- 40309
gb_df$Date[gb_df$Date == 40396] <- 40337
gb_df$Date[gb_df$Date == 40336] <- 40365
gb_df$Date[gb_df$Date == 40273] <- 40302
gb_df$Date2 <- gb_df$Date
gb_df$Date <- as.Date(gb_df$Date,"%m/%d/%Y")
gb_df$Date2 <- excel_numeric_to_date(as.numeric(as.character(gb_df$Date2)), date_system = "modern")
gb_df$Date[is.na(gb_df$Date)] <- as.Date(gb_df$Date2[is.na(gb_df$Date)], "%m/%d/%Y")
gb_df$Date2 <- NULL
View(gb_df) #check to make sure file looks clean

#add additional variables related to cost
gb_df$SalesAmount <- (gb_df$Sales * gb_df$ARP)
gb_df$COS <- (gb_df$Sales*0.89)
gb_df$DemoCost <- ifelse(gb_df$Demo>0, 157.83, 0)
gb_df$RepCost <- ifelse(gb_df$Sales_Rep>0, (57501/52), 0)
gb_df$NetIncome <- (gb_df$SalesAmount - gb_df$COS - gb_df$DemoCost - gb_df$RepCost)
View(gb_df) #check to make sure file contains additional fields

write_xlsx(gb_df,'goodbelly_df.xlsx')
