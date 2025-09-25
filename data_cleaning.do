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



/*==================================================
              1: regular data selection
==================================================*/
**# *----------1.1: Wave 2011

use $wave_1_demog, clear
tempfile wave_1_demog

g first = . 

**# Cleaning variables
replace householdID = householdID + "0"
replace ID = householdID + substr(ID,-2,2)




**# Clone variables

clonevar IDind = ID
clonevar chinese_zodiac = ba001 
clonevar birth_year = ba002_1
clonevar birth_month = ba002_2
clonevar birth_day = ba002_3
clonevar calender_type = ba003
clonevar age = ba004
clonevar birth_place = bb001







**# Generate variables
g year = 2011



g last = .
keep first-last
drop first last

save `wave_1_demog'







**# *----------1.2: Wave 2011

use $wave_2_demog, clear
tempfile wave_2_demog
g first = . 

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







**# *----------1.7: Merge all 
use `wave_1_demog',clear
append using `wave_2_demog'



duplicates report IDind

exit 


*** CHARLS cleaning - github
cd "/Users/ynbsztl/Library/CloudStorage/OneDrive-Personal/charls_data/Dofiles"
git add .
git status
git commit -m 'version_1.2_IDind'
git push











































