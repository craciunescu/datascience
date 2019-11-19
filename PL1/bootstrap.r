################################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL1                 #
#                               Grupo 4 - P1                                   #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

# library(docopt)

# Check current directory.
dir_current <- getwd()

if (grepl(".*/PL1", dir_current, perl=T)) {
    cat("hey\n")
} else {
    message("ERROR. Script not executed in correct directory.")
    message("To solve this issue, execute in */DataScience/PL1")
}

# list_of_packages[!(list_of_packages %in% installed.packages()[, "Package"])]

#'
#sStats: a Simple STATistical analyzer.
#
#Usage:
#    sStats.R --in=<input> [--out=<output>]
#    sStats.R (-i | --interactive)
#    sStats.R (-h | --help)
#    sStats.R (-v | --version)
#    sStats.R (-a | --authors)
#    sStats.R (-l | --license)
#
#Options:
#    -i, --interactive   Interactive mode.
#    -h, --help          Show this screen.
#    -v, --version       Show version.
#    -a, --authors       Show authors.
#    -l, --license       Show license.
#' -> #docString

#args <- docopt(docString, version = "sStats 1.0")


#if (args$authors) {
#    cat("@davecraciunescu\n@laurapm\n")
#} else if (args$license) {
#    cat(readLines("../LICENSE"), fill = T)
#} else {
#    cat("else")
#}
