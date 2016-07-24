# Download data file only if it does not exist
dataFile <- "emissions_data.zip"
if(!file.exists(dataFile)) {
        dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        if(Sys.info()["sysname"] == "Darwin") {
                download.file(url=dataURL,destfile=dataFile,method="curl")
        } else {
                download.file(url=url,destfile=dataFile)
        }
}
# Unzip the zip file if the following files do not exist
if(!(file.exists("summarySCC_PM25.rds") && 
     file.exists("Source_Classification_Code.rds"))) { unzip(dataFile) }