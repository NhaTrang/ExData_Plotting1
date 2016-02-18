#Send file into a variable mydata

mydata <- read.table("household_power_consumption.txt",header=TRUE, sep=";")

#Convert Dates and store column in mydata$Date

mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")

# select row from 01/02/2007 02/02/2007
pwr <- power[(mydata$Date=="2007-02-01") | (mydata$Date=="2007-02-02"),]


pwr$Global_active_power <- as.numeric(as.character(pwr$Global_active_power))
pwr$Global_reactive_power <- as.numeric(as.character(pwr$Global_reactive_power))
pwr$Voltage <- as.numeric(as.character(pwr$Voltage))

#change format of Date and Time
pwr<- transform(pwr, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
pwr$Sub_metering_1 <- as.numeric(as.character(pwr$Sub_metering_1))
pwr$Sub_metering_2 <- as.numeric(as.character(pwr$Sub_metering_2))
pwr$Sub_metering_3 <- as.numeric(as.character(pwr$Sub_metering_3))

#Construct the plot and save it into variable plot3

plot3 <plot(pwr$timestamp, pwr$Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering")
lines(pwr$timestamp,pwr$Sub_metering_2,col="red")
lines(pwr$timestamp,pwr$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))


#Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
