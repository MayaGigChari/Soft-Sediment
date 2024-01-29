#this is a script for initially getting and visualizing local histograms of data from the drive. This all has to be downladed first from the drive. 
library(readxl)
library(ggplot2)

TI_data_bloodworms<-data.frame(read_excel("TI_data.xlsx", sheet = "Bloodworms"))
TI_data_sandworms<-data.frame(read_excel("TI_data.xlsx", sheet = "sandworms"))
TI_data_crabs<- data.frame(read_excel("TI_data.xlsx", sheet = "Crabs"))


TB_data_bloodworms<- data.frame(read_excel("TB_data.xlsx", sheet = "bloodworms"))
TB_data_sandworms<-data.frame(read_excel("TB_data.xlsx", sheet = "sandworms"))


Frazier_data_bloodworms<-data.frame(read_excel("Frazier_data.xlsx", sheet = "bloodworms"))
Frazier_data_sandworms<-data.frame(read_excel("Frazier_data.xlsx", sheet = "sandworms"))
Frazier_data_crabs<- data.frame(read_excel("Frazier_data.xlsx", sheet = "crabs"))

FB_max <-max(Frazier_data_bloodworms$estimated_total_length)
FS_max<- max(Frazier_data_sandworms$estimated_total_length, na.rm = TRUE)

TI_B_max<- max(TI_data_bloodworms$estimated_total_length,na.rm = TRUE)
TI_S_max<- max(TI_data_sandworms$estimated_total_length, na.rm = TRUE)

TB_B_max<-max(TB_data_bloodworms$estimated_total_length, na.rm = TRUE)
TB_S_max<- max(TB_data_sandworms$estimated_total_length, na.rm = TRUE)



#separate age classes of trenton bridge
TB_B_babies <- length(subset(TB_data_bloodworms, estimated_total_length >0  & estimated_total_length <=4)$length)
TB_B_juveniles <- length(subset(TB_data_bloodworms, estimated_total_length >4  & estimated_total_length <=12)$length)
TB_B_adults <- length(subset(TB_data_bloodworms, estimated_total_length >12 )$length)

#calculate the total number of worms in trenton bridge 
total_orgs<- TB_B_babies+TB_B_juveniles+TB_B_adults

#determine the relativ eproportions of babies, juveniles and adults by the TB pop struct. 
prop_babies<- TB_B_babies/total_orgs
prop_juv<-TB_B_juveniles/total_orgs
prop_adults<-TB_B_adults/total_orgs


#babies to juveniles

#NOT SURE IF THIS PART IS RIGHT. here I'm finding the relative proportion of juveniles to babies and adults to juveniles but I might just want the relative proportion to the total population of worms. 

b_2_j <- TB_B_juveniles/TB_B_babies #this is for Trenton Bridge.  

#juveniles to adults 
j_2_a<- TB_B_adults/TB_B_juveniles






