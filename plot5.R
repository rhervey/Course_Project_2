source("downloadZip.R")

#Load the data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Vehicle Emissions Subset
veh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
veh_SCC <- SCC[veh,]$SCC
veh_NEI <- NEI[NEI$SCC %in% veh_SCC,]

# Baltimore Vehicles Subset
baltVehicleNEI <- veh_NEI[veh_NEI$fips=="24510",]

png("plot5.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

plot5 <- ggplot(baltVehicleNEI,aes(factor(year),Emissions)) +
        geom_bar(stat="identity",fill="orange",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="Year", y=expression("Emissions")) + 
        labs(title=expression("Baltimore Vehicle Emissions: 1999-2008"))

print(plot5)

dev.off()