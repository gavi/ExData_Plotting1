#Data Table is faster
library(data.table)
# Read everthing as character so no warning messages
power<-fread("household_power_consumption.txt",sep=";",na.strings="?",colClasses="character")
#Convert to Date
power[,Date:=as.Date(Date,"%d/%m/%Y")]
#Get Our data tha twe will use for plotting (Feb1st and 2nd 2007)
data<-rbind(power[Date=="2007-02-01"],power[Date=="2007-02-02"])
data[,Global_active_power:=as.numeric(Global_active_power)]
data[,Global_reactive_power:=as.numeric(Global_reactive_power)]
data[["Time"]]<-strptime(paste(data[["Date"]],data[["Time"]]),"%Y-%m-%d %H:%M:%S")
data[["Sub_metering_1"]]<-as.numeric(data[["Sub_metering_1"]])
data[["Sub_metering_2"]]<-as.numeric(data[["Sub_metering_2"]])
data[["Sub_metering_3"]]<-as.numeric(data[["Sub_metering_3"]])

#png(filename = "plot4.png",width = 480, height = 480)
#Split the plot to 4 corners
par(mfrow=c(2,2))
#Add first plot row 1, col 1
with(data,plot(Time,Global_active_power,type="l",ylab="Global Active Power",xlab=""))
#Add second plot row 1, col 2
plot(data$Time,data$Voltage,type="l",ylab="Voltage",xlab="")
#Add third plot row 2, col 1
plot(data$Time,data$Sub_metering_1,type="l",ylab="Energy submetering",xlab="")
points(data$Time,data$Sub_metering_2,type="l",col="red")
points(data$Time,data$Sub_metering_3,type="l",col="blue")
#Add 4th plot row 2, col 2
plot(data$Time,data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="")
#dev.off()