&!==========================================================================
&!
&! Module       : cont2dis
&! Function     : create discontinous records from continuous gathers
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
& module cont2dis(             			&
&	wavelet_t0	: integer=0,		&! wavelet time start in ms
&	tmax_in		: integer=10000,	&! length of input trace 
&	tmax_cont	: integer=8000,		&! length of output trace (continuous record) 
&	reciprocity	: boolean=false,	&! reapply reciporcity on output 
&	dt		: integer=4		&! sample interval (ms) 
& )
INFO  ======================================================================
INFO  ================================================
INFO  START OF CONT2DIS SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
& integer  num_copy = round((float(tmax_in)/float(tmax_cont))+0.49999999)+3
INFO
& sub(#1, i0) num_copy
INFO  num_copy = #1
INFO
INFO  repeat each shot several times
& sub(@7,i6) num_copy
REPEAT
THMANI
THEXPR SUBTYP = CURRPT ;
THEXPR RECST  = RECST - (SUBTYP - 1);
INFO
INFO  make each continuous record longer
& sub(@13,i6) tmax_cont*num_copy
TRCLEN     0
THMANI
& sub(#1,i0) tmax_cont*num_copy
THEXPR TMAX   = #1;
THEXPR BLKINI = 0;
& sub(#1,i0) tmax_cont
THEXPR STATX  = #1 * (SUBTYP - 1);
THEXPR T143   = 0;
INFO
STAPLY   PRE             LMS73  T143
INFO
INFO  blend
INFO  SORBET RECST         ASC        1000  1000                        STOPAR
SRTALL RECST                          5000    MB
SUMMIT     0RECST
INFO
INFO  only select continuous record which has the start of shot record
DSCIN                   sht_recst-*.saf
SQSAF 999999                              NOEXEC
INFO  
INFO  TIME is in unit of 0.1msec, DATE is in unit of 100sec
INFO  TIME is 6 digits, DATE is 6 digits 
INFO
SQXFERRECST RECST                                     REJDUPASCASC      REIDNT
SQXSOR                        200000
SAFSETSHTLIN SHTPT SHTST  DATE  TIME
THSET SHTLIN SHTPT SHTST  DATE  TIME
INFO
INFO  then perform the cut to discontinuous records
INFO
THLIST             20000
THMNE  SHTSTSHTLIN SHTPT  DATE  TIME
INFO
INFO  shift back to ensure each trace start from time 0 of each shot
THMANI
& sub(#1,i0) tmax_cont/1000
THEXPR BINNUM = (RECST * #1 - DATE * 100)*10000 - TIME  ;
THEXPR STATX = BINNUM/ 10 ;
THEXPR T143  = (BINNUM- STATX * 10) * 100000 ;
THEXPR BLKINI = 0;
STAPLY   PRE             LMS73  T143
INFO
INFO  cut to shot record length
& sub(@13,i6) tmax_in
TRCLEN     0
THMANI
& sub(#1,i0) tmax_in
THEXPR TMAX   = #1;
INFO
DSCIN                   sht_recst-*.saf
SQSAF 999999                              NOEXEC
INFO  
THLIST             20000
THMNE  SHTSTSHTLIN SHTPT  DATE  TIME
INFO
SQXFERSHTLINSHTLIN SHTPT SHTPT                        REJIGNMEMMEM      REIDNT
SQXSOR                       1000000
SAFSET  XSHT  YSHT  ZSHT  XREC  YREC  ZREC
THSET   XSHT  YSHT  ZSHT  XREC  YREC  ZREC
INFO
INFO  define some additional idents for later use
INFO
THMANI
THEXPR XSHTST = XSHT   ;
THEXPR XRECST = XREC   ;
THEXPR YSHTST = YSHT   ;
THEXPR YRECST = YREC   ;
THEXPR ZSHTST = ZSHT   ;
THEXPR ZRECST = ZREC   ;
THEXPR SHOTDP = ZSHT   ;
THEXPR RCVRDP = ZREC   ;
THEXPR XDISTX = XSHT   - XREC   ;
THEXPR XDISTY = YSHT   - YREC   ;
INFO  THEXPR XDIST  = sqrt((nint(real(XDISTX)/10.0))^2+(nint(real(XDISTY)/10.0))^2);
INFO
INFO  ================================================
INFO  END OF CONT2DIS SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
