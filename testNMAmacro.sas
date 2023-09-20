/**********************************************************************************/
/*** Scenario I: All remission is from 100 response 						   ****/
/**********************************************************************************/
data Crohn1;
input Product $ 1-15 K Trt Response Count collapsity Age CDAI year male antiTNF;
datalines;
Adalimumab      1   0   1   47  0   37      296     2006    37 100
Adalimumab      1   0   2   8   0   37      296     2006    37 100
Adalimumab      1   0   3   10  0   37      296     2006    37 100
Adalimumab      1   0   4   9   0   37      296     2006    37 100
Adalimumab      1   1   1   31  0   39      295     2006    36 100
Adalimumab      1   1   2   7   0   39      295     2006    36 100
Adalimumab      1   1   3   10  0   39      295     2006    36 100
Adalimumab      1   1   4   28  0   39      295     2006    36 100
Adalimumab      2   0   1   110 0   37      313     2007    65  0
Adalimumab      2   0   2   15  0   37      313     2007    65  0
Adalimumab      2   0   3   29  0   37      313     2007    65  0
Adalimumab      2   0   4   12  0   37      313     2007    65  0
Adalimumab      2   1   1   77  0   39      313     2007    50  0
Adalimumab      2   1   2   21  0   39      313     2007    50  0
Adalimumab      2   1   3   27  0   39      313     2007    50  0
Adalimumab      2   1   4   34  0   39      313     2007    50  0
Certolizumab    3   0   1   200 0   38      297     2007    131 74.1
Certolizumab    3   0   2   33  0   38      297     2007    131 74.1
Certolizumab    3   0   3   33  0   38      297     2007    131 74.1
Certolizumab    3   0   4   62  0   38      297     2007    131 74.1
Certolizumab    3   2   1   189 0   37      300     2007    157 69.8
Certolizumab    3   2   2   26  0   37      300     2007    157 69.8
Certolizumab    3   2   3   37  0   37      300     2007    157 69.8
Certolizumab    3   2   4   79  0   37      300     2007    157 69.8
Infliximab      4   0   1   20  1   38.5    288     1997    15  100
Infliximab      4   0   2   0   1   38.5    288     1997    15  100
Infliximab      4   0   3   3   1   38.5    288     1997    15  100
Infliximab      4   0   4   1   1   38.5    288     1997    15  100
Infliximab      4   3   1   5   1   37      312     1997    14  100
Infliximab      4   3   2   0   1   37      312     1997    14  100
Infliximab      4   3   3   13   1   37      312     1997    14  100
Infliximab      4   3   4   9  1   37      312     1997    14  100
Natalizumab     5   0   1   90  1   39      303     2005    73  61.9
Natalizumab     5   0   2   0   1   39      303     2005    73  61.9
Natalizumab     5   0   3   40  1   39      303     2005    73  61.9
Natalizumab     5   0   4   51  1   39      303     2005    73  61.9
Natalizumab     5   4   1   311 1   38      302     2005    311 59.8
Natalizumab     5   4   2   0   1   38      302     2005    311 59.8
Natalizumab     5   4   3   167 1   38      302     2005    311 59.8
Natalizumab     5   4   4   246 1   38      302     2005    311 59.8
Natalizumab     6   0   1   150 0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   2   17  0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   3   30  0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   4   53  0   37.7    299.5   2007    102 55.2
Natalizumab     6   4   1   114 0   38.1    303.9   2007    105 49.8
Natalizumab     6   4   2   21  0   38.1    303.9   2007    105 49.8
Natalizumab     6   4   3   41  0   38.1    303.9   2007    105 49.8
Natalizumab     6   4   4   83  0   38.1    303.9   2007    105 49.8
Ustekinumab     7   0   1   99  2   39.5    312.4   2012    64  0
Ustekinumab     7   0   2   0  	2   39.5    312.4   2012    64  0
Ustekinumab     7   0   3   0   2   39.5    312.4   2012    64  0
Ustekinumab     7   0   4   33  2   39.5    312.4   2012    64  0
Ustekinumab     7   5   1   58  2   39.4    338     2012    48  0
Ustekinumab     7   5   2   0  	2   39.4    338     2012    48  0
Ustekinumab     7   5   3   0  	2   39.4    338     2012    48  0
Ustekinumab     7   5   4   73	2   39.4    338     2012    48  0
Ustekinumab     8   0   1   175 1   36      313     2015    118  0.4
Ustekinumab     8   0   2   0  	1   36      313     2015    118  0.4
Ustekinumab     8   0   3   54  1   36      313     2015    118  0.4
Ustekinumab     8   0   4   18  1   36      313     2015    118  0.4
Ustekinumab     8   5   1   130 1   36      319     2015    101  1.2
Ustekinumab     8   5   2   0  	1   36      319     2015    101  1.2
Ustekinumab     8   5   3   67  1   36      319     2015    101  1.2
Ustekinumab     8   5   4   52  1   36      319     2015    101  1.2
Vedolizumab     9   0   1   0   -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   2   110 -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   3   28  -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   4   10  -1  38.6    325     2013    69  51.4
Vedolizumab     9   6   1   0   -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   2   151 -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   3   37  -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   4   32  -1  36.3    327     2013    105 49.5
Vedolizumab     10  0   1   0   -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   2   157 -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   3   23  -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   4   27  -1  34.8    301.3   2014    89  76
Vedolizumab     10  6   1   0   -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   2   109 -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   3   40  -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   4   60  -1  36.9    313.9   2014    91  76
;
run;



/**********************************************************************************/
/*** Scenario II: All remission is from 70 response 						   ****/
/**********************************************************************************/
data Crohn2;
input Product $ 1-15 K Trt Response Count collapsity Age CDAI year male antiTNF;
datalines;
Adalimumab      1   0   1   47  0   37      296     2006    37 100
Adalimumab      1   0   2   0   0   37      296     2006    37 100
Adalimumab      1   0   3   18  0   37      296     2006    37 100
Adalimumab      1   0   4   9   0   37      296     2006    37 100
Adalimumab      1   1   1   31  0   39      295     2006    36 100
Adalimumab      1   1   2   0   0   39      295     2006    36 100
Adalimumab      1   1   3   17  0   39      295     2006    36 100
Adalimumab      1   1   4   28  0   39      295     2006    36 100
Adalimumab      2   0   1   110 0   37      313     2007    65  0
Adalimumab      2   0   2   3   0   37      313     2007    65  0
Adalimumab      2   0   3   41  0   37      313     2007    65  0
Adalimumab      2   0   4   12  0   37      313     2007    65  0
Adalimumab      2   1   1   77  0   39      313     2007    50  0
Adalimumab      2   1   2   0   0   39      313     2007    50  0
Adalimumab      2   1   3   48  0   39      313     2007    50  0
Adalimumab      2   1   4   34  0   39      313     2007    50  0
Certolizumab    3   0   1   200 0   38      297     2007    131 74.1
Certolizumab    3   0   2   0   0   38      297     2007    131 74.1
Certolizumab    3   0   3   66  0   38      297     2007    131 74.1
Certolizumab    3   0   4   62  0   38      297     2007    131 74.1
Certolizumab    3   2   1   189 0   37      300     2007    157 69.8
Certolizumab    3   2   2   0   0   37      300     2007    157 69.8
Certolizumab    3   2   3   63  0   37      300     2007    157 69.8
Certolizumab    3   2   4   79  0   37      300     2007    157 69.8
Infliximab      4   0   1   20  1   38.5    288     1997    15  100
Infliximab      4   0   2   0   1   38.5    288     1997    15  100
Infliximab      4   0   3   3   1   38.5    288     1997    15  100
Infliximab      4   0   4   1   1   38.5    288     1997    15  100
Infliximab      4   3   1   5   1   37      312     1997    14  100
Infliximab      4   3   2   0   1   37      312     1997    14  100
Infliximab      4   3   3   13  1   37      312     1997    14  100
Infliximab      4   3   4   9   1   37      312     1997    14  100
Natalizumab     5   0   1   90  1   39      303     2005    73  61.9
Natalizumab     5   0   2   0   1   39      303     2005    73  61.9
Natalizumab     5   0   3   40  1   39      303     2005    73  61.9
Natalizumab     5   0   4   51  1   39      303     2005    73  61.9
Natalizumab     5   4   1   311 1   38      302     2005    311 59.8
Natalizumab     5   4   2   0   1   38      302     2005    311 59.8
Natalizumab     5   4   3   167 1   38      302     2005    311 59.8
Natalizumab     5   4   4   246 1   38      302     2005    311 59.8
Natalizumab     6   0   1   150 0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   2   0   0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   3   47  0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   4   53  0   37.7    299.5   2007    102 55.2
Natalizumab     6   4   1   114 0   38.1    303.9   2007    105 49.8
Natalizumab     6   4   2   0   0  38.1    303.9   2007    105 49.8
Natalizumab     6   4   3   62  0   38.1    303.9   2007    105 49.8
Natalizumab     6   4   4   83  0   38.1    303.9   2007    105 49.8
Ustekinumab     7   0   1   99  2   39.5    312.4   2012    64  0
Ustekinumab     7   0   2   0  	2   39.5    312.4   2012    64  0
Ustekinumab     7   0   3   0   2   39.5    312.4   2012    64  0
Ustekinumab     7   0   4   33  2   39.5    312.4   2012    64  0
Ustekinumab     7   5   1   58  2   39.4    338     2012    48  0
Ustekinumab     7   5   2   0  	2   39.4    338     2012    48  0
Ustekinumab     7   5   3   0  	2   39.4    338     2012    48  0
Ustekinumab     7   5   4   73	2   39.4    338     2012    48  0
Ustekinumab     8   0   1   175 1   36      313     2015    118  0.4
Ustekinumab     8   0   2   0  	1   36      313     2015    118  0.4
Ustekinumab     8   0   3   54  1   36      313     2015    118  0.4
Ustekinumab     8   0   4   18  1   36      313     2015    118  0.4
Ustekinumab     8   5   1   130 1   36      319     2015    101  1.2
Ustekinumab     8   5   2   0  	1   36      319     2015    101  1.2
Ustekinumab     8   5   3   67  1   36      319     2015    101  1.2
Ustekinumab     8   5   4   52  1   36      319     2015    101  1.2
Vedolizumab     9   0   1   0   -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   2   100 -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   3   38  -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   4   10  -1  38.6    325     2013    69  51.4
Vedolizumab     9   6   1   0   -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   2   119 -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   3   69  -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   4   32  -1  36.3    327     2013    105 49.5
Vedolizumab     10  0   1   0   -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   2   130 -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   3   50  -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   4   27  -1  34.8    301.3   2014    89  76
Vedolizumab     10  6   1   0   -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   2   49  -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   3   100 -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   4   60  -1  36.9    313.9   2014    91  76
;
run;


/**********************************************************************************/
/*** Scenario III: Remission is from both 70 and 100 responses with 50-50	   ****/
/**********************************************************************************/
data Crohn3;
input Product $ 1-15 K Trt Response Count collapsity Age CDAI year male antiTNF;
datalines;
Adalimumab      1   0   1   47  0   37      296     2006    37 100
Adalimumab      1   0   2   4   0   37      296     2006    37 100
Adalimumab      1   0   3   14  0   37      296     2006    37 100
Adalimumab      1   0   4   9   0   37      296     2006    37 100
Adalimumab      1   1   1   31  0   39      295     2006    36 100
Adalimumab      1   1   2   3   0   39      295     2006    36 100
Adalimumab      1   1   3   14  0   39      295     2006    36 100
Adalimumab      1   1   4   28  0   39      295     2006    36 100
Adalimumab      2   0   1   110 0   37      313     2007    65  0
Adalimumab      2   0   2   10  0   37      313     2007    65  0
Adalimumab      2   0   3   34  0   37      313     2007    65  0
Adalimumab      2   0   4   12  0   37      313     2007    65  0
Adalimumab      2   1   1   77  0   39      313     2007    50  0
Adalimumab      2   1   2   10  0   39      313     2007    50  0
Adalimumab      2   1   3   38  0   39      313     2007    50  0
Adalimumab      2   1   4   34  0   39      313     2007    50  0
Certolizumab    3   0   1   200 0   38      297     2007    131 74.1
Certolizumab    3   0   2   16  0   38      297     2007    131 74.1
Certolizumab    3   0   3   50  0   38      297     2007    131 74.1
Certolizumab    3   0   4   62  0   38      297     2007    131 74.1
Certolizumab    3   2   1   189 0   37      300     2007    157 69.8
Certolizumab    3   2   2   13  0   37      300     2007    157 69.8
Certolizumab    3   2   3   50  0   37      300     2007    157 69.8
Certolizumab    3   2   4   79  0   37      300     2007    157 69.8
Infliximab      4   0   1   20  1   38.5    288     1997    15  100
Infliximab      4   0   2   0   1   38.5    288     1997    15  100
Infliximab      4   0   3   3   1   38.5    288     1997    15  100
Infliximab      4   0   4   1   1   38.5    288     1997    15  100
Infliximab      4   3   1   5   1   37      312     1997    14  100
Infliximab      4   3   2   0   1   37      312     1997    14  100
Infliximab      4   3   3   13  1   37      312     1997    14  100
Infliximab      4   3   4   9   1   37      312     1997    14  100
Natalizumab     5   0   1   90  1   39      303     2005    73  61.9
Natalizumab     5   0   2   0   1   39      303     2005    73  61.9
Natalizumab     5   0   3   40  1   39      303     2005    73  61.9
Natalizumab     5   0   4   51  1   39      303     2005    73  61.9
Natalizumab     5   4   1   311 1   38      302     2005    311 59.8
Natalizumab     5   4   2   0   1   38      302     2005    311 59.8
Natalizumab     5   4   3   167 1   38      302     2005    311 59.8
Natalizumab     5   4   4   246 1   38      302     2005    311 59.8
Natalizumab     6   0   1   150 0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   2   8   0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   3   39  0   37.7    299.5   2007    102 55.2
Natalizumab     6   0   4   53  0   37.7    299.5   2007    102 55.2
Natalizumab     6   4   1   114 0   38.1    303.9   2007    105 49.8
Natalizumab     6   4   2   10  0   38.1    303.9   2007    105 49.8
Natalizumab     6   4   3   52  0   38.1    303.9   2007    105 49.8
Natalizumab     6   4   4   83  0   38.1    303.9   2007    105 49.8
Ustekinumab     7   0   1   99  2   39.5    312.4   2012    64  0
Ustekinumab     7   0   2   0  	2   39.5    312.4   2012    64  0
Ustekinumab     7   0   3   0   2   39.5    312.4   2012    64  0
Ustekinumab     7   0   4   33  2   39.5    312.4   2012    64  0
Ustekinumab     7   5   1   58  2   39.4    338     2012    48  0
Ustekinumab     7   5   2   0  	2   39.4    338     2012    48  0
Ustekinumab     7   5   3   0  	2   39.4    338     2012    48  0
Ustekinumab     7   5   4   73	2   39.4    338     2012    48  0
Ustekinumab     8   0   1   175 1   36      313     2015    118  0.4
Ustekinumab     8   0   2   0  	1   36      313     2015    118  0.4
Ustekinumab     8   0   3   54  1   36      313     2015    118  0.4
Ustekinumab     8   0   4   18  1   36      313     2015    118  0.4
Ustekinumab     8   5   1   130 1   36      319     2015    101  1.2
Ustekinumab     8   5   2   0  	1   36      319     2015    101  1.2
Ustekinumab     8   5   3   67  1   36      319     2015    101  1.2
Ustekinumab     8   5   4   52  1   36      319     2015    101  1.2
Vedolizumab     9   0   1   0   -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   2   105 -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   3   33  -1  38.6    325     2013    69  51.4
Vedolizumab     9   0   4   10  -1  38.6    325     2013    69  51.4
Vedolizumab     9   6   1   0   -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   2   135 -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   3   53  -1  36.3    327     2013    105 49.5
Vedolizumab     9   6   4   32  -1  36.3    327     2013    105 49.5
Vedolizumab     10  0   1   0   -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   2   143 -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   3   37  -1  34.8    301.3   2014    89  76
Vedolizumab     10  0   4   27  -1  34.8    301.3   2014    89  76
Vedolizumab     10  6   1   0   -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   2   79  -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   3   70  -1  36.9    313.9   2014    91  76
Vedolizumab     10  6   4   60  -1  36.9    313.9   2014    91  76
;
run;


%include 'C:\Users\yeongjin.gwon\OneDrive - University of Nebraska Medical Center\1. Academics\1. Research\1. SAS macro\NMAmacro\NMAOrdinal.sas';

/* Testing for generating error message */
%NMAOrdinal(CDdata=Crohn1,Model=1,Amatrix=5);
%NMAOrdinal(CDdata=Crohn1,Model=4,Amatrix=2);
%NMAOrdinal(CDdata=Crohn4,Model=3,Amatrix=1);

/* Run model 1 */
%NMAOrdinal(CDdata=Crohn1,Model=1,Amatrix=1);
%NMAOrdinal(CDdata=Crohn2,Model=1,Amatrix=1);
%NMAOrdinal(CDdata=Crohn3,Model=1,Amatrix=1);

/* Run model 2 */
%NMAOrdinal(CDdata=Crohn1,Model=2,Amatrix=1);
%NMAOrdinal(CDdata=Crohn2,Model=2,Amatrix=1);
%NMAOrdinal(CDdata=Crohn3,Model=2,Amatrix=1);

/* Run model 3 */
%NMAOrdinal(CDdata=Crohn1,Model=3,Amatrix=1);
%NMAOrdinal(CDdata=Crohn2,Model=3,Amatrix=1);
%NMAOrdinal(CDdata=Crohn3,Model=3,Amatrix=1);



