#!/usr/bin/Rscript

################################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL1                 #
#                               Grupo 4 - P1                                   #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

################################################################################
#                       IMPORTS AND DEPENDENCY CHECKS                          #
################################################################################

library(docopt)
library(foreign)
library(tools)
library(splus2R)

# list_of_packages[!(list_of_packages %in% installed.packages()[, "Package"])]

################################################################################
#                               CALCULATIONS                                   #
################################################################################

# 1. Calculate absolute and relative satellite radius frequencies.

## 1.1. Absolute frequencies.
absoluteFreq    <- function(set) {table(set)}
cumAbsoluteFreq <- function(set) {cumsum(absoluteFreq(set))}

## 1.2. Relative frequencies.
   relativeFreq <- function(set) {table(set) / length(set)}
cumRelativeFreq <- function(set) {cumsum(relativeFreq(set))}

################################################################################

# 2. Arithmetic mean.
arithmeticMean <- function(set, usrTrim = 0) (mean(set, trim = usrTrim))

################################################################################

# 3. Measures of dispersion.

# The following page was used as a reference for this section.
# http://iridl.ldeo.columbia.edu/dochelp/StatTutorial/Dispersion/index.html#Intro

## 3.1. Range.
          range <- function(set) {max(set) - min(set)}

## 3.2. Standard Deviation.
   stdDeviation <- function(set)
{
   sd(set) * (sqrt((length(set) - 1) / length(set)))
}

## 3.3. Variance.
       variance <- function(set) {var(set) * (length(set) - 1 / length(set))}

## 3.4. Root Mean Square.
    rootMeanSqr <- function(set) {sqrt(mean(set ^ 2))}

## 3.5. Root Mean Square Anomaly.
  rootMeanSqrAn <- function(set) {sqrt(sum(set - mean(set)) ^ 2) / length(set)}

## 3.6. Interquartile Range.
interQuartRange <- function(set) {IQR(set)}

## 3.7. Median Absolute Deviation.
medAbsDeviation <- function(set) {mad(set)}

################################################################################

# 4. Measures of order.

## 4.1. Median.
getMedian    <- function(set) {median(set)}

## 4.2. Mode.
getMode      <- function(set)
{
    uniqueVal <- unique(set)
    uniqueVal[which.max(tabulate(match(set, uniqueVal)))]
}

## 4.2. Quartiles.
getQuartiles <- function(set) {quantile(set)}

## 4.3. 54th Quantile.
getQuantiles <- function(set, range = 0) {quantile(set, probs = range)}

################################################################################
#                                 INTERFACE                                    #
################################################################################

'
sStats 1.1, a simple statistical analyzer

Usage:
    sstats freq (--abs | --cum_abs | --rel | --cum_rel) (--path=PATH --var=VAR)
    sstats mean (--path=PATH --var=VAR)
    sstats disp (--iq | --mad | --rng | --rms | --rmsa | --std | --vari) (--path=PATH --var=VAR)
    sstats ord (--med | --mod | --qnt=QUANT | --qrt) (--path=PATH --var=VAR)
    sstats -a | --authors
    sstats -h | --help
    sstats -l | --license
    sstats --version

Options:
    -a --authors        Show authors of the program.
    -h --help           Show this screen.
    -l --license        Show license information.
    --version           Show version information.

Commands:
    freq - frequency analyzer
    --abs               Absolute frequency
    --cum_abs           Cumulative absolute frequency
    --rel               Relative frequency
    --cum_rel           Cumulative relative frequency

    mean                Arithmetic mean

    disp - dispersion measures
    --iq                Interquartile range
    --mad               Median absolute deviation
    --rng               Range
    --rms               Root mean square
    --rmsa              Root mean square anomaly
    --std               Standard deviation
    --vari              Variance
   
    ord - ordering measures
    --med               Median
    --mod               Mode
    --qnt=QUANT         Quantile
    --qrt               Quartile

Input:
    Only processes .txt and .sav files.
' -> docString

args <- docopt(docString, version = 'sStats 1.1')

################################################################################
#                               PARSE INPUT                                    #
################################################################################

if (args $ authors) {
    cat("Proudly developed by @craciunescu and @laurapm\n")

} else if (args $ license) {
    cat(readLines("../LICENSE"), fill = T)

} else {

    # Process input file | Check for supported extension
    ext <- lowerCase(file_ext(file.path(args$path)))

    if (ext == "txt") {
        dataset <- read.table(args$path)
    } else if (ext == "sav") {
        dataset <- read.spss(args$path, to.data.frame = T)
    } else {
        print("The input file cannot be processed")
    }

    # R does not accept direct variable reference to dataset column.
   
    column <- args$var
    data <- c(dataset[column][!is.na(dataset[column])])   

    ############################################################################
    #                               COMMANDS                                   #
    ############################################################################

    # Frequencies.
    if (args $ freq) {
    
        if (args $ abs) {
            cat("Absolute frequency of data")
            absoluteFreq(data)
        
        } else if (args $ cum_abs) {
            cat("Cumulative absolute frequency\n")
            cumAbsoluteFreq(data)

        } else if (args $ rel) {
            cat("Relative frequency of data") 
            relativeFreq(data)
       
        } else if (args $ cum_rel) {
            cat("Cumulative relative frequency of data")
            cumRelativeFreq(data)
       
        } else {
            cat("Unsupported behavior for FREQ command")
            print(docString)
        }

    # Means.
    } else if (args $ mean) {
        cat("Arithmetic mean =", arithmeticMean(data), "\n")

    # Dispersion.
    } else if (args $ disp) {
        if (args $ iq) {
            cat("Interquartile Range =", interQuartRange(data), "\n")

        } else if (args $ mad) {
            cat("Median Absolute Deviation =", medAbsDeviation(data), "\n")

        } else if (args $ rng) {
            cat("Range =", range(data), "\n")

        } else if (args $ rms) {
            cat("Root mean square =", rootMeanSqr(data), "\n")

        } else if (args $ rmsa) {
            cat("Root mean square anomaly =", rootMeanSqrAn(data), "\n")

        } else if (args $ std) {
            cat("Standard deviation =", stdDeviation(data), "\n")

        } else if (args $ vari) {
            cat("Variance =", variance(data), "\n")

        } else {
            cat("Unsupported behavior for DISP command")
            cat(docString)
        }
    
    # Ordering.
    } else if (args $ ord) {
        if (args $ med) {
            cat("Median =", getMedian(data), "\n")

        } else if (args $ mod) {
            cat("Mode =", getMode(data), "\n")

        } else if (!is.null(args$qnt)) {
            
            quant <- as.numeric(args$qnt)

            if ((quant > 0) && (quant <= 1))
            {
                cat("Quantile", quant*100, "% =" , getQuantiles(data, quant), "\n")
            } else {
                cat("Unsupported Quantile Value\n")
                cat("--qnt=[0-1]\n")
            }

        } else if (args$qrt) {
            cat("Quartiles\n")
            getQuartiles(data)

        } else {
            cat("Unsupported behavior for ORD command")
            cat(docString)
        }

    # Unsupported behavior.
    } else {
        cat("An unidentified error has occurred")
        cat("Please report bugs to github.com/craciunescu/sstats")
        cat("\n")
        cat(docString)
    }
}
