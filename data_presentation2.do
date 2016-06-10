capture log close data_presentation2
log using "D:\data\kode\FCDY3702\logs\data_presentation2.log", replace name(data_presentation2)

use  "D:\data\workdata\703702\Data\Sally\data\complete_2.dta" , replace

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

* Middelværdier stratificeret på prev_druguse
preserve
keep if prev_druguse==0
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_UDEN.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_UDEN.xlsx", sheet("Means",replace) modify

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
keep if prev_druguse==1
keep if medicin==1
unique pnr

capture erase "D:\data\workdata\703702\Data\Sally\results\means_DDD_MED.xlsx"
putexcel set "D:\data\workdata\703702\Data\Sally\results\means_DDD_MED.xlsx", sheet("Means",replace) modify

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

label data "Final Long 2"
save "D:\data\workdata\703702\Data\Sally\data\final_long2.dta", replace


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




label data "Final Wide 2"
save "D:\data\workdata\703702\Data\Sally\data\final_wide2.dta", replace

log close data_presentation2
