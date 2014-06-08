fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,"household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")

colnames <- c("Date","Time","Global.ActivePower","Global.ReactivePower","Voltage","Global.Intensity","SubMetering1","SubMetering2","SubMetering3")
powerdata <- read.table("household_power_consumption.txt",sep=";",header=FALSE,col.names=colnames,skip=50000,nrows=100000,na.strings=c("?","NA"))
powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")
powerdata$DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time),format="%Y-%m-%d %H:%M:%S")

reportdata <- powerdata[powerdata$Date >= "2007-02-01" & powerdata$Date <= "2007-02-02",]

##
hist(reportdata$Global.ActivePower)
plot(reportdata$DateTime, reportdata$Global.ActivePower,col="black",type="l")
plot(reportdata$DateTime, reportdata$SubMetering1,col="black",type="l")
lines(reportdata$DateTime, reportdata$SubMetering2,col="red",type="l")
lines(reportdata$DateTime, reportdata$SubMetering3,col="blue",type="l")