library(tidyverse)
library(GGally)
library(lubridate)
library(xts)
library(zoo)
library(ichimoku)

data <- read_csv("kultur.csv")
data <- na.omit(data)

ts_forderung <- aggregate(data$Nachgefragt, list(data$Beschlussdatum), sum)
colnames(ts_forderung) <- c("Date", "Anfragebetrag")

ts_zahlung <- aggregate(data$Beschluss, list(data$Beschlussdatum), sum)
colnames(ts_zahlung) <- c("Date", "Auszahlungsbetrag")

total <- mutate(ts_forderung, ts_zahlung$Auszahlungsbetrag)
colnames(total) <- c("date", "Request", "Grant")

#colors <- c("Anfragebetrag" = "steelblue", "Anfragebetrag" = "darkred")


#weekly data transform
data <- as.xts(total$Request,order.by=as.Date(total$date))
request_weekly <- apply.weekly(data,sum)


data <- as.xts(total$Grant,order.by=as.Date(total$date))
grant_weekly <- apply.weekly(data,sum)

weekly_both <- merge(request_weekly, grant_weekly)


weekly_both_df <- xts_df(weekly_both)
colnames(weekly_both_df) <- c("date", "request", "grant")



write.csv(weekly_both_df,"/Users/flurin/Desktop/task11/csv.csv", row.names = FALSE)

data_plot <- read_csv("csv.csv")




total <- ggplot(data = data_plot, aes(x = date, y = request)) + 
  geom_bar(stat = "identity", fill = "grey", color = "red")+
  geom_bar(data = data_plot, aes(x = date, y = grant),
           stat = "identity", fill = "grey", color = "blue")+
  theme_bw()

total






weekly_aggregate <- as.data.frame.table(weekly_aggregate)
dates <- seq(as.Date( '2020-06-01'),length=38,by="weeks" )
dates <- as.data.frame.table(dates, keep.rownames=FALSE)

request_weekly <- mutate(weekly_aggregate, date=dates$Freq.dates)
#https://opendata.swiss/de/dataset/corona-hilfen-im-kulturbereich-im-kanton-zurich/resource/c8cb01da-35b4-4ba2-b9a7-6f3c2024ed31