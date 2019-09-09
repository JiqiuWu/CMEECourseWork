library(ggplot2)
library(grid)
library(dplyr)
library(reshape2)
library(Rmisc)
library(plyr)
library(vegan)

#assembly quality
assem_data <- read.csv("~/Documents/CMEE/Project/MEGAHIT_HPC/assembly_quality.csv", header = T, sep = ",")
meta_data <- read.csv("~/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/20190429_metadata.csv", header = T, sep = ",")
assem_data <- subset(assem_data, month != "M")
colnames(assem_data)[4] <- "community_size"

assem_qua <- select(assem_data, babyID, month, num_contigs, community_size, N50)
colnames(assem_qua)<- c("BabyID", "Age","Number of contigs (K)", "Community size (Mbp)", "N50 (Kbp)")
assem_qua$`Number of contigs (K)` <- assem_qua$`Number of contigs (K)` / 1000
assem_qua$`Community size (Mbp)` <- assem_qua$`Community size (Mbp)` / 1000000
assem_qua$`N50 (Kbp)` <- assem_qua$`N50 (Kbp)` / 1000

meta2com <- select(meta_data, babyID, GENDER)
colnames(meta2com) <- c("BabyID", "Gender")

assem_qua2plot<- left_join(assem_qua, meta2com, by = "BabyID")


assem_qua2plot <- melt(assem_qua2plot, id = c("BabyID", "Age", "Gender"))

assem_qua2plot$Age <- gsub("B", "Birth",  assem_qua2plot$Age)
assem_qua2plot$Age <- gsub("4M", "4 months",  assem_qua2plot$Age)
assem_qua2plot$Age <- gsub("12M", "12 months",  assem_qua2plot$Age)
assem_qua2plot$Gender <- gsub("boy", "Boy",  assem_qua2plot$Gender)
assem_qua2plot$Gender <- gsub("girl", "Girl",  assem_qua2plot$Gender)

plot_qua <- ggplot(data = assem_qua2plot, aes(x = Age, y = value, colour = Gender)) + #geom_point() + 
  geom_boxplot(outlier.shape = NA) + facet_wrap( ~ variable, scales = "free") + geom_jitter(size = 1) + 
  scale_x_discrete(limits = c("Birth", "4 months", "12 months")) + ylab("") + xlab("Age") +
  ggtitle("Assembly quality") + theme_grey(base_size = 16) + 
  theme(plot.title = element_text(hjust = 0.5)) 
plot_qua



  

#PCOA


#PCoA
library(ape)
library(vegan)
merge_data <- read.table("~/Documents/CMEE/Project/MetaPhlAn2/Baby_merged.txt",header = T)
rownames(merge_data) <- merge_data$ID
merge_data$ID <- NULL


dist <- vegdist(t(merge_data), method = "bray")

pcoa <- pcoa(dist)
pcoa_plot <- pcoa$vectors[,1:2] %>% as.data.frame()
rn <- rownames(pcoa_plot)
rn <- gsub("^.*_", "", rn)
pcoa_plot$time <- rn
colnames(pcoa_plot) <- c("Axis.1", "Axis.2", "Age(month)")
pcoa_plot$Age <- gsub("B", "Birth",  pcoa_plot$Age)
pcoa_plot$Age <- gsub("4M", "4 months",  pcoa_plot$Age)
pcoa_plot$Age <- gsub("12M", "12 months",  pcoa_plot$Age)
baby_id_pcoa <- gsub("^p", "", rownames(pcoa_plot))
BabyID <- gsub("_.*","", baby_id_pcoa)
pcoa_plot$BabyID <- BabyID
pcoa_plot <- merge(pcoa_plot, meta2com, by = "BabyID")

pcoa_plot$gender <- gsub("boy", "Boy",  pcoa_plot$gender)
pcoa_plot$gender <- gsub("girl", "Girl",  pcoa_plot$gender)

colnames(pcoa_plot)[6] <- "Gender"

p_pcoa_1 <- ggplot(pcoa_plot, aes(x = Axis.1, y = Axis.2, color = Age)) + geom_point(size = 2) +
  ggtitle("Principal cooridinate analysis (PCoA) of bacteria") + theme_grey(base_size = 16) + 
  theme(plot.title = element_text(hjust = 0.5)) 
p_pcoa_1

p_pcoa_2 <- ggplot(pcoa_plot, aes(x = Axis.1, y = Axis.2, color = Gender)) + geom_point(size = 2) +
  ggtitle("Principal cooridinate analysis (PCoA) of bacteria") + theme_grey(base_size = 16) + 
  theme(plot.title = element_text(hjust = 0.5)) 
p_pcoa_2


##rarefaction curve
merge_data_up <- ceiling(merge_data)
#rarec <- rarecurve(t(merge_data_up), step = 50, cex = 0.5)

merge_data_t <- data.frame(t(merge_data))
merge_data_t$time <- gsub("^.*?_", "", rownames(merge_data_t))
try <- gsub("^p", "", rownames(merge_data_t))
babyid <- gsub("_.*","", try)

merge_data_t$BabyID <- babyid
data2 <- merge(merge_data_t, meta2com, by = "BabyID")


group_12M <- subset(data2, time == "12M")
boy_12m <- subset(group_12M, gender == "boy")
girl_12m <- subset(group_12M, gender == "girl")

group_4M <- subset(data2, time == "4M")
boy_4m <- subset(group_4M, gender == "boy")
girl_4m <- subset(group_4M, gender == "girl")

group_B <-subset(data2, time == "B") 
boy_b <- subset(group_B, gender == "boy")
girl_b <- subset(group_B, gender == "girl")

rarefaction_12M_boy <- specaccum(boy_12m[2:1137], method = "random", permutations = 500)
rarefaction_12M_girl <- specaccum(girl_12m[2:1137], method = "random", permutations = 500)

rarefaction_4M_boy <- specaccum(boy_4m[2:1137], method = "random", permutations = 500)
rarefaction_4M_girl <- specaccum(girl_4m[2:1137], method = "random", permutations = 500)

rarefaction_B_boy <- specaccum(boy_b[2:1137], method = "random", permutations = 500)
rarefaction_B_girl <- specaccum(girl_b[2:1137], method = "random", permutations = 500)



#rarefaction_12M <- specaccum(group_12M[-1137], method = "random", permutations = 500)
#rarefaction_4M <- specaccum(group_4M[-1137], method = "random", permutations = 500)
#rarefaction_B <- specaccum(group_B[-1137], method = "random", permutations = 500)

df_12M_boy <- data.frame(`Sample size` = rarefaction_12M_boy$sites, `Bacterial richness` = rarefaction_12M_boy$richness, 
                         Age = "12 months", Gender = "Boy"  )
df_12M_girl <- data.frame(`Sample size` = rarefaction_12M_girl$sites, `Bacterial richness` = rarefaction_12M_girl$richness, 
                          Age = "12 months", Gender = "Girl" )

df_4M_boy <- data.frame(`Sample size` = rarefaction_4M_boy$sites, `Bacterial richness` = rarefaction_4M_boy$richness, 
                        Age = "4 months", Gender = "Boy" )
df_4M_girl <- data.frame(`Sample size` = rarefaction_4M_girl$sites, `Bacterial richness` = rarefaction_4M_girl$richness, 
                         Age = "4 months", Gender = "Girl" )

df_B_boy <- data.frame(`Sample size` = rarefaction_B_boy$sites, `Bacterial richness` = rarefaction_B_boy$richness, 
                       Age = "Birth", Gender = "Boy")
df_B_girl <- data.frame(`Sample size` = rarefaction_B_girl$sites, `Bacterial richness` = rarefaction_B_girl$richness, 
                        Age = "Birth", Gender = "Girl" )


df_rarefaction <- do.call("rbind", list(df_12M_boy, df_12M_girl, df_4M_boy, df_4M_girl, df_12M_girl, df_B_boy, df_B_girl))

df_rarefaction$feature <- paste0(df_rarefaction$Age, df_rarefaction$Gender)

rarefaction_curve <- ggplot(df_rarefaction, aes(x = Sample.size, y = Bacterial.richness, colour = Age, group = feature)) + 
  geom_line(aes(linetype = Gender)) +

  ylab("Bacterial richness") + xlab("Sample size") + 
  ggtitle("Rarefaction curve of bacterial richness") + theme_grey(base_size = 16) + 
  theme(plot.title = element_text(hjust = 0.5)) 

  
#geom_line(aes(colour = Age)) +
  
rarefaction_curve 

#richness
richness_data <- read.csv("~/Documents/CMEE/Project/MetaPhlAn2/species_num.csv", header = T, sep = ",")
richdata2plot <- subset(richness_data, Age != "M")

richdata2plot$Age <- gsub("B", "0",  richdata2plot$Age)
richdata2plot$Age <- gsub("4M", "4",  richdata2plot$Age)
richdata2plot$Age <- gsub("12M", "12",  richdata2plot$Age)
colnames(richdata2plot)[1] <- "BabyID"
richdata2plot <- left_join(richdata2plot, meta2com, by = "BabyID")

richdata2plot$gender <- gsub("boy", "Boy",  richdata2plot$gender)
richdata2plot$gender <- gsub("girl", "Girl",  richdata2plot$gender)

colnames(richdata2plot)[4] <- "Gender"

rich_plot <- ggplot(richdata2plot, aes(x = as.numeric(Age), y = Bacterial_richness, colour = Gender)) + 
  geom_line(aes(group = BabyID), linetype = "dotted") + geom_smooth(method = "lm") +
  ylab("Bacterial richness") + xlab("Age (month)") + 
  ggtitle("Bacterial richness") + theme_grey(base_size = 16) + 
  theme(plot.title = element_text(hjust = 0.5)) 
  
rich_plot




LM <- lm(Bacterial_richness ~ as.numeric(Age), data = richdata2plot)
summary(LM)


##diversity

rownames(merge_data) <- merge_data$ID
merge_data$ID <- NULL
diversty <- diversity(merge_data, index = "shannon", MARGIN = 2)

diversity_data <- data.frame(diversty)
write.csv(diversity_data, file = "diversity.csv", quote = F)

diversity_data <- read.csv("~/Documents/CMEE/Project/MEGAHIT_HPC/diversity.csv", header = T, sep = ",")
diversity_data$Age <- gsub("B", "0",  diversity_data$Age)
diversity_data$Age <- gsub("4M", "4",  diversity_data$Age)
diversity_data$Age <- gsub("12M", "12",  diversity_data$Age)

diversity_data<- merge(diversity_data, meta2com, by = "BabyID")

diversity_plot <- ggplot(diversity_data, aes(x = as.numeric(Age), y = Diversity, colour = gender)) + 
  geom_line(aes(group = BabyID), linetype = "dotted") + geom_smooth(method = "lm") +
  ylab("Bacterial diversity") + xlab("Age(month)") + ylim(2.5,4) +
  ggtitle("Bacterial diversity") + theme_grey(base_size = 16) + 
  theme(plot.title = element_text(hjust = 0.5)) 

diversity_plot

LM_2 <- lm(Diversity ~ as.numeric(Age), data = diversity_data)
summary(LM_2)

figure2 <- multiplot(p_pcoa_1, rarefaction_curve, p_pcoa_2,rich_plot,cols = 2 )
figure2


#crispr in one sample 

data <- read.csv("~/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/Crispr_meta_quanlity.csv", header = T, sep = ",")
CRIS_data <- subset(data, month != "M")

CRIS_data$month <- gsub("4M", as.numeric(4), CRIS_data$month)
CRIS_data$month <- gsub("12M", as.numeric(12), CRIS_data$month)
CRIS_data$month <- gsub("B", as.numeric(0), CRIS_data$month)
CRIS_data$Gender <- gsub("boy", "Boy", CRIS_data$Gender)
CRIS_data$Gender <- gsub("girl", "Girl", CRIS_data$Gender)

plot_crispr <- ggplot(CRIS_data, aes(x = as.numeric(month), y = num_CRISPRs, group = babyID, colour = Gender)) + 
  geom_line(linetype = "dotted") + geom_smooth(aes(group = Gender) , method = 'lm')  + xlim(0,12) + 
  ylab("Number of CRISPRs") + xlab("Age (month)") + 
  theme_grey(base_size = 16) 

plot_crispr

LM3 <- lm(num_CRISPRs ~ as.numeric(month), data = CRIS_data )
summary(LM3)

#spacer in one sample 
plot_spacer <- ggplot(CRIS_data, aes(x = as.numeric(month), y = spacers_sample, group = babyID, colour = Gender)) + 
  geom_line(linetype = "dotted") + geom_smooth(aes(group = Gender) , method = 'lm')  + xlim(0,12) + 
  ylab("Number of spacers") + xlab("Age (month)") + 
  theme_grey(base_size = 16) 
plot_spacer

LM3 <- lm(spacers_sample ~ as.numeric(month), data = CRIS_data )
summary(LM3)

#crispr average
plot_crispr_ave <- ggplot(CRIS_data, aes(x = as.numeric(month), y = num_CRISPRs/total_bp * 1000000, group = babyID, colour = Gender)) + 
  geom_line(linetype = "dotted") + geom_smooth(aes(group = 1) , method = 'lm')  + xlim(0,12) + 
  ylab("Density of CRISPRs") + xlab("Age (month)") +
  theme_grey(base_size = 16) 
plot_crispr_ave 

#spacer average
plot_spacer_ave <- ggplot(CRIS_data, aes(x = as.numeric(month), y = spacers_sample/total_bp * 1000000, group = babyID, colour = Gender)) + 
  geom_line(linetype = "dotted") + geom_smooth(aes(group = 1) , method = 'lm')  + xlim(0,12) + 
  ylab("Density of spacers") + xlab("Age (month)") +
  theme_grey(base_size = 16) 
plot_spacer_ave 


figure3 <- multiplot(plot_crispr,plot_spacer,plot_crispr_ave,plot_spacer_ave,cols = 2 )
figure3

#TEST
#FIG2
fig2_test <- subset(assem_qua2plot, assem_qua2plot$variable == "Community size (Mbp)")
fig2_test_b <- subset(fig2_test, fig2_test$Age == "Birth")
fig2_test_4m <- subset(fig2_test, fig2_test$Age == "4 months")
fig2_test_12m <- subset(fig2_test, fig2_test$Age == "12 months")

age_community <- aov(value ~ Age, data = fig2_test )
summary(age_community )


boys_b <- subset(fig2_test_b, Gender == "Boy")
girls_b <- subset(fig2_test_b, Gender== "Girl")
boy_b <- as.numeric(boys_b[["value"]])
girl_b <- as.numeric(girls_b[["value"]])
wilcox.test(boy_b,girl_b,alternative = "less", paired = F, exact = F)


boys_4m <- subset(fig2_test_4m, Gender == "Boy")
girls_4m <- subset(fig2_test_4m, Gender== "Girl")
boy_4m <- as.numeric(boys_4m[["value"]])
girl_4m <- as.numeric(girls_4m[["value"]])
wilcox.test(boy_4m,girl_4m,alternative = "less", paired = F, exact = F)

boys_12m <- subset(fig2_test_12m, Gender == "Boy")
girls_12m <- subset(fig2_test_12m, Gender== "Girl")
boy_12m <- as.numeric(boys_12m[["value"]])
girl_12m <- as.numeric(girls_12m[["value"]])
wilcox.test(boy_12m,girl_12m,alternative = "less", paired = F, exact = F)

#FIG3
#RICHNESS

fit_rich <- aov(Bacterial_richness ~ Age + Gender, data = richdata2plot)
summary(fit_rich)

fit_rich_boy <- lm(Bacterial_richness ~ as.numeric(Age), data = subset(richdata2plot, Gender == "Boy" ))
summary(fit_rich_boy)

fit_rich_girl <- lm(Bacterial_richness ~ as.numeric(Age), data = subset(richdata2plot, Gender == "Girl" ))
summary(fit_rich_girl)

#Fig4
#number of crisprs
fit1 <- aov(num_CRISPRs ~ Gender + month + Delivery_mode + feeding_practice_first_week + feeding_practice_4M +
              Any_breastfeeding_12_M + Antibiotic_treatment_to_infant_0_4M + Antibiotic_treatment_to_infant_4_12M, data = CRIS_data)
summary(fit1)

lm1_boy <- lm(num_CRISPRs ~ month, data = subset(CRIS_data, Gender == "Boy"))
summary(lm1_boy)

lm1_girl <- lm(num_CRISPRs ~ month, data = subset(CRIS_data, Gender == "Girl"))
summary(lm1_girl)


fit2<- aov(spacers_sample ~ Gender + month + Delivery_mode + feeding_practice_first_week + feeding_practice_4M +
             Any_breastfeeding_12_M + Antibiotic_treatment_to_infant_0_4M + Antibiotic_treatment_to_infant_4_12M, data = CRIS_data)
summary(fit2)




fit3 <- aov(num_CRIPSRs/total_bp ~ GENDER + month + Delivery_mode + feeding_practice_first_week + feeding_practice_4M +
              Any_breastfeeding_12_M + Antibiotic_treatment_to_infant_0_4M + Antibiotic_treatment_to_infant_4_12M, data = data2anova)
summary(fit3)

fit4<- aov(spacers_sample/total_bp ~ GENDER + month + Delivery_mode + feeding_practice_first_week + feeding_practice_4M +
             Any_breastfeeding_12_M + Antibiotic_treatment_to_infant_0_4M + Antibiotic_treatment_to_infant_4_12M, data = data2anova)
summary(fit4)

fit5 <- aov(spacers_sample/num_CRIPSRs ~ GENDER + month + Delivery_mode + feeding_practice_first_week + feeding_practice_4M +
              Any_breastfeeding_12_M + Antibiotic_treatment_to_infant_0_4M + Antibiotic_treatment_to_infant_4_12M, data = data2anova)
summary(fit5)

#NUM SPACERS





