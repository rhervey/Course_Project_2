source("downloadZip.R")

# Load the data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Total emissions by year
aggTot <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png",width=480,height=480,units="px",bg="transparent")

barplot(
        (aggTot$Emissions)/10^6,
        names.arg=aggTot$year,
        xlab="Year",
        ylab="Emissions",
        main="Total Emissions From All US Sources"
)
dev.off()