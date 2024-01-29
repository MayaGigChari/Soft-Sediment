#this script contains all functions for worm project. 
install.packages("tidyverse")
library(tidyverse)

install.packages("purrr")
library(purrr)

###START: HELPER FUNCTIONS

#Name: CorrectPop
#Action: takes a DMR harvest and corrects to true population.
#TODO: adjust to more accurately represent population estimate
correctPop<- function(x) #where x is the harvested population.
{
  x/efficiency
}

#Name: babiesEst
#Action: takes a number of adults from a known time-series and calculates the number of babies from that year given
# a constant population structure (assumed)
#TODO: double check validity
babiesEst<-function(x)
{
  round(x/(b_2_j), 6)
}

#Name: juvenilesEst
#Action: takes a number of adults from a known timeseries and calculates the number of juveniles from that year given
# a constant population structure (assumed)
#TODO: double check validity
juvenilesEst<-function(x)
{
  round(x/(j_2_a),6)
}

#Name: baby_next
#Action: uses the adults and average birth rate to predict babies of next year
#TODO: 
baby_next<- function(adult)
{
  baby_next<- adult*avg_per_capita_birth
}

#Name: juv_next 
#Action: uses the babies of one year and the average transition from babies to adults to predict babies of next year
#TODO: 
juv_next<-function(bab,pred) #updated 09/02/22
{
  juv_next<- bab*avg_bab_to_juv*(1-pred)
}

#Name: adult_next 
#Action: uese juveniles of past year and average transition from juv to adult to predict adults of next. 
#TODO: 
adult_next<-function(juv)
{
  adult_next<- juv*avg_juv_to_adult
}

#Name: baby_next_rand
#Action: currently negligible
#TODO: NOT in use currently.
baby_next_rand<- function(df)
{
  rate_temp_bab<- rnorm(1, mean=birth_rate_mean, sd=birth_rate_sd) 
  return(round(adult*rate_temp_bab,6))
}

#Name: juv_next_rand
#Action: currently negligible
#TODO: 
juv_next_rand<-function(bab)
{
  rate_temp_juv<- rnorm(1, mean=bab_to_juv_mean, sd=bab_to_juv_sd)
  return(round(bab*rate_temp_juv,6))
}

#Name: adult_next_rand
#Action: currently negligible
#TODO: 
adult_next_rand<-function(juv)
{
  rate_temp_ad<- rnorm(1, mean=juv_to_adult_mean, sd=juv_to_adult_sd)
  return(round(juv*rate_temp_ad,6))
}  

###END: HELPER FUNCTIONS

###START: LARGE FUNCTIONS 


#Name: rate_generator
#Action: takes a dataframe with population values for adult, juvenile and babies
#per year AND 3 empty arrays of 1- the length of the populaiton df, returns a dataframe of rates 
#from year to year (first year is 1 year prior to year listed etc. )
#TODO

rate_generator<-function(df_worm, p=0) #p should not be changed by user. 
{
  #make 3 arrays. 
  b_to_j_array<- vector(mode = "list", length(df_worm[,1])-1)
  #print(b_to_j_array)
  j_to_a_array= b_to_j_array
  birth_rate_array = b_to_j_array

  index = 1
  for(k in 1:(length(df_worm[,1])-1))
  {
    #print(k) #k will be the index for the past year
    r = k +1  #r will be the index for the next year. 
    temp_baby_to_juv_fun = df_worm[r,3]/df_worm[k,4] #juveniles/babies of past
    #print(df_worm[r,3])
    #print(df_worm[k,4])
    temp_juv_to_adult_fun<- df_worm[r,2]/df_worm[k,3] #adults/juveniles of past year a(t+1) = j(t)*rate, rate = a(t+1)/j(t)
    temp_babies_born_fun<-df_worm[r,4]/df_worm[k,2] #babies/adults of past year (for a crude per capita birth rate. )
    b_to_j_array[index] = temp_baby_to_juv_fun
    j_to_a_array[index] = temp_juv_to_adult_fun
    birth_rate_array[index] = temp_babies_born_fun
    index = index +1
  }
  #print(unlist(birth_rate_array))
  #print(length(unlist(birth_rate_array)))
  #print(length(b_to_j_array))
  years = 1976:(1999+p)
  df_rate_return<- data.frame(years)
  df_rate_return$Births<- unlist(birth_rate_array)
  df_rate_return$B_2_J<- unlist(b_to_j_array)
  df_rate_return$J_2_A<- unlist(j_to_a_array)
  return(df_rate_return)
  
}
 
#function test
#a<- rate_generator(bloodworm_df_past) #changed the function so it only has one argument


#Name: projection_with_rand
#Action: outputs projection matrices given a past dataframe, years to be projected and the predation rate on juveniles (assumed 0 if not specified)
#TODO: somehow make distribution more reflective of how changes might happen over time. don't draw random each time. looks bad. 

projection_with_rand<- function(df_past, years_proj,pred=0) #where pred is the amount of predation by predation_rate
{
  #outside for loop: 
  #need to make a larger array that can fit all of the 
  
  #create empty arrays the length of the requested years projected. 
  #it doesn't seem to work to be updating the rates. 
  
  df_past$YEAR<-as.integer(df_past$YEAR)
  
  df_past_initialsize = length(df_past$YEAR)
  #print(df_past[25,])
  #df_rates<-rate_generator(df_past,0)
  for(k in 0:years_proj) #this will put us at the first index/ value of i as the last row in the df_past dataframe. 
  {
    #print(i + df_past_initialsize)
    #maybe instead I can calculate slope of change of adults and estimate birth rates yearly based off this. 
    i = k+ df_past_initialsize
    #print(df_past[i,])
    df_rates<-rate_generator(df_past, k)
    #print(df_rates)
    adult_birth_rate_mean<- mean(df_rates$Births)
    adult_birth_rate_sd<-sd(df_rates$Births)
    
    temp_rate_births<- rnorm(1, mean=adult_birth_rate_mean, sd=adult_birth_rate_sd)
    #print(df_past[i,2])
    #print(temp_rate_births)
    new_babies<- round(df_past[i,2]*temp_rate_births,6)# find number of new babies 
    new_juv = juv_next(df_past[i,4],pred)
    new_adult = adult_next(df_past[i,3])
    #calculate new babies, juveniles and adults
    
    df_past<- df_past %>% add_row(YEAR = df_past$YEAR[length(df_past$YEAR)]+1, ADULT_EST = new_adult, JUV_EST = new_juv, BABY_EST = new_babies)
    #print(df_past)
    
  }
  return(df_past)

  
}

###END: LARGE FUNCTIONS








#leftover code I'm afraid to get rid of



#df_rates<-rate_generator(df_past)
#print(colnames(df_past))
#adult_birth_rate_mean<- mean(df_rates$Births)
#adult_birth_rate_sd<-sd(df_rates$Births)

#temp_rate_births<- rnorm(1, mean=adult_birth_rate_mean, sd=adult_birth_rate_sd)
#new_babies<- round(unlist(babies)[1]*temp_rate_births,6)

#have created a value for new babies. Now I need to add the new babies to the list. 

#babies[2] = new_babies
#new_juv = juv_next(unlist(babies[1]))
#juveniles[2] = juv_next(unlist(babies[1]))
#adults[2] = adult_next(unlist(juveniles[1]))
#new_adult = adult_next(unlist(juveniles[1]))

#print(df_past$YEAR[length(df_past$YEAR)])

#this is throwing an error because df_past$YEAR is a string. 
#df_past<- df_past %>% add_row(YEAR = df_past$YEAR[length(df_past$YEAR)]+1, ADULT_EST = new_adult, JUV_EST = new_juv, BABY_EST = new_babies)
#print(df_past)
#add everything to past dataframe. 

#now I need to make this iterative. 

#turn the above into + count. 

#print(babies)
#print(juveniles)

#print(adult_birth_rate_mean)
#print(adult_birth_rate_sd)
#print(df_rates)

#print(babies)
#print(juveniles)
#print(adults)


#now we can try to make it iterative. 

#babies<-vector(mode = "list", years_proj)
#juveniles <- projected_babies_wrand
#adults <- projected_babies_wrand

#index = length(df_past[,1]) #get the number of babies, juveniles and adults at the last true data year. 
#babies[1] = df_past[index,2]
#juveniles[1] = df_past[index,3]
#adults[1] = df_past[index,4]

