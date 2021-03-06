#Using Data Table as it is faster
library(data.table)
power<-fread("household_power_consumption.txt",sep=";",na.strings="?",colClasses="character")
power[,Date:=as.Date(Date,"%d/%m/%Y")]
data<-rbind(power[Date=="2007-02-01"],power[Date=="2007-02-02"])
#Convert data to numeric
data[["Time"]]<-strptime(paste(data[["Date"]],data[["Time"]]),"%Y-%m-%d %H:%M:%S")
data[["Sub_metering_1"]]<-as.numeric(data[["Sub_metering_1"]])
data[["Sub_metering_2"]]<-as.numeric(data[["Sub_metering_2"]])
data[["Sub_metering_3"]]<-as.numeric(data[["Sub_metering_3"]])
par(mfrow=c(1,1))
png(filename = "plot3.png",width = 480, height = 480)
plot(data$Time,data$Sub_metering_1,type="l",ylab="Energy submetering",xlab="")
points(data$Time,data$Sub_metering_2,type="l",col="red")
points(data$Time,data$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
dev.off()