&!==========================================================================
&!
&! Module       : findcrec 
&! Function     : find the trace number in the continuous record for each shot
&! 		: 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : blending, discontinous, continuous 
&! Author       : C. Willacy, G. Chang
&! Date         : 03-Aug-2020 
&!
&!==========================================================================
& module findcrec(             			&
&	tmax_out	: integer=8000,		&! length of output trace (continuous record) 
&	sqsort_maxrec	: integer=100		&
& )
INFO  ================================================
INFO  START OF FINDCREC SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
INFO  RECST is the trace number in continuous record
INFO  find the trace number in continuous record for each shot
SQMANI  EXPR
SQEXPR SHTST = 1.;
SQEXPR RECST = anint(( DATE * 100.
& sub(#1,f0) float(tmax_out/1000)
SQEXPR         + TIME  /10000.)/#1+0.4999999)  - 1.0;
INFO
& sub(@67,i6) sqsort_maxrec
SQSORT RECST   ASC                                                          80
INFO
INFO  ================================================
INFO  END OF FINDCREC SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
