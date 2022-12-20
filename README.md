# *Curated-BINs-Reference-Library*

This script selects the previously curated BINs (Barcode Index Numbers) and species names from a complete graded library (resultant from the [BAGS analysis](https://github.com/tadeu95/BAGS)) 
and selects three representative records from each BIN based on previously established quality-control criteria. 

If two or more records are tied in relation to the criteria, one record is randomly selected. 

The criteria for record selection are based on the size of the sequences and the presence of geographic information for the specimen. 
Nine sequence size classes were created to select the 3 records from each BIN: 1) sequences with 658 bp; 2) ≥ 650 & <658 bp; 3) ≥ 600 & <625 bp; 4) ≥ 575 & <600 bp; 5) ≥ 550 & <575 bp; 6) ≥ 525 & <550 bp; 7) ≥ 500 & <525 bp; 8) <500 & >658 bp.  
Within each sequence size category, priority is given to the records that have geographical information (i.e., country of region of origin).

Before running this script, you should prepare your input files: one reference library obtained from the BAGS analysis in tsv or csv format; 
and one csv/tsv file comprising a previously curated list of BINs with their corresponding species names. The file must contain a header and the first two columns should comprise, respectively, the BINs and the species names. 
The species names column must be named “species” (case-sensitive).

Then, any R environment can be used (e.g., RStudio) to run the script. Usage instructions:
1-	Go to “File” in the top left corner, select “Open File” and search for the script to open it in your R environment.
2-	Install the necessary packages by running the following command: 
```
install.packages(c("tidyr","dplyr"))
```
3-	Set your working directory to a folder or directory containing the input files. You can do this manually in RStudio by browsing for the directory then clicking “More” and “Set as working directory”. Alternatively, you can use the “setwd” function. Example:
```
setwd("C:/User/Folder_with_input_files")
```
4-	Run the script either by running each line individually or by running the entire script at once.
5-	Check your working directory, where you should find the output files.


