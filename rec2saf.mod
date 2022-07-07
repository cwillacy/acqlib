&!==========================================================================
&!
&! Module       : rec2saf
&! Function     : read an SPS receiver file and output SAF 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : SPS, receiver
&! Author       : C. Willacy
&! Date         : 29-July-2020 
&!
&!==========================================================================
& module rec2saf(           	  	&
&  filename         : character,       	&! SPS receiver filename 
&  sqsort_maxrec	: integer=1000	&! memory for sqsort
& )
INFO  ================================================
INFO  START OF REC2SAF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
DSCOUT                  receiver_file                                               
CARDIM ASCII 
& sub(#1,a0) filename
FILNAM$TMPDIR/#1                                                                       
INFO
CON
INFO  --------------------------------------------------
INFO  SIPMAP ident mapping
INFO
INFO  RECPT 	= receiver point number 
INFO  USPAR0 	= receiver code
INFO  RECSTA 	= receiver static correction
INFO  RCVRDP 	= depth of receiver below surface
INFO  RECDTM 	= datum elevation at receiver
INFO  UPHREC 	= uphole time for this receiver group in TUNIT
INFO  WATREC 	= water/weathering depth at receiver 
INFO  XREC 	= X coordinate of receiver 
INFO  YREC 	= Y coordinate of receiver
INFO  ZREC 	= surface evelvation at receiver 
INFO  DATE 	= day of the year
INFO  USPAR2 	= hours
INFO  USPAR3 	= minutes
INFO  USPAR4 	= seconds
INFO
INFO  --------------------------------------------------
DSCIN                   receiver_file                                               
UKTOPO ASCII  SPSR                        999999
UKFOR R-LINE  2 10
INFO  UKFOR DUM-1  11 17
UKFOR R-POIN 18 25
UKFOR R-CODE 27 28
UKFOR R-STAT 29 32
UKFOR R-PDEP 33 36
UKFOR R-DATU 37 40
UKFOR R-UPHO 41 42
UKFOR R-WDEP 43 46
UKFOR R-EAST 47 55
UKFOR R-NORT 56 65
UKFOR R-ELEV 66 71
INFO  UKFOR R-DATE 72 74
UKFOR  DUM-2 75 76
UKFOR  DUM-3 77 78
UKFOR  DUM-4 79 80
UKSET       R-POINR-CODER-STATR-PDEPR-DATUR-UPHOR-WDEPR-EASTR-NORTR-ELEV 
UKSET        DUM-2 DUM-3 DUM-4R-LINE
SAFSET       RECPTUSPAR0RECSTARCVRDPRECDTMUPHRECWATREC  XREC  YREC  ZREC
SAFSET      USPAR2USPAR3USPAR4RECLIN
INFO
SQMANI  EXPR
SQEXPR RECST = 0.;
SQEXPR ZREC = RCVRDP;
SQEXPR ZRECST = ZREC;
INFO
& sub(@67,i6) sqsort_maxrec
SQSORT  YREC        XREC        ZREC
RNIDNT RECST      INCPAN
SAFSET  YREC  XREC  ZREC
INFO
& sub(@67,i6) sqsort_maxrec
SQSORTRECLIN       RECPT                              FULSRT
INFO
INFO  create unique ident for RECST
INFO 
INFO  SQMANI  EXPR
INFO  SQEXPR RECST = RECLIN * RECPT; 
INFO  ================================================
INFO  END OF REC2SAF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
