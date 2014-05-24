Title
========================================================

Codebook
========

### Variables in the tidy dataset
The cleaned dataset contains 11,881 observations of 11 variables and is saved in both `text` 
(`TIDY_HumanActivity.txt`) and `csv` (`TIDY_HumanActivity.csv`) formats. 

`run_analysis.md` or `run_analysis.R` contain details on dataset creation. 


Variable list and descriptions
------------------------------


| Variable name    | Description
| -----------------|:------------
| subject          | Subject ID (1,2, ..., 30 - 30 subjects in total) 
| activity         | Activity name (e.g. WALKING, LAYING, etc. 6 activities in total)
| Domain           | Time domain or Frequency domain signal (Time or Freq)
| Instrument       | Instrument that measured the signal (Accelerometer or Gyroscope)
| Acceleration     | Acceleration signal (Body or Gravity)
| Statistic        | Mean or Standard Deviation (Mean, STD)
| Jerk             | Jerk signal
| Magnitude        | Magnitude of the signals
| Axis             | 3-axial signals in the X, Y and Z directions (X, Y, or Z)
| Count            | Number of data points used to compute `average`
| Average          | Average of each variable for each activity and each subject


### TIDY data
The first few observations of the TIDY dataset are prented below. The 
`structure` of the data is also shown:


```r
TIDY <- read.csv("TIDY_HumanActivity.csv", header = FALSE)
head(TIDY, n = 30)
```

```
##         V1       V2     V3            V4           V5   V6        V7
## 1  subject activity Domain    Instrument Acceleration Jerk Magnitude
## 2        1   LAYING   Time Accelerometer         Body <NA>      <NA>
## 3        1   LAYING   Time Accelerometer         Body <NA>      <NA>
## 4        1   LAYING   Time Accelerometer         Body <NA>      <NA>
## 5        1   LAYING   Time Accelerometer         Body <NA>      <NA>
## 6        1   LAYING   Time Accelerometer         Body <NA>      <NA>
## 7        1   LAYING   Time Accelerometer         Body <NA>      <NA>
## 8        1   LAYING   Time Accelerometer         Body <NA> Magnitude
## 9        1   LAYING   Time Accelerometer         Body <NA> Magnitude
## 10       1   LAYING   Time Accelerometer         Body Jerk      <NA>
## 11       1   LAYING   Time Accelerometer         Body Jerk      <NA>
## 12       1   LAYING   Time Accelerometer         Body Jerk      <NA>
## 13       1   LAYING   Time Accelerometer         Body Jerk      <NA>
## 14       1   LAYING   Time Accelerometer         Body Jerk      <NA>
## 15       1   LAYING   Time Accelerometer         Body Jerk      <NA>
## 16       1   LAYING   Time Accelerometer         Body Jerk Magnitude
## 17       1   LAYING   Time Accelerometer         Body Jerk Magnitude
## 18       1   LAYING   Time Accelerometer      Gravity <NA>      <NA>
## 19       1   LAYING   Time Accelerometer      Gravity <NA>      <NA>
## 20       1   LAYING   Time Accelerometer      Gravity <NA>      <NA>
## 21       1   LAYING   Time Accelerometer      Gravity <NA>      <NA>
## 22       1   LAYING   Time Accelerometer      Gravity <NA>      <NA>
## 23       1   LAYING   Time Accelerometer      Gravity <NA>      <NA>
## 24       1   LAYING   Time Accelerometer      Gravity <NA> Magnitude
## 25       1   LAYING   Time Accelerometer      Gravity <NA> Magnitude
## 26       1   LAYING   Time     Gyroscope         <NA> <NA>      <NA>
## 27       1   LAYING   Time     Gyroscope         <NA> <NA>      <NA>
## 28       1   LAYING   Time     Gyroscope         <NA> <NA>      <NA>
## 29       1   LAYING   Time     Gyroscope         <NA> <NA>      <NA>
## 30       1   LAYING   Time     Gyroscope         <NA> <NA>      <NA>
##           V8   V9   V10              V11
## 1  Statistic Axis count          average
## 2       Mean    X    50    0.22159824394
## 3       Mean    Y    50 -0.0405139534294
## 4       Mean    Z    50   -0.11320355358
## 5         SD    X    50    -0.9280564692
## 6         SD    Y    50   -0.83682740562
## 7         SD    Z    50  -0.826061401628
## 8       Mean <NA>    50    -0.8419291525
## 9         SD <NA>    50   -0.79514486386
## 10      Mean    X    50     0.0810865342
## 11      Mean    Y    50  0.0038382040088
## 12      Mean    Z    50   0.010834236361
## 13        SD    X    50     -0.958482112
## 14        SD    Y    50    -0.9241492736
## 15        SD    Z    50    -0.9548551108
## 16      Mean <NA>    50    -0.9543962646
## 17        SD <NA>    50    -0.9282456284
## 18      Mean    X    50   -0.24888179828
## 19      Mean    Y    50    0.70554977346
## 20      Mean    Z    50     0.4458177198
## 21        SD    X    50    -0.8968300184
## 22        SD    Y    50   -0.90772000676
## 23        SD    Z    50   -0.85236629022
## 24      Mean <NA>    50    -0.8419291525
## 25        SD <NA>    50   -0.79514486386
## 26      Mean    X    50  -0.016553093978
## 27      Mean    Y    50  -0.064486124088
## 28      Mean    Z    50    0.14868943626
## 29        SD    X    50   -0.87354386782
## 30        SD    Y    50    -0.9510904402
```


### The structure of the data

```r
str(TIDY)
```

```
## 'data.frame':	11881 obs. of  11 variables:
##  $ V1 : Factor w/ 31 levels "1","10","11",..: 31 1 1 1 1 1 1 1 1 1 ...
##  $ V2 : Factor w/ 7 levels "activity","LAYING",..: 1 2 2 2 2 2 2 2 2 2 ...
##  $ V3 : Factor w/ 3 levels "Domain","Freq",..: 1 3 3 3 3 3 3 3 3 3 ...
##  $ V4 : Factor w/ 3 levels "Accelerometer",..: 3 1 1 1 1 1 1 1 1 1 ...
##  $ V5 : Factor w/ 3 levels "Acceleration",..: 1 2 2 2 2 2 2 2 2 2 ...
##  $ V6 : Factor w/ 1 level "Jerk": 1 NA NA NA NA NA NA NA NA 1 ...
##  $ V7 : Factor w/ 1 level "Magnitude": 1 NA NA NA NA NA NA 1 1 NA ...
##  $ V8 : Factor w/ 3 levels "Mean","SD","Statistic": 3 1 1 1 2 2 2 1 2 1 ...
##  $ V9 : Factor w/ 4 levels "Axis","X","Y",..: 1 2 3 4 2 3 4 NA NA 2 ...
##  $ V10: Factor w/ 46 levels "36","38","39",..: 46 13 13 13 13 13 13 13 13 13 ...
##  $ V11: Factor w/ 11521 levels "-0.000143542544507042",..: 11521 10985 727 1801 5697 5253 5245 5258 5223 10526 ...
```

