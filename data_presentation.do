capture log close data_presentation
log using "D:\data\kode\FCDY3702\logs\data_presentation.log", replace name(data_presentation)

use  "D:\data\workdata\703702\Data\Sally\data\complete.dta" , replace

*Generer 0/1-varibel for, om personen bruger medicin eller ej*
gen medicin = 0
replace medicin = 1 if total_DDD!=.
unique pnr

* Tal til tabel til datapresentation
codebook pnr if medicin==0
codebook pnr if medicin==1
codebook pnr if kqn=="M" & medicin==0
codebook pnr if kqn=="K" & medicin==0
codebook pnr if kqn=="M" & medicin==1
codebook pnr if kqn=="K" & medicin==1

replace prescpt=0 if inpsyk==1
replace prescpt=0 if insom==1
replace prescpt=. if prescpt==0

codebook pnr if inpsyk==1 & medicin==1
codebook pnr if insom==1 & medicin==1
codebook pnr if prescpt==1 & medicin==1

duplicates report pnr

tostring year, gen(year_s)
tostring quarter, gen(quarter_s)
gen year_quarter=year_s+quarter_s
replace year_quarter="." if missing(year)

duplicates report year_quarter


* Generere middelværdi pr kvartal pr år
capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD.xlsx", sheet("Means",replace) modify

tokenize "`c(alpha)'"
local column_no=2
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
	mean total_DDD, over(year quarter)
		matrix table=(r(table)')
		matrix results=table[1..72,1],table[1..72,5..6]
		putexcel `indexcol'`col'1=matrix(e(N))
		putexcel `indexcol'`col'3=matrix(results)
tokenize "`c(alpha)'"
local column_no=5
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
		tabulate year_quarter if !missing(total_DDD),matcell(result)
			putexcel `indexcol'`col'3=matrix(result)
			


* Middelværdier stratificeret på diagnose type
preserve
keep if inpsyk==1
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_inpsyk.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_inpsyk.xlsx", sheet("Means",replace) modify

tokenize "`c(alpha)'"
local column_no=2
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
	mean total_DDD, over(year quarter)
		matrix table=(r(table)')
		matrix results=table[1..72,1],table[1..72,5..6]
		putexcel `indexcol'`col'1=matrix(e(N))
		putexcel `indexcol'`col'3=matrix(results)
		
tokenize "`c(alpha)'"
local column_no=5
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
		tabulate year_quarter if !missing(total_DDD) ,matcell(result)
			putexcel `indexcol'`col'3=matrix(result)

restore

preserve
keep if insom==1
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_insom.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_insom.xlsx", sheet("Means",replace) modify

tokenize "`c(alpha)'"
local column_no=2
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
	mean total_DDD, over(year quarter)
		matrix table=(r(table)')
		matrix results=table[1..72,1],table[1..72,5..6]
		putexcel `indexcol'`col'1=matrix(e(N))
		putexcel `indexcol'`col'3=matrix(results)
tokenize "`c(alpha)'"
local column_no=5
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
		tabulate year_quarter if !missing(total_DDD), matcell(result)
			putexcel `indexcol'`col'3=matrix(result)
restore

preserve
keep if prescpt==1
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_prescpt.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_prescpt.xlsx", sheet("Means",replace) modify

tokenize "`c(alpha)'"
local column_no=2
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
	mean total_DDD, over(year quarter)
		matrix table=(r(table)')
		matrix results=table[1..61,1],table[1..61,5..6]
		putexcel `indexcol'`col'1=matrix(e(N))
		putexcel `indexcol'`col'14=matrix(results)
tokenize "`c(alpha)'"
local column_no=5
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
		tabulate year_quarter if !missing(total_DDD) ,matcell(result)
			putexcel `indexcol'`col'14=matrix(result)
restore

* Middelværdier stratificeret på køn
preserve
keep if kqn=="K"
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_female.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_female.xlsx", sheet("Means",replace) modify

tokenize "`c(alpha)'"
local column_no=2
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
	mean total_DDD, over(year quarter)
		matrix table=(r(table)')
		matrix results=table[1..72,1],table[1..72,5..6]
		putexcel `indexcol'`col'1=matrix(e(N))
		putexcel `indexcol'`col'3=matrix(results)
tokenize "`c(alpha)'"
local column_no=5
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
		tabulate year_quarter if !missing(total_DDD),matcell(result)
			putexcel `indexcol'`col'3=matrix(result)
restore

preserve
keep if kqn=="M"
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_male.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_male.xlsx", sheet("Means",replace) modify

tokenize "`c(alpha)'"
local column_no=2
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
	mean total_DDD, over(year quarter)
		matrix table=(r(table)')
		matrix results=table[1..72,1],table[1..72,5..6]
		putexcel `indexcol'`col'1=matrix(e(N))
		putexcel `indexcol'`col'3=matrix(results)
tokenize "`c(alpha)'"
local column_no=5
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
		tabulate year_quarter if !missing(total_DDD),matcell(result)
			putexcel `indexcol'`col'3=matrix(result)
restore

* Middelværdier stratificeret på diagnosetidspunkt før/efter guideline i 2007
preserve
keep if diag_after==0
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_before.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_before.xlsx", sheet("Means",replace) modify

tokenize "`c(alpha)'"
local column_no=2
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
	mean total_DDD, over(year quarter)
		matrix table=(r(table)')
		matrix results=table[1..72,1],table[1..72,5..6]
		putexcel `indexcol'`col'1=matrix(e(N))
		putexcel `indexcol'`col'3=matrix(results)
tokenize "`c(alpha)'"
local column_no=5
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
		tabulate year_quarter if !missing(total_DDD),matcell(result)
			putexcel `indexcol'`col'3=matrix(result)
restore

preserve
keep if diag_after==1
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_after.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_after.xlsx", sheet("Means",replace) modify

tokenize "`c(alpha)'"
local column_no=2
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
	mean total_DDD, over(year quarter)
		matrix table=(r(table)')
		matrix results=table[1..20,1],table[1..20,5..6]
		putexcel `indexcol'`col'1=matrix(e(N))
		putexcel `indexcol'`col'54=matrix(results)
tokenize "`c(alpha)'"
local column_no=5
local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
local col="``col_no''"
local indexcol_no=floor((`column_no'-1)/26)
local indexcol="``indexcol_no''"
		tabulate year_quarter if !missing(total_DDD),matcell(result)
			putexcel `indexcol'`col'54=matrix(result)
restore

gen diag_how=0
replace diag_how=1 if inpsyk==1
replace diag_how=2 if insom==1
replace diag_how=3 if prescpt==1

gen diag_age=int((firstdato-fdato)/365.25)


gen time=0
replace time=quarter if year==1995

forvalues i=1996/2012 {
	forvalues j=1/4 {
		replace time=quarter+((`i'-1995)*4) if year==`i' & quarter==`j'
	}
}

gen time_sin_diag=year-year(firstdato)

gen kqn2=1 if kqn=="K"
replace kqn2=2 if kqn=="M"

label data "Final Long"
save "D:\data\workdata\703702\Data\Sally\data\final_long.dta", replace


replace year_quarter="0" if missing(year)
drop time time_sin_diag



** RESHAPE FROM LONG TO WIDE
rename total_DDD DDD
drop year year_s quarter*
reshape wide DDD, i(pnr) j(year_quarter) string
drop DDD0

gen y_firstdato=year(firstdato)
gen q_firstdato=quarter(firstdato)
tostring y_firstdato q_firstdato, replace
gen yq_firstdato=y_firstdato+q_firstdato
drop y_firstdato q_firstdato
destring yq_firstdato, replace

gen y_statd=year(statd)
gen q_statd=quarter(statd)
tostring y_statd q_statd, replace
replace y_statd="" if missing(y_statd)
replace q_statd="" if missing(q_statd)
gen yq_statd=y_statd+q_statd
drop y_statd q_statd
replace yq_statd="" if missing(statd)
destring yq_statd, replace


foreach x of varlist DDD19951-DDD20124 {
	replace `x'=0 if `x'==.
}



forvalues i=1995/2012 {
	forvalues j=1/4 {
		replace DDD`i'`j'=. if `i'`j'<yq_firstdato 
		replace DDD`i'`j'=. if `i'`j'>yq_statd 
	}
}

capture erase "D:\data\workdata\703702\Data\Sally\results\prevalens.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\prevalens.xlsx", sheet("ALL",replace) modify
local r=2
forvalues i=1995/2012 {
	forvalues j=1/4 {
		tokenize "`c(alpha)'"
		local column_no=1
		local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
		local col="``col_no''"
		local indexcol_no=floor((`column_no'-1)/26)
		local indexcol="``indexcol_no''"
		putexcel `indexcol'`col'1=("demente")
			count if DDD`i'`j'<.
		putexcel `indexcol'`col'`r'=matrix(r(N))
		local r=`r'+1
	}
}

local r=2
forvalues i=1995/2012 {
	forvalues j=1/4 {
		tokenize "`c(alpha)'"
		local column_no=2
		local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
		local col="``col_no''"
		local indexcol_no=floor((`column_no'-1)/26)
		local indexcol="``indexcol_no''"
		putexcel `indexcol'`col'1=("uden_medicin")
			count if DDD`i'`j'==0
		putexcel `indexcol'`col'`r'=matrix(r(N))
		local r=`r'+1
	}
}

local r=2
forvalues i=1995/2012 {
	forvalues j=1/4 {
		tokenize "`c(alpha)'"
		local column_no=3
		local col_no=cond(`column_no'>26,mod(`column_no',26),`column_no')
		local col="``col_no''"
		local indexcol_no=floor((`column_no'-1)/26)
		local indexcol="``indexcol_no''"
		putexcel `indexcol'`col'1=("med_medicin")
			count if DDD`i'`j'<. & DDD`i'`j'>0
		putexcel `indexcol'`col'`r'=matrix(r(N))
		local r=`r'+1
	}
}


label data "Final Wide"
save "D:\data\workdata\703702\Data\Sally\data\final_wide.dta", replace

log close data_presentation
