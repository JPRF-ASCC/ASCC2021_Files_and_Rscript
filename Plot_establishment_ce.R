# Paul Sewell
# 15 June 2021
# Script to read and convert large tree plot data from Epicollect output

library(dplyr)
library(ggplot2)

basepath <- "C:/Users/elkinc/OneDrive - UNBC/ASCC/JPRF_ASCC/plot_data/"
dat1 <- read.csv(paste0(basepath,"Raw_Data/Epicollect_Datasheets/","form-1__data-collection_May19_QA.csv"))

dat1 <- read.csv("E:\\2021_UNBC_ASCC\\Data_collection\\Raw_Data\\Epicollect_Datasheets\\form-1__data-collection_May19_QA.csv")

str(dat1)
Plot_details <- dat1 %>% select("X1_Establishing_a_new", "lat_3_GPS_Location", "long_3_GPS_Location",         
                        "accuracy_3_GPS_Location",        
                        "UTM_Northing_3_GPS_Location",
                        "UTM_Easting_3_GPS_Location",    
                        "UTM_Zone_3_GPS_Location",         
                        "X4_Hexagon_",                    
                        "X5_Plot_",                        
                        "X6_Elevation_m",                  
                        "X7_Slope___or_",                  
                        "X8_Aspect",                       
                        "X9_Slope_Position",                
                        "X10_Surface_Shape",             
                        "X11_Slope_Length",             
                        "X12_Slope_Uniformity",            
                        "X13_Slope_Continuity",            
                        "X14_Photo__North",               
                        "X15_Photo__East",                 
                        "X16_Photo__South",            
                        "X17_Photo__West",                 
                        "X18_Photo__VegGround",           
                        "X19_Photo__Overhead",            
                        "X20_Additional_Commen") %>% 
  rename(Test=X1_Establishing_a_new, Hexagon=X4_Hexagon_, Plot=X5_Plot_, Elevation=X6_Elevation_m, 
         Slope=X7_Slope___or_, Aspect= X8_Aspect, Slope_position=X9_Slope_Position,
         Surface_shape=X10_Surface_Shape, Slope_length=X11_Slope_Length, Slope_uniformity=X12_Slope_Uniformity,
         Slope_continuity= X13_Slope_Continuity, Photo_north=X14_Photo__North, Photo_east=X15_Photo__East, 
         Photo_south=X16_Photo__South, Photo_west=X17_Photo__West, Photo_overhead=X19_Photo__Overhead, Photo_veg=X18_Photo__VegGround, Comments=X20_Additional_Commen) %>% 
  filter(Test=="Yes, ESTABLISH 11.28m plot")
                        
         