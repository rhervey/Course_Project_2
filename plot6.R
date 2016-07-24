source("downloadZip.R")

#Load the data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Vehicle Emissions Subset
veh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
veh_SCC <- SCC[veh,]$SCC
veh_NEI <- NEI[NEI$SCC %in% veh_SCC,]

# Baltimore & LA Vehicles Subset
baltVehicleNEI <- veh_NEI[veh_NEI$fips=="24510",]
baltVehicleNEI$city <- "Baltimore City"

LAVehiclesNEI <- veh_NEI[veh_NEI$fips=="06037",]
LAVehiclesNEI$city <- "Los Angeles County"

# Combine subsets
LA_Baltimore <- rbind(baltVehicleNEI,LAVehiclesNEI)

png("plot6.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

plot6 <- ggplot(LA_Baltimore, aes(x=factor(year), y=Emissions, fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~city) +
        guides(fill=FALSE) + theme_bw() +
        labs(x="Year", y=expression("Emissions")) + 
        labs(title=expression("Vehicle Emissions in LA & Baltimore: 1999-2008"))

print(plot6)

dev.off()