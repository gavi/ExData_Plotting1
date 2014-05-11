#Using Data Table as it is faster
library(data.table)
power<-fread("household_power_consumption.txt",sep=";",na.strings="?",colClasses="character")
power[,Date:=as.Date(Date,"%d/%m/%Y")]
data<-rbind(power[Date=="2007-02-01"],power[Date=="2007-02-02"])
data[,Global_active_power:=as.numeric(Global_active_power)]
#Get time by contactenating date and time and then parsing
data[["Time"]]<-strptime(paste(data[["Date"]],data[["Time"]]),"%Y-%m-%d %H:%M:%S")
png(filename = "plot2.png",width = 480, height = 480)
par(mfrow=c(1,1))
with(data,plot(Time,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()