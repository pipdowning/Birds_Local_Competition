#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

## R code for:

## HOW LARGE COOPERATIVE BIRD GROUPS AVOID LOCAL COMPETITION

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

### PACKAGES AND DATA ###

library(metafor)
library(lattice)
library(ape)

## Zr effect sizes ##
data <- read.csv("...Table_S3.csv")
data$obs <- paste(data$species, 1:length(data$species), sep="")
data

## Within-group changes ##
within_data <- read.csv("...Table_S4.csv")
within_data

## Phylogeny ##
tree <- read.tree("...BLCtree.tre")
class(tree)
length(tree$tip.label)	# 29 species
plot(tree)
phylo_matrix <- vcv(tree, cor=TRUE)	# create the phylogenetic variance-covariance matrix

# check match between species in data and species in tree
data$tip_label[which((data$tip_label %in% tree$tip.label) == FALSE)]
tree$tip.label[which((tree$tip.label %in% data$tip_label) == FALSE)]


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

### MEAN EFFECT SIZE ###

## Main Analysis / Full Dataset ##

main_meta_mod <- rma.mv(Zr ~ 1, V=var_Zr, random=list(~1|obs, ~1|tip_label), R=list(tip_label=phylo_matrix), data=data)
summary(main_meta_mod)		# 0.39 < 0.57 < 0.76
tanh(0.57)		# back-transformed effect size r = 0.52 
0.52^2				# R^2 = 0.27
forest(main_meta_mod, showweights=TRUE, order="obs")

# within-study variance
wj <- 1/data$var_Zr							# inverse measurement error / sampling error variance
k <- length(data$var_Zr)						# number of studies
within <- sum(wj * (k-1)) / (sum(wj)^2 - sum(wj^2))		# 0.052

# heterogeneity
I2.within <-  within / (0.0783 + 0.0143  + within) * 100		# 36 %
I2.between <- 0.0783 / (0.0783 + 0.0143  + within) * 100		# 54 %
I2.phylo <- 0.0143  / (0.0783 + 0.0143  + within) * 100		# 10 %


## Sensitivity Analysis / Reduced Dataset ##

# exclude arrow marked babbler, red-cockaded woodpecker, rufous vanga, Seychelles warbler
# unsure if group size is adults only
exclude_sp <- c("Turdoides_jardineii", "Dryobates_borealis", "Schetba_rufa", "Acrocephalus_sechellensis")
sens_data <- data[!data$tip_label %in% exclude_sp,]

# trim the tree
sens_tree <- drop.tip(tree, exclude_sp, trim.internal=T)
sens_tree <- makeNodeLabel(sens_tree, method = "number")
plot(sens_tree)
length(sens_tree$tip.label)
sens_phylo_matrix <- vcv(sens_tree, cor=TRUE)

# check match between species in data and species in tree
sens_data$tip_label[which((sens_data$tip_label %in% sens_tree$tip.label) == FALSE)]
sens_tree$tip.label[which((sens_tree$tip.label %in% sens_data$tip_label) == FALSE)]
 
sens_meta_mod <- rma.mv(Zr ~ 1, V=var_Zr, random=list(~1|obs, ~1|tip_label), R=list(tip_label=sens_phylo_matrix), data=sens_data)
summary(sens_meta_mod)		# 0.44 < 0.61 < 0.77
forest(sens_meta_mod, showweights=TRUE, order="obs")


## Publication Bias and Heterogeneity ##

# basic random effect model in metafor without phylogeny
basic_mod <- rma(Zr ~ 1, vi=var_Zr, data=data)		# 0.57
summary(basic_mod)		# mean effect size = 0.57 (se = 0.08), lwr = 0.43, upr = 0.72
# tau^2 (between-study variance or heterogeneity) = 0.0886 (se = 0.04)
# I^2 (total heterogeneity / total variability) = 62.8 %
# calculated as 0.0886 / (0.0886 + within)
# test for heterogeneity Q (df = 28) = 78.7, p < 0.001

# Trim and Fill
# gives the number of effect sizes needed to generate a symmetric funnel plot
# the mean effect size is re-estimated including these
# done on the full dataset and ignores dependencies in the data (see below)
trimfill(basic_mod)		# mean effect size = 0.43 (se = 0.08), lwr = 0.27, upr = 0.58
# 9 studies estimated missing from the left-hand side
# in this case, the mean effect size has decreased from 0.57 to 0.43

# Funnel Plot
# used to explore small study effects (if effect sizes with small N are larger)
# small study effects are indicative of publication bias (but can arise for other reasons too)
# done on the full dataset and ignores dependencies in the data (see below)
funnel(data$Zr, ni=data$n_groups, yaxis="ni", ylab="Sample size", xlab=expression(paste(paste("Group size and territory area (",italic("Zr"),")"))), cex.lab=2)
# no apparent relationship between effect size magnitude and sample sizes
# with sampling variance (vi) instead of N
funnel(data$Zr, vi=data$var_Zr, yaxis="vi", ylab="Sampling variance", xlab=expression(paste(paste("Group size and territory area (",italic("Zr"),")"))), cex.lab=2)

# Fail-safe Number
# or the ‘file-drawer number’ is the number of statistically 
# non-significant unpublished results needed to make the overall effect non-significant
# This is not an estimate of the number of missing studies
# A small number is indicative of publication bias
# Note that the fail-safe N is difficult to interpret (see Nakagawa et al. 2022)
# Rosenthal
fsn(data$Zr, vi=data$var_Zr, type="Rosenthal")		# N = 1598
# Orwin
fsn(data$Zr, vi=data$var_Zr, type="Orwin")			# N = 29
# Rosenberg
fsn(data$Zr, vi=data$var_Zr, type="Rosenberg")		# N = 1149

# Egger's test not accounting for dependencies
# the intercept provides an estimate of the adjusted mean effect size
# ie the mean Zr when the sampling variance is zero
plot(Zr ~ var_Zr, data=data)
Egg_mod_1 <- lm(Zr ~ var_Zr, data=data)
summary(Egg_mod_1)
# int = 0.56 (se = 0.08, p < 0.001)
# slope = 0.60 (se = 0.36, p = 0.105)
abline(Egg_mod_1)

# Egger's test accounting for phylogeny
# the intercept provides an estimate of the adjusted mean effect size
# ie the mean Zr when the sampling variance is zero
Egg_mod_2 <- rma.mv(Zr ~ var_Zr, V =var_Zr, random = list(~ 1|obs, ~ 1|tip_label), R = list(tip_label = phylo_matrix), data = data)
summary(Egg_mod_2)
# int = 0.49 (se = 0.13, p < 0.001)
# slope = 1.25 (se = 0.77, p = 2.77)
# I^2 estimates
I2.within <-  within / (0.0514 + 0.0432  + within) * 100		# 36 %
I2.between <- 0.0514 / (0.0514 + 0.0432  + within) * 100		# 35 %
I2.phylo <- 0.0432  / (0.0514 + 0.0432  + within) * 100		# 29 %


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

### WITHIN-GROUP CHANGES ###

# visualise the data study by study
xyplot(D_terr_area ~ D_group_size | species, within_data)


## Main Analysis / Full Dataset ##

main_within_mod <- lm(D_terr_area ~ D_group_size, within_data)
summary(main_within_mod)
confint(main_within_mod, level=0.95)
# int = 2.26 (se = 1.98, p = 0.26)
# slope = 4.58 < 5.87 < 7.15 (se = 0.63, p < 0.001)
plot(D_terr_area ~ D_group_size, within_data)
abline(main_within_mod)


## Sensitivity Analysis / Reduced Dataset ##

# exclude Raford & du Plessis study which accounts for 65 % of the data (22/34 groups)
sens_within_mod <- lm(D_terr_area ~ D_group_size, within_data[-which(within_data$species == "green woodhoopoe A"),])
summary(sens_within_mod)
confint(sens_within_mod, level=0.95)
# int = -1.01 (se = 4.07, p = 0.81)
# slope = 5.08 < 7.00 < 8.92 (se = 0.86, p < 0.001)
plot(D_terr_area ~ D_group_size, within_data[-which(within_data$species == "green woodhoopoe A"),])
abline(main_within_mod)


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

## The End

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#