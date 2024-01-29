#this script reads DMR data and does preliminary processing. 
#TODO 1: verify efficiency/ population estimation methods. Possibly adjust to 
# harvest based estimation. I Should also take 
#into account the fact that only about 20% of adults were actually reproductive in the model somewhere. 

#TODO: somehow the bloodworm_df_past dataframe looses the 1975 row at some point. Need to figure out why this is happening. 

#read the DMR data. 
worm_fishery_data<- read.table(url("https://www.maine.gov/dmr/commercial-fishing/landings/documents/bloodworms.table.pdf"))
if (!require("remotes")) {
  install.packages("remotes")
}
install.packages("rJava")
library(rJava)
remotes::install_github(c("ropensci/tabulizerjars", "ropensci/tabulizer"))
library(ggplot2)
library(tabulizer)
library(reshape2)

#organize data. 
bloodworm_table <- extract_tables('bloodworms.table.pdf', pages = 1)
bloodworm_DMR_data<- data.frame(bloodworm_table)
colnames(bloodworm_DMR_data) = bloodworm_DMR_data[1,]
bloodworm_DMR_data <- bloodworm_DMR_data[-1, ]
#now we have scraped the data, stored in bloodworm_DMR_data. This is a complete dataset. 


#subset the data from 1975 to 2000
bloodworm_DMR_1975.2000<- bloodworm_DMR_data[ which(bloodworm_DMR_data$YEAR >=1975 & bloodworm_DMR_data$YEAR <2000),]


#subset from 1975-2020
bloodworm_DMR_1975.2020<-bloodworm_DMR_data[which(bloodworm_DMR_data$YEAR>=1975),]



#estimate the yearly adult bloodworm population from harvest from 1975-2000, store in bloodworm_yearly_bulk_true
bloodworm_yearly_bulk<- as.double(bloodworm_DMR_1975.2000$`POUNDS(millions)`)
bloodworm_yearly_bulk_true<-unlist(lapply(bloodworm_yearly_bulk, correctPop))
bloodworm_DMR_1975.2000$"ADULT_EST"<- unlist(bloodworm_yearly_bulk_true)

#estimate yearly juvenile bloodworm pop harvest from 1975-2000
bloodworm_juv_est<- lapply(bloodworm_DMR_1975.2000$ADULT_EST, juvenilesEst )
bloodworm_juv_est<-as.double(bloodworm_juv_est)
bloodworm_DMR_1975.2000$"JUV_EST"<- unlist(bloodworm_juv_est)


#estimate yearly baby bloodworm pop harvest from 1975-2000
bloodworm_baby_est<-lapply(bloodworm_DMR_1975.2000$JUV_EST, babiesEst )
bloodworm_baby_est<-as.double(bloodworm_baby_est)
bloodworm_DMR_1975.2000$"BABY_EST"<- unlist(bloodworm_baby_est)

#parse full dataset to produce interpolated past data. this is called bloodworm_df_past
bloodworm_df_past<- bloodworm_DMR_1975.2000
lifehist_data <- c("YEAR","ADULT_EST", "JUV_EST", "BABY_EST")
bloodworm_df_past<- data.frame(bloodworm_DMR_1975.2000[lifehist_data])








#########################NOT USEFUL. REDUNDANT. 

#here I will try an alternate method that will infer the populations of adults, babies and juveniles from the relative
#proportions determined by the "healthy" population structure instead of recruitment. 

#I think this might be right. 

#we know the estimated total population of "adult" worms because we get that fromt the
#correct pop function

# harvested = total* proportion harvested, total = harvested/proportion harvested

#total_worm_pop_est <- function(x)
# {
#   x/prop_adults
# }
# juv_est_prop<-function(x)
# {
#   x*prop_juv
# }
# bab_est_prop<-function(x)
# {
#   x*prop_babies
# }
# 
# adult_est_prop<- bloodworm_DMR_1975.2000$"ADULT_EST"
# total_worm_est<-lapply(adult_est_prop, total_worm_pop_est)
# total_worm_est<-unlist(total_worm_est)
# juv_est_prop<-lapply(total_worm_est, juv_est_prop)
# juv_est_prop<-unlist(juv_est_prop)
# bab_est_prop<-lapply(total_worm_est, bab_est_prop)
# bab_est_prop<-unlist(bab_est_prop)
# 
# predicted_sizes_df<-data.frame(bloodworm_DMR_1975.2000$YEAR)
# names(predicted_sizes_df)[names(predicted_sizes_df) == 'bloodworm_DMR_1975.2000.YEAR'] <- 'year'
# predicted_sizes_df$juv_worms<- juv_est_prop
# predicted_sizes_df$bab_worms<-bab_est_prop
# predicted_sizes_df$adult_worms<-adult_est_prop

#incedentally htis produces the exact same shit. so I don't need to do it this way