###############################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL1                 #
#                               Grupo 4 - P1                                   #
#                                                                              #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

# Load needed packages.
library(foreign)

# Check if files are in directory.

needed <- c("cardata.sav", "satelites.txt", "calc.R")

#while(!needed %in% list.files(getwd()))
#{
#    print("Files missing!. Check cardata, satelites and calc are in your dir")
#    invisible(readline(prompt="Press [enter] to continue"))
#}

# Load the data of the files.
satelites <- read.table("${GIT_DIR}/PL1/data/satelites/satelites.txt")

# satelites   <- read.table("satelites.txt")
# cardata     <- read.spss("cardata.sav", to.data.frame = T)

# Access info.
radio       <- (satelites $ radio)[!is.na(radio)]
# mpg         <- (cardata $ mpg)[!is.na(mpg)]

# Source operations.
source("calc.R")

