colnames <- c("Date","Time","Global.ActivePower","Global.ReactivePower","Voltage","Global.Intensity","SubMetering1","SubMetering2","SubMetering3")
powerdata <- read.table("household_power_consumption.txt",sep=";",header=FALSE,col.names=colnames,skip=50000,nrows=100000,na.strings=c("?","NA"))
powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")
powerdata$DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time),format="%Y-%m-%d %H:%M:%S")

reportdata <- powerdata[powerdata$Date >= "2007-02-01" & powerdata$Date <= "2007-02-02",]

##
hist(reportdata$Global.ActivePower)
