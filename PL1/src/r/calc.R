################################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL1                 #
#                               Grupo 4 - P1                                   #
#                                                                              #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

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
