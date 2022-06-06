library(tidyverse)
library(GGally)
library(lubridate)
library(xts)
library(zoo)
library(ichimoku)

#save the csv correctly

data <- read_csv("livia.csv")



#weekly data transform
data <- as.xts(data$Messages,order.by=as.Date(data$Date))
request_weekly <- apply.weekly(data,sum)



df <- xts_df(request_weekly)
colnames(df) <- c("date", "message")



write.csv(df,"/Users/flurin/Desktop/whatapp/csv.csv", row.names = FALSE)




