
# Create the data frame
df <- data.frame(DateTime = c("2023-08-04 12:00:00", "2023-08-04 13:00:00", "2023-08-04 14:00:00"))

# Set the names of the `DateTime` column
df <- setNames(df, c("DateTime"))

# Print the data frame
print(df)

t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
t <- t[complete.cases(t),]

## Combine Date and Time column
dateTime <- paste(t$Date, t$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
t <- t[ ,!(names(t) %in% c("Date","Time"))]

## Add DateTime column
t <- cbind(dateTime, t)

## Format dateTime Column
t$dateTime <- as.POSIXct(dateTime)

## Create Plot 2
plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
