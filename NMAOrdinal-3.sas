/**********************************************************************************/
/*** Scenario III: Remission is from both responses with 50-50				   ****/
/**********************************************************************************/
data Crohn;
input Product $ 1-15 TrialID k Trt Response Count collapsity Age CDAI year male antiTNF;
datalines;
Adalimumab      11  1   0   1   47  0   37      296     2006    37 100
Adalimumab      11  1   0   2   4   0   37      296     2006    37 100
Adalimumab      11  1   0   3   14   0   37      296     2006    37 100
Adalimumab      11  1   0   4   9   0   37      296     2006    37 100
Adalimumab      11  1   1   1   31  0   39      295     2006    36 100
Adalimumab      11  1   1   2   4   0   39      295     2006    36 100
Adalimumab      11  1   1   3   13  0   39      295     2006    36 100
Adalimumab      11  1   1   4   28  0   39      295     2006    36 100
Adalimumab      12  2   0   1   110 0   37      313     2007    65  0
Adalimumab      12  2   0   2   9  0   37      313     2007    65  0
Adalimumab      12  2   0   3   35  0   37      313     2007    65  0
Adalimumab      12  2   0   4   12  0   37      313     2007    65  0
Adalimumab      12  2   1   1   77  0   39      313     2007    50  0
Adalimumab      12  2   1   2   11  0   39      313     2007    50  0
Adalimumab      12  2   1   3   37  0   39      313     2007    50  0
Adalimumab      12  2   1   4   34  0   39      313     2007    50  0
Certolizumab    21  3   0   1   200 0   38      297     2007    131 74.1
Certolizumab    21  3   0   2   17  0   38      297     2007    131 74.1
Certolizumab    21  3   0   3   49  0   38      297     2007    131 74.1
Certolizumab    21  3   0   4   62  0   38      297     2007    131 74.1
Certolizumab    21  3   2   1   189 0   37      300     2007    157 69.8
Certolizumab    21  3   2   2   13  0   37      300     2007    157 69.8
Certolizumab    21  3   2   3   50  0   37      300     2007    157 69.8
Certolizumab    21  3   2   4   79  0   37      300     2007    157 69.8
Infliximab      31  4   0   1   20  1   38.5    288     1997    15  100
Infliximab      31  4   0   2   0   1   38.5    288     1997    15  100
Infliximab      31  4   0   3   3   1   38.5    288     1997    15  100
Infliximab      31  4   0   4   1   1   38.5    288     1997    15  100
Infliximab      31  4   3   1   5   1   37      312     1997    14  100
Infliximab      31  4   3   2   0   1   37      312     1997    14  100
Infliximab      31  4   3   3   13   1   37      312     1997    14  100
Infliximab      31  4   3   4   9  1   37      312     1997    14  100
Natalizumab     42  6   0   1   90  1   39      303     2005    73  61.9
Natalizumab     42  6   0   2   0   1   39      303     2005    73  61.9
Natalizumab     42  6   0   3   40  1   39      303     2005    73  61.9
Natalizumab     42  6   0   4   51  1   39      303     2005    73  61.9
Natalizumab     42  6   5   1   311 1   38      302     2005    311 59.8
Natalizumab     42  6   5   2   0   1   38      302     2005    311 59.8
Natalizumab     42  6   5   3   167 1   38      302     2005    311 59.8
Natalizumab     42  6   5   4   246 1   38      302     2005    311 59.8
Natalizumab     43  7   0   1   150 0   37.7    299.5   2007    102 55.2
Natalizumab     43  7   0   2   9  0   37.7    299.5   2007    102 55.2
Natalizumab     43  7   0   3   38  0   37.7    299.5   2007    102 55.2
Natalizumab     43  7   0   4   53  0   37.7    299.5   2007    102 55.2
Natalizumab     43  7   5   1   114 0   38.1    303.9   2007    105 49.8
Natalizumab     43  7   5   2   11  0   38.1    303.9   2007    105 49.8
Natalizumab     43  7   5   3   51  0   38.1    303.9   2007    105 49.8
Natalizumab     43  7   5   4   83  0   38.1    303.9   2007    105 49.8
Ustekinumab     53  10  0   1   99  2   39.5    312.4   2012    64  0
Ustekinumab     53  10  0   2   0  	2   39.5    312.4   2012    64  0
Ustekinumab     53  10  0   3   0   2   39.5    312.4   2012    64  0
Ustekinumab     53  10  0   4   33  2   39.5    312.4   2012    64  0
Ustekinumab     53  10  8   1   58  2   39.4    338     2012    48  0
Ustekinumab     53  10  8   2   0  	2   39.4    338     2012    48  0
Ustekinumab     53  10  8   3   0  	2   39.4    338     2012    48  0
Ustekinumab     53  10  8   4   73	2   39.4    338     2012    48  0
Ustekinumab     54  11  0   1   175 1   36      313     2015    118  0.4
Ustekinumab     54  11  0   2   0  	1   36      313     2015    118  0.4
Ustekinumab     54  11  0   3   54  1   36      313     2015    118  0.4
Ustekinumab     54  11  0   4   18  1   36      313     2015    118  0.4
Ustekinumab     54  11  8   1   130 1   36      319     2015    101  1.2
Ustekinumab     54  11  8   2   0  	1   36      319     2015    101  1.2
Ustekinumab     54  11  8   3   67  1   36      319     2015    101  1.2
Ustekinumab     54  11  8   4   52  1   36      319     2015    101  1.2
Vedolizumab     62  13  0   1   0   -1  38.6    325     2013    69  51.4
Vedolizumab     62  13  0   2   105 -1  38.6    325     2013    69  51.4
Vedolizumab     62  13  0   3   33  -1  38.6    325     2013    69  51.4
Vedolizumab     62  13  0   4   10  -1  38.6    325     2013    69  51.4
Vedolizumab     62  13  10  1   0   -1  36.3    327     2013    105 49.5
Vedolizumab     62  13  10  2   135 -1  36.3    327     2013    105 49.5
Vedolizumab     62  13  10  3   53  -1  36.3    327     2013    105 49.5
Vedolizumab     62  13  10  4   32  -1  36.3    327     2013    105 49.5
Vedolizumab     63  14  0   1   0   -1  34.8    301.3   2014    89  76
Vedolizumab     63  14  0   2   144 -1  34.8    301.3   2014    89  76
Vedolizumab     63  14  0   3   36  -1  34.8    301.3   2014    89  76
Vedolizumab     63  14  0   4   27  -1  34.8    301.3   2014    89  76
Vedolizumab     63  14  10  1   0   -1  36.9    313.9   2014    91  76
Vedolizumab     63  14  10  2   79 -1  36.9    313.9   2014    91  76
Vedolizumab     63  14  10  3   70  -1  36.9    313.9   2014    91  76
Vedolizumab     63  14  10  4   60  -1  36.9    313.9   2014    91  76
;
run;


/* The data matches up with Bayesian coding in S3 */
data Crohn;
input Product $ 1-15 TrialID k Trt Response Count collapsity Age CDAI year male antiTNF;
datalines;
Adalimumab      11  1   0   1   47  0   37      296     2006    37 100
Adalimumab      11  1   0   2   4   0   37      296     2006    37 100
Adalimumab      11  1   0   3   14   0   37      296     2006    37 100
Adalimumab      11  1   0   4   9   0   37      296     2006    37 100
Adalimumab      11  1   1   1   31  0   39      295     2006    36 100
Adalimumab      11  1   1   2   3   0   39      295     2006    36 100
Adalimumab      11  1   1   3   14  0   39      295     2006    36 100
Adalimumab      11  1   1   4   28  0   39      295     2006    36 100
Adalimumab      12  2   0   1   110 0   37      313     2007    65  0
Adalimumab      12  2   0   2   10  0   37      313     2007    65  0
Adalimumab      12  2   0   3   34  0   37      313     2007    65  0
Adalimumab      12  2   0   4   12  0   37      313     2007    65  0
Adalimumab      12  2   1   1   77  0   39      313     2007    50  0
Adalimumab      12  2   1   2   10  0   39      313     2007    50  0
Adalimumab      12  2   1   3   38  0   39      313     2007    50  0
Adalimumab      12  2   1   4   34  0   39      313     2007    50  0
Certolizumab    21  3   0   1   200 0   38      297     2007    131 74.1
Certolizumab    21  3   0   2   16  0   38      297     2007    131 74.1
Certolizumab    21  3   0   3   50  0   38      297     2007    131 74.1
Certolizumab    21  3   0   4   62  0   38      297     2007    131 74.1
Certolizumab    21  3   2   1   189 0   37      300     2007    157 69.8
Certolizumab    21  3   2   2   13  0   37      300     2007    157 69.8
Certolizumab    21  3   2   3   50  0   37      300     2007    157 69.8
Certolizumab    21  3   2   4   79  0   37      300     2007    157 69.8
Infliximab      31  4   0   1   20  1   38.5    288     1997    15  100
Infliximab      31  4   0   2   0   1   38.5    288     1997    15  100
Infliximab      31  4   0   3   3   1   38.5    288     1997    15  100
Infliximab      31  4   0   4   1   1   38.5    288     1997    15  100
Infliximab      31  4   3   1   5   1   37      312     1997    14  100
Infliximab      31  4   3   2   0   1   37      312     1997    14  100
Infliximab      31  4   3   3   13   1   37      312     1997    14  100
Infliximab      31  4   3   4   9  1   37      312     1997    14  100
Natalizumab     42  6   0   1   90  1   39      303     2005    73  61.9
Natalizumab     42  6   0   2   0   1   39      303     2005    73  61.9
Natalizumab     42  6   0   3   40  1   39      303     2005    73  61.9
Natalizumab     42  6   0   4   51  1   39      303     2005    73  61.9
Natalizumab     42  6   5   1   311 1   38      302     2005    311 59.8
Natalizumab     42  6   5   2   0   1   38      302     2005    311 59.8
Natalizumab     42  6   5   3   167 1   38      302     2005    311 59.8
Natalizumab     42  6   5   4   246 1   38      302     2005    311 59.8
Natalizumab     43  7   0   1   150 0   37.7    299.5   2007    102 55.2
Natalizumab     43  7   0   2   8  0   37.7    299.5   2007    102 55.2
Natalizumab     43  7   0   3   39  0   37.7    299.5   2007    102 55.2
Natalizumab     43  7   0   4   53  0   37.7    299.5   2007    102 55.2
Natalizumab     43  7   5   1   114 0   38.1    303.9   2007    105 49.8
Natalizumab     43  7   5   2   10  0   38.1    303.9   2007    105 49.8
Natalizumab     43  7   5   3   52  0   38.1    303.9   2007    105 49.8
Natalizumab     43  7   5   4   83  0   38.1    303.9   2007    105 49.8
Ustekinumab     53  10  0   1   99  2   39.5    312.4   2012    64  0
Ustekinumab     53  10  0   2   0  	2   39.5    312.4   2012    64  0
Ustekinumab     53  10  0   3   0   2   39.5    312.4   2012    64  0
Ustekinumab     53  10  0   4   33  2   39.5    312.4   2012    64  0
Ustekinumab     53  10  8   1   58  2   39.4    338     2012    48  0
Ustekinumab     53  10  8   2   0  	2   39.4    338     2012    48  0
Ustekinumab     53  10  8   3   0  	2   39.4    338     2012    48  0
Ustekinumab     53  10  8   4   73	2   39.4    338     2012    48  0
Ustekinumab     54  11  0   1   175 1   36      313     2015    118  0.4
Ustekinumab     54  11  0   2   0  	1   36      313     2015    118  0.4
Ustekinumab     54  11  0   3   54  1   36      313     2015    118  0.4
Ustekinumab     54  11  0   4   18  1   36      313     2015    118  0.4
Ustekinumab     54  11  8   1   130 1   36      319     2015    101  1.2
Ustekinumab     54  11  8   2   0  	1   36      319     2015    101  1.2
Ustekinumab     54  11  8   3   67  1   36      319     2015    101  1.2
Ustekinumab     54  11  8   4   52  1   36      319     2015    101  1.2
Vedolizumab     62  13  0   1   0   -1  38.6    325     2013    69  51.4
Vedolizumab     62  13  0   2   105 -1  38.6    325     2013    69  51.4
Vedolizumab     62  13  0   3   33  -1  38.6    325     2013    69  51.4
Vedolizumab     62  13  0   4   10  -1  38.6    325     2013    69  51.4
Vedolizumab     62  13  10  1   0   -1  36.3    327     2013    105 49.5
Vedolizumab     62  13  10  2   135 -1  36.3    327     2013    105 49.5
Vedolizumab     62  13  10  3   53  -1  36.3    327     2013    105 49.5
Vedolizumab     62  13  10  4   32  -1  36.3    327     2013    105 49.5
Vedolizumab     63  14  0   1   0   -1  34.8    301.3   2014    89  76
Vedolizumab     63  14  0   2   143 -1  34.8    301.3   2014    89  76
Vedolizumab     63  14  0   3   37  -1  34.8    301.3   2014    89  76
Vedolizumab     63  14  0   4   27  -1  34.8    301.3   2014    89  76
Vedolizumab     63  14  10  1   0   -1  36.9    313.9   2014    91  76
Vedolizumab     63  14  10  2   79 -1  36.9    313.9   2014    91  76
Vedolizumab     63  14  10  3   70  -1  36.9    313.9   2014    91  76
Vedolizumab     63  14  10  4   60  -1  36.9    313.9   2014    91  76
;
run;

/* Score test to examine Proportional Odds assumption */
proc logistic data=Crohn;
    where Trt>0;
	freq count;
	class k Trt / param=ref ref=first;
	model Response=Trt / link=clogit expb aggregate scale=none;
	by k;
run;


/* Section 2: Cleansing data and standardization */
data Crohn_Placebo;
    set Crohn;
    if Trt=0 then do;
        n1=0;n2=0;n3=0;n4=0;
        if Response=1 then n1=count;
        else if Response=2 then n2=count;
        else if Response=3 then n3=count;
        else n4=count;
    end;
    else delete;
run;

data Crohn_Treatment;
    set Crohn;
    if Trt>0 then do;
        n1=0;n2=0;n3=0;n4=0;
        if Response=1 then n1=count;
        else if Response=2 then n2=count;
        else if Response=3 then n3=count;
        else n4=count;
    end;
    else delete;
run;

proc sql;
    create table Crohn_Placebo_aggregate as
    select mean(TrialID) as TID,
           mean(k) as k, mean(Trt) as TRT,
           mean(Age) as AGE, mean(CDAI) as CDAIscore, mean(year) as Year,
           mean(male) as MALE, mean(antiTNF) as antiTNF,
           mean(collapsity) as collapsity,
           sum(n1) as y1, sum(n2) as y2, sum(n3) as y3, sum(n4) as y4
    from Crohn_Placebo
    where k>0
    group by k;
run;
quit;

proc sql;
    create table Crohn_Treatment_aggregate as
    select mean(TrialID) as TID,
           mean(k) as k, mean(Trt) as TRT,
           mean(Age) as AGE, mean(CDAI) as CDAIscore, mean(year) as Year,
           mean(male) as MALE, mean(antiTNF) as antiTNF,
           mean(collapsity) as collapsity,
           sum(n1) as y1, sum(n2) as y2, sum(n3) as y3, sum(n4) as y4
    from Crohn_Treatment
    where k>0
    group by k;
run;
quit;

data Crohn_Placebo_aggregate;
    set Crohn_Placebo_aggregate;
    Pmale=MALE/(y1+y2+y3+y4);
	PantiTNF=antiTNF/100;
    drop MALE antiTNF;
run;

data Crohn_Treatment_aggregate;
    set Crohn_Treatment_aggregate;
    Pmale=MALE/(y1+y2+y3+y4);
	PantiTNF=antiTNF/100;
    drop MALE antiTNF;
run;

data Crohn_aggregate;
    set Crohn_Placebo_aggregate Crohn_Treatment_aggregate;
    by k;
run;

proc means data=Crohn_aggregate;
    var AGE CDAIscore Year Pmale PantiTNF;
	output out=mout mean=mage mCDAIscore mYear mPmale mTNF
           std=sdAGE sdCDAIscore sdYear sdPmale sdTNF;
run;

proc univariate data=Crohn_aggregate;
    var AGE CDAIscore Year Pmale PantiTNF;
run;

proc means data=Crohn_aggregate;
    var PantiTNF Pmale AGE CDAIscore;
	by k;
	output out=testout mean=Kmanti KmPmale Kmage Kmcdai;
run;

data Crohn_augument;
	set Crohn_aggregate;
	if _n_=1 then set mout;
run;

data test2;
	merge Crohn_augument testout;
	by k;
run;

proc means data=test2;
	var Kmanti KmPmale Kmage Kmcdai;
	output out=testout2 mean=Kanti KPmale Kage Kcdai
           std=Ksdanti KsdPmale Ksdage Ksdcdai;
run;

data Crohn_augument;
	set test2;
	if _n_=1 then set testout2;
run;

data Crohn_augument;
    set Crohn_augument;
  	age=(age-mage)/sdage;
  	CDAIscore=(CDAIscore-mCDAIscore)/sdCDAIscore;
  	Pmale=(Pmale-mPmale)/sdPmale;
  	Year=(Year-mYear)/sdYear;
	PantiTNF=(PantiTNF-mTNF)/sdTNF;
	KantiTNF=(Kmanti-Kanti)/Ksdanti;
	KPmale=(KmPmale-KPmale)/KsdPmale;
    Kage=(Kmage-Kage)/Ksdage;
    Kcdai=(Kmcdai-Kcdai)/Ksdcdai;
run;

data Crohn_augument;
    set Crohn_augument;
 	cCDAIscore=CDAIscore*sdCDAIscore;
 	cPmale=Pmale*sdPmale;
 	cage=age*sdage;
	cTNF=PantiTNF*sdTNF;
run;

proc sort data=Crohn_augument;
	by k;
run;

proc univariate data=Crohn_augument noprint;
	var cCDAIscore cPmale cage cTNF;
	output out=outCDAI mean=mcCDAIscore mcPmale mcage mcTNF;
	by k;
run;

data Crohn_augument;
	merge Crohn_augument outCDAI;
	by k;
run;

data Crohn2;
  set Crohn_augument;
  SS=y1+y2+y3+y4;
  cs=lfact(y1+y2+y3+y4);
  c1=lfact(y1);
  c2=lfact(y2);
  c3=lfact(y3);
  c4=lfact(y4);
  coeffi=cs-(c1+c2+c3+c4);
  keep TID k TRT collapsity y1 y2 y3 y4 AGE CDAIscore Year Pmale PantiTNF c1 c2 c3 c4 cs coeffi SS;
run;

data Crohn1;
  set Crohn_augument;
  SS=y1+y2+y3+y4;
  cs=lfact(y1+y2+y3+y4);
  c1=lfact(y1);
  c2=lfact(y2);
  c3=lfact(y3);
  c4=lfact(y4);
  coeffi=cs-(c1+c2+c3+c4);
  keep TID k TRT collapsity y1 y2 y3 y4 AGE CDAIscore Year Pmale PantiTNF c1 c2 c3 c4 cs coeffi SS;
run;


/* Proposed Model 3 using Set II */
proc nlmixed data=Crohn2 cov;
	parms eta1=0.67 phi0=-1 phi1=-3
		  beta1=0.25 beta2=0.15 beta3=0.22 beta4=0.12 beta5=0.06
		  alpha20=-1.15 alpha21=-0.07 alpha22=-0.05 alpha23=-0.12 alpha24=-0.11 alpha25=0.12
		  alpha30=-0.43 alpha31=-0.13 alpha32=0.07 alpha33=0.41 alpha34=-0.06 alpha35=-0.08
          T1=-0.59 T2=-0.31 T3=-2.21 T5=-0.68 T8=-1.06 T10=-0.80;
    
	zbeta=exp(phi0+phi1*year)*mu_k;
	xbeta=beta1*AGE+beta2*Pmale+beta3*CDAIscore+beta4*year+beta5*PantiTNF+zbeta;
	z1=eta1;
	z2=z1+exp(alpha20+alpha21*Age+alpha22*Pmale+alpha23*CDAIscore+alpha24*year+alpha25*PantiTNF);
	z3=z2+exp(alpha30+alpha31*Age+alpha32*Pmale+alpha33*CDAIscore+alpha34*year+alpha35*PantiTNF);
	TRT1=T1*(TRT=1)+T2*(TRT=2)+T3*(TRT=3)+T5*(TRT=5)+T8*(TRT=8)+T10*(TRT=10);
	
	if (collapsity eq -1) then do;
	    p1=1/(1+exp(-(z1+TRT1+xbeta)));
		p2=1/(1+exp(-(z2+TRT1+xbeta)))-1/(1+exp(-(z1+TRT1+xbeta)));
		p3=1/(1+exp(-(z3+TRT1+xbeta)))-1/(1+exp(-(z2+TRT1+xbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+xbeta)));
	  	loglik=(y1+y2)*log(p1+p2)+y3*log(p3)+y4*log(p4)+coeffi;
	end;
	else if (collapsity eq 1) then do;
	    p1=1/(1+exp(-(z1+TRT1+xbeta)));
		p2=1/(1+exp(-(z2+TRT1+xbeta)))-1/(1+exp(-(z1+TRT1+xbeta)));
		p3=1/(1+exp(-(z3+TRT1+xbeta)))-1/(1+exp(-(z2+TRT1+xbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+xbeta)));
	  	loglik=y1*log(p1)+(y2+y3)*log(p2+p3)+y4*log(p4)+coeffi;
	end;
	else if (collapsity eq 2) then do;
	    p1=1/(1+exp(-(z1+TRT1+xbeta)));
		p2=1/(1+exp(-(z2+TRT1+xbeta)))-1/(1+exp(-(z1+TRT1+xbeta)));
		p3=1/(1+exp(-(z3+TRT1+xbeta)))-1/(1+exp(-(z2+TRT1+xbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+xbeta)));
	  	loglik=y1*log(p1)+(y2+y3+y4)*log(p2+p3+p4)+coeffi;
	end;
	else do;
	    p1=1/(1+exp(-(z1+TRT1+xbeta)));
		p2=1/(1+exp(-(z2+TRT1+xbeta)))-1/(1+exp(-(z1+TRT1+xbeta)));
		p3=1/(1+exp(-(z3+TRT1+xbeta)))-1/(1+exp(-(z2+TRT1+xbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+xbeta)));
	    loglik=y1*log(p1)+y2*log(p2)+y3*log(p3)+y4*log(p4)+coeffi;
	end;

	model y1~general(loglik);
	random mu_k~normal(0,1) subject=K;
	ods output CovMatParmEst=approxcovM3;

	estimate 'Infliximab-Vedolizumab 300mg'   T3-T10;
    estimate 'Infliximab-Ustakinumab 6mg/kg'  T3-T8;
	estimate 'Infliximab-Natalizumab 300mg'   T3-T5;
	estimate 'Infliximab-Adalimumab'  		  T3-T1;
	estimate 'Infliximab-Certolizumab 400mg'  T3-T2;
    estimate 'Vedolizumab 300mg-Ustakinumab 6mg/kg'	 T10-T8;
    estimate 'Vedolizumab 300mg-Natalizumab 300mg' 	 T10-T5;
    estimate 'Vedolizumab 300mg-Adalimumab' 	 	 T10-T1;
    estimate 'Vedolizumab 300mg-Certolizumab 400mg'  T10-T2;
    estimate 'Ustakinumab 6mg/kg-Natalizumab 300mg'  T8-T5;
    estimate 'Ustakinumab 6mg/kg-Adalimumab' 	 	 T8-T1;
    estimate 'Ustakinumab 6mg/kg-Certolizumab 400mg' T8-T2;
    estimate 'Natalizumab 300mg-Adalimumab' 		T5-T1;
    estimate 'Natalizumab 300mg-Certolizumab 400mg' T5-T2;
    estimate 'Adalimumab-Certolizumab 400mg'  		T1-T2;

    predict p1 out=p1;  /*prob(resp<70)for non-collapsed groups*/
    predict p2 out=p2;   /*prob(70<=resp<100) for non-collapsed groups */
    predict p3 out=p3;   /*prob(100<=resp<remission) for non-collapsed groups */
    predict p4 out=p4;   /*prob(resp=remission) for non-collapsed groups */

run;



/* Section 4: Model dianostics */
data test1(keep=TID K TRT collapsity Samplesize p1_est Pred1 y1);
	set p1;
	Samplesize=0;
	Samplesize=y1+y2+y3+y4;
	p1_est=y1/Samplesize;
	Pred1=Pred;
run;

data test2(keep=TID K TRT collapsity Samplesize p2_est Pred2 y2);
	set p2;
	Samplesize=0;
	Samplesize=y1+y2+y3+y4;
	p2_est=y2/Samplesize;
	Pred2=Pred;
run;

data test3(keep=TID K TRT collapsity Samplesize p3_est Pred3 y3);
	set p3;
	Samplesize=0;
	Samplesize=y1+y2+y3+y4;
	p3_est=y3/Samplesize;
	Pred3=Pred;
run;

data test4(keep=TID K TRT collapsity Samplesize p4_est Pred4 y4);
	set p4;
	Samplesize=0;
	Samplesize=y1+y2+y3+y4;
	p4_est=y4/Samplesize;
	Pred4=Pred;
run;

data test;
	merge test1 test2 test3 test4;
	by k;
run;


/* Calculate residuals and chi-square test statistics per trial using macro */
%macro diagnostics(TID=);

	data plb trt;
	  set test;
	  if K=&TID then do;
		if TRT=0 then output;
	  end;
	run;

	title 'Model diagnostics: Placebo arm';
	proc iml;
	use plb;
	read var {K TRT Samplesize collapsity y1 y2 y3 y4 Pred1 Pred2 Pred3 Pred4 p1_est p2_est p3_est p4_est};

	if collapsity=0 then do;
		COVplb=J(4,4,0);
		phat1=y1-Samplesize*Pred1;
		phat2=y2-Samplesize*Pred2;
		phat3=y3-Samplesize*Pred3;
		phat4=y4-Samplesize*Pred4;
		phat=phat1//phat2//phat3//phat4;
		* create covariance matrix based on predicted probabilities;
		COVplb[1,1]=Pred1*(1-Pred1);
		COVplb[2,2]=Pred2*(1-Pred2);
		COVplb[3,3]=Pred3*(1-Pred3);
		COVplb[4,4]=Pred4*(1-Pred4);
		COVplb[1,2]=-Pred1*Pred2;COVplb[2,1]=-Pred1*Pred2;
		COVplb[1,3]=-Pred1*Pred3;COVplb[3,1]=-Pred1*Pred3;
		COVplb[1,4]=-Pred1*Pred4;COVplb[4,1]=-Pred1*Pred4;
		COVplb[2,3]=-Pred2*Pred3;COVplb[3,2]=-Pred2*Pred3;
		COVplb[2,4]=-Pred2*Pred4;COVplb[4,2]=-Pred2*Pred4;
		COVplb[3,4]=-Pred3*Pred4;COVplb[4,3]=-Pred3*Pred4;
		COVplb=Samplesize*COVplb;
		*A={1 0 0 -1,0 1 0 -1,0 0 1 -1};
		*A={1 0 0 0, 0 1 0 0, 0 0 1 0};
		A={1 -1 0 0, 1 0 -1 0, 1 0 0 -1};
		rank = round(trace(ginv(A)*A));  						* Checking rank of A;
		INVCOV=INV(A*COVplb*A`);								* Calculate inverse of covariance matrix;
		eigvals=eigval(INVCOV);									* eigenvalues based on spectral decomposition;
		eigvecs=eigvec(INVCOV);									* eigenvectors based on spectral decomposition;
		resid=(eigvecs*sqrt(diag(eigvals))*eigvecs`)*(A*phat);	* Calculate residuals;
		SUMresid=sum(resid##2);									* sum of square of residuals;
		X2stat=(A*phat)`*INV(A*COVplb*A`)*(A*phat);				* Calculating a chi-square statistic;
		pval=round(1-probchi(X2stat,3),0.0001);					* Calculating p-value;
	end;

	if collapsity=-1 then do;
		COVplb=J(3,3,0);
		phat12=(y1+y2)-Samplesize*(Pred1+Pred2);
		phat3=y3-Samplesize*Pred3;
		phat4=y4-Samplesize*Pred4;
		phat=phat12//phat3//phat4;
		COVplb[1,1]=(Pred1+Pred2)*(1-Pred1-Pred2);
		COVplb[2,2]=Pred3*(1-Pred3);
		COVplb[3,3]=Pred4*(1-Pred4);
		COVplb[1,2]=-(Pred1+Pred2)*Pred3;COVplb[2,1]=-(Pred1+Pred2)*Pred3;
		COVplb[1,3]=-(Pred1+Pred2)*Pred4;COVplb[3,1]=-(Pred1+Pred2)*Pred4;
		COVplb[2,3]=-Pred3*Pred4;		 COVplb[3,2]=-Pred3*Pred4;
		COVplb=Samplesize*COVplb;
		*A={1 0 -1, 0 1 -1};
		*A={1 0 0, 0 1 0};
		A={1 -1 0, 1 0 -1};
		rank = round(trace(ginv(A)*A));  
		INVCOV=INV(A*COVplb*A`);
		eigvals=eigval(INVCOV);
		eigvecs=eigvec(INVCOV);
		resid=(eigvecs*sqrt(diag(eigvals))*eigvecs`)*(A*phat);	
		SUMresid=sum(resid##2);
		X2stat=(A*phat)`*INV(A*COVplb*A`)*(A*phat);		
		pval=round(1-probchi(X2stat,2),0.0001);
	end;

	if collapsity=1 then do;
		COVplb=J(3,3,0);
		phat1=y1-Samplesize*Pred1;
		phat23=(y2+y3)-Samplesize*(Pred2+Pred3);
		phat4=y4-Samplesize*Pred4;
		phat=phat1//phat23//phat4;
		COVplb[1,1]=Pred1*(1-Pred1);
		COVplb[2,2]=(Pred2+Pred3)*(1-Pred2-Pred3);
		COVplb[3,3]=Pred4*(1-Pred4);
		COVplb[1,2]=-Pred1*(Pred2+Pred3);COVplb[2,1]=-Pred1*(Pred2+Pred3);
		COVplb[1,3]=-Pred1*Pred4;		 COVplb[3,1]=-Pred1*Pred4;
		COVplb[2,3]=-(Pred2+Pred3)*Pred4;COVplb[3,2]=-(Pred2+Pred3)*Pred4;
		COVplb=Samplesize*COVplb;
		*A={1 0 -1, 0 1 -1};
		*A={1 0 0, 0 1 0};
		A={1 -1 0, 1 0 -1};
		rank = round(trace(ginv(A)*A));  
		INVCOV=INV(A*COVplb*A`);
		eigvals=eigval(INVCOV);
		eigvecs=eigvec(INVCOV);
		resid=(eigvecs*sqrt(diag(eigvals))*eigvecs`)*(A*phat);	
		SUMresid=sum(resid##2);
		X2stat=(A*phat)`*INV(A*COVplb*A`)*(A*phat);		
		pval=round(1-probchi(X2stat,2),0.0001);
	end;

	if collapsity=2 then do;
		COVplb=J(2,2,0);
		phat1=y1-Samplesize*Pred1;
		phat234=(y2+y3+y4)-Samplesize*(Pred2+Pred3+Pred4);
		phat=phat1//phat234;
		COVplb[1,1]=Pred1*(1-Pred1);
		COVplb[2,2]=(Pred2+Pred3+Pred4)*(1-Pred2-Pred3-Pred4);
		COVplb[1,2]=-Pred1*(Pred2+Pred3+Pred4);COVplb[2,1]=-Pred1*(Pred2+Pred3+Pred4);
		COVplb=Samplesize*COVplb;
		A={1 -1};
		*A={1 0};
		rank = round(trace(ginv(A)*A));  
		INVCOV=INV(A*COVplb*A`);
		eigvals=eigval(INVCOV);
		eigvecs=eigvec(INVCOV);
		resid=(eigvecs*sqrt(diag(eigvals))*eigvecs`)*(A*phat);	
		SUMresid=sum(resid##2);
		X2stat=(A*phat)`*INV(A*COVplb*A`)*(A*phat);		
		pval=round(1-probchi(X2stat,2),0.0001);
	end;

    resid=round(resid,0.001);
	X2stat=round(X2stat,0.001);	
	print resid, X2stat, pval;

quit;
%mend;

%diagnostics(TID=1);
%diagnostics(TID=2);
%diagnostics(TID=3);
%diagnostics(TID=4);
%diagnostics(TID=6);
%diagnostics(TID=7);
%diagnostics(TID=10);
%diagnostics(TID=11);
%diagnostics(TID=13);
%diagnostics(TID=14);



%macro diagnostics(TID=);

	data plb trt;
	  set test;
	  if K=&TID then do;
		if TRT>0 then output;
	  end;
	run;

	proc iml;
    title 'Model diagnostics: Treatment arm';
	use trt;
	read var {K TRT Samplesize collapsity y1 y2 y3 y4 Pred1 Pred2 Pred3 Pred4 p1_est p2_est p3_est p4_est};

	if collapsity=0 then do;
		COVtrt=J(4,4,0);
		phat1=y1-Samplesize*Pred1;
		phat2=y2-Samplesize*Pred2;
		phat3=y3-Samplesize*Pred3;
		phat4=y4-Samplesize*Pred4;
		phat=phat1//phat2//phat3//phat4;
		
		COVtrt[1,1]=Pred1*(1-Pred1);
		COVtrt[2,2]=Pred2*(1-Pred2);
		COVtrt[3,3]=Pred3*(1-Pred3);
		COVtrt[4,4]=Pred4*(1-Pred4);
		COVtrt[1,2]=-Pred1*Pred2;COVtrt[2,1]=-Pred1*Pred2;
		COVtrt[1,3]=-Pred1*Pred3;COVtrt[3,1]=-Pred1*Pred3;
		COVtrt[1,4]=-Pred1*Pred4;COVtrt[4,1]=-Pred1*Pred4;
		COVtrt[2,3]=-Pred2*Pred3;COVtrt[3,2]=-Pred2*Pred3;
		COVtrt[2,4]=-Pred2*Pred4;COVtrt[4,2]=-Pred2*Pred4;
		COVtrt[3,4]=-Pred3*Pred4;COVtrt[4,3]=-Pred3*Pred4;
		COVtrt=Samplesize*COVtrt;
		*A={1 0 0 -1,0 1 0 -1,0 0 1 -1};
		*A={1 0 0 0, 0 1 0 0, 0 0 1 0};
		A={1 -1 0 0, 1 0 -1 0, 1 0 0 -1};
		rank = round(trace(ginv(A)*A));  
		INVCOV=INV(A*COVtrt*A`);
		eigvals=eigval(INVCOV);
		eigvecs=eigvec(INVCOV);
		resid=(eigvecs*sqrt(diag(eigvals))*eigvecs`)*(A*phat);	
		SUMresid=sum(resid##2);
		X2stat=(A*phat)`*INV(A*COVtrt*A`)*(A*phat);		
		pval=round(1-probchi(X2stat,3),0.0001);
	end;

	if collapsity=-1 then do;
		COVtrt=J(3,3,0);
		phat12=(y1+y2)-Samplesize*(Pred1+Pred2);
		phat3=y3-Samplesize*Pred3;
		phat4=y4-Samplesize*Pred4;
		phat=phat12//phat3//phat4;
		COVtrt[1,1]=(Pred1+Pred2)*(1-Pred1-Pred2);
		COVtrt[2,2]=Pred3*(1-Pred3);
		COVtrt[3,3]=Pred4*(1-Pred4);
		COVtrt[1,2]=-(Pred1+Pred2)*Pred3;COVtrt[2,1]=-(Pred1+Pred2)*Pred3;
		COVtrt[1,3]=-(Pred1+Pred2)*Pred4;COVtrt[3,1]=-(Pred1+Pred2)*Pred4;
		COVtrt[2,3]=-Pred3*Pred4;		 COVtrt[3,2]=-Pred3*Pred4;
		COVtrt=Samplesize*COVtrt;
		*A={1 0 -1, 0 1 -1};
		*A={1 0 0, 0 1 0};
		A={1 -1 0, 1 0 -1};
		rank = round(trace(ginv(A)*A));  
		INVCOV=INV(A*COVtrt*A`);
		eigvals=eigval(INVCOV);
		eigvecs=eigvec(INVCOV);
		resid=(eigvecs*sqrt(diag(eigvals))*eigvecs`)*(A*phat);
		SUMresid=sum(resid##2);	
		X2stat=(A*phat)`*INV(A*COVtrt*A`)*(A*phat);		
		pval=round(1-probchi(X2stat,2),0.0001);
	end;

	if collapsity=1 then do;
		COVtrt=J(3,3,0);
		phat1=y1-Samplesize*Pred1;
		phat23=(y2+y3)-Samplesize*(Pred2+Pred3);
		phat4=y4-Samplesize*Pred4;
		phat=phat1//phat23//phat4;
		COVtrt[1,1]=Pred1*(1-Pred1);
		COVtrt[2,2]=(Pred2+Pred3)*(1-Pred2-Pred3);
		COVtrt[3,3]=Pred4*(1-Pred4);
		COVtrt[1,2]=-Pred1*(Pred2+Pred3);COVtrt[2,1]=-Pred1*(Pred2+Pred3);
		COVtrt[1,3]=-Pred1*Pred4;		 COVtrt[3,1]=-Pred1*Pred4;
		COVtrt[2,3]=-(Pred2+Pred3)*Pred4;COVtrt[3,2]=-(Pred2+Pred3)*Pred4;
		COVtrt=Samplesize*COVtrt;
		*A={1 0 -1, 0 1 -1};
		*A={1 0 0, 0 1 0};
		A={1 -1 0, 1 0 -1};
		rank=round(trace(ginv(A)*A));  
		INVCOV=INV(A*COVtrt*A`);
		eigvals=eigval(INVCOV);
		eigvecs=eigvec(INVCOV);
		resid=(eigvecs*sqrt(diag(eigvals))*eigvecs`)*(A*phat);	
		SUMresid=round(sum(resid##2),0.0001);
		X2stat=(A*phat)`*INV(A*COVtrt*A`)*(A*phat);		
		pval=round(1-probchi(X2stat,2),0.0001);
	end;

	if collapsity=2 then do;
		COVtrt=J(2,2,0);
		phat1=y1-Samplesize*Pred1;
		phat234=(y2+y3+y4)-Samplesize*(Pred2+Pred3+Pred4);
		phat=phat1//phat234;
		COVtrt[1,1]=Pred1*(1-Pred1);
		COVtrt[2,2]=(Pred2+Pred3+Pred4)*(1-Pred2-Pred3-Pred4);
		COVtrt[1,2]=-Pred1*(Pred2+Pred3+Pred4);COVtrt[2,1]=-Pred1*(Pred2+Pred3+Pred4);
		COVtrt=Samplesize*COVtrt;
        A={1 -1};		
		*A={1 0};
		rank = round(trace(ginv(A)*A));  
		INVCOV=INV(A*COVtrt*A`);
		eigvals=eigval(INVCOV);
		eigvecs=eigvec(INVCOV);
		resid=(eigvecs*sqrt(diag(eigvals))*eigvecs`)*(A*phat);	
		SUMresid=sum(resid##2);
		X2stat=(A*phat)`*INV(A*COVtrt*A`)*(A*phat);		
		pval=round(1-probchi(X2stat,2),0.0001);
	end;

    resid=round(resid,0.001);
	X2stat=round(X2stat,0.001);
	print resid, X2stat, pval;
	
quit;
%mend;

%diagnostics(TID=1);
%diagnostics(TID=2);
%diagnostics(TID=3);
%diagnostics(TID=4);
%diagnostics(TID=6);
%diagnostics(TID=7);
%diagnostics(TID=10);
%diagnostics(TID=11);
%diagnostics(TID=13);
%diagnostics(TID=14);



