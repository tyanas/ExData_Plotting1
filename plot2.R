# $ cat household_power_consumption.txt |grep '2/2/2007'|grep '?'
# 22/2/2007;22:58:00;?;?;?;?;?;?;
# 22/2/2007;22:59:00;?;?;?;?;?;?;
# so one can ignore info about '?' as NA

# prepare vars for complex read.csv
colCl=c(rep('character',2),rep('numeric',7))
sql="select * from file where Date in ('1/2/2007','2/2/2007')"

library(sqldf)
data<-read.csv.sql('household_power_consumption.txt',sep=';',sql=sql,colClasses=colCl)

closeAllConnections()
#rm(data)

library(dplyr)

data2<-tbl_df(data)

data2$dt <- strptime(paste(data2$Date, data2$Time), format="%Y-%m-%d %H:%M:%S")

# plot2
data1<-select(data2, 10, 3:6)
png(filename="plot2.png")
plot(data1$dt, data1$Global_active_power, type='l', xlab='', ylab=kwLabel)
