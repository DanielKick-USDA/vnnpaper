#!/usr/bin/R
# loading packages for GAPIT and GAPIT functions
#source("./GAPIT_functions/GAPIT.library.R")
#source("./GAPIT_functions/gapit_functions.txt")
library(tidyverse)
library(GAPIT)

myY=read.table(file="./hmp_phno.txt", head = TRUE, skip = 2)
myY <- as.data.frame(myY) 
dim(myY)

#myG <- read.table("./5_Genotype_Data_All_Years_hzg0825.hmp.txt",
myG <- read.table("./geno.hmp.txt",
                  head = FALSE, 
                  comment.char = '', # important so that columns are not truncated by #
                  sep = '\t' # must be set to prevent empty columns from being excluded
                  )
dim(myG)

#Step 2: Run GAPIT
myGAPIT <- GAPIT(
		 Y=myY,
		 G=myG,
		 PCA.total=3,
		 model="CMLM"
		 )
#for(current_model in c(
#  "GLM", "MLM", "CMLM", "MLMM", "SUPER", "FarmCPU", "BLINK")){
#  print(current_model) 
#  
#  myGAPIT <- GAPIT(
#    Y=myY,
#    G=myG,
#    PCA.total=3,
#    model=current_model
#  )
#}
