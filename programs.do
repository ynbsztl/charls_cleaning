
*lunar to solar date conversion (need to have "lunar2solar.mmat" file)
*! Version 1.0, Nov 07 2014, by Yafeng Wang, econyfwang@gmail.com
*! Chinese lunar to solar date transformation
capture program drop lunar2solar
program define lunar2solar
    version 10
    syntax varname(string) [if] [in], matfile(string) [leap GENerate(string)]
    marksample touse, strok
    if "`generate'" != "" {
        local newvar `generate'
    }
    else {
        local newvar `varlist'_solar
    }
    tempvar index mindex
    tempfile ls0 ls1
    qui {
    gen `index' = _n
    // leap == 0 sample
    preserve
    drop _all
    set obs 49949
    gen str8 `varlist' = ""
    gen str8 `newvar' = ""
    mata: lunar2solar("`matfile'", "`varlist'", "`newvar'", "")
    save "`ls0'"
    restore
    merge m:1 `varlist' using "`ls0'", gen(`mindex')
    drop if `mindex' == 2
    drop `mindex'
    replace `newvar' = "" if `touse' == 0
    // leap == 1 sample
    if ("`leap'" != "") {
        preserve
        drop _all
        set obs 1521
        gen str8 `varlist' = ""
        gen str8 `newvar' = ""
        mata: lunar2solar("`matfile'", "`varlist'", "`newvar'", "`leap'")
        save "`ls1'"
        restore
        merge m:1 `varlist' using "`ls1'", update replace gen(`mindex')
        drop if `mindex' == 2
        drop `mindex'
        replace `newvar' = "" if `touse' == 0
        }
    sort `index'
    }
end

mata: mata set matastrict on
mata: mata clear
mata: 
void function lunar2solar(string scalar matfile, string scalar lunarv, string scalar solarv, string scalar leap)
{
    string matrix ls, lsl, S, NS
    real scalar fh

    fh = fopen(matfile,"r")
    ls = fgetmatrix(fh)
    lsl = fgetmatrix(fh)
    fclose(fh)
    if (leap == "") {
        S = ls[.,2]
        NS = ls[.,1]
    }
    else {
        S = lsl[.,2]
        NS = lsl[.,1]
    }
    st_sstore(.,lunarv,S)
    st_sstore(.,solarv,NS)
}
end

*choose the harmonized variable with the highest value
capture program drop max_h_value
program define max_h_value
syntax varlist, result(varname)
	missing_H `varlist', result(`result')
	tempvar rowmaxvar
	egen `rowmaxvar' = rowmax(`varlist')
	replace `result' = `rowmaxvar' if !mi(`rowmaxvar')
end
capture program drop h_wy_level 
program define h_wy_level, rclass
syntax varname [, HRS ELSA SHARE JSTAR CHARLS LASI KLOSA MHAS TILDA CRELES wy(string) asset income ]
    local l = substr("`varlist'",1,1)
    local ll = substr("`varlist'",1,2)
    local lll = substr("`varlist'",1,3)
    if "`ll'" == "hh" {
        local l = substr("`varlist'",1,2)
    }
    if "`lll'" == "inw" {
        local l = substr("`varlist'",1,3)
    }
    if "`l'" == "inw" {
        local t = substr("`varlist'",4,1)
        if "`t'"=="0"|"`t'"=="1"|"`t'"=="2"|"`t'"=="3"|"`t'"=="4"|"`t'"=="5"|"`t'"=="6"|"`t'"=="7"|"`t'"=="8"|"`t'"=="9" {
            local time wave
            local w = substr("`varlist'",4,1)
        	local tt = substr("`varlist'",5,1)
        	if "`tt'"=="0"|"`tt'"=="1"|"`tt'"=="2"|"`tt'"=="3"|"`tt'"=="4"|"`tt'"=="5"|"`tt'"=="6"|"`tt'"=="7"|"`tt'"=="8"|"`tt'"=="9" {
        	    local w = substr("`varlist'",4,2)
        	    local ttt = substr("`varlist'",6,1)
        	    if "`ttt'"=="0"|"`ttt'"=="1"|"`ttt'"=="2"|"`ttt'"=="3"|"`ttt'"=="4"|"`ttt'"=="5"|"`ttt'"=="6"|"`ttt'"=="7"|"`ttt'"=="8"|"`ttt'"=="9" {
        	        local w
        	        local y = substr("`varlist'",4,4)
        	        local time year
        	    }
        	}
    	}
    }
    else if "`l'" == "hh" {
        local t = substr("`varlist'",3,1)
        if "`t'"=="0"|"`t'"=="1"|"`t'"=="2"|"`t'"=="3"|"`t'"=="4"|"`t'"=="5"|"`t'"=="6"|"`t'"=="7"|"`t'"=="8"|"`t'"=="9" {
            local time wave
            local w = substr("`varlist'",3,1)
        	local tt = substr("`varlist'",4,1)
        	if "`tt'"=="0"|"`tt'"=="1"|"`tt'"=="2"|"`tt'"=="3"|"`tt'"=="4"|"`tt'"=="5"|"`tt'"=="6"|"`tt'"=="7"|"`tt'"=="8"|"`tt'"=="9" {
        	    local w = substr("`varlist'",3,2)
        	    local ttt = substr("`varlist'",5,1)
        	    if "`ttt'"=="0"|"`ttt'"=="1"|"`ttt'"=="2"|"`ttt'"=="3"|"`ttt'"=="4"|"`ttt'"=="5"|"`ttt'"=="6"|"`ttt'"=="7"|"`ttt'"=="8"|"`ttt'"=="9" {
        	        local w
        	        local y = substr("`varlist'",3,4)
        	        local time year
        	    }
        	}
    	}
    }
    else {
        local t = substr("`varlist'",2,1)
        if "`t'"=="0"|"`t'"=="1"|"`t'"=="2"|"`t'"=="3"|"`t'"=="4"|"`t'"=="5"|"`t'"=="6"|"`t'"=="7"|"`t'"=="8"|"`t'"=="9" {
            local time wave
            local w = substr("`varlist'",2,1)
        	local tt = substr("`varlist'",3,1)
        	if "`tt'"=="0"|"`tt'"=="1"|"`tt'"=="2"|"`tt'"=="3"|"`tt'"=="4"|"`tt'"=="5"|"`tt'"=="6"|"`tt'"=="7"|"`tt'"=="8"|"`tt'"=="9" {
        	    local w = substr("`varlist'",2,2)
        	    local ttt = substr("`varlist'",4,1)
        	    if "`ttt'"=="0"|"`ttt'"=="1"|"`ttt'"=="2"|"`ttt'"=="3"|"`ttt'"=="4"|"`ttt'"=="5"|"`ttt'"=="6"|"`ttt'"=="7"|"`ttt'"=="8"|"`ttt'"=="9" {
        	        local w
        	        local y = substr("`varlist'",2,4)
        	        local time year
        	    }
        	}
    	}
    }       
    
	return local level "`l'"
	
	if "`w'" == "" & "`y'" == "" {
	    if "`wy'"=="0"|"`wy'"=="1"|"`wy'"=="2"|"`wy'"=="3"|"`wy'"=="4"|"`wy'"=="5"|"`wy'"=="6"|"`wy'"=="7"|"`wy'"=="8"|"`wy'"=="9" | ///
	        "`wy'"=="10"|"`wy'"=="11"|"`wy'"=="12"|"`wy'"=="13"|"`wy'"=="14"|"`wy'"=="15"|"`wy'"=="16"|"`wy'"=="17"|"`wy'"=="18"|"`wy'"=="19" {
		    local w `wy'
		}
		else {
		    local y `wy'
		}
		local time panel
	}
	local studies `hrs' `elsa' `share' `jstar' `charls' `lasi' `klosa' `mhas' `tilda'
	local n_studies : word count `studies'
	if "`w'"=="0"|"`w'"=="1"|"`w'"=="2"|"`w'"=="3"|"`w'"=="4"|"`w'"=="5"|"`w'"=="6"|"`w'"=="7"|"`w'"=="8"|"`w'"=="9" | ///
	        "`w'"=="10"|"`w'"=="11"|"`w'"=="12"|"`w'"=="13"|"`w'"=="14"|"`w'"=="15"|"`w'"=="16"|"`w'"=="17"|"`w'"=="18"|"`w'"=="19" {
		if `n_studies' > 1 {
			di "can only specify one study"
			exit 198
		}
		else if "`hrs'" == "hrs" {
			local y = 1992 + ((`w'-1)*2)
		}
		else if "`elsa'" == "elsa" {
			local y = 2002 + ((`w'-1)*2)
		}
		else if "`share'" == "share" {
			local y = 2004 + ((`w'-1)*2)
		}
		else if "`jstar'" == "jstar" {
			local y = 2006 + ((`w'-1)*2)
		}
		else if "`charls'" == "charls" {
			local y = 2010 + ((`w'-1)*2)
		}
		else if "`lasi'" == "lasi" {
			local y = 2012 + ((`w'-1)*2)
		}
		else if "`klosa'" == "klosa" {
			local y = 2006 + ((`w'-1)*2)
		}
		else if "`mhas'" == "mhas" {
		    if `w' == 1 | `w' == 2 {
			    local y = 2000 + ((`w'-1)*2)
			}
			else {
			    local y = 2012 + ((`w'-1)*2)
			}
		}
		else if "`tilda'" == "tilda" {
			local y = 2010 + ((`w'-1)*2)
		}
		else if "`creles'" == "creles" {
		    if `w' == 1 | `w' == 2 | `w' == 3 {
			    local y = 2004 + ((`w'-1)*2)
			}
			else {
			    local y = 2010 + ((`w'-1)*2)
			}
		}
		return local wy `w'
	}
	else if "`y'" != "" {
		if `n_studies' > 1 {
			di "can only specify one study"
			exit 198
		}
		else if "`hrs'" == "hrs" {
			local w = ((`y'-1992)/2)+1
		}
		else if "`elsa'" == "elsa" {
			local w = ((`y'-2002)/2)+1
		}
		else if "`share'" == "share" {
			local w = ((`y'-2004)/2)+1
		}
		else if "`jstar'" == "jstar" {
			local w = ((`y'-2006)/2)+1
		}
		else if "`charls'" == "charls" {
			local w = ((`y'-2010)/2)+1
		}
		else if "`lasi'" == "lasi" {
			local w = ((`y'-2012)/2)+1
		}
		else if "`klosa'" == "klosa" {
			local w = ((`y'-2006)/2)+1
		}
		else if "`mhas'" == "mhas" {
		    if `y' == 2000 | `y' == 2002 {
			    local w = ((`y'-2000)/2)+1
			}
			else {
			    local w = ((`y'-2012)/2)+1
			}
		}
		else if "`tilda'" == "tilda" {
			local w = ((`y'-2010)/2)+1
		}
		else if "`creles'" == "creles" {
		    if `y' == 2004 | `y' == 2006 | `y' == 2008 {
			    local w = ((`y'-2004)/2)+1
			}
			else {
			    local w = ((`y'-2010)/2)+1
			}
		}
		return local wy `y'
	}
	
	if "`asset'" == "asset" {
	    if "`hrs'" == "hrs" {
			local fin_time this_year 
		}
		else if "`elsa'" == "elsa" {
			local fin_time this_year 
		}
		else if "`share'" == "share" {
			local fin_time this_year 
		}
		else if "`jstar'" == "jstar" {
			local fin_time this_year 
		}
		else if "`charls'" == "charls" {
			local fin_time this_year
		}
		else if "`lasi'" == "lasi" {
			local fin_time this_year 
		}
		else if "`klosa'" == "klosa" {
			local fin_time this_year 
		}
		else if "`mhas'" == "mhas" {
			local fin_time this_year 
		}
		else if "`tilda'" == "tilda" {
			local fin_time this_year 
		}
		else if "`creles'" == "creles" {
			local fin_time this_year 
		}
	}
	else if "`income'" == "income" {
	    if "`hrs'" == "hrs" {
	        if `w' == 1 {
	            local fin_time sp_year
	            local fin_sp_year = 1991
	        }
	        else if `w' == 2 {
	            local fin_time mixed
	            local fin_sp_year = 1993
	        }
	        else {
	            local fin_time last_year
			}
		}
		else if "`elsa'" == "elsa" {
			local fin_time this_year 
		}
		else if "`share'" == "share" {
			local fin_time last_year
		}
		else if "`jstar'" == "jstar" {
			local fin_time last_year
		}
		else if "`charls'" == "charls" {
			local fin_time last_year
		}
		else if "`lasi'" == "lasi" {
			local fin_time this_year
		}
		else if "`klosa'" == "klosa" {
			local fin_time last_year
		}
		else if "`mhas'" == "mhas" {
			local fin_time unknown
		}
		else if "`tilda'" == "tilda" {
			local fin_time unknown
		}
		else if "`creles'" == "creles" {
			local fin_time unknown
		}
	}
	
	return local wave `w'
	return local year `y'
	return local time `time'
	return local fin_time `fin_time'
	return local fin_sp_year `fin_sp_year'
end

*create special missing codes
***missing_c_w1
***this is a program that creates speical missing codes for CHARLS Wave 1 variables
***
*** the program is called as follows
***		missing_c varlist [if] [in], result(result)
***			where:
***				varlist - list of variables which should influnce missing codes
***				result 	- name of variable, must be generated before program
***				[if] and [in] allow limitation of the program to a subsample using an if or in statement, both are optional
capture program drop missing_c_w1
program define missing_c_w1
syntax varlist [if] [in], result(varname) [wave(string)]

    
    marksample touse, novarlist // process if and in statements
    if "`wave'" == "" {
        h_wy_level `result'
        local w `r(wave)'
        local time `r(time)'
    }
    else {
        local w `wave'
    }
       
        
    
    quietly {
    	if "`time'" == "wave" | "`wave'" != "" {
            foreach v of varlist `varlist' {
        		replace `result' = .m if inlist(`v',.,.e) & !inlist(`result',.d,.r) & inw`w' == 1 & (`touse') // this is the lowest category
        	}
        }
    	foreach v of varlist `varlist' {
    		replace `result' = .d if `v' == .d & `result'!= .r & (`touse')
    	}
    	foreach v of varlist `varlist' {
    		replace `result' = .r if `v' == .r & (`touse')
    	}
    }
end
***missing_c_w2
***this is a program that creates speical missing codes for CHARLS Wave 1 variables
***
*** the program is called as follows
***		missing_c varlist [if] [in], result(result)
***			where:
***				varlist - list of variables which should influnce missing codes
***				result 	- name of variable, must be generated before program
***				[if] and [in] allow limitation of the program to a subsample using an if or in statement, both are optional
capture program drop missing_c_w2
program define missing_c_w2
syntax varlist [if] [in], result(varname) [wave(string)]

    
    marksample touse, novarlist // process if and in statements
    if "`wave'" == "" {
        h_wy_level `result'
        local w `r(wave)'
        local time `r(time)'
    }
    else {
        local w `wave'
    }
       
        
    
    quietly {
    	if "`time'" == "wave" | "`wave'" != "" {
            foreach v of varlist `varlist' {
        		replace `result' = .m if inlist(`v',.,.e) & !inlist(`result',.d,.r) & inw`w' == 1 & (`touse') // this is the lowest category
        	}
        }
    	foreach v of varlist `varlist' {
    		replace `result' = .d if `v' == .d & `result'!=.r & (`touse')
    	}
    	foreach v of varlist `varlist' {
    		replace `result' = .r if `v' == .r & (`touse')
    	}
    }
end
