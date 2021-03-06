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

# plot4
png(filename="plot4.png")
par(mfrow=c(2,2))
# 1 top left
data2$Global_active_power<-as.numeric(data2$Global_active_power)
plot(data2$dt, data2$Global_active_power, type='l', xlab='', ylab="Global Active Power")
# 2 top right
data2$Voltage<-as.numeric(data2$Voltage)
plot(data2$dt, data2$Voltage, type='l', xlab='datetimw', ylab="Voltage")
# 3 bottom left
plot(data3$dt, data3$Sub_metering_1, type='l', xlab='', ylab="Energy sub metering")
lines(data3$dt, data3$Sub_metering_2, col='red')
lines(data3$dt, data3$Sub_metering_3, col='blue')
legend('topright', col=c('black', 'red', 'blue'), c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty=1)
#4 bottom right
data2$Global_reactive_power<-as.numeric(data2$Global_reactive_power)
plot(data2$dt, data2$Global_reactive_power, type='l', xlab='datetime', ylab="Global_rective_power")
