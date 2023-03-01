#================================= BIBLIOTEKI ===============================================================

#library(ggplot2)
library(openxlsx)
library(dplyr)
library(tidyverse)
#library(gridExtra)
#library(data.table)

#============================== IMPORT DANYCH I WSTEPNA OBRÓBKA ============================================

setwd("C:/Users/mateu/OneDrive/Pulpit/Projekt_inżynierski/")

Wskaznik_HDI <- read.xlsx("HDI_INDEX_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)
PKB_na_mieszkanca <- read.xlsx("GDP_PER_CAPITA_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)
Wspolczynnik_Giniego <- read.xlsx("GINI_INDEX_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)
Smiertelnosc_niemowlat <- read.xlsx("INFANT_MORTALITY_RATE_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)
Ogolne_szczescie <- read.xlsx("HAPPINESS_SCORE_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)

# Dla danych "Ogolne_szczescie" jest oddzielny plik R, w którym został utworzony plik Excel - HAPPINESS_SCORE_PROJ.xlsx.

names(Wskaznik_HDI) <- c("region", "rok.2012","rok.2013",
                     "rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019")

names(PKB_na_mieszkanca) <- c("region", "rok.2010","rok.2011","rok.2012","rok.2013",
                     "rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019",
                     "rok.2020","rok.2021")

names(Wspolczynnik_Giniego) <- c("region","rok.2009", "rok.2010","rok.2011","rok.2012","rok.2013",
                            "rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019",
                            "rok.2020")

names(Smiertelnosc_niemowlat) <- c("region","rok.2009", "rok.2010","rok.2011","rok.2012","rok.2013",
                                  "rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019")


PKB_na_mieszkanca <- select(PKB_na_mieszkanca,c("region","rok.2012","rok.2013","rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019","rok.2020","rok.2021"))
Wspolczynnik_Giniego <- select(Wspolczynnik_Giniego,c("region","rok.2012","rok.2013","rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019","rok.2020"))
Smiertelnosc_niemowlat <- select(Smiertelnosc_niemowlat,c("region","rok.2012","rok.2013","rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019"))


# zmiana nazw panstw
Wskaznik_HDI$region <- gsub("United Kingdom", "UK", Wskaznik_HDI$region)
PKB_na_mieszkanca$region <- gsub("United Kingdom", "UK", PKB_na_mieszkanca$region)
Wspolczynnik_Giniego$region <- gsub("United Kingdom", "UK", Wspolczynnik_Giniego$region)
Smiertelnosc_niemowlat$region <- gsub("United Kingdom", "UK", Smiertelnosc_niemowlat$region)
Ogolne_szczescie$region <- gsub("United Kingdom", "UK",Ogolne_szczescie$region)

PKB_na_mieszkanca$region <- gsub("Czechia", "Czech Republic", PKB_na_mieszkanca$region)
Wspolczynnik_Giniego$region <- gsub("Czechia", "Czech Republic", Wspolczynnik_Giniego$region)
Smiertelnosc_niemowlat$region <- gsub("Czechia", "Czech Republic", Smiertelnosc_niemowlat$region)

Ogolne_szczescie$region <- gsub("Macedonia", "North Macedonia",Ogolne_szczescie$region)

Wskaznik_HDI$region <- gsub("Bosnia Herzegovina", "Bosnia and Herzegovina", Wskaznik_HDI$region)

Wspolczynnik_Giniego <- Wspolczynnik_Giniego[-37, ]

#Usuwnie niewłaściwych państw lub państw z brakami danych
Wskaznik_HDI <- Wskaznik_HDI[-c(3,5,17,30,37), ]
rownames(Wskaznik_HDI) <- 1:nrow(Wskaznik_HDI)
Wskaznik_HDI[,2:9] <- round(Wskaznik_HDI[,2:9], 3)

Smiertelnosc_niemowlat <- Smiertelnosc_niemowlat[-c(38,40,42,43,44,46,47,48), ]
rownames(Smiertelnosc_niemowlat) <- 1:nrow(Smiertelnosc_niemowlat)

Ogolne_szczescie <- Ogolne_szczescie[-c(26,28),]
rownames(Ogolne_szczescie) <- 1:nrow(Ogolne_szczescie)
Ogolne_szczescie[,2:6] <- round(Ogolne_szczescie[,2:6], 3)    # zaokrąglanie wszystkich kolumn do 3 miejsc po przecinku

# Tworzymy dodatkową ramkę danych dla "Ogolne_szczescie" w celu usprawnienia działania wykresów w aplikacji
Ogolne_szczescie_2012_2019 <- Ogolne_szczescie %>%
  add_column(
    rok.2012 = "NA",   #dodawanie 0 kolumn
    rok.2013 = "NA",
    rok.2014 = "NA", .after="region")


# ucinamy dane do 36 wierszy, poniewaz wykres korealcji wymaga danych o tej samej dlugosci
Ogolne_szczescie_2012_2019.36 <- Ogolne_szczescie_2012_2019[-c(26,27,34,36),] 
rownames(Ogolne_szczescie_2012_2019.36) <- 1:nrow(Ogolne_szczescie_2012_2019.36)

Smiertelnosc_niemowlat.36 <- Smiertelnosc_niemowlat[-c(29,34,38,39),]
rownames(Smiertelnosc_niemowlat.36) <- 1:nrow(Smiertelnosc_niemowlat.36)

Wskaznik_HDI.36 <- Wskaznik_HDI[-c(21,26,28,32),]
rownames(Wskaznik_HDI.36) <- 1:nrow(Wskaznik_HDI.36)






              