### This is the README.md file, set up to explain how all of the scripts work and are connected.


#### Preliminary assumptions:
* The file "run_analysis" includes the relevant code for "tidying" the data. Note: as per the instructions, the script assumes that the data set is already in the current working directory when run. Nevertheless, the dataset can be obtained via [this link][id].
* This script requires the use of Hadley Wickham's **reshape2** package. Thus, you should install said package *before* running this script.









##### Elements of a *tidy data set*

The script I've provided ensures that:
1. Each variable measured is in its own column
2. Different observations of that a given variable are all in a different rows.
[Note: the next two elements--though important components of "tidy data"--do not pertain to this script, however]
3. One table for each “kind” of variable 
4. With multiple tables, they should include a column in the table that allows them to be linked.
  
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

##### Additional Notes:
* The folder: "Original Content" provides the original descriptions from the UCI HAR Dataset--for explanations of some of the more complicated **features** (esp. those involving **Fast Fourier Transforms**), these original files should be sought out.


[id]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
