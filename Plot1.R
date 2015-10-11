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
Plot1<-function(hpc)
{
	png("Plot1.png")
	hist(hpc$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)")
	dev.off()
}
hpc<-readProject1Data()
Plot1(hpc)