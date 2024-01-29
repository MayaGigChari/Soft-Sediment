#this is a script for the matrix model including transition rate estimations, matrix calculations and projections. 


###START: predict transition rates (not currently in use)
#first in this script I need to infer survivorship and transition 
#one thing we know is 0 remain in each size class each year because they only have a 3 year life cycle.

#call the rate_generator function to determine rates from past. 
#predicted_rates_df<- rate_generator(bloodworm_df_past)
#this isn't really used at all now. 

#reshaped rates dataframe
#rates_reshaped <- melt(predicted_rates_df ,  id.vars = 'years', variable.name = 'stage')
###END of chunk of code. predicted_rates_df contains all recruitment data from 1975-2000 and all rate data surmised. 



###START: model 1

#projection model if all rates are averaged from past timeseries data. NO STOCHASTICS. 
years_proj<- 2000:2019 
projection_df<-data.frame(years_proj)
projected_babies<-vector(mode = "list", 20)
projected_juv <- projected_babies
projected_adults <- projected_babies
projected_babies[1] <-baby_next(bloodworm_df_past$ADULT_EST[24])
projected_juv[1] <-(juv_next(bloodworm_df_past$BABY_EST[24], predation_rate))
projected_adults[1]<-(adult_next(bloodworm_df_past$JUV_EST[24]))

#create arrays for projections and populate first projected value

for(i in 1:19)
{
  #print(i)
  #print(baby_next(unlist(projected_adults[i])))
  
  projected_babies[i+1]<-baby_next(unlist(projected_adults[i]))
  projected_juv[i+1]<-juv_next(unlist(projected_babies[i]), predation_rate)
  projected_adults[i+1]<-adult_next(unlist(projected_juv[i]))
}


projection_df$adults<-unlist(projected_adults)
projection_df$juveniles<-unlist(projected_juv)
projection_df$babies<-unlist(projected_babies)

projection_df = data.frame(projection_df)

projections_reshaped <- melt(projection_df,  id.vars = 'years_proj', variable.name = 'stages')
##### END of model 1




#### START: MODEL 2: with some stochasticity THIS IS THE MAIN MODEL!
#09/02/2022 update: distribution of birth rates updates each time step. decreases craziness of graph. 

#run the function for projectiong with stochastics for 50 and 100 years 
#with a 5% increase in predation

projections_wrand_50yrs<- projection_with_rand(bloodworm_df_past,50,predation_rate)
projections_wrand_50yrs_reshaped<-melt(projections_wrand_50yrs,id.vars = "YEAR", variable.name = "stages")
projections_wrand_100yrs<-projection_with_rand(bloodworm_df_past,100,predation_rate)
projections_wrand_100yrs_reshaped<-melt(projections_wrand_100yrs,id.vars = "YEAR", variable.name = "stages")















#currently useless scared to get rid of code: 

# years_proj_wrand<- 2000:2100
# projection_df_wrand<-data.frame(years_proj_wrand)
# projected_babies_wrand<-vector(mode = "list", 101)
# projected_juv_wrand <- projected_babies_wrand
# projected_adults_wrand <- projected_babies_wrand
# projected_babies_wrand[1] <-baby_next_rand(bloodworm_df_past$ADULT_EST[24])
# projected_juv_wrand[1] <-juv_next_rand(bloodworm_df_past$BABY_EST[24])
# projected_adults_wrand[1]<-adult_next_rand(bloodworm_df_past$JUV_EST[24])
# 
# #create arrays for projections and populate first projected value
# for(i in 1:100)
# {
#   projected_babies_wrand[i+1]<-baby_next_rand(unlist(projected_adults_wrand[i]))
#   projected_juv_wrand[i+1]<-juv_next(unlist(projected_babies_wrand[i]))
#   projected_adults_wrand[i+1]<-adult_next(unlist(projected_juv_wrand[i]))
# }
# 
# projection_df_wrand$adults<-unlist(projected_adults_wrand)
# projection_df_wrand$juveniles<-unlist(projected_juv_wrand)
# projection_df_wrand$babies<-unlist(projected_babies_wrand)
# 
# projection_df_wrand2<-as.data.frame(projection_df_wrand)
# 
# 
# projections_rand_reshaped<- melt(projection_df_wrand2,  id.vars = 'years_proj_wrand', variable.name = 'stages')
# ggplot(projections_rand_reshaped, aes(years_proj_wrand, value)) +
#   geom_line(aes(colour = stages ))+ labs(x = "Year", y = "worms (millions lbs)")+theme_bw()
# 
# typeof(projections_rand_reshaped)
# 

#now I will look at projected 2022 data ant







