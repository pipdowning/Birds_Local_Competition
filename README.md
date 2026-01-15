# Birds_Local_Competition
Data, code, and supplementary information for HOW LARGE COOPERATIVE BIRD GROUPS AVOID LOCAL COMPETITION

Number of supplementary items: eight
1. Table_S1.csv
2. Table_S2.csv
3. Table_S3.csv
4. Table_S4.csv
5. Data_Extraction.txt
6. BLCtree.tre
7. BLC_code.R
8. BLC_supp_figures.pdf


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

File name: Table_S1.csv

This csv document contains:
	+ details of the 15 benchmark studies
	+ column descriptions:
		A. Authors
		B. Year
		C. Title
		D. Journal


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

File name: Table_S2.csv

This csv document contains:
	+ the 199 full text records screened with reasons for exclusion 
	+ column descriptions:
		A. source = was the record identified from scopus / web of science or during screening
		B. title = name of record
		C. year = publication date of record
		D. journal = name of scientific journal if applicable
		E. volume = journal volume if applicable
		F. issue = journal issue if applicable
		G. pages = journal pages if applicable
		H. authors = who conducted the study
		I. coop_breeding_definition = does the record meet the cooperative breeding definition (yes / no)
		J. data_available = can data be extracted from the record to calculate an effect size (yes / no)
		K. territory_area = was space use during the breeding season reported (yes / no)
		L. group_size_definition = was group size during the breeding season reported (yes / no)
		M. decision = was the record included or excluded
		N. notes = details on why studies were excluded


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

File name: Table_S3.csv

This csv document contains:
	+ Zr effect size estimates for the 29 species included in the study
	+ this file should be read into R
	+ column descriptions:
		A. species = English name of each species
		B. tip_label = latin binomial of each species, matches the phylogeny
		C. Zr = Fisher’s Z-transformed correlation coefficient
		D. var_Zr = variance of Zr, calculated as 1/(n-3) where n is the sample size
		E. n_groups = the number of groups studied, corresponds to n above


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

File name: Table_S4.csv

This csv document contains:
	+ data on within-group changes in group size and territory size from five studies
	+ this file should be read into R
	+ column descriptions:
		A. species = English name of each species
		B. group_ID = the ID given to each group in the original study
		C. D_group_size = change in group size between breeding seasons
		D. D_terr_area = change in territory area between breeding seasons
		E. study = reference for the data point


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

File name: Data_Extraction.txt

This plain text document contains details of the figures, tables, and text fragments from which data were obtained, and the calculations used to pool data, organised by study


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

File name: BLCtree.tre

The phylogeny used in the analysis. To be read into R using the script below.


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

File name: BLC_code.R

This R script contains all the code needed to replicate the analyses (including packages and functions).

- Packages and Data (lines 9 to 33)
- Mean Effect Size
	+ Main analysis (lines 40 to 56)
	+ Sensitivity analysis (lines 59 to 79)
	+ Publication bias (lines 82 to 142)
- Within-Group Changes
	+ Main analysis (lines 153 to 161)
	+ Sensitivity analysis (lines 164 to 173)


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

File name: BLC_supp_figures.pdf

This PDF document contains supplementary figures S1 to S3.


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
