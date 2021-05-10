library(dplyr)

rm(list = ls())
datapath <- "./data/气候室内温度"
Room_no <- dir(datapath)
df <- data.frame()

for(i in 1:length(Room_no)){
  ls <- list.files(paste(datapath, Room_no[i], sep = "/"))
  for(j in 1:length(ls)){
    df1 <- paste(datapath, Room_no[i], ls[j], sep = "/") %>% 
      read.csv(skip = 1) %>% 
      select(Time = 2, Ta = 3, RH = 4) %>% 
      mutate(Time = as.POSIXct(Time),
             Room = Room_no[i],
             TempNo = unlist(strsplit(ls[j], "\\."))[1])
    df <- rbind(df, df1)
  }
}

df1 <- aggregate(Ta~Room + Time, data = df, FUN = "mean")


