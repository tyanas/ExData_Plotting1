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

# plot1
data2$Global_active_power<-as.numeric(data2$Global_active_power)
png(filename="plot1.png", width=480, height=480, bg = "transparent")
hist(data2$Global_active_power, col='red', xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')
