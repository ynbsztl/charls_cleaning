
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

