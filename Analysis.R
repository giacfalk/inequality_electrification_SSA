##R Script for: 
##Sub-national inequalities in progress towards SDG7 in sub-Saharan Africa
##Giacomo Falchetta, Shonali Pachauri, Simon Parkinson, Edward Byers
## Version: 23/07/18

##NB This script should be run after the Earth Engine (EE) javascript code. 
#The googledrive package will call and download the files generated in EE. 
#The script produces figures and statistics, and can be easily manipupalted to produce new metrics.
#Supporting files and folder structure as in the GitHub repository are required for the script to run successfully.
#Any question should be addressed to giacomo.falchetta@feem.it

##NB First, set the working directory to the directory of the cloned repository

#Install the appropriate version of the required libraries 
install.packages("checkpoint")
library(checkpoint)
checkpoint("2019-07-23")

#Load libraries
library(sf)
library(raster)
library(ncdf4)
library(RNetCDF)
library(googledrive)
library(data.table)
library(dplyr)
library(ggplot2)
library(scales)
library(ggpmisc)
library(wbstats)
library(ggrepel)
library(ineq)
library(cowplot)
library(rworldmap)
library(rgdal)
library(reshape2)
library(latex2exp)
library(tidyr)
library(readxl)
library(rgdal)
library(ggthemes)
library(RColorBrewer)
library(gtools)
library(countrycode)

#Google drive authentication (to be run before launching the entire script)
drive_find(n_max = 30)

#1) Import data for populaiton and population without access

drive_download("pop18.csv", type = "csv", overwrite = TRUE)
pop18 = read.csv("pop18.csv")

drive_download("pop16.csv", type = "csv", overwrite = TRUE)
pop16 = read.csv("pop16.csv")

drive_download("pop14.csv", type = "csv", overwrite = TRUE)
pop14 = read.csv("pop14.csv")

drive_download("no_acc_18.csv", type = "csv", overwrite = TRUE)
no_acc_18 = read.csv("no_acc_18.csv")

drive_download("no_acc_16.csv", type = "csv", overwrite = TRUE)
no_acc_16 = read.csv("no_acc_16.csv")

drive_download("no_acc_14.csv", type = "csv", overwrite = TRUE)
no_acc_14 = read.csv("no_acc_14.csv")

#1.1) Merge different years, remove non Sub-Saharan countries and other misc provinces
merged_14 = merge(pop14, no_acc_14, by=c("GID_1"), all=TRUE)
merged_16 = merge(pop16, no_acc_16, by=c("GID_1"), all=TRUE)
merged_18 = merge(pop18, no_acc_18, by=c("GID_1"), all=TRUE)

merged_14=subset(merged_14, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")
merged_16=subset(merged_16, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")
merged_18=subset(merged_18, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")

merged_14 = dplyr::filter(merged_14,  !is.na(GID_0.x))
merged_16 = dplyr::filter(merged_16,  !is.na(GID_0.x))
merged_18 = dplyr::filter(merged_18,  !is.na(GID_0.x))

#2) Calculate province-level electrification rates and merge them into a single dataframe 
merged_18$elrate=(1-(merged_18$sum.y / merged_18$sum.x))
merged_16$elrate=(1-(merged_16$sum.y / merged_16$sum.x))
merged_14$elrate=(1-(merged_14$sum.y / merged_14$sum.x))

elrates = data.frame(merged_18$elrate, merged_16$elrate, merged_14$elrate, merged_14$GID_1, merged_14$GID_0.x, merged_18$sum.x, merged_14$sum.x)

varnames<-c("elrate18", "elrate16", "elrate14", "GID_1", "GID_0", "pop18", "pop14")

setnames(elrates,names(elrates),varnames )

#2.1) Calculate the change in electrification rates over the two years considered
elrates$eldiff = elrates$elrate18 - elrates$elrate14 
elrates$eldiffpc = (elrates$elrate18 - elrates$elrate14) / elrates$elrate14

#3) Calculate national electrification rates

merged_14_countrylevel = merged_14 %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_14_countrylevel$elrate = (1-(merged_14_countrylevel$popnoacc/merged_14_countrylevel$pop))

merged_16_countrylevel = merged_16 %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_16_countrylevel$elrate = (1-(merged_16_countrylevel$popnoacc/merged_16_countrylevel$pop))

merged_18_countrylevel = merged_18 %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_18_countrylevel$elrate = (1-(merged_18_countrylevel$popnoacc/merged_18_countrylevel$pop))

merged_diff=data.frame(merged_18_countrylevel$GID_0.x, (merged_18_countrylevel$elrate-merged_14_countrylevel$elrate), merged_18_countrylevel$elrate, merged_16_countrylevel$elrate, merged_14_countrylevel$elrate, merged_14_countrylevel$pop, merged_18_countrylevel$pop)
merged_diff <- na.omit(merged_diff)
varnames<-c("GID_0", "elrate_diff", "elrate18", "elrate16","elrate14", "pop14", "pop18")
setnames(merged_diff,names(merged_diff),varnames )
merged_diff$popch=merged_diff$pop18-merged_diff$pop14


merged_diff$gainedaccess = (merged_diff$elrate18*merged_diff$pop18) - (merged_diff$elrate14*merged_diff$pop14)
merged_diff$gainedperday = merged_diff$gainedaccess / 1825

#3.1) Plot change in national electricity access rates between the two years considered

barplot_elrate = ggplot(merged_diff, aes(x=reorder(GID_0, -elrate_diff), y=elrate_diff*100))+
  theme_classic()+
  scale_y_continuous()+
  geom_bar(stat="identity", aes(fill=elrate18))+
  scale_fill_gradient2(low="firebrick2", mid="gold", midpoint = 0.5, high="forestgreen", name="Electr. level (2018)",  labels = scales::percent_format(accuracy = 1))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75))+
  xlab("")+
  ylab("Perc. points change \n (2014-2018)")+
  guides(fill = guide_colourbar(barwidth = 10, barheight = 0.5, title.position = "top", title.hjust = 0.5))+
  theme(legend.position="bottom")

ggsave("Barplot_progress.pdf", plot = barplot_elrate, device = "pdf", width = 30, height = 15, units = "cm", scale=0.4)

barplot_absolute_day = ggplot(merged_diff, aes(x=reorder(GID_0, -gainedperday), y=gainedperday))+
  theme_classic()+
  geom_bar(stat="identity", aes(fill=elrate18))+
  scale_fill_gradient2(low="firebrick2", mid="gold", midpoint = 0.5, high="forestgreen", name="Electr. rate \n in 2018",  labels = scales::percent_format(accuracy = 1))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6))+
  xlab("Country")+
  ylab("Average new connectiosn \n  per day (2014-2018)")+
  guides(fill = guide_colourbar(barwidth = 0.5, barheight = 3.5))

ggsave("Barplot_absolute_day.pdf", plot = barplot_absolute_day, device = "pdf", width = 30, height = 12, units = "cm", scale=0.5)

barplot_popch = ggplot(merged_diff, aes(x=reorder(GID_0, -(pop18-pop14)/1000000), y=((pop18-pop14)/1000000)))+
  theme_classic()+
  scale_y_continuous()+
  geom_bar(stat="identity", aes(fill=(pop18-pop14)/pop14))+
  scale_fill_gradient2(low="maroon1", mid="gray32", midpoint = 0, high="limegreen", name="Percentage change (2014-2018)", labels = scales::percent_format(accuracy = 1))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75))+
  xlab("")+
  ylab("Popul. change (million)")+
  guides(fill = guide_colourbar(barwidth = 10, barheight = 0.5))+
  theme(legend.position="bottom")

ggsave("barplot_popch.pdf", plot = barplot_popch, device = "pdf", width = 30, height = 15, units = "cm", scale=0.4)

#3.2) Plot change in urban and rural electricity access rates between the two years considered
drive_download("pop18_rur.csv", type = "csv", overwrite = TRUE)
pop18_rur = read.csv("pop18_rur.csv")

drive_download("pop16_rur.csv", type = "csv", overwrite = TRUE)
pop16_rur = read.csv("pop16_rur.csv")

drive_download("pop14_rur.csv", type = "csv", overwrite = TRUE)
pop14_rur = read.csv("pop14_rur.csv")

drive_download("no_acc_18_rur.csv", type = "csv", overwrite = TRUE)
no_acc_18_rur = read.csv("no_acc_18_rur.csv")

drive_download("no_acc_16_rur.csv", type = "csv", overwrite = TRUE)
no_acc_16_rur = read.csv("no_acc_16_rur.csv")

drive_download("no_acc_14_rur.csv", type = "csv", overwrite = TRUE)
no_acc_14_rur = read.csv("no_acc_14_rur.csv")

#3.3) Merge different years, remove non Sub-Saharan countries and other misc provinces
merged_14_rur = merge(pop14_rur, no_acc_14_rur, by=c("GID_1"), all=TRUE)
merged_16_rur = merge(pop16_rur, no_acc_16_rur, by=c("GID_1"), all=TRUE)
merged_18_rur = merge(pop18_rur, no_acc_18_rur, by=c("GID_1"), all=TRUE)

merged_14_rur=subset(merged_14_rur, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")
merged_16_rur=subset(merged_16_rur, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")
merged_18_rur=subset(merged_18_rur, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")

merged_14_rur = dplyr::filter(merged_14_rur,  !is.na(GID_0.x))
merged_16_rur = dplyr::filter(merged_16_rur,  !is.na(GID_0.x))
merged_18_rur = dplyr::filter(merged_18_rur,  !is.na(GID_0.x))

#4) Calculate province-level electrification rates and merge them into a single dataframe 
merged_18_rur$elrate=(1-(merged_18_rur$sum.y / merged_18_rur$sum.x))
merged_16_rur$elrate=(1-(merged_16_rur$sum.y / merged_16_rur$sum.x))
merged_14_rur$elrate=(1-(merged_14_rur$sum.y / merged_14_rur$sum.x))

elrates_rur = data.frame(merged_18_rur$elrate, merged_16_rur$elrate, merged_14_rur$elrate, merged_14_rur$GID_1, merged_14_rur$GID_0.x, merged_18_rur$sum.x, merged_14_rur$sum.x)

varnames<-c("elrate18", "elrate16", "elrate14", "GID_1", "GID_0", "pop18", "pop14")

setnames(elrates_rur,names(elrates_rur),varnames )

#4.1) Calculate the change in electrification rates over the two years considered
elrates_rur$eldiff = elrates_rur$elrate18 - elrates_rur$elrate14 
elrates_rur$eldiffpc = (elrates_rur$elrate18 - elrates_rur$elrate14) / elrates_rur$elrate14

#4.2) Calculate national electrification rates
merged_14_countrylevel_rur = merged_14_rur %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_14_countrylevel_rur$elrate = (1-(merged_14_countrylevel_rur$popnoacc/merged_14_countrylevel_rur$pop))

merged_16_countrylevel_rur = merged_16_rur %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_16_countrylevel_rur$elrate = (1-(merged_16_countrylevel_rur$popnoacc/merged_16_countrylevel_rur$pop))

merged_18_countrylevel_rur = merged_18_rur %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_18_countrylevel_rur$elrate = (1-(merged_18_countrylevel_rur$popnoacc/merged_18_countrylevel_rur$pop))

merged_diff_rur=data.frame(merged_18_countrylevel_rur$GID_0.x, (merged_18_countrylevel_rur$elrate-merged_14_countrylevel_rur$elrate), merged_18_countrylevel_rur$elrate, merged_16_countrylevel_rur$elrate, merged_14_countrylevel_rur$elrate, merged_14_countrylevel_rur$pop, merged_18_countrylevel_rur$pop)
merged_diff_rur <- na.omit(merged_diff_rur)
varnames<-c("GID_0", "elrate_diff", "elrate18", "elrate16","elrate14", "pop14", "pop18")
setnames(merged_diff_rur,names(merged_diff_rur),varnames )

#4.3) Plot change in national electricity access rates between the two years considered
barplot_elrate_rur = ggplot(merged_diff_rur, aes(x=reorder(GID_0, -elrate_diff), y=elrate_diff*100))+
  theme_classic()+
  scale_y_continuous()+
  geom_bar(stat="identity", aes(fill=elrate18))+
  scale_fill_gradient2(low="firebrick2", mid="gold", midpoint = 0.5, high="forestgreen", name="2018",  labels = scales::percent_format(accuracy = 1))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=7.6))+
  xlab("")+
  ylab("Perc. points change \n (2014-2018)")+
  guides(fill = guide_colourbar(barwidth = 10, barheight = 0.5))+
  theme(legend.position="bottom")

ggsave("Barplot_progress_rural.pdf", plot = barplot_elrate_rur, device = "pdf", width = 30, height = 15, units = "cm", scale=0.4)

barplot_popch_rur = ggplot(merged_diff_rur, aes(x=reorder(GID_0, -(pop18-pop14)/1000000), y=((pop18-pop14)/1000000)))+
  theme_classic()+
  scale_y_continuous()+
  geom_bar(stat="identity", aes(fill=(pop18-pop14)/pop14))+
  scale_fill_gradient2(low="maroon1", mid="gray32", midpoint = 0, high="limegreen", name="Percentage change (2014-2018)", labels = scales::percent_format(accuracy = 1))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75))+
  xlab("")+
  ylab("Popul. change (million)")+
  guides(fill = guide_colourbar(barwidth = 10, barheight = 0.5))+
  theme(legend.position="bottom")

ggsave("barplot_popch_rur.pdf", plot = barplot_popch_rur, device = "pdf", width = 30, height = 15, units = "cm", scale=0.4)

##Urban
drive_download("pop18_urb.csv", type = "csv", overwrite = TRUE)
pop18_urb = read.csv("pop18_urb.csv")

drive_download("pop16_urb.csv", type = "csv", overwrite = TRUE)
pop16_urb = read.csv("pop16_urb.csv")

drive_download("pop14_urb.csv", type = "csv", overwrite = TRUE)
pop14_urb = read.csv("pop14_urb.csv")

drive_download("no_acc_18_urb.csv", type = "csv", overwrite = TRUE)
no_acc_18_urb = read.csv("no_acc_18_urb.csv")

drive_download("no_acc_16_urb.csv", type = "csv", overwrite = TRUE)
no_acc_16_urb = read.csv("no_acc_16_urb.csv")

drive_download("no_acc_14_urb.csv", type = "csv", overwrite = TRUE)
no_acc_14_urb = read.csv("no_acc_14_urb.csv")

# Merge different years, remove non Sub-Saharan countries and other misc provinces
merged_14_urb = merge(pop14_urb, no_acc_14_urb, by=c("GID_1"), all=TRUE)
merged_16_urb = merge(pop16_urb, no_acc_16_urb, by=c("GID_1"), all=TRUE)
merged_18_urb = merge(pop18_urb, no_acc_18_urb, by=c("GID_1"), all=TRUE)

merged_14_urb=subset(merged_14_urb, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")
merged_16_urb=subset(merged_16_urb, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")
merged_18_urb=subset(merged_18_urb, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")

merged_14_urb = dplyr::filter(merged_14_urb,  !is.na(GID_0.x))
merged_16_urb = dplyr::filter(merged_16_urb,  !is.na(GID_0.x))
merged_18_urb = dplyr::filter(merged_18_urb,  !is.na(GID_0.x))

# Calculate province-level electrification rates and merge them into a single dataframe 
merged_18_urb$elrate=(1-(merged_18_urb$sum.y / merged_18_urb$sum.x))
merged_16_urb$elrate=(1-(merged_16_urb$sum.y / merged_16_urb$sum.x))
merged_14_urb$elrate=(1-(merged_14_urb$sum.y / merged_14_urb$sum.x))

elrates_urb = data.frame(merged_18_urb$elrate, merged_16_urb$elrate, merged_14_urb$elrate, merged_14_urb$GID_1, merged_14_urb$GID_0.x, merged_18_rur$sum.x, merged_14_rur$sum.x)

varnames<-c("elrate18", "elrate16", "elrate14", "GID_1", "GID_0", "pop18", "pop14")
setnames(elrates_urb,names(elrates_urb),varnames )

# Calculate the change in electrification rates over the two years considered
elrates_urb$eldiff = elrates_urb$elrate18 - elrates_urb$elrate14 
elrates_urb$eldiffpc = (elrates_urb$elrate18 - elrates_urb$elrate14) / elrates_urb$elrate14

# Calculate national electrification rates
merged_14_countrylevel_urb = merged_14_urb %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_14_countrylevel_urb$elrate = (1-(merged_14_countrylevel_urb$popnoacc/merged_14_countrylevel_urb$pop))

merged_16_countrylevel_urb = merged_16_urb %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_16_countrylevel_urb$elrate = (1-(merged_16_countrylevel_urb$popnoacc/merged_16_countrylevel_urb$pop))

merged_18_countrylevel_urb = merged_18_urb %>% group_by(GID_0.x) %>% dplyr::summarize(pop=sum(sum.x,na.rm = T), popnoacc=sum(sum.y,na.rm = T)) %>% ungroup()
merged_18_countrylevel_urb$elrate = (1-(merged_18_countrylevel_urb$popnoacc/merged_18_countrylevel_urb$pop))

merged_diff_urb=data.frame(merged_18_countrylevel_urb$GID_0.x, (merged_18_countrylevel_urb$elrate-merged_14_countrylevel_urb$elrate), merged_18_countrylevel_urb$elrate, merged_16_countrylevel_urb$elrate, merged_14_countrylevel_urb$elrate, merged_14_countrylevel_urb$pop, merged_18_countrylevel_urb$pop)
merged_diff_urb <- na.omit(merged_diff_urb)
varnames<-c("GID_0", "elrate_diff", "elrate18", "elrate16","elrate14", "pop14", "pop18")
setnames(merged_diff_urb,names(merged_diff_urb),varnames )

# Plot change in national electricity access rates between the two years considered
barplot_elrate_urb = ggplot(merged_diff_urb, aes(x=reorder(GID_0, -elrate_diff), y=elrate_diff*100))+
  theme_classic()+
  scale_y_continuous()+
  geom_bar(stat="identity", aes(fill=elrate18))+
  scale_fill_gradient2(low="firebrick2", mid="gold", midpoint = 0.5, high="forestgreen", name="2018",  labels = scales::percent_format(accuracy = 1))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75))+
  xlab("")+
  ylab("Perc. points change \n (2014-2018)")+
  guides(fill = guide_colourbar(barwidth = 10, barheight = 0.5))+
  theme(legend.position="bottom")

ggsave("Barplot_progress_urban.pdf", plot = barplot_elrate_urb, device = "pdf", width = 30, height = 15, units = "cm", scale=0.4)

barplot_popch_urb = ggplot(merged_diff_urb, aes(x=reorder(GID_0, -(pop18-pop14)/1000000), y=((pop18-pop14)/1000000)))+
  theme_classic()+
  scale_y_continuous()+
  geom_bar(stat="identity", aes(fill=(pop18-pop14)/pop14))+
  scale_fill_gradient2(low="maroon1", mid="gray32", midpoint = 0, high="limegreen", name="Percentage change (2014-2018)", labels = scales::percent_format(accuracy = 1))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75))+
  xlab("")+
  ylab("Popul. change (million)")+
  guides(fill = guide_colourbar(barwidth = 10, barheight = 0.5, title.position = "top", title.hjust = 0.5))+
  theme(legend.position="bottom")

ggsave("barplot_popch_urb.pdf", plot = barplot_popch_urb, device = "pdf", width = 30, height = 15, units = "cm", scale=0.4)


pgrid = plot_grid(barplot_elrate + theme(legend.position="none", plot.title = element_text(hjust = 0.5)) + ggtitle("Electrification level"), barplot_popch + theme(legend.position="none", plot.title = element_text(hjust = 0.5)) + ggtitle("Population"), barplot_elrate_urb + theme(legend.position="none"), barplot_popch_urb + theme(legend.position="none"), barplot_elrate_rur + theme(legend.position="none"), barplot_popch_rur + theme(legend.position="none"), rel_heights = c(1.05, 1.05, 1, 1, 1, 1), ncol=2, nrow = 3)

pgrid_titles = plot_grid(ggdraw() + draw_label("National", size = 10), ggdraw() + draw_label("Urban", size = 10), ggdraw() + draw_label("Rural", size = 10), nrow = 3, ncol = 1)

pgrid = plot_grid(pgrid_titles, pgrid, ncol=2, rel_widths = c(0.1, 1))

pgrid = plot_grid(pgrid, plot_grid(get_legend(barplot_elrate), get_legend(barplot_popch_urb), ncol=2, nrow = 1), ncol = 1, rel_heights = c(1, 0.1))

ggsave("barplots.png", plot = pgrid, device = "png", width = 55, height = 40, units = "cm", scale=0.4)
ggsave("barplots.pdf", plot = pgrid, device = "pdf", width = 55, height = 40, units = "cm", scale=0.4)


#5) inequality in ACCESS: calculate indexes and produce Lorenz Curve graphs
shapefile = st_read("shapefile/gadm36_1.shp")
shapefile = merge(shapefile, elrates, by=c("GID_1"), all=TRUE)
data = shapefile

#loop for graphs
colist=unique(elrates$GID_0)
ine14=list()
ine18=list()
lorenz=list()

for (Z in colist){
  datin=subset(data, data$GID_0.x== Z)
  #sort data 
  out14 = sort(datin$elrate14*(datin$pop14/ave(datin$pop14, datin$GID_0.x, FUN=sum)))
  out18 = sort(datin$elrate18*(datin$pop18/ave(datin$pop18, datin$GID_0.x, FUN=sum)))
  
  #calculate within-country Gini-index in access rate ineqaulity
  ine14[[Z]] = ineq(out14,type="Gini")
  ine18[[Z]] = ineq(out18,type="Gini")
  #plot and store Lorenz curve
  Lorenz=Lc(out14, plot =F)
  p14 <- Lorenz$p
  L14 <- Lorenz$L
  out_df14 <- data.frame(p14,L14)
  
  Lorenz=Lc(out18, plot =F)
  p18 <- Lorenz$p
  L18 <- Lorenz$L
  out_df18 <- data.frame(p18,L18)
  
  
  databoth = merge(out_df18, out_df14, by.x="p18", by.y="p14")
  databoth$difference = databoth$L18 - databoth$L14
  
  lorenz[[Z]] = ggplot() +
    theme_classic()+
    geom_line(data = out_df14, aes(x=p14, y=L14, colour="red"), size=1, alpha=0.8) +
    geom_line(data = out_df18, aes(x=p18, y=L18, color="darkblue"), size=1, alpha=0.8)+
    geom_line(data = databoth, aes(x=p18, y=difference, color="black"), size=1, alpha=0.8)+
    scale_color_discrete(name = "Legend", labels = c("Difference", "2018", "2014"))+
    geom_hline(yintercept = 0, alpha=0.5)+
    scale_x_continuous(name="Cum. percentage of popul. \n from lowest to highest electrified", limits=c(0,1)) + 
    scale_y_continuous(name="Cum. percentage of \n national electr. access", limits=c(-0.1,1), sec.axis = sec_axis(trans= ~  .)) +
    geom_abline()+
    geom_point(data = out_df18, aes(x=p18, y=L18), size=0.3)+
    geom_point(data = out_df14, aes(x=p14, y=L14), size=0.3)+
    theme(axis.text=element_text(size=6),
          axis.title=element_text(size=6))
  
  data = as.data.frame(shapefile)
  
}


pgrid = plot_grid(lorenz[['BDI']] + theme(legend.position="none"), lorenz[['KEN']] + theme(legend.position="none"), lorenz[['ETH']] + theme(legend.position="none"), lorenz[['TZA']] + theme(legend.position="none"), lorenz[['NGA']]  + theme(legend.position="none"), lorenz[['COD']] + theme(legend.position="none"), lorenz[['GHA']] + theme(legend.position="none"), lorenz[['ZAF']] + theme(legend.position="none"), lorenz[['AGO']] + theme(legend.position="none"),  labels=c("BDI", "KEN", "ETH", "TZA", "NGA", "COD", "GHA", "ZAF", "AGO"), label_size = 6, hjust= 0, ncol=3)
legend <- get_legend(lorenz[['BDI']])
p <- plot_grid(pgrid, legend, ncol = 2, rel_widths = c(0.4, .1))
ggsave("Lorenz.pdf", p, device = "pdf", width = 50, height = 30, units = "cm", scale=0.35)

ginis14 = as.data.frame(ine14)
ginis14 = melt(ginis14)
ginis18 = as.data.frame(ine18)
ginis18 = melt(ginis18)
ginis = data.frame(ginis14$variable, ginis14$value, ginis18$value, (ginis18$value-ginis14$value))
varnames<-c("ISO3", "Gini14", "Gini18", "DiffGini")
setnames(ginis,names(ginis),varnames )


ginis_access <- joinCountryData2Map(ginis, joinCode = "ISO3",
                                    nameJoinColumn = "ISO3")

ginis_access@data=data.frame(ginis_access@data$ISO3, ginis_access@data$Gini14, ginis_access@data$Gini18, ginis_access@data$DiffGini)
writeOGR(layer="ginis_access2", obj =ginis_access,  driver = "ESRI Shapefile", dsn=getwd())

ginis_access = readOGR("ginis_access2.shp")

ginis_access@data$id = rownames(ginis_access@data)
poly_rgn_df <- fortify(ginis_access, region = 'id')

poly_rgn_df <- poly_rgn_df %>%
  left_join(ginis_access@data, by = 'id')

cnames <- aggregate(cbind(long, lat) ~  g___ISO, data=poly_rgn_df, 
                    FUN=function(x)mean(range(x))) 

theme_clean <- function(base_size = 12) {
  require(grid)
  theme_grey(base_size) %+replace%
    theme(
      axis.title = element_blank(),
      axis.text = element_blank(),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.ticks.length = unit(0,"cm"), 
      axis.ticks.margin = unit(0,"cm"),
      panel.margin = unit(0,"lines"),
      plot.margin = unit(c(0, 0, 0, 0), "lines"),
      complete = TRUE
    )}

poly_rgn_df = poly_rgn_df[complete.cases(poly_rgn_df), ]

#Produce map of inequality in access
mapginiaccess = ggplot(data = poly_rgn_df, aes(long, lat, group=group, fill=g___G18)) +
  geom_polygon(colour = "white") +
  coord_map(projection = "mercator") +
  theme_clean()+
  scale_fill_gradient2(high = "darkred", midpoint = 0.5, mid="gold", low = "forestgreen", na.value = "grey50", guide = "colorbar",  name="Electr. acc. Gini")

ggsave("Mapginiaccess.pdf", plot = mapginiaccess, device = "pdf", width = 15, height = 15, units = "cm", scale=0.8)


##Urban inequality
shapefile = st_read("shapefile/gadm36_1.shp")
shapefile = merge(shapefile, elrates_urb, by=c("GID_1"), all=TRUE)
data = shapefile

#loop for graphs
colist=unique(elrates_urb$GID_0)
ine14=list()
ine18=list()
lorenz=list()

for (Z in colist){
  datin=subset(data, data$GID_0.x== Z)
  #sort data 
  out14 = sort(datin$elrate14*(datin$pop14/ave(datin$pop14, datin$GID_0.x, FUN=sum)))
  out18 = sort(datin$elrate18*(datin$pop18/ave(datin$pop18, datin$GID_0.x, FUN=sum)))
  
  #calculate within-country Gini-index in access rate ineqaulity
  ine14[[Z]] = ineq(out14,type="Gini")
  ine18[[Z]] = ineq(out18,type="Gini")
  #plot and store Lorenz curve
  Lorenz=Lc(out14, plot =F)
  p14 <- Lorenz$p
  L14 <- Lorenz$L
  out_df14 <- data.frame(p14,L14)
  
  Lorenz=Lc(out18, plot =F)
  p18 <- Lorenz$p
  L18 <- Lorenz$L
  out_df18 <- data.frame(p18,L18)
  
  
  databoth = merge(out_df18, out_df14, by.x="p18", by.y="p14")
  databoth$difference = databoth$L18 - databoth$L14
  
  lorenz[[Z]] = ggplot() +
    theme_classic()+
    geom_line(data = out_df14, aes(x=p14, y=L14, colour="red"), size=1, alpha=0.8) +
    geom_line(data = out_df18, aes(x=p18, y=L18, color="darkblue"), size=1, alpha=0.8)+
    geom_line(data = databoth, aes(x=p18, y=difference, color="black"), size=1, alpha=0.8)+
    scale_color_discrete(name = "Legend", labels = c("Difference", "2018", "2014"))+
    geom_hline(yintercept = 0, alpha=0.5)+
    scale_x_continuous(name="", limits=c(0,1)) + 
    scale_y_continuous(name="", limits=c(-0.1,1)) +
    geom_abline()+
    geom_point(data = out_df18, aes(x=p18, y=L18), size=0.3)+
    geom_point(data = out_df14, aes(x=p14, y=L14), size=0.3)+
    theme(axis.text=element_text(size=7.5),
          axis.title=element_text(size=7.5))
  
  data = as.data.frame(shapefile)
  
}


ppp = as.data.frame(merge(melt(ine18), melt(ine14), by="L1"))
ppp$change=ppp$value.x-ppp$value.y

library(grid)

pgrid = plot_grid(lorenz[['RWA']] + theme(legend.position="none"), lorenz[['KEN']] + theme(legend.position="none"), lorenz[['ETH']] + theme(legend.position="none"), lorenz[['NGA']]  + theme(legend.position="none"), lorenz[['COD']] + theme(legend.position="none"), lorenz[['UGA']] + theme(legend.position="none"), labels=c("RWA", "KEN", "ETH", "NGA", "COD", "UGA"), label_size = 8, hjust= 0, vjust = 1, ncol=2)

ylab <- ggdraw() + draw_label("Cum. fraction of national electr. access", size = 10, angle = 90)

pgrid_u = plot_grid(ylab, pgrid, ncol=2, rel_widths =c(0.1, 1))

tit_urb <- ggdraw() + draw_label("Urban", size = 10)

pgrid_u = plot_grid(tit_urb, pgrid_u, ncol=1, rel_heights=c(0.05, 1))


##Rural inequality 
shapefile = st_read("shapefile/gadm36_1.shp")
shapefile = merge(shapefile, elrates_rur, by=c("GID_1"), all=TRUE)
data = shapefile

#loop for graphs
colist=unique(elrates_rur$GID_0)
ine14=list()
ine18=list()
lorenz=list()

for (Z in colist){
  datin=subset(data, data$GID_0.x== Z)
  #sort data 
  out14 = sort(datin$elrate14*(datin$pop14/ave(datin$pop14, datin$GID_0.x, FUN=sum)))
  out18 = sort(datin$elrate18*(datin$pop18/ave(datin$pop18, datin$GID_0.x, FUN=sum)))
  
  #calculate within-country Gini-index in access rate ineqaulity
  ine14[[Z]] = ineq(out14,type="Gini")
  ine18[[Z]] = ineq(out18,type="Gini")
  #plot and store Lorenz curve
  Lorenz=Lc(out14, plot =F)
  p14 <- Lorenz$p
  L14 <- Lorenz$L
  out_df14 <- data.frame(p14,L14)
  
  Lorenz=Lc(out18, plot =F)
  p18 <- Lorenz$p
  L18 <- Lorenz$L
  out_df18 <- data.frame(p18,L18)
  
  
  databoth = merge(out_df18, out_df14, by.x="p18", by.y="p14")
  databoth$difference = databoth$L18 - databoth$L14
  
  lorenz[[Z]] = ggplot() +
    theme_classic()+
    geom_line(data = out_df14, aes(x=p14, y=L14, colour="red"), size=1, alpha=0.8) +
    geom_line(data = out_df18, aes(x=p18, y=L18, color="darkblue"), size=1, alpha=0.8)+
    geom_line(data = databoth, aes(x=p18, y=difference, color="black"), size=1, alpha=0.8)+
    scale_color_discrete(name = "Legend", labels = c("Difference", "2018", "2014"))+
    geom_hline(yintercept = 0, alpha=0.5)+
    scale_x_continuous(name=" ", limits=c(0,1)) + 
    scale_y_continuous(name=" ", limits=c(-0.1,1)) +
    geom_abline()+
    geom_point(data = out_df18, aes(x=p18, y=L18), size=0.3)+
    geom_point(data = out_df14, aes(x=p14, y=L14), size=0.3)+
    theme(axis.text=element_text(size=7.5),
          axis.title=element_text(size=7.5))
  
  data = as.data.frame(shapefile)
  
}

ppp = as.data.frame(merge(melt(ine18), melt(ine14), by="L1"))


pgrid = plot_grid(lorenz[['RWA']] + theme(legend.position="none"), lorenz[['KEN']] + theme(legend.position="none"), lorenz[['ETH']] + theme(legend.position="none"), lorenz[['NGA']]  + theme(legend.position="none"), lorenz[['COD']] + theme(legend.position="none"), lorenz[['UGA']] + theme(legend.position="none"), labels=c("RWA", "KEN", "ETH", "NGA", "COD", "UGA"), label_size = 8, hjust= 0, vjust=1, ncol=2)

tit_rur <- ggdraw() + draw_label("Rural", size = 10)

pgrid = plot_grid(tit_rur, pgrid, ncol=1, rel_heights=c(0.05,1))

pgrid = plot_grid(pgrid_u, pgrid, ncol=2, rel_heights=c(1,1), rel_widths = c(1.05,1))

xlab <- ggdraw() + draw_label("Cum. fraction of popul. from lowest to highest electrified", size = 10)

pgrid = plot_grid(pgrid, xlab, ncol=1, rel_heights=c(1, 0.05))

legend <- get_legend(lorenz[['RWA']])

p <- plot_grid(pgrid, legend, ncol = 2, rel_widths = c(0.6, .1))

ggsave("Lorenz.pdf", p, device = "pdf", width = 38, height = 22, units = "cm", scale=0.6)
ggsave("Lorenz.png", p, device = "png", width = 38, height = 22, units = "cm", scale=0.6)


# 6) Consumption tiers analysis
#Import rural 'consumption' tiers for 2018
drive_download("pop18_tier_0_rural.csv", type = "csv", overwrite = TRUE)
pop18_tier_0_rural = read.csv("pop18_tier_0_rural.csv")
pop18_tier_0_rural = data.frame(pop18_tier_0_rural$sum, pop18_tier_0_rural$GID_1)
varnames<-c("pop_tier_0_rural", "GID_1")
setnames(pop18_tier_0_rural,names(pop18_tier_0_rural),varnames )

drive_download("pop18_tier_1_rural.csv", type = "csv", overwrite = TRUE)
pop18_tier_1_rural = read.csv("pop18_tier_1_rural.csv")
pop18_tier_1_rural = data.frame(pop18_tier_1_rural$sum, pop18_tier_1_rural$GID_1)
varnames<-c("pop_tier_1_rural", "GID_1")
setnames(pop18_tier_1_rural,names(pop18_tier_1_rural),varnames )

drive_download("pop18_tier_2_rural.csv", type = "csv", overwrite = TRUE)
pop18_tier_2_rural = read.csv("pop18_tier_2_rural.csv")
pop18_tier_2_rural = data.frame(pop18_tier_2_rural$sum, pop18_tier_2_rural$GID_1)
varnames<-c("pop_tier_2_rural", "GID_1")
setnames(pop18_tier_2_rural,names(pop18_tier_2_rural),varnames )

drive_download("pop18_tier_3_rural.csv", type = "csv", overwrite = TRUE)
pop18_tier_3_rural = read.csv("pop18_tier_3_rural.csv")
pop18_tier_3_rural = data.frame(pop18_tier_3_rural$sum, pop18_tier_3_rural$GID_1)
varnames<-c("pop_tier_3_rural", "GID_1")
setnames(pop18_tier_3_rural,names(pop18_tier_3_rural),varnames )

drive_download("pop18_tier_4_rural.csv", type = "csv", overwrite = TRUE)
pop18_tier_4_rural = read.csv("pop18_tier_4_rural.csv")
pop18_tier_4_rural = data.frame(pop18_tier_4_rural$sum, pop18_tier_4_rural$GID_1)
varnames<-c("pop_tier_4_rural", "GID_1")
setnames(pop18_tier_4_rural,names(pop18_tier_4_rural),varnames )

elrates18 = Reduce(function(x,y) merge(x,y,by="GID_1",all=TRUE) ,list(elrates, pop18_tier_0_rural, pop18_tier_1_rural, pop18_tier_2_rural, pop18_tier_3_rural, pop18_tier_4_rural))
elrates_BK_18 = elrates18

elrates18=subset(elrates18, GID_0 != "ATF" & GID_0 != "EGY" & GID_0 != "ESH"& GID_0 != "ESP" & GID_0 != "LBY" & GID_0 != "MAR" & GID_0 != "MYT" & GID_0 != "SYC" & GID_0 != "COM" & GID_0 != "YEM" & GID_0 != "TUN" & GID_0 != "DZA")
elrates18 = dplyr::filter(elrates18,  !is.na(GID_0))

# calculate gini index of consumption among those with access within each province
colist=unique(elrates18$GID_0)
output_d_18=list()
for (A in colist){
  datin=subset(elrates18, elrates18$GID_0== A)
  
  datin$share_tier_0_rural=datin$pop_tier_0_rural/(datin$pop_tier_0_rural+datin$pop_tier_1_rural+datin$pop_tier_2_rural+datin$pop_tier_3_rural+datin$pop_tier_4_rural)
  datin$share_tier_1_rural=datin$pop_tier_1_rural/(datin$pop_tier_0_rural+datin$pop_tier_1_rural+datin$pop_tier_2_rural+datin$pop_tier_3_rural+datin$pop_tier_4_rural)
  datin$share_tier_2_rural=datin$pop_tier_2_rural/(datin$pop_tier_0_rural+datin$pop_tier_1_rural+datin$pop_tier_2_rural+datin$pop_tier_3_rural+datin$pop_tier_4_rural)
  datin$share_tier_3_rural=datin$pop_tier_3_rural/(datin$pop_tier_0_rural+datin$pop_tier_1_rural+datin$pop_tier_2_rural+datin$pop_tier_3_rural+datin$pop_tier_4_rural)
  datin$share_tier_4_rural=datin$pop_tier_4_rural/(datin$pop_tier_0_rural+datin$pop_tier_1_rural+datin$pop_tier_2_rural+datin$pop_tier_3_rural+datin$pop_tier_4_rural)
  
  datin=data.frame(datin$GID_0, datin$GID_1, datin$share_tier_0_rural, datin$share_tier_1_rural,datin$share_tier_2_rural,datin$share_tier_3_rural,datin$share_tier_4_rural)
  
  #reshape by making rows columns and by naming such columns after GID_1 of that row
  datin = reshape(datin, direction="long", idvar=c("datin.GID_1", "datin.GID_0"), varying = c("datin.share_tier_0_rural", "datin.share_tier_1_rural", "datin.share_tier_2_rural", "datin.share_tier_3_rural", "datin.share_tier_4_rural"))
  datin2 = reshape(datin, direction="wide", idvar=c("time"), timevar = c("datin.GID_1"))
  datin3 = dplyr::select(datin2, - matches("GID_0|time"))
  
  #calculate gini indexes
  output = lapply(1:ncol(datin3), function(X){ineq(datin3[, X],type="Gini")})
  output = unlist(output)
  output = as.data.frame(rbind(output, colnames(datin3)))
  output_d_18[[A]] = output
  elrates18 = elrates_BK_18
}

#calculate summary statistics for the gini indexes in each country (mean, max, min, obs...)
lis_18 = 1:length(output_d_18)

fune_18 = function(X){  
  as.data.frame(t(output_d_18[[X]][1, ]))
}

store_18 = lapply(lis_18, fune_18)

#index of number-country to select which to visualise
#View(colist)

#summary statistics for inequality in consumption within provinces
# i.e. here we see the within-province inequality in consumption for those with access
#a distribution of the inequality within each region of the country
functi_18 = function(x){
  summary(as.numeric(levels(store_18[[x]]$output))[store_18[[x]]$output])
}
distribution_inequality_18 = lapply(c(1:43), functi_18)


#what if we wanted to see the between province inequality in consumption for those with access?
#simply calculate the gini of the last object
#One figures which sums up inequality at the national level
functi2_18= function(x){
  ineq(as.numeric(levels(store_18[[x]]$output))[store_18[[x]]$output],type="Gini")
}

national_inequality_18 = lapply(c(1:43), functi2_18)


##Column plot split of consumption (RURAL)
data_cons = data.frame(elrates18$GID_0, elrates18$GID_1, elrates18$pop_tier_0_rural, elrates18$pop_tier_1_rural, elrates18$pop_tier_2_rural,elrates18$pop_tier_3_rural,elrates18$pop_tier_4_rural)
varnames<-c("GID_0", "GID_1", "t0_18", "t1_18", "t2_18", "t3_18", "t4_18")
setnames(data_cons,names(data_cons),varnames )

dfm <- gather(data_cons, key=tier, value=value, "t0_18", 't1_18','t2_18','t3_18', 't4_18')

dfm_sum = dfm %>% 
  dplyr::group_by(GID_0, tier) %>% 
  dplyr::summarise(value = sum(value))

dfm_sum <- na.omit(dfm_sum)

colist=unique(dfm_sum$GID_0)
gini=list()

for (Z in colist){
  datin=subset(dfm_sum, dfm_sum$GID_0== Z)
  gini_s = sort(datin$value)
  gini[[Z]] = ineq(gini_s,type="Gini")
}  

gini_cons_flat = as.data.frame(gini)
gini_cons_flat = melt(gini_cons_flat)
varnames<-c("ISO3", "Gini_cons")
setnames(gini_cons_flat,names(gini_cons_flat),varnames )

#ADD Population without access as 0
#plot actual population instead of share
#add secondary y axis with share

#currently looks okay for the numbers, but not best visualisatio n 

barplot_consumption_rur = ggplot() + 
  theme_classic()+
  geom_bar(data = dfm_sum, aes(x = GID_0, y = value, fill = tier),stat = "identity", position = "fill") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75), legend.position="none", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  ggtitle("Rural")+
  ylab("")+
  xlab("")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))

barplot_consumption_rur_abs = ggplot() + 
  theme_classic()+
  geom_bar(data = dfm_sum, aes(x=reorder(GID_0, -value), y = value/1000000, fill = tier),stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75), legend.position="none", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  ggtitle("")+
  ylab("")+
  xlab("")+
  scale_y_continuous()

ggsave("Barplot_consumption_rur.pdf", plot = barplot_consumption, device = "pdf", width = 34, height = 14, units = "cm", scale=0.6)

##
#Import urban consumption' tiers for 2018
drive_download("pop18_tier_0_urban.csv", type = "csv", overwrite = TRUE)
pop18_tier_0_urban = read.csv("pop18_tier_0_urban.csv")
pop18_tier_0_urban = data.frame(pop18_tier_0_urban$sum, pop18_tier_0_urban$GID_1)
varnames<-c("pop_tier_0_urban", "GID_1")
setnames(pop18_tier_0_urban,names(pop18_tier_0_urban),varnames )

drive_download("pop18_tier_1_urban.csv", type = "csv", overwrite = TRUE)
pop18_tier_1_urban = read.csv("pop18_tier_1_urban.csv")
pop18_tier_1_urban = data.frame(pop18_tier_1_urban$sum, pop18_tier_1_urban$GID_1)
varnames<-c("pop_tier_1_urban", "GID_1")
setnames(pop18_tier_1_urban,names(pop18_tier_1_urban),varnames )

drive_download("pop18_tier_2_urban.csv", type = "csv", overwrite = TRUE)
pop18_tier_2_urban = read.csv("pop18_tier_2_urban.csv")
pop18_tier_2_urban = data.frame(pop18_tier_2_urban$sum, pop18_tier_2_urban$GID_1)
varnames<-c("pop_tier_2_urban", "GID_1")
setnames(pop18_tier_2_urban,names(pop18_tier_2_urban),varnames )

drive_download("pop18_tier_3_urban.csv", type = "csv", overwrite = TRUE)
pop18_tier_3_urban = read.csv("pop18_tier_3_urban.csv")
pop18_tier_3_urban = data.frame(pop18_tier_3_urban$sum, pop18_tier_3_urban$GID_1)
varnames<-c("pop_tier_3_urban", "GID_1")
setnames(pop18_tier_3_urban,names(pop18_tier_3_urban),varnames )

drive_download("pop18_tier_4_urban.csv", type = "csv", overwrite = TRUE)
pop18_tier_4_urban = read.csv("pop18_tier_4_urban.csv")
pop18_tier_4_urban = data.frame(pop18_tier_4_urban$sum, pop18_tier_4_urban$GID_1)
varnames<-c("pop_tier_4_urban", "GID_1")
setnames(pop18_tier_4_urban,names(pop18_tier_4_urban),varnames )

elrates18 = Reduce(function(x,y) merge(x,y,by="GID_1",all=TRUE) ,list(elrates, pop18_tier_0_urban, pop18_tier_1_urban, pop18_tier_2_urban, pop18_tier_3_urban, pop18_tier_4_urban))
elrates_BK_18 = elrates18

elrates18=subset(elrates18, GID_0 != "ATF" & GID_0 != "EGY" & GID_0 != "ESH"& GID_0 != "ESP" & GID_0 != "LBY" & GID_0 != "MAR" & GID_0 != "MYT" & GID_0 != "SYC" & GID_0 != "COM" & GID_0 != "YEM" & GID_0 != "TUN" & GID_0 != "DZA")
elrates18 = dplyr::filter(elrates18,  !is.na(GID_0))

# calculate gini index of consumption among those with access within each province
colist=unique(elrates18$GID_0)
output_d_18=list()
for (A in colist){
  datin=subset(elrates18, elrates18$GID_0== A)
  
  datin$share_tier_0_urban=datin$pop_tier_0_urban/(datin$pop_tier_0_urban+datin$pop_tier_1_urban+datin$pop_tier_2_urban+datin$pop_tier_3_urban+datin$pop_tier_4_urban)
  datin$share_tier_1_urban=datin$pop_tier_1_urban/(datin$pop_tier_0_urban+datin$pop_tier_1_urban+datin$pop_tier_2_urban+datin$pop_tier_3_urban+datin$pop_tier_4_urban)
  datin$share_tier_2_urban=datin$pop_tier_2_urban/(datin$pop_tier_0_urban+datin$pop_tier_1_urban+datin$pop_tier_2_urban+datin$pop_tier_3_urban+datin$pop_tier_4_urban)
  datin$share_tier_3_urban=datin$pop_tier_3_urban/(datin$pop_tier_0_urban+datin$pop_tier_1_urban+datin$pop_tier_2_urban+datin$pop_tier_3_urban+datin$pop_tier_4_urban)
  datin$share_tier_4_urban=datin$pop_tier_4_urban/(datin$pop_tier_0_urban+datin$pop_tier_1_urban+datin$pop_tier_2_urban+datin$pop_tier_3_urban+datin$pop_tier_4_urban)
  
  datin=data.frame(datin$GID_0, datin$GID_1, datin$share_tier_0_urban, datin$share_tier_1_urban,datin$share_tier_2_urban,datin$share_tier_3_urban,datin$share_tier_4_urban)
  
  #reshape by making rows columns and by naming such columns after GID_1 of that row
  datin = reshape(datin, direction="long", idvar=c("datin.GID_1", "datin.GID_0"), varying = c("datin.share_tier_0_urban", "datin.share_tier_1_urban", "datin.share_tier_2_urban", "datin.share_tier_3_urban", "datin.share_tier_4_urban"))
  datin2 = reshape(datin, direction="wide", idvar=c("time"), timevar = c("datin.GID_1"))
  datin3 = dplyr::select(datin2, - matches("GID_0|time"))
  
  #calculate gini indexes
  output = lapply(1:ncol(datin3), function(X){ineq(datin3[, X],type="Gini")})
  output = unlist(output)
  output = as.data.frame(rbind(output, colnames(datin3)))
  output_d_18[[A]] = output
  elrates18 = elrates_BK_18
}

#calculate summary statistics for the gini indexes in each country (mean, max, min, obs...)
lis_18 = 1:length(output_d_18)

fune_18 = function(X){  
  as.data.frame(t(output_d_18[[X]][1, ]))
}

store_18 = lapply(lis_18, fune_18)

#index of number-country to select which to visualise
#View(colist)

#summary statistics for inequality in consumption within provinces
# i.e. here we see the within-province inequality in consumption for those with access
#a distribution of the inequality within each region of the country
functi_18 = function(x){
  summary(as.numeric(levels(store_18[[x]]$output))[store_18[[x]]$output])
}
distribution_inequality_18 = lapply(c(1:43), functi_18)


#what if we wanted to see the between province inequality in consumption for those with access?
#simply calculate the gini of the last object
#One figures which sums up inequality at the national level
functi2_18= function(x){
  ineq(as.numeric(levels(store_18[[x]]$output))[store_18[[x]]$output],type="Gini")
}

national_inequality_18 = lapply(c(1:43), functi2_18)


##Column plot split of consumption (urban)
data_cons = data.frame(elrates18$GID_0, elrates18$GID_1, elrates18$pop_tier_0_urban, elrates18$pop_tier_1_urban, elrates18$pop_tier_2_urban,elrates18$pop_tier_3_urban,elrates18$pop_tier_4_urban)
varnames<-c("GID_0", "GID_1", "t0_18", "t1_18", "t2_18", "t3_18", "t4_18")
setnames(data_cons,names(data_cons),varnames )

dfm <- gather(data_cons, key=tier, value=value, "t0_18", 't1_18','t2_18','t3_18', 't4_18')

dfm_sum = dfm %>% 
  dplyr::group_by(GID_0, tier) %>% 
  dplyr::summarise(value = sum(value))

dfm_sum <- na.omit(dfm_sum)

colist=unique(dfm_sum$GID_0)
gini=list()

for (Z in colist){
  datin=subset(dfm_sum, dfm_sum$GID_0== Z)
  gini_s = sort(datin$value)
  gini[[Z]] = ineq(gini_s,type="Gini")
}  

gini_cons_flat = as.data.frame(gini)
gini_cons_flat = melt(gini_cons_flat)
varnames<-c("ISO3", "Gini_cons")
setnames(gini_cons_flat,names(gini_cons_flat),varnames )

#ADD Population without access as 0
#plot actual population instead of share
#add secondary y axis with share

#currently looks okay for the numbers, but not best visualisatio n 
barplot_consumption_urb = ggplot() + 
  theme_classic()+
  geom_bar(data = dfm_sum ,aes(x = GID_0, y = value, fill = tier), stat = "identity", position="fill") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75), legend.position="bottom", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  ggtitle("Urban")+
  ylab("")+
  xlab("")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))

barplot_consumption_urb_abs = ggplot() + 
  theme_classic()+
  geom_bar(data = dfm_sum ,aes(x=reorder(GID_0, -value), y = value/1000000, fill = tier), stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=6.75), legend.position="bottom", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  ggtitle("")+
  ylab("")+
  xlab("")


pgrid = plot_grid(barplot_consumption_urb + theme(legend.position = "none"), barplot_consumption_urb_abs + theme(legend.position = "none"), ncol=1, rel_heights=c(1,1))

tit_a <- ggdraw() + draw_label("Popul. distribution across \n electr. consumption tiers", size = 13, angle = 90)
tit_b <- ggdraw() + draw_label("People in each \n consumption tier (million)", size = 13, angle = 90)
pgrid_titles = plot_grid(tit_a, tit_b, ncol=1, rel_heights=c(1,1))

pgrid_a = plot_grid(pgrid_titles, pgrid, ncol=2, rel_heights=c(1,1), rel_widths = c(0.1,1))

##
pgrid_b = plot_grid(barplot_consumption_rur + theme(legend.position = "none"), barplot_consumption_rur_abs + theme(legend.position = "none"), ncol=1, rel_heights=c(1,1))
pgrid = plot_grid(pgrid_a, pgrid_b, ncol=2, rel_heights=c(1,1), rel_widths = c(1.1,1))

pgrid = plot_grid(pgrid, get_legend(barplot_consumption_urb), ncol=1, rel_heights=c(1,0.1), rel_widths = c(1,1))

ggsave("Barplot_consumption.pdf", plot = pgrid, device = "pdf", width = 55, height = 32, units = "cm", scale=0.4)
ggsave("Barplot_consumption.png", plot = pgrid, device = "png", width = 55, height = 32, units = "cm", scale=0.4)


# 7) Hotspots identification
#Steepest declining access rates
grid10km_sh = read_sf("shapefile/grid_wdata.shp")
v = colnames(grid10km_sh)
v[5] = "changeinnoaccess"
colnames(grid10km_sh) = v

# keep only pixels in top 25%
grid10km_sh_pos=subset(grid10km_sh, grid10km_sh$changeinnoaccess>0)
quantile(grid10km_sh_pos$changeinnoaccess, probs = seq(0, 1, by= 0.1))
zonal_top25 = subset(grid10km_sh_pos, grid10km_sh_pos$changeinnoaccess > 1735)

#CDF graph
#ordering 
newdata <- zonal_top25[order(zonal_top25$pop),] 

#cumvariable
newdata =  mutate(newdata, x = as.numeric(rownames(newdata)))
newdata$x = newdata$x / 1552

newdata$cumsumnoaccess = cumsum(newdata$changeinnoaccess)

newdata$cumsumnoaccess_n = newdata$cumsumnoaccess / 45583924

#Export to QGIS fot plotting
write_sf(zonal_top25, "maps/growing_pop_without_access.shp")

#Latent demand
##
grid10km_sh$elrate=(1-(grid10km_sh$noaccess/grid10km_sh$pop))

grid10km_sh_pos=subset(grid10km_sh, grid10km_sh$meantier>0)

summary(grid10km_sh_pos$meantier)
zonal_latentdemand = subset(grid10km_sh_pos, grid10km_sh_pos$elrate > 0.5 & grid10km_sh_pos$meantier < 0.05556)

write_sf(zonal_latentdemand, "maps/latent_demand_hotspots.shp")

# New map access and demographics change
gid_1_shapefile = read_sf('shapefile/gadm36_1.shp')

m = merge(gid_1_shapefile, elrates, by="GID_1")

m$electrpopchange = ((m$elrate18*m$pop18) - (m$elrate14*m$pop14))

m$popchange = m$pop18-m$pop14

m$cats = ifelse(m$electrpopchange>0 & m$popchange >0, 1, ifelse(m$electrpopchange<0 & m$popchange>0, 2, ifelse(m$electrpopchange>0 & m$popchange<0, 3, ifelse(m$electrpopchange<0 & m$popchange<0, 4, ifelse(m$electrpopchange==0 , 5, 0)))))

write_sf(m, 'maps/demographics_electrification.shp')
