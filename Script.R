###Install necessary packages
install.packages(c("tidyr","dplyr"))

###Load packages
library(tidyr)
library(dplyr)

###Set working directory
setwd("C:/User/Folder_with_input_files")

###Load data set
bold_coi<-read.delim("BAGS_records.csv",sep=";")
bins<-read.delim("CuratedBINs (1).csv",sep=";")

###Subset only curated BINs
bold_coi<-bold_coi[bold_coi$BIN %in% bins$BIN,]

###Replace species names column
bold_coi<-left_join(bold_coi,bins,by="BIN")
bold_coi$species.x<-NULL
names(bold_coi)[13]<-"species"
bold_coi<-bold_coi[,c("species","BIN","sequence","country","grade","family","order","class","sampleid","processid","lattitude","longitude","base_number")]

###Calculate number of records per BIN
sequences_per_bin<-data.frame(table(bold_coi$BIN))
names(sequences_per_bin)<-c("BIN","sequences_per_bin")
bold_coi_2<-full_join(bold_coi,sequences_per_bin,by="BIN")

###Establish criteria for record selection
bold_coi_3<-bold_coi_2 %>%
  mutate(class_bp = ifelse(base_number==658,"1",
                        ifelse(base_number>=650 & base_number<658,"2",
                               ifelse(base_number>=600 & base_number<650,"3",
                                      ifelse(base_number>=500 & base_number<600,"4",
                                             ifelse(base_number<500 | base_number>658,"5","nao_pode"))))))
bold_coi_3<-bold_coi_3 %>%
  mutate(has_country=ifelse(country != "","yes","no"))

###Separate into two datasets: one for BINs with less or equal to 3 records, and another for BINs with more than 3 records
bold_less_than_3_per_bin<-bold_coi_3[bold_coi_3$sequences_per_bin<=3,]
bold_less_than_3_per_bin$class_bp<-NULL
bold_less_than_3_per_bin$has_country<-NULL
bold_more_than_3<-bold_coi_3[bold_coi_3$sequences_per_bin>3,]

###Sample the records by base pair number and the presence of country data
test_1<-bold_more_than_3 %>% 
  group_by(BIN) %>% 
  slice_sample(prop = 1) %>% 
  arrange(class_bp, desc(has_country)) %>% 
  slice_head(n = 3) %>% 
  select(-class_bp, -has_country)

###Create final data set and write tsv file
final<-rbind(test_1,bold_less_than_3_per_bin)

#Tabular format
write_tsv(final,"Curated_library.tsv")
#Comma separated values format
write.csv(final,"Curated_library.csv")


