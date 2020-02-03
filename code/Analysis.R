##R Script for: 
##Satellite observations reveal inequalities in the progress and effectiveness of recent electrification in sub-Saharan Africa
##Giacomo Falchetta, Shonali Pachauri, Olha Danylo, Edward Byers, Simon Parkinson
## Version: 03/02/20

##NB This script can only be successfully run after the Google Earth Engine (GEE) javascript code has been operated and reducer tasks are completed. 
#The googledrive package will call and download the files generated in GEE. 
#Supporting files and folder structure as in the GitHub repository are required for the script to run successfully.
#Any question should be addressed to giacomo.falchetta@feem.it

##First, set the working directory to the directory of the cloned repository
setwd('./inequality_electrification_SSA')

#Install the appropriate version of the required libraries 
install.packages("checkpoint")
library(checkpoint)
checkpoint("2020-02-02")

#Load libraries
library(sf)
library(raster)
library(googledrive)
library(data.table)
library(dplyr)
library(ggplot2)
library(scales)
library(plyr)
library(ggpmisc)
library(wbstats)
library(ggrepel)
library(ineq)
library(cowplot)
library(rworldmap)
library(rgdal)
library(reshape2)
library(tidyr)
library(readxl)
library(rgdal)
library(ggthemes)
library(RColorBrewer)
library(gtools)
library(grid)
library(countrycode)
library(spatstat)
library(exactextractr)
library(stargazer)

#Google drive authentication (to be run before launching the entire script)
drive_find(n_max = 30)

#Import data for populaiton and population without access
drive_download("input_data/pop.csv", type = "csv", overwrite = TRUE)
pop = read.csv("input_data/pop.csv")

drive_download("input_data/no_acc.csv", type = "csv", overwrite = TRUE)
no_acc = read.csv("input_data/no_acc.csv")

#Merge different years, remove non Sub-Saharan countries and other misc provinces
merged = merge(pop, no_acc, by=c("GID_1"), all=TRUE)

merged=subset(merged, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")

merged = dplyr::filter(merged,  !is.na(GID_0.x))

#Calculate province-level electrification rates and merge them into a single dataframe 
merged$elrate19=(1-(merged$noacc19 / merged$pop19))
merged$elrate18=(1-(merged$noacc18 / merged$pop18))
merged$elrate17=(1-(merged$noacc17 / merged$pop17))
merged$elrate16=(1-(merged$noacc16 / merged$pop16))
merged$elrate15=(1-(merged$noacc15 / merged$pop15))
merged$elrate14=(1-(merged$noacc14 / merged$pop14))

elrates = merged

#Calculate the change in electrification rates over 2018-2014
elrates$eldiff = elrates$elrate19 - elrates$elrate14 

#Calculate national electrification rates
merged_countrylevel = merged %>% group_by(GID_0.x) %>% dplyr::summarize(pop19=sum(pop19,na.rm = T), noacc19=sum(noacc19,na.rm = T), pop18=sum(pop18,na.rm = T), noacc18=sum(noacc18,na.rm = T), pop17=sum(pop17,na.rm = T), noacc17=sum(noacc17,na.rm = T), pop16=sum(pop16,na.rm = T), noacc16=sum(noacc16,na.rm = T), pop15=sum(pop15,na.rm = T), noacc15=sum(noacc15,na.rm = T), pop14=sum(pop14,na.rm = T), noacc14=sum(noacc14,na.rm = T)) %>% ungroup()

merged_countrylevel$elrate19 = (1-(merged_countrylevel$noacc19/merged_countrylevel$pop19))
merged_countrylevel$elrate18 = (1-(merged_countrylevel$noacc18/merged_countrylevel$pop18))
merged_countrylevel$elrate17 = (1-(merged_countrylevel$noacc17/merged_countrylevel$pop17))
merged_countrylevel$elrate16 = (1-(merged_countrylevel$noacc16/merged_countrylevel$pop16))
merged_countrylevel$elrate15 = (1-(merged_countrylevel$noacc15/merged_countrylevel$pop15))
merged_countrylevel$elrate14 = (1-(merged_countrylevel$noacc14/merged_countrylevel$pop14))

merged_diff=merged_countrylevel
merged_diff <- na.omit(merged_diff)

merged_diff$gainedaccess = (merged_diff$elrate19*merged_diff$pop19) - (merged_diff$elrate14*merged_diff$pop14)
merged_diff$gainedperday = merged_diff$gainedaccess / 2190

merged_diff$elrate_diff = merged_diff$elrate19 - merged_diff$elrate14

natpop19 = sum(merged_diff$pop19)
natpop14 = sum(merged_diff$pop14)

#Plot change in national electricity access rates between the two years considered
bubbleplot_elrate <- ggplot(merged_diff, aes(x=elrate_diff*100, y=((pop19/pop14) - 1), colour = elrate19, size = pop18/1000000, label = GID_0.x))+
  geom_point(alpha=0.9) + 
  scale_size(range = c(1, 10), name = "Population \n(million)") +
  geom_label_repel(aes(label = GID_0.x),
                   box.padding   = 0.2, 
                   point.padding = 0.3,
                   segment.color = 'grey50', label.size = 0.25, colour="black", size=3) +
   xlab("National electricity access level: percentage points change (2014-2019)") +
   ylab("National population: percentage change (2014-2019)") + 
  xlim(c(-5,20))+
  geom_vline(xintercept = 0, colour = "black", linetype="dashed")+
  theme_classic()+
  scale_colour_gradient2(low="firebrick2", mid="gold", midpoint = 0.5, high="forestgreen", name="Electr. \naccess level \n(2019)",  labels = scales::percent_format(accuracy = 1))+
  ggtitle("National level")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))

# Calculate SSA-wide change in people with access
a = sum(merged_diff$elrate19*merged_diff$pop19)
b = sum(merged_diff$elrate14*merged_diff$pop14)
a-b

# Calculate SSA-wide change in people without access
c = sum(merged_diff$pop19) - sum(merged_diff$elrate19*merged_diff$pop19) 
c2 = sum(merged_diff$pop14) - sum(merged_diff$elrate14*merged_diff$pop14) 

# Calculate SSA-wide change in electricity access level
d =  sum(merged_diff$elrate19*merged_diff$pop19) / sum(merged_diff$pop19)
e = sum(merged_diff$elrate14*merged_diff$pop14) / sum(merged_diff$pop14)

# Calculate SSA-wide change in population
f =   sum(merged_diff$pop19) -  sum(merged_diff$pop14)
sum(merged_diff$pop19)/sum(merged_diff$pop14)

# Calculate SSA-wide 2019 population
k = sum(merged_diff$pop19)

# Calculate number of people with electricity access in 2014 and 2019
a = sum(merged_diff$pop19)*0.446
b = sum(merged_diff$pop14)*0.38

# Calculate the average number of people who have gained access every year between 2014 and 2019
yearly_average = (a-b)/6

# Calculate how many people would have access in 2030 if the same pace of 2014-2019 is kept
elrate_in2030_baseline = 1- (((c + (1400000000-k)*(1-d)) - (yearly_average)*10)/1400000000)

# Calculate per year requirement to achieve full electrification by 2030
solution <- 

# Validation against official statistics
# Tracking SDG7 report
tracking2019 <- read_excel("validation/TrackingSDG7.xlsx")
tracking2019$ISO = countrycode::countrycode(tracking2019$Country, 'country.name', 'iso3c')

tracking2019$difftracking2019 = tracking2019$`2017` - tracking2019$`2014`
merged_diff = merge(merged_diff, tracking2019, by.x = "GID_0.x", by.y = "ISO")

cor(merged_diff$elrate17, merged_diff$`2017`)
cor(merged_diff$elrate_diff, merged_diff$difftracking2019)

# Linearity SI graph
library(reshape2)
tracking2019 <- melt(tracking2019 %>% select(-Country), id.vars = c("ISO"))

tracking2019$variable = as.numeric(as.character(tracking2019$variable))

linearity = ggplot(subset(tracking2019, tracking2019$variable>2009), aes(x=variable, y=value, group=ISO)) +
  geom_line()+
  xlab("Electr. acc. level.")+
  ylab("Country")

ggsave("figures/linearity.png", plot = linearity, device = "png", width = 20, height = 12, units = "cm", scale=0.6)

summary(lm(value ~ variable, data=tracking2019)  )
summary(lm(value ~ poly(variable, 3), data=tracking2019)  )

# IEA Access Database
iea <- read_excel("validation/WEO2018.xlsx")
iea$ISO = countrycode::countrycode(iea$Region, 'country.name', 'iso3c')

merged_iea = merge(merged_diff, iea, by.x = "GID_0.x", by.y = "ISO")

merged_iea$diff = merged_iea$`2017`-merged_iea$`2010`

cor(merged_iea$elrate17, merged_iea$`2017.y`)

cor(merged_iea$diff, merged_iea$elrate_diff)

# Atlas of the Sustainable Development Goals From World Development Indicators
elrate_wb <- wb(indicator = "EG.ELC.ACCS.ZS", startdate = 2017, enddate = 2017)
elrate_wb_2 <- wb(indicator = "EG.ELC.ACCS.ZS", startdate = 2014, enddate = 2014)
elrate_wb = merge(elrate_wb, elrate_wb_2, by="iso3c")

elrate_wb = data.frame(elrate_wb$iso3c, elrate_wb$value.x, elrate_wb$value.y)
elrate_wb$diff = elrate_wb$elrate_wb.value.x - elrate_wb$elrate_wb.value.y
merged_diff = merge(merged_diff, elrate_wb, by.x = "GID_0.x", by.y = "elrate_wb.iso3c")

cor(merged_diff$elrate17, merged_diff$elrate_wb.value.x)
cor(merged_diff$elrate_diff, (merged_diff$elrate_wb.value.x-merged_diff$elrate_wb.value.y))

# numbers
sum(merged_diff$elrate18*merged_diff$pop18) - sum(merged_diff$elrate14*merged_diff$pop14)

### validation plot
comparison1 = ggplot(merged_diff, aes(x=elrate16, y=`2017`/100))+
  geom_point(data=merged_diff, aes(x=elrate16, y=`2017`/100, size=pop17/1e06), alpha=0.7)+
  geom_label_repel(data=merged_diff, aes(x=elrate16, y=`2017`/100, label = GID_0.x),
                   box.padding   = 0.2, 
                   point.padding = 0.3,
                   segment.color = 'grey50') +
  scale_size_continuous(name = "Total pop. (million)")+
  theme_classic()+
  geom_abline()+
  ylab("Country-level electrification level \n- ESMAP/World Bank")+
  xlab("Country-level electrification level \n- Estimated")+
  scale_x_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0,1))+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0,1))+
  theme(axis.title=element_text(size=12), axis.title.y = element_text(size = 14), axis.title.x = element_text(size = 14), legend.text=element_text(size=14))+
  stat_poly_eq(aes(label = paste(..rr.label..)), 
               label.x.npc = "right", label.y.npc = 0.15,
               formula = formula, parse = TRUE, size = 8)

comparison2 = ggplot(merged_iea, aes(x=elrate16, y=`2017.y`))+
  geom_point(data=merged_iea, aes(x=elrate16, y=`2017.y`, size=pop17/1e06), alpha=0.7)+
  geom_label_repel(data=merged_iea, aes(x=elrate16, y=`2017.y`, label = GID_0.x),
                   box.padding   = 0.2, 
                   point.padding = 0.3,
                   segment.color = 'grey50') +
  scale_size_continuous(name = "Total pop. (million)")+
  theme_classic()+
  geom_abline()+
  ylab("Country-level electrification level \n- IEA")+
  xlab("Country-level electrification level \n- Estimated")+
  scale_x_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0,1))+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0,1))+
  theme(axis.title=element_text(size=12), axis.title.y = element_text(size = 14), axis.title.x = element_text(size = 14), legend.text=element_text(size=14))+
  stat_poly_eq(aes(label = paste(..rr.label..)), 
               label.x.npc = "right", label.y.npc = 0.15,
               formula = formula, parse = TRUE, size = 8)


pg = plot_grid(comparison1, comparison2, comparison_province, ncol = 1, labels = "AUTO")

ggsave("figures/validation.png", plot = pg, device = "png", width = 60, height = 100, units = "cm", scale=0.35, dpi=400)

##Rural
drive_download("input_data/pop_rural.csv", type = "csv", overwrite = TRUE)
pop_rural = read.csv("input_data/pop_rural.csv")

drive_download("input_data/no_acc_rural.csv", type = "csv", overwrite = TRUE)
no_acc_rural = read.csv("input_data/no_acc_rural.csv")

#Merge different years, remove non Sub-Saharan countries and other misc provinces
merged = merge(pop_rural, no_acc_rural, by=c("GID_1"), all=TRUE)

merged=subset(merged, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")

merged = dplyr::filter(merged,  !is.na(GID_0.x))

#Calculate province-level electrification rates and merge them into a single dataframe 
# merged_19$elrate=(1-(merged_19$sum.y / merged_19$sum.x))
merged$elrate19=(1-(merged$noacc19 / merged$pop19))
merged$elrate18=(1-(merged$noacc18 / merged$pop18))
merged$elrate17=(1-(merged$noacc17 / merged$pop17))
merged$elrate16=(1-(merged$noacc16 / merged$pop16))
merged$elrate15=(1-(merged$noacc15 / merged$pop15))
merged$elrate14=(1-(merged$noacc14 / merged$pop14))

elrates_rur = merged

#Calculate the change in electrification rates over 2018-2014
elrates_rur$eldiff = elrates_rur$elrate19 - elrates_rur$elrate14 

#Calculate national electrification rates
merged_countrylevel = merged %>% group_by(GID_0.x) %>% dplyr::summarize(pop19=sum(pop19,na.rm = T), noacc19=sum(noacc19,na.rm = T), pop18=sum(pop18,na.rm = T), noacc18=sum(noacc18,na.rm = T), pop17=sum(pop17,na.rm = T), noacc17=sum(noacc17,na.rm = T), pop16=sum(pop16,na.rm = T), noacc16=sum(noacc16,na.rm = T), pop15=sum(pop15,na.rm = T), noacc15=sum(noacc15,na.rm = T), pop14=sum(pop14,na.rm = T), noacc14=sum(noacc14,na.rm = T)) %>% ungroup()

merged_countrylevel$elrate19 = (1-(merged_countrylevel$noacc19/merged_countrylevel$pop19))
merged_countrylevel$elrate18 = (1-(merged_countrylevel$noacc18/merged_countrylevel$pop18))
merged_countrylevel$elrate17 = (1-(merged_countrylevel$noacc17/merged_countrylevel$pop17))
merged_countrylevel$elrate16 = (1-(merged_countrylevel$noacc16/merged_countrylevel$pop16))
merged_countrylevel$elrate15 = (1-(merged_countrylevel$noacc15/merged_countrylevel$pop15))
merged_countrylevel$elrate14 = (1-(merged_countrylevel$noacc14/merged_countrylevel$pop14))

merged_diff=merged_countrylevel
merged_diff <- na.omit(merged_diff)

merged_diff$gainedaccess = (merged_diff$elrate18*merged_diff$pop19) - (merged_diff$elrate14*merged_diff$pop14)
merged_diff$gainedperday = merged_diff$gainedaccess / 2190

merged_diff$elrate_diff = merged_diff$elrate19 - merged_diff$elrate14

merged_diff_rur = merged_diff

(sum(merged_diff_rur$pop19) - sum(merged_diff_rur$noacc19))/sum(merged_diff_rur$pop19) -  ((sum(merged_diff_rur$pop14) - sum(merged_diff_rur$noacc14))/sum(merged_diff_rur$pop14))

(sum(merged_diff_rur$pop19) - sum(merged_diff_rur$noacc19)) -  (sum(merged_diff_rur$pop14) - sum(merged_diff_rur$noacc14))

rpop = sum(merged_diff_rur$pop19)

#Plot change in national electricity access rates between the two years considered
bubbleplot_elrate_rur <- ggplot(merged_diff_rur, aes(x=elrate_diff*100, y=(pop19-pop14)/pop14, colour = elrate19, size = pop19/1000000, label = GID_0.x))+
  geom_point(alpha=0.9) + 
  geom_label_repel(aes(label = GID_0.x),
                   box.padding   = 0.2, 
                   point.padding = 0.3,
                   segment.color = 'grey50', label.size = 0.25, colour="black", size=3) +
  xlab("Rural electricity access level: percentage points change (2014-2019)") +
  ylab("Rural population: percentage change (2014-2019)") + 
  xlim(c(-5,20))+
  geom_vline(xintercept = 0, colour = "black", linetype="dashed")+
  theme_classic()+
  scale_colour_gradient2(low="firebrick2", mid="gold", midpoint = 0.5, high="forestgreen", name="Electr. \naccess level \n(2019)",  labels = scales::percent_format(accuracy = 1))+
  scale_size(range = c(1, 10), name = "Population \n(million)") +
  ggtitle("Rural areas")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))

##Urban
drive_download("input_data/pop_urban.csv", type = "csv", overwrite = TRUE)
pop_urban = read.csv("input_data/pop_urban.csv")

drive_download("input_data/no_acc_urban.csv", type = "csv", overwrite = TRUE)
no_acc_urban = read.csv("input_data/no_acc_urban.csv")

#Merge different years, remove non Sub-Saharan countries and other misc provinces
merged = merge(pop_urban, no_acc_urban, by=c("GID_1"), all=TRUE)

merged=subset(merged, GID_0.x != "ATF" & GID_0.x != "EGY" & GID_0.x != "ESH"& GID_0.x != "ESP" & GID_0.x != "LBY" & GID_0.x != "MAR" & GID_0.x != "MYT" & GID_0.x != "SYC" & GID_0.x != "COM" & GID_0.x != "YEM" & GID_0.x != "TUN" & GID_0.x != "DZA" & GID_0.x != "SHN" & GID_0.x != "DJI" & GID_0.x != "STP")

merged = dplyr::filter(merged,  !is.na(GID_0.x))

#Calculate province-level electrification rates and merge them into a single dataframe 
# merged_19$elrate=(1-(merged_19$sum.y / merged_19$sum.x))
merged$elrate19=(1-(merged$noacc19 / merged$pop19))
merged$elrate18=(1-(merged$noacc18 / merged$pop18))
merged$elrate17=(1-(merged$noacc17 / merged$pop17))
merged$elrate16=(1-(merged$noacc16 / merged$pop16))
merged$elrate15=(1-(merged$noacc15 / merged$pop15))
merged$elrate14=(1-(merged$noacc14 / merged$pop14))

elrates_urb = merged

#Calculate the change in electrification rates over 2018-2014
elrates_urb$eldiff = elrates_urb$elrate19 - elrates_urb$elrate14 

#Calculate national electrification rates

merged_countrylevel = merged %>% group_by(GID_0.x) %>% dplyr::summarize(pop19=sum(pop19,na.rm = T), noacc19=sum(noacc19,na.rm = T), pop18=sum(pop18,na.rm = T), noacc18=sum(noacc18,na.rm = T), pop17=sum(pop17,na.rm = T), noacc17=sum(noacc17,na.rm = T), pop16=sum(pop16,na.rm = T), noacc16=sum(noacc16,na.rm = T), pop15=sum(pop15,na.rm = T), noacc15=sum(noacc15,na.rm = T), pop14=sum(pop14,na.rm = T), noacc14=sum(noacc14,na.rm = T)) %>% ungroup()

merged_countrylevel$elrate19 = (1-(merged_countrylevel$noacc19/merged_countrylevel$pop19))
merged_countrylevel$elrate18 = (1-(merged_countrylevel$noacc18/merged_countrylevel$pop18))
merged_countrylevel$elrate17 = (1-(merged_countrylevel$noacc17/merged_countrylevel$pop17))
merged_countrylevel$elrate16 = (1-(merged_countrylevel$noacc16/merged_countrylevel$pop16))
merged_countrylevel$elrate15 = (1-(merged_countrylevel$noacc15/merged_countrylevel$pop15))
merged_countrylevel$elrate14 = (1-(merged_countrylevel$noacc14/merged_countrylevel$pop14))

merged_diff=merged_countrylevel
merged_diff <- na.omit(merged_diff)

merged_diff$gainedaccess = (merged_diff$elrate18*merged_diff$pop19) - (merged_diff$elrate14*merged_diff$pop14)
merged_diff$gainedperday = merged_diff$gainedaccess / 2190

merged_diff$elrate_diff = merged_diff$elrate19 - merged_diff$elrate14

merged_diff_urb = merged_diff

(sum(merged_diff_urb$pop19) - sum(merged_diff_urb$noacc19))/sum(merged_diff_urb$pop19) -  ((sum(merged_diff_urb$pop14) - sum(merged_diff_urb$noacc14))/sum(merged_diff_urb$pop14))

(sum(merged_diff_urb$pop19) - sum(merged_diff_urb$noacc19)) -  (sum(merged_diff_urb$pop14) - sum(merged_diff_urb$noacc14))

upop19 = sum(merged_diff_urb$pop19)
upop14 = sum(merged_diff_urb$pop14)

ushare19 = upop19/natpop19
ushare14 = upop14/natpop14

#Plot change in national electricity access rates between the two years considered
bubbleplot_elrate_urb <- ggplot(merged_diff_urb, aes(x=elrate_diff*100, y=(pop19-pop14)/pop14, colour = elrate19, size = pop19/1000000, label = GID_0.x))+
  geom_point(alpha=0.9) + 
  geom_label_repel(aes(label = GID_0.x),
                   box.padding   = 0.2, 
                   point.padding = 0.3,
                   segment.color = 'grey50', label.size = 0.25, colour="black", size=3) +
  xlab("Urban electricity access level: percentage points change (2014-2019)") +
  ylab("Urban population: percentage change (2014-2019)") + 
  xlim(c(-5,20))+
  geom_vline(xintercept = 0, colour = "black", linetype="dashed")+
  theme_classic()+
  scale_colour_gradient2(low="firebrick2", mid="gold", midpoint = 0.5, high="forestgreen", name="Electr. \naccess level \n(2019)",  labels = scales::percent_format(accuracy = 1))+
  scale_size(range = c(1, 10), name = "Population \n(million)") +
  ggtitle("Urban areas")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))+ guides(
    color = guide_colorbar(order = 0),
    size = guide_legend(order = 1)
  )

pgrid_titles = plot_grid(ggdraw() + draw_label("National", size = 8), ggdraw() + draw_label("Urban", size = 8), ggdraw() + draw_label("Rural", size = 8), nrow = 3, ncol = 1)

pgrid = plot_grid(bubbleplot_elrate, bubbleplot_elrate_urb, bubbleplot_elrate_rur, ncol=1, labels = "AUTO")

ggsave("figures/bubbleplots.png", plot = pgrid, device = "png", width = 60, height = 100, units = "cm", scale=0.35, dpi=350)

#Inequality in ACCESS: calculate indexes and produce Lorenz Curve graphs
shapefile = st_read("shapefile/gadm36_1.shp")
shapefile = merge(shapefile, elrates, by=c("GID_1"), all=TRUE)
data = shapefile

#loop for graphs
colist=unique(elrates$GID_0.x)
ine14=list()
ine19=list()
lorenz=list()

for (Z in colist){
  datin=subset(data, data$GID_0.x== Z)
  #sort data 
  out14 = sort(datin$elrate14*(datin$pop14/ave(datin$pop14, datin$GID_0.x, FUN=sum)))
  out19 = sort(datin$elrate19*(datin$pop19/ave(datin$pop19, datin$GID_0.x, FUN=sum)))
  
  #calculate within-country Gini-index in access rate ineqaulity
  ine14[[Z]] = ineq(out14,type="Gini")
  ine19[[Z]] = ineq(out19,type="Gini")
  #plot and store Lorenz curve
  Lorenz=Lc(out14, plot =F)
  p14 <- Lorenz$p
  L14 <- Lorenz$L
  out_df14 <- data.frame(p14,L14)
  
  Lorenz=Lc(out19, plot =F)
  p19 <- Lorenz$p
  L19 <- Lorenz$L
  out_df19 <- data.frame(p19,L19)
  
  
  databoth = merge(out_df19, out_df14, by.x="p19", by.y="p14")
  databoth$difference = databoth$L19 - databoth$L14
  
  lorenz[[Z]] = ggplot() +
    theme_classic()+
    geom_line(data = out_df14, aes(x=p14, y=L14, colour="red"), size=1, alpha=0.8) +
    geom_line(data = out_df19, aes(x=p19, y=L19, color="darkblue"), size=1, alpha=0.8)+
    geom_line(data = databoth, aes(x=p19, y=difference, color="black"), size=1, alpha=0.8)+
    scale_color_discrete(name = "Legend", labels = c("Difference", "2019", "2014"))+
    geom_hline(yintercept = 0, alpha=0.5)+
    scale_x_continuous(name="Cum. percentage of popul. \n from lowest to highest electrified", limits=c(0,1)) + 
    scale_y_continuous(name="Cum. percentage of \n national electr. access", limits=c(-0.1,1), sec.axis = sec_axis(trans= ~  .)) +
    geom_abline()+
    geom_point(data = out_df19, aes(x=p19, y=L19), size=0.3)+
    geom_point(data = out_df14, aes(x=p14, y=L14), size=0.3)+
    theme(axis.text=element_text(size=6),
          axis.title=element_text(size=6))
  
  data = as.data.frame(shapefile)
  
}


pgrid = plot_grid(lorenz[['BDI']] + theme(legend.position="none"), lorenz[['KEN']] + theme(legend.position="none"), lorenz[['ETH']] + theme(legend.position="none"), lorenz[['TZA']] + theme(legend.position="none"), lorenz[['NGA']]  + theme(legend.position="none"), lorenz[['COD']] + theme(legend.position="none"), lorenz[['GHA']] + theme(legend.position="none"), lorenz[['ZAF']] + theme(legend.position="none"), lorenz[['AGO']] + theme(legend.position="none"),  labels=c("BDI", "KEN", "ETH", "TZA", "NGA", "COD", "GHA", "ZAF", "AGO"), label_size = 6, hjust= 0, ncol=3)
legend <- get_legend(lorenz[['BDI']])
p <- plot_grid(pgrid, legend, ncol = 2, rel_widths = c(0.4, .1))

ginis14 = as.data.frame(ine14)
ginis14 = melt(ginis14)
ginis19 = as.data.frame(ine19)
ginis19 = melt(ginis19)
ginis = data.frame(ginis14$variable, ginis14$value, ginis19$value, (ginis19$value-ginis14$value))
varnames<-c("ISO3", "Gini14", "Gini19", "DiffGini")
setnames(ginis,names(ginis),varnames )

ginis_access <- joinCountryData2Map(ginis, joinCode = "ISO3",
                                    nameJoinColumn = "ISO3")

ginis_access@data=data.frame(ginis_access@data$ISO3, ginis_access@data$Gini14, ginis_access@data$Gini19, ginis_access@data$DiffGini)
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

##Urban inequality
shapefile = st_read("shapefile/gadm36_1.shp")
shapefile = merge(shapefile, elrates_urb, by=c("GID_1"), all=TRUE)
data = shapefile

#loop for graphs
colist=unique(elrates_urb$GID_0.x)
ine14=list()
ine19=list()
lorenz=list()

for (Z in colist){
  datin=subset(data, data$GID_0.x== Z)
  #sort data 
  out14 = sort(datin$elrate14*(datin$pop14/ave(datin$pop14, datin$GID_0.x, FUN=sum)))
  out19 = sort(datin$elrate19*(datin$pop19/ave(datin$pop19, datin$GID_0.x, FUN=sum)))
  
  #calculate within-country Gini-index in access rate ineqaulity
  ine14[[Z]] = ineq(out14,type="Gini")
  ine19[[Z]] = ineq(out19,type="Gini")
  #plot and store Lorenz curve
  Lorenz=Lc(out14, plot =F)
  p14 <- Lorenz$p
  L14 <- Lorenz$L
  out_df14 <- data.frame(p14,L14)
  
  Lorenz=Lc(out19, plot =F)
  p19 <- Lorenz$p
  L19 <- Lorenz$L
  out_df19 <- data.frame(p19,L19)
  
  databoth = merge(out_df19, out_df14, by.x="p19", by.y="p14")
  databoth$difference = databoth$L19 - databoth$L14
  
  lorenz[[Z]] = ggplot() +
    theme_classic()+
    geom_line(data = out_df14, aes(x=p14, y=L14, colour="red"), size=1, alpha=0.8) +
    geom_line(data = out_df19, aes(x=p19, y=L19, color="darkblue"), size=1, alpha=0.8)+
    geom_line(data = databoth, aes(x=p19, y=difference, color="black"), size=1, alpha=0.8)+
    scale_color_discrete(name = "Legend", labels = c("Difference", "2019", "2014"))+
    geom_hline(yintercept = 0, alpha=0.5)+
    scale_x_continuous(name="", limits=c(0,1)) + 
    scale_y_continuous(name="", limits=c(-0.1,1)) +
    geom_abline()+
    geom_point(data = out_df19, aes(x=p19, y=L19), size=0.3)+
    geom_point(data = out_df14, aes(x=p14, y=L14), size=0.3)+
    theme(axis.text=element_text(size=7.5),
          axis.title=element_text(size=7.5))
  
  data = as.data.frame(shapefile)
  
}

ginis14 = as.data.frame(ine14)
ginis14 = melt(ginis14)
ginis19 = as.data.frame(ine19)
ginis19 = melt(ginis19)
ginis = data.frame(ginis14$variable, ginis14$value, ginis19$value, (ginis19$value-ginis14$value))
varnames<-c("ISO3", "Gini14", "Gini19", "DiffGini")
setnames(ginis,names(ginis),varnames )

ppp = as.data.frame(merge(melt(ine19), melt(ine14), by="L1"))
ppp$change=ppp$value.x-ppp$value.y

pgrid = plot_grid(lorenz[['RWA']] + theme(legend.position="none"), lorenz[['KEN']] + theme(legend.position="none"), lorenz[['ETH']] + theme(legend.position="none"), lorenz[['NGA']]  + theme(legend.position="none"), lorenz[['COD']] + theme(legend.position="none"), lorenz[['UGA']] + theme(legend.position="none"), labels=c("RWA", "KEN", "ETH", "NGA", "COD", "UGA"), label_size = 8, hjust= 0, vjust = 1, ncol=3)

tit_urb <- ggdraw() + draw_label("Urban", size = 10)
pgrid_u = plot_grid(tit_urb, pgrid, ncol=1, rel_heights=c(0.05, 1))

##Rural inequality 
shapefile = st_read("shapefile/gadm36_1.shp")
shapefile = merge(shapefile, elrates_rur, by=c("GID_1"), all=TRUE)
data = shapefile

#loop for graphs
colist=unique(elrates_rur$GID_0.x)
ine14=list()
ine19=list()
lorenz=list()

for (Z in colist){
  datin=subset(data, data$GID_0.x== Z)
  #sort data 
  out14 = sort(datin$elrate14*(datin$pop14/ave(datin$pop14, datin$GID_0.x, FUN=sum)))
  out19 = sort(datin$elrate19*(datin$pop19/ave(datin$pop19, datin$GID_0.x, FUN=sum)))
  
  #calculate within-country Gini-index in access rate ineqaulity
  ine14[[Z]] = ineq(out14,type="Gini")
  ine19[[Z]] = ineq(out19,type="Gini")
  #plot and store Lorenz curve
  Lorenz=Lc(out14, plot =F)
  p14 <- Lorenz$p
  L14 <- Lorenz$L
  out_df14 <- data.frame(p14,L14)
  
  Lorenz=Lc(out19, plot =F)
  p19 <- Lorenz$p
  L19 <- Lorenz$L
  out_df19 <- data.frame(p19,L19)
  
    databoth = merge(out_df19, out_df14, by.x="p19", by.y="p14")
  databoth$difference = databoth$L19 - databoth$L14
  
  lorenz[[Z]] = ggplot() +
    theme_classic()+
    geom_line(data = out_df14, aes(x=p14, y=L14, colour="red"), size=1, alpha=0.8) +
    geom_line(data = out_df19, aes(x=p19, y=L19, color="darkblue"), size=1, alpha=0.8)+
    geom_line(data = databoth, aes(x=p19, y=difference, color="black"), size=1, alpha=0.8)+
    scale_color_discrete(name = "Legend", labels = c("Difference", "2019", "2014"))+
    geom_hline(yintercept = 0, alpha=0.5)+
    scale_x_continuous(name=" ", limits=c(0,1)) + 
    scale_y_continuous(name=" ", limits=c(-0.1,1)) +
    geom_abline()+
    geom_point(data = out_df19, aes(x=p19, y=L19), size=0.3)+
    geom_point(data = out_df14, aes(x=p14, y=L14), size=0.3)+
    theme(axis.text=element_text(size=7.5),
          axis.title=element_text(size=7.5), legend.direction = "horizontal")
  
  data = as.data.frame(shapefile)
  
}

ginis14 = as.data.frame(ine14)
ginis14 = melt(ginis14)
ginis19 = as.data.frame(ine19)
ginis19 = melt(ginis19)
ginis = data.frame(ginis14$variable, ginis14$value, ginis19$value, (ginis19$value-ginis14$value))
varnames<-c("ISO3", "Gini14", "Gini19", "DiffGini")
setnames(ginis,names(ginis),varnames )

ppp = as.data.frame(merge(melt(ine19), melt(ine14), by="L1"))

pgrid = plot_grid(lorenz[['RWA']] + theme(legend.position="none"), lorenz[['KEN']] + theme(legend.position="none"), lorenz[['ETH']] + theme(legend.position="none"), lorenz[['NGA']]  + theme(legend.position="none"), lorenz[['COD']] + theme(legend.position="none"), lorenz[['UGA']] + theme(legend.position="none"), labels=c("RWA", "KEN", "ETH", "NGA", "COD", "UGA"), label_size = 8, hjust= 0, vjust=1, ncol=3)

tit_rur <- ggdraw() + draw_label("Rural", size = 10)

pgrid = plot_grid(tit_rur, pgrid, ncol=1, rel_heights=c(0.05,1))

pgrid = plot_grid(pgrid_u, pgrid, ncol=1, rel_heights=c(1,1))

xlab <- ggdraw() + draw_label("Cum. fraction of popul. from lowest to highest electrified", size = 10)

pgrid = plot_grid(pgrid, xlab, ncol=1, rel_heights=c(1, 0.05))

legend <- get_legend(lorenz[['RWA']])

p <- plot_grid(pgrid, legend, ncol = 1, rel_heights = c(1, 0.1))

ylab <- ggdraw() + draw_label("Cum. fraction of national electr. access", size = 10, angle = 90)

p <- plot_grid(ylab, p, ncol = 2, rel_widths = c(0.05, 1))

ggsave("figures/Lorenz.png", p, device = "png", width = 26, height = 26, units = "cm", scale=0.7)

#Define thresholds for consumption tiers to be manually inputted in GEE
drive_download("input_data/pctiles_pc_urban.csv", type = "csv", overwrite = TRUE)
histogram = read.csv("input_data/pctiles_pc_urban.csv")

histogram = histogram %>% gather(percentile, value, -c(ISO3))

histogram = histogram[complete.cases(histogram$value), ]

cdat <- ddply(histogram, "percentile", summarise, value.mean=median(value))

histogram1 = ggplot(subset(histogram, value < 6), aes(x=value, fill=percentile)) +
  scale_x_continuous(limits = c(0,6))+
  theme_classic()+
  geom_density(alpha=.4) +
  geom_vline(data=cdat, aes(xintercept=value.mean,  colour=percentile),
             linetype="dashed", size=1)+
  xlab(TeX("Radiance ($\\mu W \\cdot cm^{-2} \\cdot sr^{-1}$)"))+
  ylab("Density (urban areas)")+
  scale_color_discrete(name="Median")+
  scale_fill_discrete(name="Percentile")

#drive_download("pctiles_pc_rural.csv", type = "csv", overwrite = TRUE)
histogram = read.csv("pctiles_pc_rural.csv")

histogram = histogram %>% gather(percentile, value, -c(ISO3))

histogram = histogram[complete.cases(histogram$value), ]

cdat <- ddply(histogram, "percentile", summarise, value.mean=median(value))

histogram2 = ggplot(subset(histogram, value < 6), aes(x=value, fill=percentile)) +
  scale_x_continuous(limits = c(0,6))+
  theme_classic()+
  geom_density(alpha=.4) +
  geom_vline(data=cdat, aes(xintercept=value.mean,  colour=percentile),
             linetype="dashed", size=1)+
  xlab(TeX("Radiance ($\\mu W \\cdot cm^{-2} \\cdot sr^{-1}$)"))+
  ylab("Density (rural areas)")+
  scale_color_discrete(name="Median")+
  scale_fill_discrete(name="Percentile")

#drive_download("pctiles_pc_national.csv", type = "csv", overwrite = TRUE)
histogram = read.csv("input_data/pctiles_pc_national.csv")

histogram = histogram %>% gather(percentile, value, -c(ISO3))

histogram = histogram[complete.cases(histogram$value), ]

cdat <- ddply(histogram, "percentile", summarise, value.mean=median(value))

histogram3 = ggplot(subset(histogram, value < 6), aes(x=value, fill=percentile)) +
  scale_x_continuous(limits = c(0,6))+
  theme_classic()+
  geom_density(alpha=.4) +
  geom_vline(data=cdat, aes(xintercept=value.mean,  colour=percentile),
             linetype="dashed", size=1)+
  xlab(TeX("Radiance ($\\mu W \\cdot cm^{-2} \\cdot sr^{-1}$)"))+
  ylab("Density (all settlements)")+
  scale_color_discrete(name="Median")+
  scale_fill_discrete(name="Percentile")


histos = plot_grid(histogram3, histogram1, histogram2, ncol=1, labels = "AUTO")

ggsave("figures/histos.png", plot = histos, device = "png", width = 15, height = 30, units = "cm", scale=1)

# 6) Consumption tiers analysis
#Import rural 'consumption' tiers for 2018
drive_download("input_data/tiers_rural.csv", type = "csv", overwrite = TRUE)
tiers_rural = read.csv("input_data/tiers_rural.csv")

colnames(tiers_rural)[7:11] <- c("pop_tier_0_rural", "pop_tier_1_rural", "pop_tier_2_rural", "pop_tier_3_rural", "pop_tier_4_rural")

elrates18 = Reduce(function(x,y) merge(x,y,by="GID_1") ,list(elrates, tiers_rural))
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
data_cons_rural = data.frame(elrates18$GID_0, elrates18$GID_1, elrates18$pop_tier_0_rural, elrates18$pop_tier_1_rural, elrates18$pop_tier_2_rural,elrates18$pop_tier_3_rural,elrates18$pop_tier_4_rural)
varnames<-c("GID_0", "GID_1", "t0_18", "t1_18", "t2_18", "t3_18", "t4_18")
setnames(data_cons_rural,names(data_cons_rural),varnames )

dfm_rural <- gather(data_cons_rural, key=tier, value=value, "t0_18", 't1_18','t2_18','t3_18', 't4_18')

dfm_sum_rural = dfm_rural %>% 
  dplyr::group_by(GID_0, tier) %>% 
  dplyr::summarise(value = sum(value))

dfm_sum_rural <- na.omit(dfm_sum_rural)

colist=unique(dfm_sum_rural$GID_0)
gini=list()

for (Z in colist){
  datin=subset(dfm_sum_rural, dfm_sum_rural$GID_0== Z)
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
  geom_bar(data = dfm_sum_rural, aes(x = GID_0, y = value, fill = tier),stat = "identity", position = "fill") +
  theme(axis.text.x = element_text(angle = 90, size=6.75), legend.position="none", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  #ggtitle("")+
  ylab("Rural")+
  xlab("")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))

barplot_consumption_rur_abs = ggplot() + 
  theme_classic()+
  geom_bar(data = dfm_sum_rural, aes(x=reorder(GID_0, -value), y = value/1000000, fill = tier),stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, size=6.75), legend.position="none", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  ggtitle("")+
  ylab("")+
  xlab("")+
  scale_y_continuous()

##
#Import urban consumption' tiers for 2018
drive_download("input_data/tiers_urban.csv", type = "csv", overwrite = TRUE)
tiers_urban = read.csv("input_data/tiers_urban.csv")

colnames(tiers_urban)[7:11] <- c("pop_tier_0_urban", "pop_tier_1_urban", "pop_tier_2_urban", "pop_tier_3_urban", "pop_tier_4_urban")

elrates18 = Reduce(function(x,y) merge(x,y,by="GID_1") ,list(elrates, tiers_urban))
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
data_cons_urban = data.frame(elrates18$GID_0, elrates18$GID_1, elrates18$pop_tier_0_urban, elrates18$pop_tier_1_urban, elrates18$pop_tier_2_urban,elrates18$pop_tier_3_urban,elrates18$pop_tier_4_urban)
varnames<-c("GID_0", "GID_1", "t0_18", "t1_18", "t2_18", "t3_18", "t4_18")
setnames(data_cons_urban,names(data_cons_urban),varnames )

dfm_urban <- gather(data_cons_urban, key=tier, value=value, "t0_18", 't1_18','t2_18','t3_18', 't4_18')

dfm_sum_urban = dfm_urban %>% 
  dplyr::group_by(GID_0, tier) %>% 
  dplyr::summarise(value = sum(value))

dfm_sum_urban <- na.omit(dfm_sum_urban)

colist=unique(dfm_sum_urban$GID_0)
gini=list()

for (Z in colist){
  datin=subset(dfm_sum_urban, dfm_sum_urban$GID_0== Z)
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
  geom_bar(data = dfm_sum_urban, aes(x = GID_0, y = value, fill = tier),stat = "identity", position = "fill") +
  theme(axis.text.x = element_text(angle = 90, size=6.75), legend.position="none", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  #ggtitle("Urban")+
  ylab("Urban")+
  xlab("")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))

barplot_consumption_urb_abs = ggplot() + 
  theme_classic()+
  geom_bar(data = dfm_sum_urban, aes(x=reorder(GID_0, -value), y = value/1000000, fill = tier),stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, size=6.75), legend.position="none", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  ggtitle("")+
  ylab("")+
  xlab("")+
  scale_y_continuous()

ggsave("Barplot_consumption_urb.pdf", plot = barplot_consumption, device = "pdf", width = 34, height = 14, units = "cm", scale=0.6)


###
#Import national consumption' tiers for 2018
drive_download("input_data/tiers_national.csv", type = "csv", overwrite = TRUE)
tiers_national = read.csv("input_data/tiers_national.csv")

colnames(tiers_national)[7:11] <- c("pop_tier_0_national", "pop_tier_1_national", "pop_tier_2_national", "pop_tier_3_national", "pop_tier_4_national")

elrates18 = Reduce(function(x,y) merge(x,y,by="GID_1") ,list(elrates, tiers_national))
elrates_BK_18 = elrates18

elrates18=subset(elrates18, GID_0 != "ATF" & GID_0 != "EGY" & GID_0 != "ESH"& GID_0 != "ESP" & GID_0 != "LBY" & GID_0 != "MAR" & GID_0 != "MYT" & GID_0 != "SYC" & GID_0 != "COM" & GID_0 != "YEM" & GID_0 != "TUN" & GID_0 != "DZA")
elrates18 = dplyr::filter(elrates18,  !is.na(GID_0))

# calculate gini index of consumption among those with access within each province
colist=unique(elrates18$GID_0)
output_d_18=list()
for (A in colist){
  datin=subset(elrates18, elrates18$GID_0== A)
  
  datin$share_tier_0_national=datin$pop_tier_0_national/(datin$pop_tier_0_national+datin$pop_tier_1_national+datin$pop_tier_2_national+datin$pop_tier_3_national+datin$pop_tier_4_national)
  datin$share_tier_1_national=datin$pop_tier_1_national/(datin$pop_tier_0_national+datin$pop_tier_1_national+datin$pop_tier_2_national+datin$pop_tier_3_national+datin$pop_tier_4_national)
  datin$share_tier_2_national=datin$pop_tier_2_national/(datin$pop_tier_0_national+datin$pop_tier_1_national+datin$pop_tier_2_national+datin$pop_tier_3_national+datin$pop_tier_4_national)
  datin$share_tier_3_national=datin$pop_tier_3_national/(datin$pop_tier_0_national+datin$pop_tier_1_national+datin$pop_tier_2_national+datin$pop_tier_3_national+datin$pop_tier_4_national)
  datin$share_tier_4_national=datin$pop_tier_4_national/(datin$pop_tier_0_national+datin$pop_tier_1_national+datin$pop_tier_2_national+datin$pop_tier_3_national+datin$pop_tier_4_national)
  
  datin=data.frame(datin$GID_0, datin$GID_1, datin$share_tier_0_national, datin$share_tier_1_national,datin$share_tier_2_national,datin$share_tier_3_national,datin$share_tier_4_national)
  
  #reshape by making rows columns and by naming such columns after GID_1 of that row
  datin = reshape(datin, direction="long", idvar=c("datin.GID_1", "datin.GID_0"), varying = c("datin.share_tier_0_national", "datin.share_tier_1_national", "datin.share_tier_2_national", "datin.share_tier_3_national", "datin.share_tier_4_national"))
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


##Column plot split of consumption (national)
data_cons_national = data.frame(elrates18$GID_0, elrates18$GID_1, elrates18$pop_tier_0_national, elrates18$pop_tier_1_national, elrates18$pop_tier_2_national,elrates18$pop_tier_3_national,elrates18$pop_tier_4_national)
varnames<-c("GID_0", "GID_1", "t0_18", "t1_18", "t2_18", "t3_18", "t4_18")
setnames(data_cons_national,names(data_cons_national),varnames )

dfm_national <- gather(data_cons_national, key=tier, value=value, "t0_18", 't1_18','t2_18','t3_18', 't4_18')

dfm_sum_national = dfm_national %>% 
  dplyr::group_by(GID_0, tier) %>% 
  dplyr::summarise(value = sum(value))

dfm_sum_national <- na.omit(dfm_sum_national)

colist=unique(dfm_sum_national$GID_0)
gini=list()

for (Z in colist){
  datin=subset(dfm_sum_national, dfm_sum_national$GID_0== Z)
  gini_s = sort(datin$value)
  gini[[Z]] = ineq(gini_s,type="Gini")
}  

gini_cons_flat = as.data.frame(gini)
gini_cons_flat = melt(gini_cons_flat)
varnames<-c("ISO3", "Gini_cons")
setnames(gini_cons_flat,names(gini_cons_flat),varnames )

barplot_consumption_nat = ggplot() + 
  theme_classic()+
  geom_bar(data = dfm_sum_national, aes(x = GID_0, y = value, fill = tier),stat = "identity", position = "fill") +
  theme(legend.direction = "horizontal", axis.text.x = element_text(angle = 90, size=6.75), plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "WB-MTF, tier of access", labels = c("0", "1", "2", "3", "4+"), palette="Spectral")+
  #ggtitle("National")+
  ylab("National")+
  xlab("")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))

barplot_consumption_nat_abs = ggplot() + 
  theme_classic()+
  geom_bar(data = dfm_sum_national, aes(x=reorder(GID_0, -value), y = value/1000000, fill = tier),stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, size=6.75), legend.position="none", plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(name = "Tier of consumption \n (kWh/day/hh)", labels = c("~ 0", "<0.2", "<1", "<3.4", ">3.4"), palette="Spectral")+
  ggtitle("")+
  ylab("")+
  xlab("")+
  scale_y_continuous()

pgrid_b = plot_grid(barplot_consumption_rur + theme(legend.position = "none"), barplot_consumption_rur_abs + theme(legend.position = "none"), ncol=2, rel_heights=c(1,1))

pgrid_a = plot_grid(barplot_consumption_nat + theme(legend.position = "none"), barplot_consumption_nat_abs + theme(legend.position = "none"), ncol=2, rel_heights=c(1,1))

pgrid_c = plot_grid(barplot_consumption_urb + theme(legend.position = "none"), barplot_consumption_urb_abs + theme(legend.position = "none"), ncol=2, rel_heights=c(1,1))


pgrid = plot_grid(pgrid_a, pgrid_b, pgrid_c, ncol=1, rel_heights=c(1,1,1), rel_widths = c(1,1,1))

pgrid = plot_grid(pgrid, get_legend(barplot_consumption_nat), ncol=1, rel_heights=c(1,0.1), rel_widths = c(1,1))

tit_a <- ggdraw() + draw_label("Popul. distribution across \n electr. consumption tiers", size = 10)
tit_b <- ggdraw() + draw_label("People in each \n consumption tier (million)", size = 10)
pgrid_titles = plot_grid(tit_a, tit_b, ncol=2, rel_heights=c(1,1))

pgrid = plot_grid(pgrid_titles, pgrid, ncol=1, rel_heights=c(0.075,1), rel_widths = c(1,1))

ggsave("figures/Barplot_consumption.png", plot = pgrid, device = "png", width = 48, height = 40, units = "cm", scale=0.4)

#Hotspots identification
#Steepest declining access rates
grid10km_sh = read_sf("shapefile/grid_wdata.shp")
v = colnames(grid10km_sh)
v[5] = "changeinnoaccess"
colnames(grid10km_sh) = v

# keep only pixels in top 25%
grid10km_sh_pos=subset(grid10km_sh, grid10km_sh$changeinnoaccess>0)
quantile(grid10km_sh_pos$changeinnoaccess, probs = seq(0, 1, by= 0.1))
zonal_top25 = subset(grid10km_sh_pos, grid10km_sh_pos$changeinnoaccess > 1735)

sum(zonal_top25$pop)

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

m$elctrpp = ((m$elrate19*m$pop19) - (m$elrate14*m$pop14))

m$popchng = (((1-m$elrate19)*m$pop19) - ((1-m$elrate14)*m$pop14))

#m$cats = ifelse(m$elctrpp>0 & m$popchng >0, 1, ifelse(m$elctrpp<0 & m$popchng>0, 2, ifelse(m$elctrpp>0 & m$popchng<0, 3, ifelse(m$elctrpp<0 & m$popchng<0, 4, ifelse(m$elctrpp==0 , 5, 0)))))

write_sf(m, 'maps/demographics_electrification.shp')

###########
#ECDF Figure#
#Steepest declining access rates
grid10km_sh = read_sf("shapefile/grid_wdata.shp")
v = colnames(grid10km_sh)
v[5] = "changeinnoaccess"
colnames(grid10km_sh) = v

drive_download("input_data/travel.tif", type = "tif", overwrite = TRUE)
tt_city <- raster('input_data/travel.tif')

grid10km_sh$tt = exactextractr::exact_extract(tt_city, grid10km_sh, 'mean')

# keep only pixels in top 25%
grid10km_sh_pos=subset(grid10km_sh, grid10km_sh$changeinnoaccess>0)
quantile(grid10km_sh_pos$changeinnoaccess, probs = seq(0, 1, by= 0.1))

#Latent demand
grid10km_sh$elrate=(1-(grid10km_sh$noaccess/grid10km_sh$pop))
grid10km_sh_pos2=subset(grid10km_sh, grid10km_sh$meantier>0)

r = ggplot(data=subset(grid10km_sh_pos, grid10km_sh_pos$tt>0), aes(x=tt/60, weight = changeinnoaccess, colour= "darkred")) +
  stat_ecdf()+
  coord_cartesian(xlim=c(0, 6))+
  xlab('Travel time to the nearest \n50,000+ inhabitants city')+
  ylab('Cumulative fraction of \npopulation without electricity access')+
  theme_classic()+
  theme(legend.position = "none")+
  scale_colour_brewer(name="Country", palette = "Set1")+
  theme(legend.position = "none")+
  scale_size(range = c(0.5, 1), guide="none")+
  scale_x_continuous(limits = c(0, 8))+
  scale_y_continuous(limits = c(0,1))

x = ggplot_build(r)$data[[1]]$x
y = ggplot_build(r)$data[[1]]$y

xy = data.frame(x, y)

p = ggplot(subset(grid10km_sh_pos2, grid10km_sh_pos2$elrate > 0.5 & grid10km_sh_pos2$meantier < 0.05556), aes(x=tt/60, weight = pop, colour="blue")) +
  stat_ecdf()+
  coord_cartesian(xlim=c(0, 6))+
  xlab('Travel time to the nearest \n50,000+ inhabitants city')+
  ylab('Cumulative fraction of \npopulation without electricity access')+
  theme_classic()+
  theme(legend.position = "none")+
  scale_colour_brewer(name="Country", palette = "Set2")+
  theme(legend.position = "none")+
  scale_size(range = c(0.5, 1), guide="none")+
  scale_x_continuous(limits = c(0, 8))+
  scale_y_continuous(limits = c(0,1))

x = ggplot_build(p)$data[[1]]$x
y = ggplot_build(p)$data[[1]]$y

xy2 = data.frame(x, y)

plot_ecdf = ggplot()+
  geom_line(data=xy, aes(x=x, y=y, colour="Fast growing pop. \nwithout access"))+
  geom_line(data=xy2, aes(x=x, y=y, colour="Electr. pop. with \nlatent demand"))+
  scale_colour_manual(name="Legend", values = c("darkred", "blue"), labels=c("Fast growing pop. \nwithout access", "Electr. pop. with \nlatent demand"))+
  xlab('Travel time to the nearest \n50,000+ inhabitants city')+
  ylab('Cumulative fraction of the \npopulation')+
  theme_classic()+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))

ggsave("figures/plot_ecdf.png", plot_ecdf, scale=1, width = 5, height = 2.5)  

#WBMTF sureys validation
# Input WBMTF shares 
wbmtf<-read_excel("validation/MTF_surveys_aggregates.xlsx", sheet="Foglio1")

wbmtf = wbmtf %>% filter(Tier != "0" & Tier !="1" & Tier != "4" & Tier != "5")

colnames(wbmtf) <- c("GID_0", "tier", "value", "x", "which")

wbmtf$x = NULL

# Merge with our estimate
dfm_sum_national$which="National"
dfm_sum_urban$which="Urban"
dfm_sum_rural$which="Rural"

dfm_sum = rbind(dfm_sum_national, dfm_sum_urban, dfm_sum_rural)

# Aggregate tiers like in wbmtf
dfm_sum$tier[dfm_sum$tier == "t0_18"] <- "0+1"
dfm_sum$tier[dfm_sum$tier == "t1_18"] <- "0+1"
dfm_sum$tier[dfm_sum$tier == "t2_18"] <- "2"
dfm_sum$tier[dfm_sum$tier == "t3_18"] <- "3"
dfm_sum$tier[dfm_sum$tier == "t4_18"] <- "4+5"

dfm_sum$GID_0 = as.character(dfm_sum$GID_0)

wbmtf$GID_0[wbmtf$GID_0 == "Ethiopia"] <- "ETH"
wbmtf$GID_0[wbmtf$GID_0 == "Rwanda"] <- "RWA"
wbmtf$GID_0[wbmtf$GID_0 == "Zambia"] <- "ZMB"

# merge by country, tier, and which variables
dfm_sum = dfm_sum %>% group_by(GID_0, tier, which) %>% summarise(value = sum(value))

dfm_sum = dfm_sum %>% group_by(GID_0, which) %>% mutate(value = value/sum(value))

wbmtf = merge(wbmtf, dfm_sum, by=c("GID_0", "tier", "which"))

cor = wbmtf %>% group_by(GID_0) %>% mutate(corr=cor(value.x, value.y))

wbmtf = gather(wbmtf, key = "type", value="value", value.x, value.y)

# Plot validation
tiers_valid<-ggplot(wbmtf, aes(x=as.factor(tier), y=value, fill=as.factor(type))) +
  geom_bar(stat="identity", position = position_dodge(preserve = "single"))+  facet_grid(rows = vars(GID_0), cols=vars(which))+
  scale_y_continuous(labels=percent, limits = c(0,1))+
  scale_fill_discrete(name="Legend", labels = c("Survey (real)", "Estimate (NTL)"))+
  xlab("WB-MTF, tier of access")+
  ylab("Share of population")

ggsave("figures/tiers_valid.png", p, device = "png", scale=2)


# DHS microdata
a = read.csv("validation/Parsing.csv")
b = readxl::read_excel("input_data/STATcompilerExport20191021_145233.xlsx")

prova = merge(a, b, by.x = c("ï..Country", "Survey", "region"), by.y=c("Country", "Survey", "Characteristic"))

sf = sf::read_sf("shapefile/gadm36_1.shp")

sf = merge(sf, prova, by="GID_1")

sf = merge(sf, elrates, by="GID_1")

##
# electricity access has grown the most in those provinces with a higher gini coefficient
m1 <- lm(elrate19~`Wealth index Gini coefficient` + as.factor(NAME_0), data=sf)

sf$popchange = sf$pop19-sf$pop14
sf$noaccpopchange = (1-(sf$pop19*sf$elrate19)) - (1-(sf$pop14*sf$elrate14))

# electricity access has grown the most in those provinces with a higher gini coefficient
m2 <- lm(eldiff~`Wealth index Gini coefficient` + as.factor(NAME_0), data=sf)

# calculate average consumption in each cell
drive_download("input_data/tiers_joint.tif", type = "tif", overwrite = TRUE)
tiers = raster("input_data/tiers_joint.tif")
tiers[tiers==5] = 1
tiers[tiers==6] = 2
tiers[tiers==7] = 3
tiers[tiers==8] = 4
tiers[tiers==0] = NA

drive_download("input_data/pop15.tif", type = "tif", overwrite = TRUE)
pop = raster("input_data/pop15.tif")

tiers = tiers*pop

sf$av_cons <- exact_extract(tiers, sf, 'sum')/sf$pop15

# residential consumption is higher where there is less income inequality
m3 <- lm(av_cons~`Wealth index Gini coefficient` + as.factor(NAME_0), data=sf)

# residential consumption estimated with NTL is correlated with the probability of a household posessing appliances (further layer of valiation)
m4 <- lm(`Households possessing a television`~av_cons + as.factor(NAME_0), data=sf)
m5 <- lm(`Households possessing a refrigerator` ~ av_cons + as.factor(NAME_0), dat=sf)
m6 <- lm(`Households possessing a mobile telephone`~av_cons + as.factor(NAME_0), data=sf)
m7 <- lm(`Households possessing a radio` ~ av_cons + as.factor(NAME_0), data=sf)

# Output table SI1
stargazer(m1, m2, m3, m4, m5, m6, m7, type = "html")

# Analyse data for Table 3
gid_1_shapefile = read_sf('maps/demographics_electrification.shp')
gid_1_shapefile = subset(gid_1_shapefile, gid_1_shapefile$elr19>0.5)
sum(gid_1_shapefile$ncc19)

##

gid_1_shapefile = read_sf('maps/demographics_electrification.shp')
gid_1_shapefile$noaccchnge = gid_1_shapefile$ncc19 - gid_1_shapefile$ncc14
gid_1_shapefile = subset(gid_1_shapefile, gid_1_shapefile$noaccchnge>0)
sum(gid_1_shapefile$noaccchnge)
gid_1_shapefile = st_as_sf(gid_1_shapefile)
write_sf(gid_1_shapefile, "a.shp")

##

tiers_national = read.csv("input_data/tiers_national.csv")

colnames(tiers_national)[7:11] <- c("pop_tier_0_national", "pop_tier_1_national", "pop_tier_2_national", "pop_tier_3_national", "pop_tier_4_national")

elrates18 = Reduce(function(x,y) merge(x,y,by="GID_1") ,list(elrates, tiers_national))
elrates_BK_18 = elrates18

elrates18=subset(elrates18, GID_0 != "ATF" & GID_0 != "EGY" & GID_0 != "ESH"& GID_0 != "ESP" & GID_0 != "LBY" & GID_0 != "MAR" & GID_0 != "MYT" & GID_0 != "SYC" & GID_0 != "COM" & GID_0 != "YEM" & GID_0 != "TUN" & GID_0 != "DZA")
elrates18 = dplyr::filter(elrates18,  !is.na(GID_0))

gid_1_shapefile = read_sf('maps/demographics_electrification.shp')

gid_1_shapefile = dplyr::select(gid_1_shapefile, geometry, GID_1)

elrates18_2 = merge(elrates18, gid_1_shapefile, by.x="GID_1", by.y="GID_1")

elrates18_2 = subset(elrates18_2, elrates18$elrate19>0.5)

sum(elrates18_2$pop_tier_1_national)+ sum(elrates18_2$pop_tier_2_national)

elrates18_2$t1t2 = elrates18_2$pop_tier_1_national + elrates18_2$pop_tier_2_national

write_sf(elrates18_2, "b.shp")


