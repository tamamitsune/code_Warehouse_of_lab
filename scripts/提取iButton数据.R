library(dplyr)


datapath <- "./data/皮肤温度"
ibutton_no <- dir(datapath)
df <- data.frame()

for(i in 1:length(ibutton_no)){
  ls <- list.files(paste(datapath, ibutton_no[i], sep = "/"))
  for(j in 1:length(ls)){
    df1 <- paste(datapath, ibutton_no[i], ls[j], sep = "/") %>% 
      read.csv() %>% 
      select(Time = 1, Temp = 2) %>% 
      mutate(Time = as.POSIXct(Time),
             No = ibutton_no[i],
             Bodypart = unlist(strsplit(ls[j], "\\."))[1])
    df <- rbind(df, df1)
  }
}