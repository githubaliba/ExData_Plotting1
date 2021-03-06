## this code will download the appropriate file, process it, and generate the first plot saved to a PNG.

## Download code
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,"household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")

## processing code
colnames <- c("Date","Time","Global.ActivePower","Global.ReactivePower","Voltage","Global.Intensity","SubMetering1","SubMetering2","SubMetering3")
powerdata <- read.table("household_power_consumption.txt",sep=";",header=FALSE,col.names=colnames,skip=50000,nrows=100000,na.strings=c("?","NA"))
powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")
powerdata$DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time),format="%Y-%m-%d %H:%M:%S")

## slice
reportdata <- powerdata[powerdata$Date >= "2007-02-01" & powerdata$Date <= "2007-02-02",]

## plot 3
png(filename="plot3.png",width=480,height=480,units="px")
plot(reportdata$DateTime, reportdata$SubMetering1,col="black",type="l",xlab="",ylab="Energy sub metering")
lines(reportdata$DateTime, reportdata$SubMetering2,col="red",type="l")
lines(reportdata$DateTime, reportdata$SubMetering3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
dev.off()
