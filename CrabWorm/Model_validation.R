# I will look at projected 2022 data for an increase in predation on juveniles by 
#5 percent, 10 percent and 15 percent. 
#TODO: do an actual sensitivity analysis. This is very basic validation. 


install.packages('ggpmisc')
install.packages('pkr')
library(ggpmisc)
library(pkr)
library(reshape2)

#first we need the "true" estimated data for the adult worm populations from 2000-2020. 
bloodworm_DMR_data_current<- bloodworm_DMR_data[which(bloodworm_DMR_data$YEAR >=2000 & bloodworm_DMR_data$YEAR <2021),]
Years_current<-bloodworm_DMR_data_current$YEAR
df_corrected_bloodworm_current<- data.frame(Years_current)
bloodworm_yearly_bulk_current<- as.double(bloodworm_DMR_data_current$`POUNDS(millions)`)

#this dataframe consists of a timeseries of estimated millions of lbs of worms. 
df_corrected_bloodworm_current$ADULTS<-unlist(lapply(bloodworm_yearly_bulk_current, correctPop))
df_corrected_bloodworm_current = data.frame(df_corrected_bloodworm_current)


#this dataset is a melted version of df_corrected_bloodworm_current for plotting. 
df_current_blood_reshaped <- melt(df_corrected_bloodworm_current,  id.vars = 'Years_current', variable.name = 'stages')

