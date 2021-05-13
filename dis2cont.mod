&!==========================================================================
&!
&! Module       : dis2cont
&! Function     : create blended continuous records from discontinous gathers
&! 		: 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : blending, discontinuous, continuous 
&! Author       : C. Willacy, G. Chang
&! Date         : 03-Aug-2020 
&!
&!==========================================================================
& module dis2cont(             			&
&	wavelet_t0	: integer=0,		&! wavelet time start in ms
&	tmax_in		: integer=10000,	&! length of input trace 
&	tmax_cont	: integer=8000,		&! length of output trace (continuous record) 
&	dt		: integer=4		&! sample interval (ms) 
& )
INFO  ======================================================================
INFO  ================================================
INFO  START OF DIS2CONT SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
& integer  num_copy = round((float(tmax_in)/float(tmax_cont))+0.49999999)+2
INFO
& sub(#1, i0) num_copy
INFO  num_copy = #1
INFO
HHCORR
& sub(@13,i0) -wavelet_t0
& sub(@25,i0) tmax_in
HHCHAN  TMIN        TMAX      
INFO
THMANI
& sub(#1,i0) -wavelet_t0
THEXPR TMIN = #1;
& sub(#1,i0) tmax_in
THEXPR TMAX = #1
INFO
INFO  TIME is in unit of 0.1msec, DATE is in unit of 100sec
INFO  TIME is 6 digits, DATE is 6 digits
INFO  
INFO  taper the TMIN and TMAX a little bit before blending
INFO
THMANI
& sub(#1,i0) tmax_in
THEXPR TMAX   = #1;
& sub(@13,i6) 400/dt
BLAPLY  TMAX
& sub(@13,i6) 400/dt
BLAPLY  INIT
INFO
SRTALLSHTLIN SHTPT   ASC   ASC      500000MEMTRA
INFO
INFO  make several copies of input trace to prepare cut
INFO  RECST is the trace number in continuous record
INFO
& sub(@7,i6) num_copy
REPEAT
THMANI
THEXPR SUBTYP = CURRPT ;
INFO
INFO  create a trace ident for the continuous record from 
INFO  the firing time (in seconds), in 1000ms chunks 
INFO
& sub(#1,i0) tmax_cont/1000
THEXPR RECST  = (DATE   * 100 + TIME  / 10000) / #1 + SUBTYP - 1;
INFO
INFO  output some information to the log
INFO
THLIST              1000
THMNE SHTLIN SHTPT  DATE  TIME RECSTSUBTYP
INFO
INFO  shift
INFO
THMANI
INFO
INFO  create a BINNUM (time window) relative to the current time
INFO  for each gather 
INFO  
& sub(#1,i0) tmax_cont/1000
THEXPR BINNUM = (DATE  * 100 - RECST * #1)*10000 + TIME  ;
&! convert to milliseconds before applying static shift
THEXPR STATX = BINNUM / 10 ;
&! define the fractional time shift portion
THEXPR T143  = (BINNUM - STATX * 10) * 100000 ;
& sub(#1,i0) tmax_in
THEXPR TMAX   = #1;
INFO  calculate some extra idents to use for qc later
THEXPR SKLPR7 = nint(REAL(T143)/100000.);
THEXPR SKLPR8 = SCRAT9 + STATX + SKLPR7;
INFO
THLIST              1000
THMNE SHTLIN SHTPT  DATE  TIME RECSTBINNUM STATX  T143
INFO
STAPLY   PRE             LMS73  T143
INFO
INFO  cut new trace length
INFO
& sub(@13,i6) tmax_cont-dt
TRCLEN     0
THMANI
& sub(#1,i0) tmax_cont-dt
THEXPR TMAX   = #1;
THEXPR TMIN   = 0
INFO
HHCORR
& sub(@25,i0) tmax_cont-dt
HHCHAN  TMIN     0  TMAX     
INFO
INFO  blend
INFO
SRTALLRECLIN RECPT   ASC           5000000 TRACE
SORBAD RECST
INFO
SUMMIT     0RECLIN RECPT RECST
INFO
INFO  insert necessary idents
INFO  update DATE and TIME with the new binned values
INFO
THMANI
& sub(#1,i0) tmax_cont/1000
THEXPR DATE  = RECST * #1/100;
& sub(#1,i0) tmax_cont/1000
THEXPR TIME  = (RECST * #1 - DATE  * 100)*10000 ;
INFO  ================================================
INFO  END OF DIS2CONT SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
