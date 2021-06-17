# Paul Sewell
# 15 June 2021
# Script to read and convert large tree plot data from Epicollect output

# basepath <- "C:/Users/elkinc/OneDrive - UNBC/ASCC/JPRF_ASCC/plot_data/Raw_Data/Epicollect_Datasheets/"

basepath <- "E:/JPRF ASCC/Data Processing/working_data/Epicollect_Datasheets/"


library(dplyr)
library(ggplot2)
dat1 <- read.csv(paste0(basepath,"form-1__data-collection_May19_QA.csv"))
dat2 <- read.csv(paste0(basepath,"https://www.dropbox.com/home/ASCC/Epicollect/Working%20Data?preview=form-1__data-collection_May26.csv"))
dat3 <- read.csv(paste0(basepath,"form-1__data-collection_May27.csv"))
dat4 <- read.csv(paste0(basepath,"form-1__data-collection_May20.csv"))
dat5 <- read.csv(paste0(basepath,"form-1__data-collection_may28-june11.csv"))

# Katherine: Add in additional data collection days

lk <- read.csv(paste0(basepath,"lookup1.csv"))
dat7 <- rbind (dat1, dat2, dat3, dat4, dat5)

trees <- dat7 %>% select("X1_Establishing_a_new", "X22_Hexagon_",	"X23_Plot_",	"X24_Species",	"X25_If_other_fill_in",	
                        "X26_Is_it_a_snag",	"X27_DBH_cm__tenth_dec",	"X28_Age_Taken",	
                        "X29_If_age_is_taken_r",	"X30_For_tress_that_ar",	"X31_Tree_Class",	
                        "X32_Live_crown_class",	"X33_Conk",	"X34_Blind_Conk",	"X35_Fork_Crook",
                        "X36_Scar",	"X37_Frost_Damage",	"X38_Mistletoe",	"X39_Rotten_Bark",	
                        "X40_Dead_or_broken_to",	"X41_Insect_Damage",	"X42_Fire_Damage",	
                        "X43_Down_Tree",	"X44_Additional_Commen",
                        "ec5_uuid")%>% 
                        filter(X1_Establishing_a_new %in% c("No, 11.28m Plot - Core Tree collection", "Yes, ESTABLISH 11.28m plot")) %>% 
                        rename(Test=X1_Establishing_a_new, 
                               Hexagon=X22_Hexagon_, 
                               Plot=X23_Plot_,
                               Species= X24_Species,
                               Other_spp= X25_If_other_fill_in,
                               Live_status= X26_Is_it_a_snag,
                               DBH=X27_DBH_cm__tenth_dec,
                               Age_id= X29_If_age_is_taken_r,
                               Height= X30_For_tress_that_ar,
                               Crown_class= X32_Live_crown_class,
                               Cruise_tree_class= X31_Tree_Class,
                               Conk= X33_Conk,
                               Blind_conk= X34_Blind_Conk,
                               Fork_crook= X35_Fork_Crook,
                               Scar= X36_Scar,
                               Frost_damage =X37_Frost_Damage,
                               Mistletoe= X38_Mistletoe,
                               Rotten_bark= X39_Rotten_Bark,
                               Dead_broken_top =X40_Dead_or_broken_to,
                               Insect_damage= X41_Insect_Damage,
                               Fire_damage= X42_Fire_Damage,
                               Down_tree= X43_Down_Tree,
                               Comments= X44_Additional_Commen)

trees1 <- trees %>% filter(ec5_uuid!="dcbab0b8-9f0a-4443-8571-") %>% 
  mutate(Species1= ifelse(Species=="Ac: poplar", "Ac", 
                       ifelse(Species=="At: trembling aspen", "At",
                              ifelse(Species=="Bl: subalpine fir", "Bl",
                                    ifelse(Species== "D: alder", "D",
                                             ifelse(Species== "Ep: paper birch", "Ep",
                                                      ifelse(Species=="Fd: douglas-fir", "Fd",
                                                               ifelse(Species== "Pl: lodgepole pine", "Pl",
                                                                        ifelse(Species== "Sb: black spruce", "Sb", 
                                                                               ifelse(Species=="Sx: spruce hybrid", "Sx", "Other"))))))))))
                                                                    
trees2 <- left_join(trees1, lk) %>% 
  mutate(Hexagon=as.factor(Hexagon), Plot=as.factor(Plot)) 

Live.trees <- trees2 %>% filter(Live_status=="Standing (Live)")

t.summ=Live.trees %>% select(plot.id, Hexagon, Plot, Species1, Height, DBH) %>% mutate(SPHt=10000/400, BAt=pi*(DBH/200)^2) %>% 
  mutate(BA.ha=BAt*SPHt)

write.csv(t.summ, paste0(basepath,"Tree.Summary.csv"))

