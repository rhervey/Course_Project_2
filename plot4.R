source("downloadZip.R")

#Load the data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Coal combustion emission subset
combustRecords <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRecords <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal_combust_records <- (combustRecords & coalRecords)
c_SCC <- SCC[coal_combust_records,]$SCC
c_NEI <- NEI[NEI$SCC %in% c_SCC,]

png("plot4.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

plot4 <- ggplot(c_NEI,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="red",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="Year", y=expression("Emissions")) + 
        labs(title=expression("Coal Combustion Emissions Across US: 1999-2008"))

print(plot4)

dev.off()
