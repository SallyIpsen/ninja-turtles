capture log close tilpas_data
log using "D:\data\kode\FCDY3702\logs\tilpas_data.log", replace name(tilpas_data)

* Indlæser første demensdiagnose - data *
use  "D:\data\workdata\703702\Data\Sally\data\fstdemed02_2012.dta" , replace
* Dropper variable, der ikke skal bruges *
keep if diagaftersixty==1
drop diag* type* atc* icd*
display td(01jan2013) " "
drop if firstdato>=19359


* Putter køn-variabel på fra stamdata
preserve
use "D:\data\workdata\703702\Data\Sally\data\stamdata2012.dta", replace
keep pnr kqn stat statd
sort pnr
tempfile stam
save `stam'
restore
merge 1:1 pnr using `stam', keep(match master)
drop _merge*
drop if stat==20
drop if stat==30
drop if stat==70
replace inpsyk=0 if inpsyk==.
replace insom=0 if insom==.
display td(01jan1995) " "
drop if statd<=12784
unique pnr

display td(01jan2008) " "
gen diag_after=0
replace diag_after=1 if firstdato>=17532


* Indlæser drug-data *
preserve
use "D:\data\workdata\703702\Data\Sally\data\alldrugs_psykofarm.dta" , replace
* Dropper variable, der ikke skal bruges *
drop if atc3!="N05A"
drop if year(eksd)==2013
drop bald doso indo rinr r_typ
sort pnr eksd
tempfile drug
save `drug'
restore

* Merger de to datasæt sammen *
merge 1:m pnr using `drug', keep(match master)
drop _merge*

* Making binary variable according to previous druguse
sort pnr eksd
by pnr:gen j=_n

drop if j!=1

gen prev_druguse=0
replace prev_druguse=1 if eksd<firstdato

unique pnr
drop j
keep pnr fdato firstdato prev_druguse


* Putter køn-variabel på fra stamdata
preserve
use "D:\data\workdata\703702\Data\Sally\data\stamdata2012.dta", replace
keep pnr kqn stat statd 
sort pnr
tempfile sex_NY
save `sex_NY'
restore
merge m:1 pnr using `sex_NY', keep(match master)
drop _merge*
drop if stat==20
drop if stat==30
drop if stat==70
drop if statd<=12784
unique pnr

* Putter firstdato, inpsyk, insom og prescpt på fra fstdemens-data
preserve
use "D:\data\workdata\703702\Data\Sally\data\fstdemed02_2012.dta", replace
keep pnr firstdato inpsyk insom prescpt
sort pnr
tempfile info_NY
save `info_NY'
restore
merge m:1 pnr using `info_NY', keep(match master)
drop _merge*

display td(01jan2008) " "
gen diag_after=0
replace diag_after=1 if firstdato>=17532


* Generere alders-variabel
gen age_diag=int((firstdato-fdato)/365.25)
gen age_group=0
	replace age_group=1 if age_diag>59 & age_diag<70
	replace age_group=2 if age_diag>69 & age_diag<80
	replace age_group=3 if age_diag>79 & age_diag<90
	replace age_group=4 if age_diag>89 
	
summarize(age_diag)
	
* Laver tabeller til data presentation
tabulate kqn prev_druguse, cell
tabulate kqn diag_after, cell
tabulate kqn age_group, cell
tabulate kqn inpsyk, cell
tabulate kqn insom, cell
tabulate kqn prescpt, cell
count if insom==1 & prescpt==1
count if inpsyk==1 & prescpt==1
count if insom==1 & prescpt==1 & kqn=="K"
count if insom==1 & prescpt==1 & kqn=="M"
count if inpsyk==1 & prescpt==1 & kqn=="K"
count if inpsyk==1 & prescpt==1 & kqn=="M"

* Indlæser drug-data *
preserve
use "D:\data\workdata\703702\Data\Sally\data\alldrugs_psykofarm.dta" , replace
* Dropper variable, der ikke skal bruges *
drop if atc3!="N05A"
drop if year(eksd)==2013
drop bald doso indo rinr r_typ
sort pnr eksd
tempfile atcDataNew
save `atcDataNew'
restore

* Merger de to datasæt sammen *
merge 1:m pnr using `atcDataNew'
drop if _merge==2 

drop _merge*

unique pnr
sort pnr eksd

keep if firstdato<=eksd
label data "temp2"
save "D:\data\workdata\703702\Data\Sally\data\temp2.dta", replace

* Indlæser første demensdiagnose - data *
use  "D:\data\workdata\703702\Data\Sally\data\fstdemed02_2012.dta" , replace
* Dropper variable, der ikke skal bruges *
keep if diagaftersixty==1
drop diag* type* atc* icd*
display td(01jan2013) " "
drop if firstdato>=19359
* Putter køn-variabel på fra stamdata
preserve
use "D:\data\workdata\703702\Data\Sally\data\stamdata2012.dta", replace
keep pnr kqn stat statd
sort pnr
tempfile sex
save `sex'
restore
merge 1:1 pnr using `sex', keep(match master)
drop _merge*
drop if stat==20
drop if stat==30
drop if stat==70
replace inpsyk=0 if inpsyk==.
replace insom=0 if insom==.
display td(01jan1995) " "
drop if statd<=12784

merge 1:m pnr using "D:\data\workdata\703702\Data\Sally\data\temp2.dta", keep(match master)
drop _merge*
unique pnr


* Inddeler i år og kvartaler *
gen year = yofd(eksd)
gen quarter_help = ((qofd(eksd) /4 ) + 1960 ) - year
gen quarter = 0
replace quarter = 1 if quarter_help==0
replace quarter = 2 if quarter_help==0.25
replace quarter = 3 if quarter_help==0.5
replace quarter = 4 if quarter_help==0.75
replace quarter =. if quarter_help==.
drop quarter_help

* Tæller op over år og kvartaler *
gen DDD = volume * apk      
**fordi volume angiver DDD pr pakke
*by pnr year quarter , sort: egen total_DDD = sum(DDD)
collapse (sum) total_DDD=DDD, by(pnr fdato year quarter prev_druguse)
replace total_DDD =. if total_DDD==0

* Putter køn-variabel på fra stamdata
preserve
use "D:\data\workdata\703702\Data\Sally\data\stamdata2012.dta", replace
keep pnr kqn stat statd 
sort pnr
tempfile sex
save `sex'
restore
merge m:1 pnr using `sex', keep(match master)
drop _merge*
drop if stat==20
drop if stat==30
drop if stat==70
drop if statd<=12784
unique pnr


* Putter firstdato, inpsyk, insom og prescpt på fra fstdemens-data
preserve
use "D:\data\workdata\703702\Data\Sally\data\fstdemed02_2012.dta", replace
keep pnr firstdato inpsyk insom prescpt
sort pnr
tempfile info
save `info'
restore
merge m:1 pnr using `info', keep(match master)
drop _merge*

display td(01jan2008) " "
gen diag_after=0
replace diag_after=1 if firstdato>=17532

replace prev_druguse=0 if missing(prev_druguse)

label data "complete 201605"
save "D:\data\workdata\703702\Data\Sally\data\complete_2.dta", replace
erase "D:\data\workdata\703702\Data\Sally\data\temp2.dta"

log close tilpas_data
