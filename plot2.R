source("downloadZip.R")

# Load the data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Emission data by Baltimore's emission.
baltimoreEmissions <- NEI[NEI$fips=="24510",]

# Aggregate using sum the Baltimore emissions data by year
aggTotBalt <- aggregate(Emissions ~ year, baltimoreEmissions,sum)

png("plot2.png",width=480,height=480,units="px",bg="transparent")

barplot(
        aggTotBalt$Emissions,
        names.arg=aggTotBalt$year,
        xlab="Year",
        ylab="Emissions",
        main="Total Emissions From Baltimore City"
)

dev.off()