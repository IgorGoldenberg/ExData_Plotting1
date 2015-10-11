readProject1Data<-function()
{
	library("sqldf")
	library("RSQLite")
	urlname<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	zipfilename<-"household_power_consumption.zip"
	textfilename<-"household_power_consumption.txt"
	download.file(url=urlname, destfile = zipfilename)
	unzip(zipfilename)
	DT<-read.csv.sql(textfilename, sql="select * from file where Date = '1/2/2007' OR Date = '2/2/2007'", sep = ';')
	DT$Time<-strptime(paste(DT$Date, DT$Time), format="%d/%m/%Y %H:%M:%S")
	DT$Date<-as.Date(DT$Date, format="%d/%m/%Y")
	invisible(DT)
}
Plot3<-function(hpc)
{
	png("Plot3.png")
	plot(hpc$Time, hpc$Sub_metering_1, type = "n", xlab="", ylab = "Energy Sub metering")
	lines(hpc$Time, hpc$Sub_metering_1, col="gray",lwd=2)
	lines(hpc$Time, hpc$Sub_metering_2, col="red", lwd=2)
	lines(hpc$Time, hpc$Sub_metering_3, col="blue", lwd=2)
	legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("grey", "red", "blue"), lwd =2, cex=0.8)
	dev.off()
}
hpc<-readProject1Data()
Plot3(hpc)