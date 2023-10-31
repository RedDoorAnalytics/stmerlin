local drive /Users/michael/My Drive/products/stmerlin
cd "`drive'"
adopath ++ "`drive'"
adopath ++ "`drive'/stmerlin"
clear all

set seed 72549

pr drop _all
clear
set obs 100000
gen id1 = _n
gen trt = runiform()>0.5
gen age = rnormal(55,5)

survsim stime died , dist(weib) lambda(0.1) gamma(1.2) cov(trt -0.5 age 0.01) maxt(5)

stset stime, f(died)

stmerlin trt age if _n<1000, dist(rp) df(3) tvc(age) dftvc(2) showinit

merlin (_t trt age age#rcs(_t, df(2) log orthog event) if _n<1000, family(rp, df(3) failure(_d)))


// stmerlin trt age age#rcs(_t, df(2) log orthog event), dist(rp) df(3) 

// stmerlin trt age, dist(rp) df(3)

// stmerlin trt rcs(age, df(3)), dist(rp) df(3)
