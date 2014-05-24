Title
========================================================

Codebook
========

### Variables in the tidy dataset
The cleaned dataset is saved in both `text` (`TIDY_HumanActivity.txt`) and `csv` 
(`TIDY_HumanActivity.csv`) formats. `run_analysis.md` or `run_analysis.R` 
contain details on dataset creation.

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
| Average          | Feature: Average of each variable for each activity and each subject


### The first few observations


```r
TIDY <- read.csv("TIDY_HumanActivity.csv", header = FALSE)
head(TIDY, n = 25)
```

```
##         V1       V2     V3           V4            V5   V6        V7
## 1  subject activity Domain Acceleration    Instrument Jerk Magnitude
## 2        1   LAYING   Time         <NA>     Gyroscope <NA>      <NA>
## 3        1   LAYING   Time         <NA>     Gyroscope <NA>      <NA>
## 4        1   LAYING   Time         <NA>     Gyroscope <NA>      <NA>
## 5        1   LAYING   Time         <NA>     Gyroscope <NA>      <NA>
## 6        1   LAYING   Time         <NA>     Gyroscope <NA>      <NA>
## 7        1   LAYING   Time         <NA>     Gyroscope <NA>      <NA>
## 8        1   LAYING   Time         <NA>     Gyroscope <NA> Magnitude
## 9        1   LAYING   Time         <NA>     Gyroscope <NA> Magnitude
## 10       1   LAYING   Time         <NA>     Gyroscope Jerk      <NA>
## 11       1   LAYING   Time         <NA>     Gyroscope Jerk      <NA>
## 12       1   LAYING   Time         <NA>     Gyroscope Jerk      <NA>
## 13       1   LAYING   Time         <NA>     Gyroscope Jerk      <NA>
## 14       1   LAYING   Time         <NA>     Gyroscope Jerk      <NA>
## 15       1   LAYING   Time         <NA>     Gyroscope Jerk      <NA>
## 16       1   LAYING   Time         <NA>     Gyroscope Jerk Magnitude
## 17       1   LAYING   Time         <NA>     Gyroscope Jerk Magnitude
## 18       1   LAYING   Time         Body Accelerometer <NA>      <NA>
## 19       1   LAYING   Time         Body Accelerometer <NA>      <NA>
## 20       1   LAYING   Time         Body Accelerometer <NA>      <NA>
## 21       1   LAYING   Time         Body Accelerometer <NA>      <NA>
## 22       1   LAYING   Time         Body Accelerometer <NA>      <NA>
## 23       1   LAYING   Time         Body Accelerometer <NA>      <NA>
## 24       1   LAYING   Time         Body Accelerometer <NA> Magnitude
## 25       1   LAYING   Time         Body Accelerometer <NA> Magnitude
## 26       1   LAYING   Time         Body Accelerometer Jerk      <NA>
## 27       1   LAYING   Time         Body Accelerometer Jerk      <NA>
## 28       1   LAYING   Time         Body Accelerometer Jerk      <NA>
## 29       1   LAYING   Time         Body Accelerometer Jerk      <NA>
## 30       1   LAYING   Time         Body Accelerometer Jerk      <NA>
##           V8   V9   V10              V11
## 1  Statistic Axis count          average
## 2       Mean    X    50  -0.016553093978
## 3       Mean    Y    50  -0.064486124088
## 4       Mean    Z    50    0.14868943626
## 5         SD    X    50   -0.87354386782
## 6         SD    Y    50    -0.9510904402
## 7         SD    Z    50    -0.9082846626
## 8       Mean <NA>    50     -0.874759548
## 9         SD <NA>    50   -0.81901016976
## 10      Mean    X    50  -0.107270949192
## 11      Mean    Y    50   -0.04151728689
## 12      Mean    Z    50    -0.0740501211
## 13        SD    X    50    -0.9186085208
## 14        SD    Y    50    -0.9679072436
## 15        SD    Z    50    -0.9577901596
## 16      Mean <NA>    50      -0.96346103
## 17        SD <NA>    50    -0.9358409828
## 18      Mean    X    50    0.22159824394
## 19      Mean    Y    50 -0.0405139534294
## 20      Mean    Z    50   -0.11320355358
## 21        SD    X    50    -0.9280564692
## 22        SD    Y    50   -0.83682740562
## 23        SD    Z    50  -0.826061401628
## 24      Mean <NA>    50    -0.8419291525
## 25        SD <NA>    50   -0.79514486386
## 26      Mean    X    50     0.0810865342
## 27      Mean    Y    50  0.0038382040088
## 28      Mean    Z    50   0.010834236361
## 29        SD    X    50     -0.958482112
## 30        SD    Y    50    -0.9241492736
```

