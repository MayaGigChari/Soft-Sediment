library(readxl)
library(dplyr)


refugia_data<-data.frame(read.csv("survey_0.csv"))
head(refugia_data)

refugia_data_subset<- subset(refugia_data, select = c("ObjectID", "GlobalID", "CreationDate", "Transect.Orientation","Latitude", "Longitude", "Flower.Buds", "Open.Flowers","Unripe.Fruit", "Ripe.Fruit"))     # Subset with select argument

refugia_unique<-unique(refugia_data_subset$Flower.Buds)
refugia_to_empty<- refugia_unique[refugia_unique != "Black_crowberry"]; # without elements that are "b"


refugia_data_binary<-refugia_data_subset
for(i in 1: length(refugia_to_empty))
{
  refugia_data_binary[refugia_data_binary == refugia_to_empty[i]] <- 0
}

refugia_data_binary[refugia_data_binary == "Black_crowberry"]<-1


refugia_cleaned<-subset(refugia_data_binary, select = c("CreationDate", "Latitude", "Longitude", "Flower.Buds", "Open.Flowers","Unripe.Fruit", "Ripe.Fruit"))     # Subset with select argument
