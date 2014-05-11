#Using Data Table as it is faster
library(data.table)
power<-fread("household_power_consumption.txt",sep=";",na.strings="?",colClasses="character")
power[,Date:=as.Date(Date,"%d/%m/%Y")]
power[,Global_active_power:=as.numeric(Global_active_power)]
data<-rbind(power[Date=="2007-02-01"],power[Date=="2007-02-02"])
png(filename = "plot1.png",width = 480, height = 480)
with(data,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()