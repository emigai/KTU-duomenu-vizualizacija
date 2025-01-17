library(ggplot2)
library(dplyr)
library(readr)

#1_uzd
duom <- read_csv("D:/Emilija/Desktop/R/Laboratorinis2/laboratorinis/data/lab_sodra.csv")
duom <- duom[duom$ecoActCode == "522920",]

ggplot(duom, aes(avgWage)) + geom_histogram(bins = 100)

#2_uzd
imones <- names(head(sort(tapply(duom$avgWage, duom$name, max), decreasing = TRUE), 5))
did <- filter(duom, duom$name == imones[1] | duom$name == imones[2] | duom$name == imones[3] | duom$name == imones[4] | duom$name == imones[5])
did %>% ggplot(aes(x = month, y = avgWage, group = name, color = name)) + geom_line()

#3uzd
insurance <- as.data.frame.table(tapply(did$numInsured, did$name, max))
colnames(insurance)
insurance <- insurance %>% rename(name = Var1, apdraustieji = Freq)

insurance %>% ggplot(aes(x = name, y = apdraustieji, fill = name)) + geom_bar(stat = "identity") + scale_fill_brewer(palette = "OrRd") + theme(axis.text.x = element_text(angle = 45, hjust = 1))
