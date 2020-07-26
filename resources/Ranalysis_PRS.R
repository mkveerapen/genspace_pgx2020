# Script for polygenic risk scoring, used to merge individuals' polygenic scores and principal components (PCs),
# and then compute the phenotypic variance explained by the polygenic score. 

# Written by Hanyang Shen and Laramie Duncan
# July 2017


### SETUP:
setwd("~/Downloads")		# Set the directory where files will be analyzed.

dataset <- read.table("SCZ.pe2.profile",header=T)	# Read the polygenic scores, for individuals into a file called 'dataset'


### EXAMINING THE DATA:
?hist()		# hist is a command that makes histograms of data.  By using a question mark before 'hist' you can see the documentation for the hist command.
par(mfrow=c(1,2))	# this command specifies how the histograms will be printed to the screen. It means 1 row of plots with two columns, which we will see below.

# Now we will plot histograms of the polygenic scores, and we will specify how many bins should be included (20 and 100).
# The additional commands below specify the title of the plot ('main=') and the label for the x-axis ('xlab=')
# It's always a good idea to plot your data throughout the analysis process.
hist(dataset$SCORE,main="20 bins",xlab="Schizophrenia pe2 Score",breaks=20)
hist(dataset$SCORE,main="100 bins",xlab="Schizophrenia pe2 Score",breaks=100)


### MERGING THE PRINCIPAL COMPONENTS (PC) FILE WITH THE POLYGENIC SCORES:

pca <- read.table("PCA_20_for_1000_Genomes.eigenvec")	# Read the PC file into a file called 'pca'
#pca <- read.table("All_1000_Genomes_biallelic_SNPs_maf001_pca.eigenvec")	# Same as above, but use this if the input file has a different name.

head(pca)	# Run this command to see the top of the pca file.  You will notice that there are no column names, but rather R has automatically assigned column names as V1, V2, ... . 

names(pca) <- c("FID","IID",paste0("PC",1:20))	# Provide the column names with this command.
head(pca)	# Examine the pca file again.  Now there are informative column headers.

dim(dataset)	# get the dimensions of the dataset.  At this point there are 2504 rows and 6 columns.
dataset <- merge(dataset,pca,by=c("FID","IID"))		# Merge the polygenic score file (dataset) and the pca file (pca). Merging will be based on the "FID" and "IID" columns.
dim(dataset)	# Now the dataset has 2504 rows (same as before) and 26 columns, since we merged two files. Even though the 'pca' dataset has 22 columns, two of those columns are 'FID' and 'IID' and therefore only 20 new columns are added (for the 20 PCs).

names(dataset)	# this command lets you see which columns are in 'dataset'


### ANALYSIS: CONDUCT A REGRESSION ANALYSIS IN WHICH OUR RANDOM PHENOTYPE IS REGRESSED UPON (i.e. PREDICTED BY) POLYGENIC SCORE AND PCs.

# We will run two regression analyses. The first will include the polygenic score and 10 PCs:
Fullmodel <- glm(data=dataset,PHENO-1~SCORE+PC1+PC2+PC3+PC4+PC5+
                   PC6+PC7+PC8+PC9+PC10,family = "binomial")
                   
# The second model only includes 10 PCs.                   
Reducedmodel <- glm(data=dataset,PHENO-1~PC1+PC2+PC3+PC4+PC5+
                      PC6+PC7+PC8+PC9+PC10,family = "binomial")

# Below we will calculate how much phenotypic variance is explained by the full model (PRS + PCs) and how much phenotypic variance is explained by the reduced model (PCs only).  The difference in variance explained between the two models is the amount of variance explained by the polygenic score term.  This is the primary question that is usually asked in a polygenic scoring study.                    
                      
# First we will examine the output of the regression models:                      
summary(Fullmodel)

summary(Reducedmodel)

# Now we will calculate the variance explained by the polygenic scoring 'SCORE' term.
# We need a new package to do this:
install.packages("fmsb")
library(fmsb)


NagelkerkeR2(Fullmodel)	# this command calculates Nagelkerke's R2 for the full model:
Fullmodel.rsquare <- NagelkerkeR2(Fullmodel)[[2]]		# Use this command to extract just the R2 value
Fullmodel.rsquare

Reducedmodel.rsquare <- NagelkerkeR2(Reducedmodel)[[2]]	# Now do the same for the reduced model.

diff.rsquare <- Fullmodel.rsquare -  Reducedmodel.rsquare		# Compute the difference in R2 between the two models

# FINALLY, make a nice file summaryzing the relevant results:
Estimate <- coef(summary(Fullmodel))[2,c(1,4)]	# get the log(OR) and p-value for the polygenic score term (from the full model). Note that it is not significant.
results <- as.data.frame(cbind(Estimate[1],Estimate[2],diff.rsquare))	# put these values into a 'results' file with the differnece in R2
names(results) <- c("OR","p-value","NagelkerkeR2")	# For clarity, add column headers manually
results		# Look at the results file you've created! 


write.csv(results,"PRS results.csv")		# now write this results file to a file on your computer. 













