fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,"household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")

colnames <- c("Date","Time","Global.ActivePower","Global.ReactivePower","Voltage","Global.Intensity","SubMetering1","SubMetering2","SubMetering3")
powerdata <- read.table("household_power_consumption.txt",sep=";",header=FALSE,col.names=colnames,skip=50000,nrows=100000,na.strings=c("?","NA"))
powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")
powerdata$DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time),format="%Y-%m-%d %H:%M:%S")

reportdata <- powerdata[powerdata$Date >= "2007-02-01" & powerdata$Date <= "2007-02-02",]

## plot 1
png(filename="plot1.png",width=480,height=480,units="px")
hist(reportdata$Global.ActivePower,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",col="red")
dev.off()

## plot 2
png(filename="plot2.png",width=480,height=480,units="px")
plot(reportdata$DateTime, reportdata$Global.ActivePower,col="black",type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

## plot 3
png(filename="plot3.png",width=480,height=480,units="px")
plot(reportdata$DateTime, reportdata$SubMetering1,col="black",type="l",xlab="",ylab="Energy sub metering")
lines(reportdata$DateTime, reportdata$SubMetering2,col="red",type="l")
lines(reportdata$DateTime, reportdata$SubMetering3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
dev.off()

##plot 4
png(filename="plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
## plot 4.1
plot(reportdata$DateTime, reportdata$Global.ActivePower,col="black",type="l", xlab="", ylab="Global Active Power")

## plot 4.2
plot(reportdata$DateTime, reportdata$Voltage,col="black",type="l", xlab="datetime", ylab="Voltage")

## plot 4.3
plot(reportdata$DateTime, reportdata$SubMetering1,col="black",type="l",xlab="",ylab="Energy sub metering")
lines(reportdata$DateTime, reportdata$SubMetering2,col="red",type="l")
lines(reportdata$DateTime, reportdata$SubMetering3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),bty="n")

## plot 4.4
plot(reportdata$DateTime, reportdata$Global.ReactivePower,col="black",type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()