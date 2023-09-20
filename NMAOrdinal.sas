/*************************************************************************
 * This macro is used to replicate all analyses results from the paper	 *
 * Network meta-regression for ordinal outcomes: 			 *
 *    Applications to in comparing Crohn's disease treatments		 *
 * By Gwon et al.(2020) Statistics in Medicine; 39: pp. 1846-1870	 *
 *                                                                       *
 * Written by Drs.Yeongjin Gwon and Ming-Hui Chen, February, 2021        *
 *************************************************************************/

%macro NMAOrdinal(CDdata,Model,Amatrix);

/* Checking error message for input values */
%if (&Model>3) %then %do;
  %put ERROR: Invalid Model number;
  %return;
%end;

%if (&Amatrix>3) %then %do;
  %put ERROR: Invalid constant matrix A;
  %return;
%end;

%if (&CDdata=Crohn1) %then %do;
  %put Message: You are running Scenario1;
%end;
%else %if (&CDdata=Crohn2) %then %do;
  %put Message: You are running Scenario2;
%end;
%else %if (&CDdata=Crohn3) %then %do;
  %put Message: You are running Scenario3;
%end;
%else %do;
  %put ERROR: Invalid Dataset;
  %return;
%end;

/* Score test to examine Proportional Odds assumption */
proc logistic data=&CDdata;
  where Trt>0;
  freq count;
  class K Trt / param=ref ref=first;
  model Response=Trt / link=clogit expb aggregate scale=none;
  by K;
run;

/* Section 2: Cleansing data and standardization */
data Crohn_Placebo;
  set &CDdata;
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
  set &CDdata;
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
  select mean(K) as K, mean(Trt) as TRT,
    mean(Age) as AGE, mean(CDAI) as CDAIscore, mean(year) as Year,
    mean(male) as MALE, mean(antiTNF) as antiTNF,
    mean(collapsity) as collapsity,
    sum(n1) as y1, sum(n2) as y2, sum(n3) as y3, sum(n4) as y4
  from Crohn_Placebo
  where K>0
  group by K;
run;
quit;

proc sql;
  create table Crohn_Treatment_aggregate as
  select mean(K) as K, mean(Trt) as TRT,
    mean(Age) as AGE, mean(CDAI) as CDAIscore, mean(year) as Year,
    mean(male) as MALE, mean(antiTNF) as antiTNF,
    mean(collapsity) as collapsity,
    sum(n1) as y1, sum(n2) as y2, sum(n3) as y3, sum(n4) as y4
  from Crohn_Treatment
  where K>0
  group by K;
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
  by K;
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
  by K;
  output out=testout mean=Kmanti KmPmale Kmage Kmcdai;
run;

data Crohn_augument;
  set Crohn_aggregate;
  if _n_=1 then set mout;
run;

data test2;
  merge Crohn_augument testout;
  by K;
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
  by K;
run;

proc univariate data=Crohn_augument noprint;
  var cCDAIscore cPmale cage cTNF;
  output out=outCDAI mean=mcCDAIscore mcPmale mcage mcTNF;
  by K;
run;

data Crohn_augument;
  merge Crohn_augument outCDAI;
  by K;
run;

data Crohn;
  set Crohn_augument;
  cs=lfact(y1+y2+y3+y4);
  c1=lfact(y1);
  c2=lfact(y2);
  c3=lfact(y3);
  c4=lfact(y4);
  coeffi=cs-(c1+c2+c3+c4);
  keep k TRT collapsity y1 y2 y3 y4 AGE CDAIscore Year Pmale PantiTNF c1 c2 c3 c4 cs coeffi;
run;

/* Running Statistical Models */
%if &CDdata='Crohn2' %then %do;
  %if &Model=1 %then %do;
    proc nlmixed data=Crohn;
	  parms eta1=0.58 eta2=0.37 eta3=0.7  phi0=-3.5
		  T1=-0.89 T2=-0.21 T3=-1.9 T4=-0.68 T5=-0.8 T6=-0.66;
      bounds eta2>0,eta3>0;

	  z1=eta1;
	  z2=z1+eta2;
	  z3=z2+eta3;
	  zbeta=exp(phi0)*mu_k;
	  TRT1=T1*(TRT=1)+T2*(TRT=2)+T3*(TRT=3)+T4*(TRT=4)+T5*(TRT=5)+T6*(TRT=6);
	
	  if (collapsity eq -1) then do;
	    p1=1/(1+exp(-(z1+TRT1+zbeta)));
		p2=1/(1+exp(-(z2+TRT1+zbeta)))-1/(1+exp(-(z1+TRT1+zbeta)));
		p3=1/(1+exp(-(z3+TRT1+zbeta)))-1/(1+exp(-(z2+TRT1+zbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+zbeta)));
	  	loglik=(y1+y2)*log(p1+p2)+y3*log(p3)+y4*log(p4)+coeffi;
	  end;
	  else if (collapsity eq 1) then do;
	    p1=1/(1+exp(-(z1+TRT1+zbeta)));
		p2=1/(1+exp(-(z2+TRT1+zbeta)))-1/(1+exp(-(z1+TRT1+zbeta)));
		p3=1/(1+exp(-(z3+TRT1+zbeta)))-1/(1+exp(-(z2+TRT1+zbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+zbeta)));
	  	loglik=y1*log(p1)+(y2+y3)*log(p2+p3)+y4*log(p4)+coeffi;
	  end;
	  else if (collapsity eq 2) then do;
	    p1=1/(1+exp(-(z1+TRT1+zbeta)));
		p2=1/(1+exp(-(z2+TRT1+zbeta)))-1/(1+exp(-(z1+TRT1+zbeta)));
		p3=1/(1+exp(-(z3+TRT1+zbeta)))-1/(1+exp(-(z2+TRT1+zbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+zbeta)));
	  	loglik=y1*log(p1)+(y2+y3+y4)*log(p2+p3+p4)+coeffi;
	  end;
	  else do;
	    p1=1/(1+exp(-(z1+TRT1+zbeta)));
		p2=1/(1+exp(-(z2+TRT1+zbeta)))-1/(1+exp(-(z1+TRT1+zbeta)));
		p3=1/(1+exp(-(z3+TRT1+zbeta)))-1/(1+exp(-(z2+TRT1+zbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+zbeta)));
	    loglik=y1*log(p1)+y2*log(p2)+y3*log(p3)+y4*log(p4)+coeffi;
	  end;

	  model y1~general(loglik);
	  random mu_k~normal(0,1) subject=K;
	  ods output ParameterEstimates=_para_est FitStatistics=_fit AdditionalEstimates=_pair_comp;

	  estimate 'Infliximab-Vedolizumab 300mg'   		T3-T6;
      estimate 'Infliximab-Ustakinumab 6mg/kg'  		T3-T5;
	  estimate 'Infliximab-Natalizumab 300mg'   		T3-T4;
	  estimate 'Infliximab-Adalimumab'  		  		T3-T1;
	  estimate 'Infliximab-Certolizumab 400mg'  		T3-T2;
      estimate 'Vedolizumab 300mg-Ustakinumab 6mg/kg'	T6-T5;
      estimate 'Vedolizumab 300mg-Natalizumab 300mg' 	T6-T4;
      estimate 'Vedolizumab 300mg-Adalimumab' 	 	 	T6-T1;
      estimate 'Vedolizumab 300mg-Certolizumab 400mg'  	T6-T2;
      estimate 'Ustakinumab 6mg/kg-Natalizumab 300mg'  	T5-T4;
      estimate 'Ustakinumab 6mg/kg-Adalimumab' 	 	 	T5-T1;
      estimate 'Ustakinumab 6mg/kg-Certolizumab 400mg' 	T5-T2;
      estimate 'Natalizumab 300mg-Adalimumab' 		 	T4-T1;
      estimate 'Natalizumab 300mg-Certolizumab 400mg'  	T4-T2;
      estimate 'Adalimumab-Certolizumab 400mg'  		T1-T2;

      predict p1 out=p1;  	/*prob(resp<70)for non-collapsed groups*/
      predict p2 out=p2;   	/*prob(70<=resp<100) for non-collapsed groups */
      predict p3 out=p3;   	/*prob(100<=resp<remission) for non-collapsed groups */
      predict p4 out=p4;   	/*prob(resp=remission) for non-collapsed groups */
    run;
  %end;
  %else %if &Model=2 %then %do;
    proc nlmixed data=Crohn;
  	  parms eta1=0.58 eta2=0.37 eta3=0.7 phi0=-1
          beta1=0.02 beta2=-0.02 beta3=-0.1 beta4=0.21 beta5=0.5
		  T1=-0.89 T2=-0.21 T3=-1.9 T4=-0.68 T5=-0.8 T6=-0.66;
      bounds eta2>0,eta3>0;

	  zbeta=exp(phi0);
	  xbeta=beta1*AGE+beta2*Pmale+beta3*CDAIscore+beta4*year+beta5*PantiTNF+zbeta*mu_k;
	  z1=eta1;
	  z2=z1+eta2;
	  z3=z2+eta3;
	  TRT1=T1*(TRT=1)+T2*(TRT=2)+T3*(TRT=3)+T4*(TRT=4)+T5*(TRT=5)+T6*(TRT=6);
	
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
	  ods output ParameterEstimates=_para_est FitStatistics=_fit AdditionalEstimates=_pair_comp;

	  estimate 'Infliximab-Vedolizumab 300mg'   		T3-T6;
      estimate 'Infliximab-Ustakinumab 6mg/kg'  		T3-T5;
	  estimate 'Infliximab-Natalizumab 300mg'   		T3-T4;
	  estimate 'Infliximab-Adalimumab'  		  		T3-T1;
	  estimate 'Infliximab-Certolizumab 400mg'  		T3-T2;
      estimate 'Vedolizumab 300mg-Ustakinumab 6mg/kg'	T6-T5;
      estimate 'Vedolizumab 300mg-Natalizumab 300mg' 	T6-T4;
      estimate 'Vedolizumab 300mg-Adalimumab' 	 	 	T6-T1;
      estimate 'Vedolizumab 300mg-Certolizumab 400mg'  	T6-T2;
      estimate 'Ustakinumab 6mg/kg-Natalizumab 300mg'  	T5-T4;
      estimate 'Ustakinumab 6mg/kg-Adalimumab' 	 	 	T5-T1;
      estimate 'Ustakinumab 6mg/kg-Certolizumab 400mg' 	T5-T2;
      estimate 'Natalizumab 300mg-Adalimumab' 		 	T4-T1;
      estimate 'Natalizumab 300mg-Certolizumab 400mg'  	T4-T2;
      estimate 'Adalimumab-Certolizumab 400mg'  		T1-T2;

      predict p1 out=p1;  	/*prob(resp<70)for non-collapsed groups*/
      predict p2 out=p2;   	/*prob(70<=resp<100) for non-collapsed groups */
      predict p3 out=p3;   	/*prob(100<=resp<remission) for non-collapsed groups */
      predict p4 out=p4;   	/*prob(resp=remission) for non-collapsed groups */

    run;
  %end;
  %else %if &Model=3 %then %do;
    proc nlmixed data=Crohn;
  	  parms eta1=0.53 phi0=-5 phi1=-1
		  beta1=0.25 beta2=0.15 beta3=0.22 beta4=0.12 beta5=0.06
		  alpha20=-4.15 alpha21=-0.48 alpha22=2.1 alpha23=2.0 alpha24=-1.4 alpha25=-2.2
		  alpha30=0.05 alpha31=-0.08 alpha32=-0.31 alpha33=0.40 alpha34=0.10 alpha35=0.34
          T1=-0.50 T2=-0.31 T3=-2.21 T4=-0.78 T5=-0.70 T6=-1.3;
    
	  zbeta=exp(phi0+phi1*year)*mu_k;
	  xbeta=beta1*AGE+beta2*Pmale+beta3*CDAIscore+beta4*year+beta5*PantiTNF+zbeta;
	  z1=eta1;
	  z2=z1+exp(alpha20+alpha21*Age+alpha22*Pmale+alpha23*CDAIscore+alpha24*year+alpha25*PantiTNF);
	  z3=z2+exp(alpha30+alpha31*Age+alpha32*Pmale+alpha33*CDAIscore+alpha34*year+alpha35*PantiTNF);
	  TRT1=T1*(TRT=1)+T2*(TRT=2)+T3*(TRT=3)+T4*(TRT=4)+T5*(TRT=5)+T6*(TRT=6);
	
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
	  ods output ParameterEstimates=_para_est FitStatistics=_fit AdditionalEstimates=_pair_comp;

	  estimate 'Infliximab-Vedolizumab 300mg'   		T3-T6;
      estimate 'Infliximab-Ustakinumab 6mg/kg'  		T3-T5;
	  estimate 'Infliximab-Natalizumab 300mg'   		T3-T4;
	  estimate 'Infliximab-Adalimumab'  		  		T3-T1;
	  estimate 'Infliximab-Certolizumab 400mg'  		T3-T2;
      estimate 'Vedolizumab 300mg-Ustakinumab 6mg/kg'	T6-T5;
      estimate 'Vedolizumab 300mg-Natalizumab 300mg' 	T6-T4;
      estimate 'Vedolizumab 300mg-Adalimumab' 	 	 	T6-T1;
      estimate 'Vedolizumab 300mg-Certolizumab 400mg'  	T6-T2;
      estimate 'Ustakinumab 6mg/kg-Natalizumab 300mg'  	T5-T4;
      estimate 'Ustakinumab 6mg/kg-Adalimumab' 	 	 	T5-T1;
      estimate 'Ustakinumab 6mg/kg-Certolizumab 400mg' 	T5-T2;
      estimate 'Natalizumab 300mg-Adalimumab' 		 	T4-T1;
      estimate 'Natalizumab 300mg-Certolizumab 400mg'  	T4-T2;
      estimate 'Adalimumab-Certolizumab 400mg'  		T1-T2;

      predict p1 out=p1;  /*prob(resp<70)for non-collapsed groups*/
      predict p2 out=p2;   /*prob(70<=resp<100) for non-collapsed groups */
      predict p3 out=p3;   /*prob(100<=resp<remission) for non-collapsed groups */
      predict p4 out=p4;   /*prob(resp=remission) for non-collapsed groups */

    run;
  %end;
%end;
%else %do;
  %if &Model=1 %then %do;
    proc nlmixed data=Crohn;
	  parms eta1=0.58 eta2=0.37 eta3=0.7  phi0=-3.5
		  T1=-0.89 T2=-0.21 T3=-1.9 T4=-0.68 T5=-0.8 T6=-0.66;
      bounds eta2>0,eta3>0;

	  z1=eta1;
	  z2=z1+eta2;
	  z3=z2+eta3;
	  zbeta=exp(phi0)*mu_k;
	  TRT1=T1*(TRT=1)+T2*(TRT=2)+T3*(TRT=3)+T4*(TRT=4)+T5*(TRT=5)+T6*(TRT=6);
	
	  if (collapsity eq -1) then do;
	    p1=1/(1+exp(-(z1+TRT1+zbeta)));
		p2=1/(1+exp(-(z2+TRT1+zbeta)))-1/(1+exp(-(z1+TRT1+zbeta)));
		p3=1/(1+exp(-(z3+TRT1+zbeta)))-1/(1+exp(-(z2+TRT1+zbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+zbeta)));
	  	loglik=(y1+y2)*log(p1+p2)+y3*log(p3)+y4*log(p4)+coeffi;
	  end;
	  else if (collapsity eq 1) then do;
	    p1=1/(1+exp(-(z1+TRT1+zbeta)));
		p2=1/(1+exp(-(z2+TRT1+zbeta)))-1/(1+exp(-(z1+TRT1+zbeta)));
		p3=1/(1+exp(-(z3+TRT1+zbeta)))-1/(1+exp(-(z2+TRT1+zbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+zbeta)));
	  	loglik=y1*log(p1)+(y2+y3)*log(p2+p3)+y4*log(p4)+coeffi;
	  end;
	  else if (collapsity eq 2) then do;
	    p1=1/(1+exp(-(z1+TRT1+zbeta)));
		p2=1/(1+exp(-(z2+TRT1+zbeta)))-1/(1+exp(-(z1+TRT1+zbeta)));
		p3=1/(1+exp(-(z3+TRT1+zbeta)))-1/(1+exp(-(z2+TRT1+zbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+zbeta)));
	  	loglik=y1*log(p1)+(y2+y3+y4)*log(p2+p3+p4)+coeffi;
	  end;
	  else do;
	    p1=1/(1+exp(-(z1+TRT1+zbeta)));
		p2=1/(1+exp(-(z2+TRT1+zbeta)))-1/(1+exp(-(z1+TRT1+zbeta)));
		p3=1/(1+exp(-(z3+TRT1+zbeta)))-1/(1+exp(-(z2+TRT1+zbeta)));
		p4=1-1/(1+exp(-(z3+TRT1+zbeta)));
	    loglik=y1*log(p1)+y2*log(p2)+y3*log(p3)+y4*log(p4)+coeffi;
	  end;

	  model y1~general(loglik);
	  random mu_k~normal(0,1) subject=K;
	  ods output ParameterEstimates=_para_est FitStatistics=_fit AdditionalEstimates=_pair_comp;

	  estimate 'Infliximab-Vedolizumab 300mg'   		T3-T6;
      estimate 'Infliximab-Ustakinumab 6mg/kg'  		T3-T5;
	  estimate 'Infliximab-Natalizumab 300mg'   		T3-T4;
	  estimate 'Infliximab-Adalimumab'  		  		T3-T1;
	  estimate 'Infliximab-Certolizumab 400mg'  		T3-T2;
      estimate 'Vedolizumab 300mg-Ustakinumab 6mg/kg'	T6-T5;
      estimate 'Vedolizumab 300mg-Natalizumab 300mg' 	T6-T4;
      estimate 'Vedolizumab 300mg-Adalimumab' 	 	 	T6-T1;
      estimate 'Vedolizumab 300mg-Certolizumab 400mg'  	T6-T2;
      estimate 'Ustakinumab 6mg/kg-Natalizumab 300mg'  	T5-T4;
      estimate 'Ustakinumab 6mg/kg-Adalimumab' 	 	 	T5-T1;
      estimate 'Ustakinumab 6mg/kg-Certolizumab 400mg' 	T5-T2;
      estimate 'Natalizumab 300mg-Adalimumab' 		 	T4-T1;
      estimate 'Natalizumab 300mg-Certolizumab 400mg'  	T4-T2;
      estimate 'Adalimumab-Certolizumab 400mg'  		T1-T2;

      predict p1 out=p1;  	/*prob(resp<70)for non-collapsed groups*/
      predict p2 out=p2;   	/*prob(70<=resp<100) for non-collapsed groups */
      predict p3 out=p3;   	/*prob(100<=resp<remission) for non-collapsed groups */
      predict p4 out=p4;   	/*prob(resp=remission) for non-collapsed groups */
    run;
  %end;
  %else %if &Model=2 %then %do;
    proc nlmixed data=Crohn;
  	  parms eta1=0.58 eta2=0.47 eta3=0.7 phi0=-1.0
          beta1=0.5 beta2=-0.1 beta3=0.7 beta4=1.1 beta5=0.01
		  T1=-0.40 T2=-0.31 T3=-1.9 T4=-0.68 T5=-0.8 T6=-0.86;
      bounds eta2>0,eta3>0;

	  zbeta=exp(phi0);
	  xbeta=beta1*AGE+beta2*Pmale+beta3*CDAIscore+beta4*year+beta5*PantiTNF+zbeta*mu_k;
	  z1=eta1;
	  z2=z1+eta2;
	  z3=z2+eta3;
	  TRT1=T1*(TRT=1)+T2*(TRT=2)+T3*(TRT=3)+T4*(TRT=4)+T5*(TRT=5)+T6*(TRT=6);
	
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
	  ods output ParameterEstimates=_para_est FitStatistics=_fit AdditionalEstimates=_pair_comp;

	  estimate 'Infliximab-Vedolizumab 300mg'   		T3-T6;
      estimate 'Infliximab-Ustakinumab 6mg/kg'  		T3-T5;
	  estimate 'Infliximab-Natalizumab 300mg'   		T3-T4;
	  estimate 'Infliximab-Adalimumab'  		  		T3-T1;
	  estimate 'Infliximab-Certolizumab 400mg'  		T3-T2;
      estimate 'Vedolizumab 300mg-Ustakinumab 6mg/kg'	T6-T5;
      estimate 'Vedolizumab 300mg-Natalizumab 300mg' 	T6-T4;
      estimate 'Vedolizumab 300mg-Adalimumab' 	 	 	T6-T1;
      estimate 'Vedolizumab 300mg-Certolizumab 400mg'  	T6-T2;
      estimate 'Ustakinumab 6mg/kg-Natalizumab 300mg'  	T5-T4;
      estimate 'Ustakinumab 6mg/kg-Adalimumab' 	 	 	T5-T1;
      estimate 'Ustakinumab 6mg/kg-Certolizumab 400mg' 	T5-T2;
      estimate 'Natalizumab 300mg-Adalimumab' 		 	T4-T1;
      estimate 'Natalizumab 300mg-Certolizumab 400mg'  	T4-T2;
      estimate 'Adalimumab-Certolizumab 400mg'  		T1-T2;

      predict p1 out=p1;  	/*prob(resp<70)for non-collapsed groups*/
      predict p2 out=p2;   	/*prob(70<=resp<100) for non-collapsed groups */
      predict p3 out=p3;   	/*prob(100<=resp<remission) for non-collapsed groups */
      predict p4 out=p4;   	/*prob(resp=remission) for non-collapsed groups */
    run;
  %end;
  %else %if &Model=3 %then %do;
    proc nlmixed data=Crohn;
	  parms eta1=0.53 phi0=-3 phi1=-1
		  beta1=0.25 beta2=0.15 beta3=0.22 beta4=0.12 beta5=0.06
		  alpha20=-4.15 alpha21=-0.48 alpha22=2.1 alpha23=2.0 alpha24=-1.4 alpha25=-2.2
		  alpha30=0.05 alpha31=-0.08 alpha32=-0.31 alpha33=0.40 alpha34=0.10 alpha35=0.34
          T1=-0.50 T2=-0.31 T3=-2.21 T4=-0.78 T5=-0.70 T6=-1.3;
    
	  zbeta=exp(phi0+phi1*year)*mu_k;
	  xbeta=beta1*AGE+beta2*Pmale+beta3*CDAIscore+beta4*year+beta5*PantiTNF+zbeta;
	  z1=eta1;
	  z2=z1+exp(alpha20+alpha21*Age+alpha22*Pmale+alpha23*CDAIscore+alpha24*year+alpha25*PantiTNF);
	  z3=z2+exp(alpha30+alpha31*Age+alpha32*Pmale+alpha33*CDAIscore+alpha34*year+alpha35*PantiTNF);
	  TRT1=T1*(TRT=1)+T2*(TRT=2)+T3*(TRT=3)+T4*(TRT=4)+T5*(TRT=5)+T6*(TRT=6);
	
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
	  ods output ParameterEstimates=_para_est FitStatistics=_fit AdditionalEstimates=_pair_comp;

	  estimate 'Infliximab-Vedolizumab 300mg'   		T3-T6;
      estimate 'Infliximab-Ustakinumab 6mg/kg'  		T3-T5;
	  estimate 'Infliximab-Natalizumab 300mg'   		T3-T4;
	  estimate 'Infliximab-Adalimumab'  		  		T3-T1;
	  estimate 'Infliximab-Certolizumab 400mg'  		T3-T2;
      estimate 'Vedolizumab 300mg-Ustakinumab 6mg/kg'	T6-T5;
      estimate 'Vedolizumab 300mg-Natalizumab 300mg' 	T6-T4;
      estimate 'Vedolizumab 300mg-Adalimumab' 	 	 	T6-T1;
      estimate 'Vedolizumab 300mg-Certolizumab 400mg'  	T6-T2;
      estimate 'Ustakinumab 6mg/kg-Natalizumab 300mg'  	T5-T4;
      estimate 'Ustakinumab 6mg/kg-Adalimumab' 	 	 	T5-T1;
      estimate 'Ustakinumab 6mg/kg-Certolizumab 400mg' 	T5-T2;
      estimate 'Natalizumab 300mg-Adalimumab' 		 	T4-T1;
      estimate 'Natalizumab 300mg-Certolizumab 400mg'  	T4-T2;
      estimate 'Adalimumab-Certolizumab 400mg'  		T1-T2;

      predict p1 out=p1;  /*prob(resp<70)for non-collapsed groups*/
      predict p2 out=p2;   /*prob(70<=resp<100) for non-collapsed groups */
      predict p3 out=p3;   /*prob(100<=resp<remission) for non-collapsed groups */
      predict p4 out=p4;   /*prob(resp=remission) for non-collapsed groups */

    run;
  %end;
%end;

proc transpose data=_fit out=_fit2;
  var value;
  id Descr;
run;

data _fit(rename=(_2_Log_Likelihood=Loglik AIC__smaller_is_better_=AIC AICC__smaller_is_better_=AICC BIC__smaller_is_better_=BIC));
  set _fit2;
run;

/* Section 4: Model dianostics */
data test1(keep=K TRT collapsity Samplesize p1_est Pred1 y1);
	set p1;
	Samplesize=0;
	Samplesize=y1+y2+y3+y4;
	p1_est=y1/Samplesize;
	Pred1=Pred;
run;

data test2(keep=K TRT collapsity Samplesize p2_est Pred2 y2);
	set p2;
	Samplesize=0;
	Samplesize=y1+y2+y3+y4;
	p2_est=y2/Samplesize;
	Pred2=Pred;
run;

data test3(keep=K TRT collapsity Samplesize p3_est Pred3 y3);
	set p3;
	Samplesize=0;
	Samplesize=y1+y2+y3+y4;
	p3_est=y3/Samplesize;
	Pred3=Pred;
run;

data test4(keep=K TRT collapsity Samplesize p4_est Pred4 y4);
	set p4;
	Samplesize=0;
	Samplesize=y1+y2+y3+y4;
	p4_est=y4/Samplesize;
	Pred4=Pred;
run;

data test;
	merge test1 test2 test3 test4;
	by K;
run;

data test2;
  set test;
  N=_n_;
run;

%do s=1 %to 20;
  data temp&s;
    set test2;
    if N=&s then output;
  run;

  proc iml;
	use temp&s;
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
		%if &Amatrix=1 %then %do;
		  A={1 0 0 0, 0 1 0 0, 0 0 1 0};
        %end;
		%else %if &Amatrix=2 %then %do;
		  A={1 0 0 -1,0 1 0 -1,0 0 1 -1};
		%end;
		%else %do;		
		  A={1 -1 0 0, 1 0 -1 0, 1 0 0 -1};
        %end;
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
		%if &Amatrix=1 %then %do;
		  A={1 0 0, 0 1 0};
		%end;
		%else %if &Amatrix=2 %then %do;
		  A={1 0 -1, 0 1 -1};
		%end;
		%else %do;
		  A={1 -1 0, 1 0 -1};
        %end;
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
		%if &Amatrix=1 %then %do;
		  A={1 0 0, 0 1 0};
		%end;
		%else %if &Amatrix=2 %then %do;
		  A={1 0 -1, 0 1 -1};
		%end;
		%else %do;
		  A={1 -1 0, 1 0 -1};
        %end;
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
		%if &Amatrix=1 %then %do;
		  A={1 0};
		%end;
		%else %do;
          A={1 -1};
        %end;
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

    OUT1=resid;
	OUT2=X2stat;
	OUT3=pval;

    create stat1 from OUT1[colname="Residual"];
	append from OUT1;
	close stat1;

	create stat2 from OUT2[colname="X2stat"];
	append from OUT2;
	close stat2;

    create stat3 from OUT3[colname="Pvalue"];
	append from OUT3;
	close stat3;

  quit;

  data OUT&s;
    set stat1 stat2 stat3;
    N=&s;
  run;

  data out_X;
    set OUT&s;
    if X2stat=. then delete;
    ID=N;
    drop residual Pvalue N;
  run;

  data out_P;
    set OUT&s;
    if Pvalue=. then delete;
    ID=N;
    drop residual X2stat N;
  run;

  data out_R;
    set OUT&s;
    if Residual=. then delete;
    drop Pvalue X2stat N;
  run;

  proc transpose data=out_R out=out_R (drop=_name_);
  run;

  data out_R;
    set out_R;
    ID=&s;
  run;

  data out_new&s;
    merge out_X out_P out_R;
    by ID;
  run;
%end;

/* Residuals plots */
data OUT;
  set out_new1-out_new20;
run;

data OUT;
  set OUT;
  N=_n_;
  if (mod(N,2) eq 0) then Group="TRT";
  else Group="PLB";
  Trial=round(N/2,1);
run;

/* Treatment Ranking: P-score Approach */
proc iml;
  use _pair_comp;
  read all var {"Estimate" "StandardError"};

  Pmat=j(15,1,0);
  Pmat=Estimate/StandardError;
  TPmat=Pmat`;
  ProbD=CDF('NORMAL',TPmat);
  PvalD=2*(1-CDF('NORMAL',abs(TPmat)));
  nT=6;

  temp1=j(nT,nT,0);
  temp2=j(nT,nT,0);
  cnt=1;
  do i=1 to nT-1;
    j=nT-i;
	temp1[i,i+1:nT]=TPmat[,cnt:cnt+j-1];
	temp2[i,i+1:nT]=PvalD[,cnt:cnt+j-1];
	cnt=cnt+j;
  end;

  PscoreMat=j(nT,nT,0);
  do i=1 to nT;
    do j=1 to nT;
	  if (temp1[i,j]>=0) then
	    PscoreMat[i,j]=temp2[i,j]/2;
	  else 
	    PscoreMat[i,j]=1-temp2[i,j]/2;
	end;
  end;

  do i=1 to nT;
    do j=1 to nT;
	  if (i=j) then
	    PscoreMat[i,j]=PscoreMat[i,j];
	  else
	    PscoreMat[j,i]=1-PscoreMat[i,j];
	end;
  end;

  RowSum=PscoreMat[,+];
  Pscore=round(RowSum/(nT-1),0.001);
  Pscore=Pscore`;

  create stat4 from Pscore;
  append from Pscore;
  close stat4;

quit;

data stat4(rename=(COL1=Infliximab
                   COL2=Vedolizumab
                   COL3=Ustekinumab
                   COL4=Natalizumab
                   COL5=Adalimumab
                   COL6=Certolizumab));
  set stat4;
run;

/* Create all relevant outputs to RTF files */
ods rtf file="RESULT.rtf" bodytitle;

proc report data=_para_est nowd center split='|' headline headskip 

	style(report)=[font_face='Times New Roman' font_size=10pt] 
    style(column)=[font_face='Times New Roman' font_size=10pt]
    style(lines) =[font_face='Times New Roman' font_size=10pt just=c font_weight=bold foreground=black background=GRAYB8];

    columns Parameter Estimate StandardError Probt Lower Upper;
	define  Parameter / "Parameters"			 	display;
	define  Estimate  / "Estimates"            	 	display format=comma8.3;
	define  StandardError / "SE" 	       	 		display format=comma8.3;
	define  Probt / "P-value"						display format=comma8.3;
	define  Lower / "95% LCI" 		       	 		display format=comma8.3;
	define  Upper / "95% UCI" 		       	 		display format=comma8.3;
    title 'Parameter Estimates';

run;

proc report data=_fit nowd center split='|' headline headskip 

	style(report)=[font_face='Times New Roman' font_size=10pt] 
    style(column)=[font_face='Times New Roman' font_size=10pt]
    style(lines) =[font_face='Times New Roman' font_size=10pt just=c font_weight=bold foreground=black background=GRAYB8];

    columns loglik AIC AICC BIC;	
	define  loglik / "-2Loglik"						display format=comma8.2;
	define  AIC  /   "AIC" 	          	 	 		display format=comma8.2;
	define  AICC  /  "AICC"           	 	 		display format=comma8.2;
	define  BIC  /   "BIC" 	          	 	 		display format=comma8.2;
    title 'Model Assessment Criteria';

run;

proc report data=_pair_comp nowd center split='|' headline headskip 

	style(report)=[font_face='Times New Roman' font_size=10pt] 
    style(column)=[font_face='Times New Roman' font_size=10pt]
    style(lines) =[font_face='Times New Roman' font_size=10pt just=c font_weight=bold foreground=black background=GRAYB8];

    columns Label Estimate StandardError Probt Lower Upper;
	define  Label / "Mean differences"			 	display;
	define  Estimate  / "Estimates" 	       	 	display format=comma8.3;
	define  StandardError / "SE" 	       	 		display format=comma8.3;
	define  Probt / "P-value"						display format=comma8.3;
	define  Lower / "95% LCI" 		         		display format=comma8.3;
	define  Upper / "95% UCI" 		         		display format=comma8.3;
    title 'Pairwise Comparisons';

run;

proc report data=OUT nowd center split='|' headline headskip 

	style(report)=[font_face='Times New Roman' font_size=10pt] 
    style(column)=[font_face='Times New Roman' font_size=10pt]
    style(lines) =[font_face='Times New Roman' font_size=10pt just=c font_weight=bold foreground=black background=GRAYB8];

    columns Trial Group X2stat Pvalue COL1 COL2 COL3;
	define  Trial / "Study"							display;
	define  Group / "Arm"							display;
	define  X2stat  / "Chi-square test Statistic"	display format=comma8.3;
	define  Pvalue / "P-value" 	                	display format=comma8.3;
	define  COL1 / "Resid1" 	                	display format=comma8.3;
	define  COL2 / "Resid2" 	                	display format=comma8.3;
	define  COL3 / "Resid3" 	                	display format=comma8.3;
    title 'Model Diagnostics';

run;

ods graphics / height=3in width=4in attrpriority=none;
proc sgplot data=OUT;

  title 'Pearson Residuals Plot by Trial';
  styleattrs
  	datasymbols=(CircleFilled TriangleFilled)
    datacontrastcolors=(green purple);
  scatter x=Trial y=COL1 / group=Group markerattrs=(size=8px);  
  scatter x=Trial y=COL2 / group=Group markerattrs=(size=8px); 
  scatter x=Trial y=COL3 / group=Group markerattrs=(size=8px);
  yaxis values=(-5 to 5 by 1) label="Pearson Residuals";
  xaxis values=(1 to 10 by 1) label="Trial";
  refline -3 / axis=y lineattrs=(color=blue pattern=Dot);
  refline  3 / axis=y lineattrs=(color=blue pattern=Dot);
  
run;

proc sgplot data=OUT;

  title 'P-values Plot for the Goodness-of-fit';
  styleattrs
  	datasymbols=(CircleFilled TriangleFilled)
    datacontrastcolors=(green purple);
  scatter x=Trial y=Pvalue / group=Group markerattrs=(size=8px);  
  yaxis values=(0 to 1 by 0.1) label="P-value";
  xaxis values=(1 to 10 by 1) label="Trial";
  refline 0.05/ axis=y lineattrs=(color=blue pattern=Dot);

run;

proc report data=stat4 nowd center split='|' headline headskip 

	style(report)=[font_face='Times New Roman' font_size=10pt] 
    style(column)=[font_face='Times New Roman' font_size=10pt]
    style(lines) =[font_face='Times New Roman' font_size=10pt just=c font_weight=bold foreground=black background=GRAYB8];

    columns Adalimumab Certolizumab Infliximab Natalizumab Ustekinumab Vedolizumab;
	define Adalimumab 	/ style(column)={cellwidth=1.0in};
	define Certolizumab / style(column)={cellwidth=1.0in};
	define Infliximab 	/ style(column)={cellwidth=1.0in};
	define Natalizumab 	/ style(column)={cellwidth=1.0in};
	define Ustekinumab 	/ style(column)={cellwidth=1.0in};
	define Vedolizumab 	/ style(column)={cellwidth=1.0in};
    title 'P-Score for Treatment Ranking';

run;

ods rtf close;

%mend NMAOrdinal;
