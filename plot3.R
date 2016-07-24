source("downloadZip.R")

# Load the data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Emission data by Baltimore's emission.
baltimoreEmissions <- NEI[NEI$fips=="24510",]

png("plot3.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

plot3 <- ggplot(baltimoreEmissions,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        theme_bw() + guides(fill=FALSE)+
        facet_grid(.~type,scales = "free",space="free") + 
        labs(x="year", y=expression("Emissions")) + 
        labs(title=expression("Emissions, Baltimore City 1999-2008 by Type"))

print(plot3)

dev.off()
