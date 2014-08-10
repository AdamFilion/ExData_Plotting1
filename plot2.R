
# data set start date is Dec 16, 2006 at 17:24:00
# only want data from Feb 1, 2007 00:00:00 to Feb 2, 2007 24:00:00

# read in first line for start information
startdate = read.csv("household_power_consumption.txt",sep=";",nrow=1)
# convert to date/time information
startdate$datetime = strptime( paste(startdate$Date,startdate$Time),"%d/%m/%Y %H:%M:%S")
# start date for data analyzed, plus 1 minute since subtracting
adate = strptime("01/02/2007 00:01:00","%d/%m/%Y %H:%M:%S") 
# end date for data analyzed, plus 1 minute since subtracting
bdate = strptime("03/02/2007 00:01:00","%d/%m/%Y %H:%M:%S") 
# number of rows in data file to skip
numskip = as.double(adate-startdate$datetime)*24*60 
# number of rows to read
numrow = as.double(bdate-adate)*24*60 
# read in data to be analyzed
cnames = read.csv("household_power_consumption.txt",sep=";",nrow=1,header=FALSE,stringsAsFactors=FALSE)
cnames = as.vector(cnames,"character")
hpc = read.csv("household_power_consumption.txt",sep=";",skip=numskip,nrow=numrow,na.strings="?",header=FALSE,col.names=cnames)
hpc$datetime = strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S")

# create desired plot
plot(hpc$datetime,hpc$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

# save to png
png(filename="plot2.png",width=480,height=480)
plot(hpc$datetime,hpc$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
