# import the csv of the lab datasheets

#run all the following that is not commented out.

#installs packages necessary for the 
install.package("readxl")
library("readxl")
install.packages("janitor")
library("janitor") #will use this for some data cleaning. 
library("dplyr")


#in this chunk of code we are altering the dataset to make it usable in the diversity index. 
#run the whole thing, it should produce csv files and tables of each site data in your working directed 

sitenames<-c("WP1", "WP2", "OC1", "OC2", "TI", "Frazier1", "Frazier2", "Wonderland", "EP1", "EP2")
sitenameslength<- length(sitenames) #define an integer that is the length of the site names
coreID<- c("Species","L1", "L2", "L3", "L4", "R1", "R2", "R3", "R4")
coreID_withBigCores<- c(coreID, "RL_6", "RH_6","LH_6")
for(i in (1:length(sitenames)))#changex this to 1: length(sitenames) after debugging 
{
  data_frame_worms <- data.frame(read_excel("worms_2022.xlsx", sheet = sitenames[i])) #need to convert to dataframe. 
  data_frame_worms %>%
    row_to_names(row_number = 1)
  if(sitenames[i]=="OC1")
    colnames(data_frame_worms)<-coreID_withBigCores
  else
    colnames(data_frame_worms)<-coreID
  data_frame_worms<-data_frame_worms[-c(1),]
  data_frame_worms$Species <- chartr(" ", "_", data_frame_worms$Species) #works better in chartr than sub
  rownames(data_frame_worms)<- data_frame_worms$Species
  data_frame_worms$Species<-NULL
  data_frame_worms[is.na(data_frame_worms)] = 0
  
  #print(data_frame_worms) #now the data is in an appropriate form to convert 
  str = paste(sitenames[i], "_data_cleaned.csv", sep = "")
  write.table(data_frame_worms, file = paste(sitenames[i], "_data_cleaned", sep = ""))
  write.csv(data_frame_worms, file = paste(sitenames[i], "_data_cleaned.csv", sep = ""))
  #save them as tables and csv's. 
  
  #data_frame_2<- data_frame[-c(1)]
  #print(data_frame_2)
  #write.csv(data_frame, paste("worms_2022_", sitenames[i], ".csv"))
}
#kudos to me for making this super easy for myself 


#here I'm playing around with subsetting the dataframe so that the data is parsible 
#table_practice_species<-c(rownames(table_practice))
#for(i in 1: length(table_practice_species))
#{
#  print(table_practice_species[i])
#  for(j in 1: ncol(table_practice))
#   {
#    print(table_practice[i,j]) #this prints the values of each species. 
#   }
#}

#now I will load the datasheet that needs to be filled. 
