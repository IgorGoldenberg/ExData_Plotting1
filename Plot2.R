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
Plot2<-function(hpc)
{
	png("Plot2.png")
	plot(hpc$Time, hpc$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
	lines(hpc$Time, hpc$Global_active_power)
	dev.off()
}
hpc<-readProject1Data()
Plot2(hpc)