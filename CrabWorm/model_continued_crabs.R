#this script will be to visualize what the data actually looks like compared to what it would
#have looked like if the population structures had remained constant. 


#load the bloodworm DMR data and separate into the current dataset. 
bloodworm_DMR_data
bloodworm_DMR_data_current<- bloodworm_DMR_data[ which(bloodworm_DMR_data$YEAR >=2000 & bloodworm_DMR_data$YEAR <2021),]

#calculate total values for adults
bloodworm_yearly_bulk_to2020<- as.double(bloodworm_DMR_data_current$`POUNDS(millions)`)
bloodworm_yearly_bulk_true2020<-unlist(lapply(bloodworm_yearly_bulk_to2020, correctPop))

#calculate estimates for juveniles and babies. This is not useful because it assumes a stable population structure. 

###USELESS
#bloodworm_juv_est_to2020<- lapply(bloodworm_yearly_bulk_true2020, juvenilesEst )
#bloodworm_juv_est_true2020<-as.double(bloodworm_juv_est_to2020)
#bloodworm_baby_est_to2020<-lapply(bloodworm_yearly_bulk_true2020, babiesEst )
#bloodworm_baby_est_true2020<-as.double(bloodworm_baby_est_to2020)

#put everything into a dataframe (useless)
#years_true<-unlist(bloodworm_DMR_data_current$YEAR)
#true_bloodworm_pop_data<-data.frame(years_true)
#true_bloodworm_pop_data$ADULTS<-unlist(bloodworm_yearly_bulk_true2020)
#true_bloodworm_pop_data$JUV<-unlist(bloodworm_juv_est_true2020)
#true_bloodworm_pop_data$BABY<-unlist(bloodworm_baby_est_true2020)

#true_bloodworm_pop_data<-data.frame(true_bloodworm_pop_data)
###USELESS




#not sure why I had to add groups= stages but I did. 
true_data_reshaped<- melt(true_bloodworm_pop_data,  id.vars = 'years_true', variable.name = 'stages')
ggplot(true_data_reshaped, aes(years_true, value, group = stages)) +
  geom_line(aes(colour = stages))

typeof(true_data_reshaped)




