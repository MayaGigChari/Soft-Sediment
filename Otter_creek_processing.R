library("vegan")
?diversity #this is the package we will likely use for the diversity index


#you should be able to read the files from worm_data_automation.R

OC1_table<-read.table(file = "OC1_data_cleaned")
OC1_table

#for the purposes of simplicity we will probably use vegan
#need the data in the form of a community data matrix. 
#community matrix: rows are samples and columns are species. 

OC1_matrix<- as.matrix(OC1_table)
OC1_matrix
OC1_matrix<-OC1_matrix[-1,]
OC1_matrix_t<-t(OC1_matrix) #i think this might now be in the form of a community data matrix!



OC1_diversity_shannon<-diversity(OC1_matrix_t, index = "shannon")
OC1_diversity_simpson<-diversity(OC1_matrix_t, index = "simpson")

OC1_diversity_small_shannon<-OC1_diversity_shannon[1:8]
OC1_diversity_large_shannon<-OC1_diversity_shannon[9:11]

OC1_diversity_small_simp<-OC1_diversity_simpson[1:8]
OC1_diversity_large_simp<-OC1_diversity_simpson[9:11]

p_value_with_outlier_sim<-t.test(OC1_diversity_large_simp, OC1_diversity_small_simp)



#the following code doesn't work because there is only one value. 

p_value_with_outlier_shan<-t.test(OC1_diversity_large_shannon, OC1_diversity_small_shannon) #this will tell us if there is any significant difference. Might also want to make a bar plot. 


dataframe_diversity_shan= data.frame(OC1_diversity_shannon)
dataframe_diversity_shan["core_type"] = c("small", "small", "small", "small", "small", "small", "small", "small", "large", "large", "large")
#this might be blasphemy but it is a hack. fill the dataframe with the same data over and over again. 

dataframe_diversity_simp = data.frame(OC1_diversity_simpson)
dataframe_diversity_simp["core_type"] = c("small", "small", "small", "small", "small", "small", "small", "small", "large", "large", "large")



install.packages("ggplot2")
library(ggplot2)


dataframe_diversity_without_outlier_shan<- dataframe_diversity_shan[-5, ]   # notice the -
dataframe_diversity_without_outlier_simp<-dataframe_diversity_simp[-5,]


#here we plot some figures. you can access them by highlighting the names and hitting command+enter

p_shan <- ggplot(dataframe_diversity_shan, aes(x= core_type, y= OC1_diversity_shannon)) +  
  geom_boxplot()

p_no_outlier_shan<-ggplot(dataframe_diversity_without_outlier_shan, aes(x= core_type, y= OC1_diversity_shannon)) +  
  geom_boxplot()


p_simp<-ggplot(dataframe_diversity_simp, aes(x= core_type, y= OC1_diversity_simpson)) +  
  geom_boxplot()

p_simp_no_outlier<-ggplot(dataframe_diversity_without_outlier_simp, aes(x= core_type, y= OC1_diversity_simpson)) +  
  geom_boxplot()





