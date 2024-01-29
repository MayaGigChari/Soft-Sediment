
library(ggplot2)
library(ggpmisc)
library(pkr)


#for histograms and pop structures: 

#make preliminary histograms. 

#Frazer histograms
ggplot(Frazier_data_bloodworms,aes(estimated_total_length))+geom_histogram(bins=3, breaks = c(0,3.9,12,FB_max))+ theme_bw()+geom_histogram(bins=3, breaks = c(0,3.9,12,TB_B_max), color = "black", fill = "lightblue")  +labs(x = "length (cm)", y = "count") #maybe this is useful. 
ggplot(Frazier_data_sandworms,aes(estimated_total_length))+geom_histogram(bins=3, breaks = c(0,3.9,12,FS_max))

#Thompson Island histograms
ggplot(TI_data_bloodworms,aes(estimated_total_length))+geom_histogram(bins=3, breaks = c(0,3.9,12,TI_B_max))
ggplot(TI_data_sandworms,aes(estimated_total_length))+geom_histogram(bins=3, breaks = c(0,3.9,12,TI_S_max))

#Trenton Bridge histograms
ggplot(TB_data_bloodworms, aes(estimated_total_length))+ theme_bw()+geom_histogram(bins=3, breaks = c(0,3.9,12,TB_B_max), color = "black", fill = "lightblue")  +labs(x = "length (cm)", y = "count")
ggplot(TB_data_sandworms,aes(estimated_total_length))+geom_histogram(bins=3, breaks = c(0,3.9,12,TB_S_max))


#to visualize rates of transition from the past

ggplot(rates_reshaped, aes(years, value)) +
  geom_line(aes(colour = stage ))

#histogram of birth rates from past data

ggplot(predicted_rates_df, aes(x = per_capita_birth))+ geom_histogram(bins = 12)


#to visualize model predictions if all rates are constant and extrapolated from past data

ggplot(projections_reshaped, aes(years_proj, value)) +
  geom_line(aes(colour = stages ))


#plot to visualize model predictions for 50 year projection with stochastics 
#TODO: time axis not showing

ggplot(projections_wrand_50yrs_reshaped, aes(YEAR, value, group = stages)) + 
  geom_line(aes(colour = stages )) + scale_x_discrete(breaks = seq(1950, 2050, by = 5)) + labs(x = "Year", y = "worms (millions lbs)")+theme_bw()


#plot to visualize model predictions for 100 year projection with stochastics 
#TODO: time axis not showing

ggplot(projections_wrand_100yrs_reshaped, aes(YEAR, value, group = stages)) + 
  geom_line(aes(colour = stages )) + scale_x_discrete(breaks = seq(1950, 2100, by = 5)) + labs(x = "Year", y = "worms (millions lbs)")+theme_bw()


######for training: 

#plot the interpolated data from 1975-2000 of adult, juv and baby population estimations. 
ggplot(df_blood_reshaped, aes(YEAR, value, group = stages)) + 
  geom_line(aes(colour = stages )) + scale_x_discrete(breaks = seq(1950, 2005, by = 5)) + labs(x = "Year", y = "worms (millions lbs)")+theme_bw()




######for validation: 

#plotting the "true estimated" adult worm values for 2000-2020
ggplot(df_current_blood_reshaped, aes(Years_current, value, group = stages)) + 
  geom_line(aes(colour = stages )) + labs(x = "Year", y = "worms (millions lbs)")+theme_bw()

#plotting the "true estimated" adult worm regression from 2000-2020 with 95% confidence. 
ggplot(df_corrected_bloodworm_current, aes(x = Years_current, y = ADULTS, group = 1)) + 
  stat_poly_line() + stat_poly_eq(aes(label = paste(after_stat(eq.label),after_stat(rr.label), sep = "*\", \"*")))  + geom_point() + scale_x_discrete(breaks = seq(2000, 2020, by = 2))+ labs(x = "years", y = "Adult worms (millions lbs)")

#plotting the "5% increase in predation starting in 2000" regression from 2000-2020 
ggplot(five_percent_projection[which(five_percent_projection$years_proj_wrand>=2000 & five_percent_projection$years_proj_wrand<= 2021),], aes(x = years_proj_wrand, y = adults, group = 1)) + 
  stat_poly_line() + stat_poly_eq(aes(label = paste(after_stat(eq.label),after_stat(rr.label), sep = "*\", \"*")))  + geom_point() +  labs(x = "years", y = "Adult worms (millions lbs)")

#plotting the "10%increase in predation starting in 2020" regression from 2000-2020
ggplot(ten_percent_projection[which(ten_percent_projection$years_proj_wrand>=2000 & ten_percent_projection$years_proj_wrand<= 2021),], aes(x = years_proj_wrand, y = adults, group = 1)) + 
  stat_poly_line() + stat_poly_eq(aes(label = paste(after_stat(eq.label),after_stat(rr.label), sep = "*\", \"*")))  + geom_point() +  labs(x = "years", y = "Adult worms (millions lbs)")



