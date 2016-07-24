Exploratory Data Analysis - Course Project 2
============================================

### Question 1

**Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?**

Aggregate emission totals for each of the years 1999, 2002, 2005, and 2008.


```r
aggTot <- aggregate(Emissions ~ year,NEI, sum)
```

Using barplot to show emissions by year,


```r
barplot(
        (aggTot$Emissions)/10^6,
        names.arg=aggTot$year,
        xlab="Year",
        ylab="Emissions",
        main="Total Emissions From All US Sources"
)
```

![plot of chunk plot1](plot1.png) 

Answer:  Total emissions HAVE decreased in the US from 1999 to 2008.

### Question 2

Aggregate Emission Totals for Baltimore from 1999 to 2008.


```r
baltimoreEmissions <- NEI[NEI$fips=="24510",]
aggTotBalt <- aggregate(Emissions ~ year, baltimoreEmissions,sum)
```

User barplot to see Baltimore Emissions,


```r
barplot(
  aggTotalsBaltimore$Emissions,
  names.arg=aggTotalsBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From All Baltimore City Sources"
)
```

![plot of chunk plot2](plot2.png) 

**Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?**

Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.

### Question 3

Using the ggplot2 plotting system,


```r
library(ggplot2)

ggp <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)
```

![plot of chunk plot3](figure/plot3.png) 

**Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?**

The `non-road`, `nonpoint`, `on-road` source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.

**Which have seen increases in emissions from 1999–2008?**

The `point` source saw a slight increase overall from 1999-2008. Also note that the `point` source saw a significant increase until 2005 at which point it decreases again by 2008 to just above the starting values. 

(Note that I did not catch this originally as I started off with a log scale on Emissions)

### Question 4

First we subset coal combustion source factors NEI data.


```r
# Subset coal combustion related NEI data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]
```

Note:  The SCC levels go from generic to specific. We assume that coal combustion related SCC records are those where SCC.Level.One contains the substring 'comb' and SCC.Level.Four contains the substring 'coal'.


```r
library(ggplot2)

ggp <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)
```

![plot of chunk plot4](figure/plot4.png) 

**Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?**

Emissions from coal combustion related sources have decreased from 6 * 10^6 to below 4 * 10^6 from 1999-2008.

Eg. Emissions from coal combustion related sources have decreased by about 1/3 from 1999-2008!

### Question 5

First we subset the motor vehicles, which we assume is anything like Motor Vehicle in SCC.Level.Two.


```r
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
```

Next we subset for motor vehicles in Baltimore,


```r
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips==24510,]
```

Finally we plot using ggplot2,


```r
library(ggplot2)
ggp <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)
```

![plot of chunk plot5](figure/plot5.png) 

**How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?**

Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City!

### Question 6

Comparing emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"),


```r
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == 24510,]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)
```

Now we plot using the ggplot2 system,


```r
library(ggplot2)
 
ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
 geom_bar(aes(fill=year),stat="identity") +
 facet_grid(scales="free", space="free", .~city) +
 guides(fill=FALSE) + theme_bw() +
 labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
 labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
 
print(ggp)
```

![plot of chunk plot6](figure/plot6.png) 

**Which city has seen greater changes over time in motor vehicle emissions?**

Los Angeles County has seen the greatest changes over time in motor vehicle emissions.
