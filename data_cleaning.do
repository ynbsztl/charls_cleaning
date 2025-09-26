/*==================================================
project:       CHARLS
Author:        ZHANG Tianlei
E-email:       zhangtianlei@whu.edu.cn
url:           https://ynbsztl.github.io/homepage/
Dependencies:  Wuhan University
----------------------------------------------------
Creation Date:   Sep 24th,2025
Modification Date:
Do-file version:    01
References:
Output:
==================================================*/

/*==================================================
              0: Program set up: Macro
==================================================*/
version 16 // 无论今后 Stata 更新到什么版本，我们当下用 Stata 16 写的命令都能被兼容
drop _all // 删掉数据库中所有变量和数据
clear matrix
clear mata
set maxvar 32767
set mem 10000m
set matsize 11000
set scheme s2color


global main "/Users/ynbsztl/Library/CloudStorage/OneDrive-Personal/charls_data"
local inputw1 "$main/Raw_data/charls_2011"
local inputw2 "$main/Raw_data/charls_2013"
local inputlh "$main/Raw_data/CHARLS_Life_History_Data"
local inputw3 "$main/Raw_data/charls_2015"
local inputw4 "$main/Raw_data/charls_2018"
local inputw5 "$main/Raw_data/charls_2020"
local lunar2solar "$main/Raw_data/lunar2solar"
local output "$main/output_dataset"
global dofiles "$main/Dofiles"

***define files locations
***respondent level file
global wave_1_demog			"`inputw1'/demographic_background"
global wave_1_mainr			"`inputw1'/mainr"
global wave_1_health		"`inputw1'/health_status_and_functioning"
global wave_1_healthcare	"`inputw1'/health_care_and_insurance"
global wave_1_indinc		"`inputw1'/individual_income"
global wave_1_work			"`inputw1'/work_retirement_and_pension"
global wave_1_weight		"`inputw1'/weight"
global wave_1_biomark		"`inputw1'/biomarkers"

***household level file
global wave_1_house			"`inputw1'/housing_characteristics"
global wave_1_faminfo		"`inputw1'/family_information"
global wave_1_famtran		"`inputw1'/family_transfer"
global wave_1_hhinc			"`inputw1'/household_income"
global wave_1_psu			  "`inputw1'/psu"
global wave_1_hhroster	"`inputw1'/household_roster"

**Wave 2 file
****respondent level file
global wave_2_demog			"`inputw2'/Demographic_Background"
global wave_2_health		"`inputw2'/Health_Status_and_Functioning"
global wave_2_healthcare	"`inputw2'/Health_Care_and_Insurance"
global wave_2_indinc		"`inputw2'/Individual_Income"
global wave_2_work			"`inputw2'/Work_Retirement_and_Pension"
global wave_2_weight 		"`inputw2'/Weights"
global wave_2_biomark		"`inputw2'/Biomarker"

**household level file
global wave_2_house			"`inputw2'/Housing_Characteristics"
global wave_2_faminfo		"`inputw2'/Family_Information"
global wave_2_famtran		"`inputw2'/Family_Transfer"
global wave_2_hhinc			"`inputw2'/Household_Income"
global wave_2_psu			  "`inputw2'/PSU"
global wave_2_child			"`inputw2'/Child"
global wave_2_parent    "`inputw2'/Parent"
global wave_2_exit			"`inputw2'/Exit_Interview"

**Life history file
global wave_lh_demog       "`inputlh'/Demographic_Backgrounds"
global wave_lh_educa       "`inputlh'/Education_History"
global wave_lh_faminfo     "`inputlh'/Family_Information"
global wave_lh_health      "`inputlh'/Health_History"
global wave_lh_residence   "`inputlh'/Residence"
global wave_lh_info        "`inputlh'/Sample_Infor"
global wave_lh_wealth      "`inputlh'/Wealth_History"
global wave_lh_work        "`inputlh'/Work_History"

**Wave 3 file
****respondent level file
global wave_3_demog			"`inputw3'/Demographic_Background"
global wave_3_health		"`inputw3'/Health_Status_and_Functioning"
global wave_3_healthcare	"`inputw3'/Health_Care_and_Insurance"
global wave_3_indinc		"`inputw3'/Individual_Income"
global wave_3_work			"`inputw3'/Work_Retirement_and_Pension"
global wave_3_weight		"`inputw3'/Weights"
global wave_3_biomark		"`inputw3'/Biomarker"

**household level file
global wave_3_house			"`inputw3'/Housing_Characteristics"
global wave_3_faminfo		"`inputw3'/Family_Information"
global wave_3_famtran		"`inputw3'/Family_Transfer"
global wave_3_hhinc			"`inputw3'/Household_Income"
global wave_3_child			"`inputw3'/Child"
global wave_3_hhmember	"`inputw3'/Household_Member"
global wave_3_parent		"`inputw3'/Parent"
global wave_3_sib		    "`inputw3'/Sibling"
global wave_3_s_sib	    "`inputw3'/Spousal_Sibling"
global wave_3_info			"`inputw3'/Sample_Infor"


**Wave 4 file
****respondent level file
global wave_4_demog			"`inputw4'/Demographic_Background"

global wave_4_health		"`inputw4'/Health_Status_and_Functioning"
global wave_4_healthcare	"`inputw4'/Health_Care_and_Insurance"

global wave_4_indinc		"`inputw4'/Individual_Income"
global wave_4_weight		"`inputw4'/Weights"
global wave_4_cognition "`inputw4'/Cognition"
global wave_4_insider   "`inputw4'/Insider"
global wave_4_work      "`inputw4'/Work_Retirement"
global wave_4_pension   "`inputw4'/Pension"

**household level file
global wave_4_house			"`inputw4'/Housing"
global wave_4_faminfo		"`inputw4'/Family_Information"
global wave_4_famtran		"`inputw4'/Family_Transfer"
global wave_4_hhinc			"`inputw4'/Household_Income"
global wave_4_info			"`inputw4'/Sample_Infor"


*这里都定义的是一些空的路径
**Wave 5 file
****respondent level file
global wave_5_demog			"`inputw5'/Demographic_Background"
global wave_5_covid			"`inputw5'/COVID_Module"
global wave_5_exit			"`inputw5'/Exit_Module"

global wave_5_health		"`inputw5'/Health_Status_and_Functioning"

global wave_5_indinc		"`inputw5'/Individual_Income"
global wave_5_work      "`inputw5'/Work_Retirement"
global wave_5_weight		"`inputw5'/Weights"

* Part of questionair not release: Jan 20th, 2025
/*

global wave_5_healthcare	"`inputw5'/Health_Care_and_Insurance"
global wave_5_cognition "`inputw5'/Cognition"

global wave_5_insider   "`inputw5'/Insider"
global wave_5_pension   "`inputw5'/Pension"
*/
**household level file
global wave_5_faminfo		"`inputw5'/Family_Information"
global wave_5_hhinc			"`inputw5'/Household_Income"
global wave_5_info			"`inputw5'/Sample_Infor"

* Part of questionair not release: Jan 20th, 2025
/*
global wave_5_house			"`inputw5'/Housing"
global wave_5_famtran		"`inputw5'/Family_Transfer"
*/

*solar to lunar date conversion Mata file
global lunar2solar "`lunar2solar'/lunar2solar.mmat"


**# Programs defined
do "$dofiles/programs.do"


/*==================================================
              1: Demographic Background
==================================================*/
*********************************************************************
**# *----------1.1: Wave 2011
*********************************************************************


use $wave_1_demog, clear
tempfile wave_1_demog

g first = . 

**# Cleaning variables
replace householdID = householdID + "0"
replace ID = householdID + substr(ID,-2,2)


**************************************
***Birth date: Year, Month, and Day***
**************************************

***merge with weight file
local demo_w1_weight iyear 
merge 1:1 ID using "$wave_1_weight", keepusing(`demo_w1_weight') nolabel
drop if _merge ==2
drop _merge

***Birth date
*set wave number
local wv=1

***In wave 1
gen inw1=1
label variable inw1 "inw1:In wave 1" 
label values inw1 yesno

***in Wave 1 (update)
replace inw1 = 0 if inw1 ==.
tab inw1

***Interview year
destring(iyear), gen(r`wv'iwy) 
replace r`wv'iwy=. if inw`wv'==0
label variable r`wv'iwy  "r`wv'iwy:w`wv' r year of interview"

gen byear_l = ba002_1 if inrange(ba002_1,1900,2012) & ba003 == 2

gen bmonth_l = ba002_2 if inrange(ba002_2,1,12) & ba003 == 2

gen bday_l = ba002_3 if inrange(ba002_3,1,31) & ba003 == 2

gen bdate_l = mdy(bmonth_l,bday_l,byear_l)
gen bdate_l2 = string(bdate_l,"%tdCYND")

lunar2solar bdate_l2, matfile($lunar2solar) gen(bdate_s)

gen bdate_s2 = date(bdate_s,"YMD")
gen byear_s = year(bdate_s2)
gen bmonth_s = month(bdate_s2)
gen bday_s = day(bdate_s2)

***Birth year
gen r`wv'byear =.
missing_c_w1 ba002_1 ba002_2 ba002_3 ba003, result(r`wv'byear) wave(`wv')
replace r`wv'byear = .i if byear_s > r`wv'iwy-1 & inrange(byear_s,1900,2012) & ba003 == 2
replace r`wv'byear = .i if ba002_1 > r`wv'iwy-1 & inrange(ba002_1,1900,2012) & ba003 == 1
replace r`wv'byear = .x if ((ba002_2 == 0 | inlist(ba002_2,.d,.r)) | (ba002_3 == 0 | inlist(ba002_3,.d,.r)) | !mi(bdate_l2)) & ba003 == 2 & mi(bdate_s)
replace r`wv'byear = byear_s if inrange(byear_s,1900,r`wv'iwy-1) & ba003 == 2
replace r`wv'byear = ba002_1 if inrange(ba002_1,1900,r`wv'iwy-1) & ba003 == 1

***Birth month
gen r`wv'bmonth =.
missing_c_w1 ba002_2 ba002_3 ba003, result(r`wv'bmonth) wave(`wv')
replace r`wv'bmonth = .x if ((ba002_2 == 0 | inlist(ba002_2,.d,.r)) | (ba002_3 == 0 | inlist(ba002_3,.d,.r)) | !mi(bdate_l2)) & ba003 == 2 & mi(bdate_s)
replace r`wv'bmonth = .d if ba002_2 == 0 & ba003 == 1
replace r`wv'bmonth = bmonth_s if inrange(bmonth_s,1,12) & ba003 == 2
replace r`wv'bmonth = ba002_2 if inrange(ba002_2,1,12) & ba003 == 1

***Birth day
gen r`wv'bday =.
missing_c_w1 ba002_2 ba002_3 ba003, result(r`wv'bday) wave(`wv')
replace r`wv'bday = .x if ((ba002_2 == 0 | inlist(ba002_2,.d,.r)) | (ba002_3 == 0 | inlist(ba002_3,.d,.r)) | !mi(bdate_l2)) & ba003 == 2 & mi(bdate_s)
replace r`wv'bday = .d if ba002_3 == 0 & ba003 == 1
replace r`wv'bday = bday_s if inrange(bday_s,1,31) & ba003 == 2
replace r`wv'bday = ba002_3 if inrange(ba002_3,1,31) & ba003 == 1

drop byear_l bmonth_l bday_l bdate_l bdate_l2 bdate_s bdate_s2 byear_s bmonth_s bday_s

***Birth date, lunar or solar
gen r`wv'bdatels =.
missing_c_w1 ba003, result(r`wv'bdatels) wave(`wv')
replace r`wv'bdatels = 1 if ba003 == 1
replace r`wv'bdatels = 2 if ba003 == 2
label values r`wv'bdatels lsdate

rename r1byear birth_year
rename r1bmonth birth_month
rename r1bday birth_day

drop r1iwy inw1 r1bdatels iyear

*******************
**# Clone variables
*******************
clonevar IDind = ID
clonevar chinese_zodiac = ba001

clonevar calender_type = ba003
clonevar age = ba004
clonevar birth_place = bb001

**# Generate variables
g year = 2011

g last = .
keep first-last
drop first last

save `wave_1_demog'


*********************************************************************
**# *----------1.2: Wave 2013
*********************************************************************
use $wave_2_demog, clear
tempfile wave_2_demog
g first = . 



**************************************
***Birth date: Year, Month, and Day***
**************************************
***Birth date
gen byear_l = ba002_1 if inrange(ba002_1,1900,2014) & ba003 == 2
replace byear_l = 1934 if ID == "094004103001" // *change one birth year after checking father bdaydro

gen bmonth_l = ba002_2 if inrange(ba002_2,1,12) & ba003 == 2

gen bday_l = ba002_3 if inrange(ba002_3,1,31) & ba003 == 2

gen bdate_l = mdy(bmonth_l,bday_l,byear_l)
gen bdate_l2 = string(bdate_l,"%tdCYND")

lunar2solar bdate_l2, matfile($lunar2solar) gen(bdate_s)

gen bdate_s2 = date(bdate_s,"YMD")
gen byear_s = year(bdate_s2)
gen bmonth_s = month(bdate_s2)
gen bday_s = day(bdate_s2)

***Respondent Birth Year
gen r`wv'byear =.
missing_c_w2 ba002_1 ba002_2 ba002_3 ba003, result(r`wv'byear) wave(`wv')
replace r`wv'byear = .i if byear_s > r`wv'iwy-1 & inrange(byear_s,1900,2014) & ba003 == 2
replace r`wv'byear = .i if ba002_1 > r`wv'iwy-1 & inrange(ba002_1,1900,2014) & ba003 == 1
replace r`wv'byear = .x if ((ba002_2 == 0 | inlist(ba002_2,.d,.r)) | (ba002_3 == 0 | inlist(ba002_3,.d,.r)) | !mi(bdate_l2)) & ba003 == 2 & mi(bdate_s)
replace r`wv'byear = byear_s if inrange(byear_s,1900,r`wv'iwy-1) & ba003 == 2
replace r`wv'byear = ba002_1 if inrange(ba002_1,1900,r`wv'iwy-1) & ba003 == 1

***Respondent Birth Month
gen r`wv'bmonth =.
missing_c_w2 ba002_2 ba002_3 ba003, result(r`wv'bmonth) wave(`wv')
replace r`wv'bmonth = .x if ((ba002_2 == 0 | inlist(ba002_2,.d,.r)) | (ba002_3 == 0 | inlist(ba002_3,.d,.r)) | !mi(bdate_l2)) & ba003 == 2 & mi(bdate_s)
replace r`wv'bmonth = .d if ba002_2 == 0 & ba003 == 1
replace r`wv'bmonth = bmonth_s if inrange(bmonth_s,1,12) & ba003 == 2
replace r`wv'bmonth = ba002_2 if inrange(ba002_2,1,12) & ba003 == 1

***Respondent Birth Day 
gen r`wv'bday =.
missing_c_w2 ba002_2 ba002_3 ba003, result(r`wv'bday) wave(`wv')
replace r`wv'bday = .x if ((ba002_2 == 0 | inlist(ba002_2,.d,.r)) | (ba002_3 == 0 | inlist(ba002_3,.d,.r)) | !mi(bdate_l2)) & ba003 == 2 & mi(bdate_s)
replace r`wv'bday = .d if ba002_3 == 0 & ba003 == 1
replace r`wv'bday = bday_s if inrange(bday_s,1,31) & ba003 == 2
replace r`wv'bday = ba002_3 if inrange(ba002_3,1,31) & ba003 == 1

drop byear_l bmonth_l bday_l bdate_l bdate_l2 bdate_s bdate_s2 byear_s bmonth_s bday_s

***Respondent Birth Date Flag
gen r`wv'fbdate = 1 if ba001_w2_1 == 2

***Birth date, lunar or solar
gen r`wv'bdatels =.
missing_c_w2 ba003, result(r`wv'bdatels) wave(`wv')
replace r`wv'bdatels = 1 if ba003 == 1
replace r`wv'bdatels = 2 if ba003 == 2
label values r`wv'bdatels lsdate




*******************
**# Clone variables
*******************
clonevar IDind = ID
clonevar chinese_zodiac = ba001 
clonevar birth_year = ba002_1
clonevar birth_month = ba002_2
clonevar birth_day = ba002_3
clonevar calender_type = ba003
clonevar age = ba004
clonevar birth_place = bb001

g year = 2013


g last = .
keep first-last
drop first last
save `wave_2_demog'

exit


**# *----------1.3: Wave 2015

use $wave_3_demog, clear
tempfile wave_3_demog
g first = . 

clonevar IDind = ID
clonevar birth_year = ba002_1
clonevar birth_month = ba002_2
clonevar birth_day = ba002_3
clonevar calender_type = ba003
clonevar birth_place = bb001

g year = 2015


g last = .
keep first-last
drop first last
save `wave_3_demog'


**# *----------1.4: Wave 2018

use $wave_4_demog, clear
tempfile wave_4_demog
g first = . 

clonevar IDind = ID
clonevar chinese_zodiac = ba001 
clonevar birth_year = ba002_1
clonevar birth_month = ba002_2
clonevar birth_day = ba002_3
clonevar calender_type = ba003
clonevar birth_place = bb001

g year = 2018


g last = .
keep first-last
drop first last
save `wave_4_demog'

**# *----------1.5: Wave 2020

use $wave_5_demog, clear
tempfile wave_5_demog
g first = . 

clonevar IDind = ID
clonevar chinese_zodiac = ba001 
clonevar birth_year = zrbirthyear
clonevar birth_month = ba003_2
clonevar birth_day = ba003_3



g year = 2020


g last = .
keep first-last
drop first last
save `wave_5_demog'


**# *----------1.7: Merge all 
use `wave_1_demog',clear
append using `wave_2_demog'
append using `wave_3_demog'
append using `wave_4_demog'
append using `wave_5_demog'






**# *----------2.0: Cleaning Demographic Background
**# *----------2.1: Luner to Solar birth date






exit 


*** CHARLS cleaning - github
cd "/Users/ynbsztl/Library/CloudStorage/OneDrive-Personal/charls_data/Dofiles"
git add .
git status
git commit -m 'version_1.4_wave1_birthdate'
git push











































