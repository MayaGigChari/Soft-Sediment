library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot) 
library(readxl)

#don't worry about this. This is a PCA for jes's data. 

sediment_data<-read_excel("Sediment data.xlsx", sheet = "data_standardized") #load the excel data sheet from drive
sediment_data<- data.frame(sediment_data)
list_names<- c("low", "med-low", "med-high", "high")
rownames(sediment_data)<-list_names
sediment_data$ID<-NULL


sediment.pca <- prcomp(sediment_data[1:8], center = TRUE,scale. = TRUE)
p_j<-ggbiplot(sediment.pca, labels = sediment_data$Shannon_diversity, varname.size =2)+xlim(-1.75,2)+ylim(-1.75,1.75)
p_j

?ggbiplot


#for diversity between parts of the site

df_shan_divers<- dataframe_diversity
df_shan_divers_nobig<-df_shan_divers[-c(9,10),]
df_shan_divers_nobig["location"] = c("High intertidal", "Med intertidal", "Med-Low intertidal", "Low intertidal", "High intertidal", "Med intertidal", "Med-Low intertidal", "Low intertidal")
df_shan_divers_nobig


p_site <- ggplot(df_shan_divers_nobig, aes(x= location, y= OC1_diversity_shannon)) +  
  geom_boxplot()


library("dplyr")  

df_for_bar<-data.frame(df_shan_divers_nobig %>% group_by(location) %>%                        
  summarise_at(vars(OC1_diversity_shannon),
               list(name = mean)))


install.packages("forcats")
library(forcats)
library(ggplot2)
graph_bar_reorder <- df_for_bar %>%
  mutate(location = fct_relevel(location, 
                            "Low intertidal", "Med-Low intertidal", "Med intertidal", "High intertidal")) %>%
  ggplot( aes(x=location, y=name ))+
  geom_bar(stat="identity") +
  xlab("")

graph_bar_reorder

p_site_bar<- ggplot(df_for_bar, aes(x = location, y = name))+geom_bar(stat="identity")
