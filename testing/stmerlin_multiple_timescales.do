clear
set seed 249857
set obs 10000
gen trt = runiform()>0.5
gen age = rnormal(50,5)
gen agec = age - 50
gen year = 1990 + floor(20*runiform())
gen yearc = year - 2000

survsim stime died,     maxtime(5) cov(trt -0.5) 		///
                        hazard(	0.1:*1.2:*{t}:^0.2 :*	        ///
                        exp(0.1 :* (agec :+ {t}) 		///
                                :- 0.1 :* (yearc :+ {t}))	///
                        )
stset stime, f(died)
				
timer clear
timer on 1
stmerlin trt, 	dist(cox)					///
                time2(df(2) offset(agec) time noorthog)		///
                time3(df(2) offset(yearc) time noorthog)
timer off 1

timer on 2
stmerlin trt, 	dist(rp) df(3)	noorthog			///
                time2(df(2) offset(agec) time noorthog)		///
                time3(df(2) offset(yearc) time noorthog)
timer off 2

timer on 3
stmerlin trt, 	dist(rcs) df(3) noorthog 			///
                time2(df(2) offset(agec) time  noorthog)	///
                time3(df(2) offset(yearc) time noorthog) 
timer off 3

timer on 4
stmt trt, 	time1(df(3)) noorthog				///
                time2(df(2) start(agec) logtoff) 		///
                time3(df(2) start(yearc) logtoff) 		///
                nohr 
timer off 4
timer list
