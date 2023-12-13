library(devtools)
library(umx)
library (OpenMx)
library (haven)
library (dplyr)
library(car)
library(psych)
library(lme4)
library(nlme)
library(lmerTest)
library(ggplot2)
library(tidyverse)
library(lme4)
library(car)
library(multilevelTools)
library(haven)
library(JWileymisc)
library(effects)
library(sjPlot)
library(sjmisc)
source("C:/Users/trbell/Documents/OpenMx Workshop 2023/GenEpiHelperFunctions.R")
source("C:/Users/trbell/Documents/OpenMx Workshop 2023polychoricMeansMatrix3.R")

#SET WORKING DIRECTORY; 

setwd("C:/Users/trbell/Documents/ACTIVE/")

#READ IN DATA; 
ACTIVE<-NA
ACTIVE <- read_sav("ACTIVE_LONG_02192023.sav",encoding="latin1")
names(ACTIVE)
names(ACTIVE)<- toupper(names(ACTIVE))

#DATA SELECTION; WE SELECTED THE CONTROL GROUP OF ACTIVE;  
ACTIVE.mem.sub<-NA
ACTIVE.mem.sub <- subset(ACTIVE, (ACTIVE$INTGRP==1 | ACTIVE$INTGRP==4) & DEP_9_BIN_1==0)
ACTIVE.reas.sub <- subset(ACTIVE, (ACTIVE$INTGRP==2 | ACTIVE$INTGRP==4) & DEP_9_BIN_1==0)
ACTIVE.speed.sub <- subset(ACTIVE, (ACTIVE$INTGRP==3 | ACTIVE$INTGRP==4) & DEP_9_BIN_1==0)

view(ACTIVE.mem.sub)
#MLM MODELS;
ACTIVE.mem.sub$DEP_9_BIN_1
ACTIVE.mem.sub$DEP_9_BIN <-as_factor(ACTIVE.mem.sub$DEP_9_BIN)
ACTIVE.reas.sub$DEP_9_BIN <-as_factor(ACTIVE.mem.sub$DEP_9_BIN)
ACTIVE.reas.sub$DEP_9_BIN <-as_factor(ACTIVE.mem.sub$DEP_9_BIN)


ACTIVE.mem.sub$VISIT <-as_factor(ACTIVE.mem.sub$VISIT)
model.result2 <- lmer(MEM_COMP ~  INDEX1 + EDUCLEVL + RACE_CAT + GENDER_CAT + AGE_BC +  MMSE_B 
                     +  INTGRP + DEP_9_BIN +  INTGRP*INDEX1 
                     +  DEP_9_BIN*INDEX1 + INTGRP*DEP_9_BIN 
                     + INTGRP*INDEX1*DEP_9_BIN  + DEP_NVALID
                     + (1| ID ), ACTIVE.mem.sub, REML=FALSE) 
summary(model.result2)

ACTIVE$AGE_LONG_TIMESINCE
ACTIVE$newvariable
ACTIVE$newvariable<-NA
ACTIVE.speed.sub$newvariable<-NA
# Assuming your data frame is called "your_data"
ACTIVE.mem.sub$newvariable <- ifelse(ACTIVE.mem.sub$INTGRPR == 1 & ACTIVE.mem.sub$DEP_9_BIN == 0, 1,
                             ifelse(ACTIVE.mem.sub$INTGRPR == 1 & ACTIVE.mem.sub$DEP_9_BIN == 1, 2,
                                    ifelse(ACTIVE.mem.sub$INTGRPR == 4 & ACTIVE.mem.sub$DEP_9_BIN == 0, 3,
                                           ifelse(ACTIVE.mem.sub$INTGRPR == 4 & ACTIVE.mem.sub$DEP_9_BIN == 1, 4, NA))))
ACTIVE.reas.sub$newvariable <- ifelse(ACTIVE.reas.sub$INTGRPR == 2 & ACTIVE.reas.sub$DEP_9_BIN == 0, 1,
                                     ifelse(ACTIVE.reas.sub$INTGRPR == 2 & ACTIVE.reas.sub$DEP_9_BIN == 1, 2,
                                            ifelse(ACTIVE.reas.sub$INTGRPR == 4 & ACTIVE.reas.sub$DEP_9_BIN == 0, 3,
                                                   ifelse(ACTIVE.reas.sub$INTGRPR == 4 & ACTIVE.reas.sub$DEP_9_BIN == 1, 4, NA))))
ACTIVE.speed.sub$newvariable <- ifelse(ACTIVE.speed.sub$INTGRPR == 3 & ACTIVE.speed.sub$DEP_9_BIN == 0, 1,
                                      ifelse(ACTIVE.speed.sub$INTGRPR == 3 & ACTIVE.speed.sub$DEP_9_BIN == 1, 2,
                                             ifelse(ACTIVE.speed.sub$INTGRPR == 4 & ACTIVE.speed.sub$DEP_9_BIN == 0, 3,
                                                    ifelse(ACTIVE.speed.sub$INTGRPR == 4 & ACTIVE.speed.sub$DEP_9_BIN == 1, 4, NA))))

ACTIVE.mem.sub$newvariable <-as_factor(ACTIVE.mem.sub$newvariable)

labels <- c("1" = "Memory No Depression", "2" = "Memory Depression", "3" = "Control No Depression", "4" = "Control Depression")


memory <- ggplot(ACTIVE.mem.sub, aes(x = AGE_LONG_TIMESINCE, y = scale(MEM_COMP), color = newvariable, linetype = newvariable)) +
  geom_point() + 
  geom_smooth(method = "lm", se = TRUE, fullrange = TRUE) +
  labs(x = "Years Since Baseline",
       y = "Memory",
       color = "Group",
       linetype = "Group") + 
  theme_minimal() + ylim(-3, 3)+ 
  
  scale_color_manual(values = c("1" = "salmon", "2" = "chartreuse4", "3" = "mediumpurple4", "4" = "cyan3"), labels = labels) +
  scale_linetype_manual(values = c("1" = "dashed", "2" = "solid", "3" = "dotted", "4" = "dotdash"), labels = labels) 
memory
memory2<-memory + theme(text = element_text(family="serif",size = 15))
memory2



ACTIVE.speed.sub$newvariable<-as_factor(ACTIVE.speed.sub$newvariable)


labels <- c("1" = "SOP No Depression", "2" = "SOP Depression", "3" = "Control No Depression", "4" = "Control Depression")
speed <- ggplot(ACTIVE.speed.sub, aes(x = AGE_LONG_TIMESINCE, y = SOPCOMP, color = newvariable, linetype = newvariable)) +
  geom_point() + 
  geom_smooth(method = "lm", se = TRUE, fullrange = TRUE,  size = 1.5) +
  labs(x = "Years Since Baseline",
       y = "Speed of Processing (SoP)",
       color = "Group",
       linetype = "Group") + 
  theme_minimal() + ylim(-3, 3) + 
  
  scale_color_manual(values = c("1" = "salmon", "2" = "chartreuse4", "3" = "mediumpurple4", "4" = "cyan3"), labels = labels) +
  scale_linetype_manual(values = c("1" = "dashed", "2" = "solid", "3" = "dotted", "4" = "dotdash"), labels = labels) 
  speed
speed2<-speed + theme(text = element_text(family="serif",size = 15))

ACTIVE.reas.sub$newvariable<-as_factor(ACTIVE.reas.sub$newvariable)


labels <- c("1" = "Reasoning No Depression", "2" = "Reasoning Depression", "3" = "Control No Depression", "4" = "Control Depression")
reas <- ggplot(ACTIVE.reas.sub, aes(x = AGE_LONG_TIMESINCE, y = SOPCOMP, color = newvariable, linetype = newvariable)) +
  geom_point() + 
  geom_smooth(method = "lm", se = TRUE, fullrange = TRUE, size = 1.5) +
  labs(x = "Years Since Baseline",
       y = "Reasoning",
       color = "Group",
       linetype = "Group") + 
  ylim(-3, 3) +
  scale_color_manual(values = c("1" = "salmon", "2" = "chartreuse4", "3" = "mediumpurple4", "4" = "cyan3"), labels = labels) +
  scale_linetype_manual(values = c("1" = "dashed", "2" = "solid", "3" = "dotted", "4" = "dotdash"), labels = labels) +
  theme_minimal()


reas + theme(text = element_text(family = "serif"))

reas2 <- reas + theme(text = element_text(family="serif",size = 15))
reas2
ggsave("amyloid_hip3.tiff",hip3,dpi=300)


library(officer)
library(rvg)
pptx <- read_pptx()

pptx %>%
  add_slide() %>%
  # This first line puts it in as a static png image for comparison
  ph_with(memory2, location = ph_location_type(type = "body")) %>%
  add_slide() %>%
  # This line puts in a shape object, which can be ungrouped and edited
  ph_with(rvg::dml(ggobj = memory2),
          width = 8,
          height = 4,
          location = ph_location_type(type = "body"))

#> pptx document with 2 slide(s)

print(pptx, "test_graph.pptx")
pptx <- read_pptx()

pptx %>%
  add_slide() %>%
  # This first line puts it in as a static png image for comparison
  ph_with(reas2, location = ph_location_type(type = "body")) %>%
  add_slide() %>%
  # This line puts in a shape object, which can be ungrouped and edited
  ph_with(rvg::dml(ggobj = reas2),
          width = 8,
          height = 4,
          location = ph_location_type(type = "body"))

#> pptx document with 2 slide(s)

print(pptx, "test_graph.pptx")

pptx <- read_pptx()

pptx %>%
  add_slide() %>%
  # This first line puts it in as a static png image for comparison
  ph_with(speed2, location = ph_location_type(type = "body")) %>%
  add_slide() %>%
  # This line puts in a shape object, which can be ungrouped and edited
  ph_with(rvg::dml(ggobj = speed2),
          width = 8,
          height = 4,
          location = ph_location_type(type = "body"))

#> pptx document with 2 slide(s)

print(pptx, "test_graph.pptx")