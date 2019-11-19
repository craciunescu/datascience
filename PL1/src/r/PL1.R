################################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL1                 #
#                               Grupo 4 - P1                                   #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

# Check make sure files are loaded correctly.
#while(!needed %in% list.files(getwd()))
#{
#    print("Files missing!. Check data and soure files in your directory!")
#    invisible(readline(prompt="Press [enter] to continue"))
#}

# Load the data of the files.
satelites <- read.table("../../data/satelites/satelites.txt")
cardata   <- read.spss("../../data//cardata.sav", to.data.frame = T)

# Access info.
radio       <- (satelites$radio)[!is.na(satelites$radio)]
mpg         <- (cardata$mpg)[!is.na(cardata$mpg)]

# Source operations.
source("calc.R")
