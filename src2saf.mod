&!==========================================================================
&!
&! Module       : src2saf 
&! Function     : read an SPS source file and output SAF 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : SPS, source 
&! Author       : C. Willacy
&! Date         : 29-July-2020 
&!
&!==========================================================================
& module src2saf(           	  	&
&  filename         : character,       	&! SPS source filename 
&  sqsort_maxrec    : integer=100	&! memory for SAF sort
& )
INFO  ================================================
INFO  START OF SRC2SAF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
DSCOUT                  source_file                                               
CARDIM ASCII 
& sub(#1,a0) filename
FILNAM#1                                                                       
INFO
CON
INFO  --------------------------------------------------
INFO  SIPMAP ident mapping
INFO
INFO  SKLPR0 	= time fraction
INFO  SHTPT 	= shot point number 
INFO  INSNUM 	= boat code
INFO  SHTCOD 	= shot code
INFO  SHTSTA 	= static correction
INFO  SHOTDP 	= depth of source below surface
INFO  SHTDTM 	= datum elevation at source
INFO  UPHOLE 	= uphole time in TUNIT
INFO  WATSHT 	= water/weathering depth at source
INFO  XSHT 	= X coordinate of shot
INFO  YSHT 	= Y coordinate of shot
INFO  ZSHT 	= surface elevation at source
INFO  SKLPR1    = day of the year
INFO  SKLPR2 	= hours
INFO  SKLPR3 	= minutes
INFO  SKLPR4 	= seconds
INFO
INFO  --------------------------------------------------
DSCIN                   source_file                                               
UKTOPO ASCII  SPSS                        999999
UKFOR S-LINE  2 10
UKFOR  DUM-1 11 17
UKFOR S-POIN 18 25
UKFOR S-CODE 26 26
UKFOR S-INDE 27 28
UKFOR S-STAT 29 32
UKFOR S-PDEP 33 36
UKFOR S-DATU 37 40
UKFOR S-UPHO 41 42
UKFOR S-WDEP 43 46
UKFOR S-EAST 47 55
UKFOR S-NORT 56 65
UKFOR S-ELEV 66 71
UKFOR S-DATE 72 74
UKFOR  DUM-2 75 76
UKFOR  DUM-3 77 78
UKFOR  DUM-4 79 80
UKSET  DUM-1S-POINS-INDES-CODES-STATS-PDEPS-DATUS-UPHOS-WDEPS-EASTS-NORT 
UKSET S-ELEVS-DATE DUM-2 DUM-3 DUM-4S-LINE
SAFSETSKLPR0 SHTPTINSNUMSHTCODSHTSTASHOTDPSHTDTMUPHOLEWATSHT  XSHT  YSHT 
SAFSET  ZSHTSKLPR1SKLPR2SKLPR3SKLPR4SHTLIN
INFO
INFO
& sub(@67,i6) sqsort_maxrec
SQSORTSKLPR1      SKLPR2      SKLPR3      SKLPR4      FULSRT
SORSAFSKLPR0
INFO
INFO  set dummy ident to use later for merging
INFO
SQMANI
SQEXPR FLAG = 1.;
INFO
DSCOUT                  source.saf                                            
SQSAF
INFO
CON
DSCIN                   source.saf                                            
SQSAF                  1           1
INFO
INFO  select the first entry of the SAF file
INFO  i.e. the first shot of the survey
INFO  USPAR5 = DAY
INFO  USPAR6 = HOUR
INFO  USPAR7 = MIN 
INFO  USPAR8 = SEC 
INFO  USPAR0 = SFRAC
INFO
SQUTILRENAME
DATINP
SAFSETSKLPR1SKLPR2SKLPR3SKLPR4SKLPR0
DATOUT
SAFSETUSPAR5USPAR6USPAR7USPAR8USPAR9
INFO
DSCOUT                  first.saf                                            
SQSAF 
SAFID FIRST           
CON
INFO
DSCIN                   source.saf                                            
SQSAF
INFO
DSCIN                   first.saf                                             
SAF
INFO
INFO  and the starting shot time to all records for later use
INFO
SQJOININCLUD  FLAG      
SAFSETUSPAR5USPAR6USPAR7USPAR8USPAR9
SAFLIB            FIRST           
INFO
& sub(@67,i6) sqsort_maxrec
SQSORTSHTLIN       SHTPT                              FULSRT
INFO
INFO  calculate the time in seconds for the current shot
INFO
SQMANI
SQEXPR SCRAT1 = SKLPR1; 
INFO  --------------------------------------------------------
INFO  calculate the time in seconds for the start of the survey
INFO  create the Julian date
INFO
INFO  the julian date format is CYYDDD, where:
INFO  C is added to 19 to create the century e.g. 1+19 = 20
INFO  YY is the year of the centuray
INFO  DDD is the day i the year
INFO
SQEXPR SCRAT4 = 100000. + 21000. + USPAR5;
SQEXPR DTEMP7 = DATE2SEC(SCRAT4); 
INFO  create the time in hhmmss
SQEXPR SCRAT5 = (USPAR6*10000.) + (USPAR7*100.) + USPAR8;
SQEXPR DTEMP8 = TIME2SEC(SCRAT5);
SQEXPR DTEMP9 = DTEMP7 + DTEMP8 + USPAR9; 
INFO  --------------------------------------------------------
INFO  calculate the time in seconds for the current shot
INFO  create the Julian date
SQEXPR SCRAT2 = 100000. + 21000. + SKLPR1;
SQEXPR DTEMP4 = DATE2SEC(SCRAT2);
INFO  create the time in hhmmss
SQEXPR SCRAT3 = (SKLPR2*10000.) + (SKLPR3*100.) + SKLPR4;
SQEXPR DTEMP5 = TIME2SEC(SCRAT3);
SQEXPR DTEMP6 = DTEMP4 + DTEMP5 + SKLPR0;
INFO  --------------------------------------------------------
INFO  calc the time difference in seconds from the start of the survey 
SQEXPR USPAR0 = DTEMP6 - DTEMP9; 
SQEXPR DATE = real(int(USPAR0 / 100.)) ;
INFO  time is the truncated time difference in 0.1 milliseconds
SQEXPR TIME = real(int((USPAR0 - DATE*100.)*10000.)) ; 
INFO
SQLIST
SAFSETUSPAR0  DATE  TIMESKLPR4SCRAT6 SHTPTSHTCODINSNUM
SAFPRAACCEPT  TIME
SFOR12 -999999999.         0.1        -0.1
INFO
INFO  SQLIST                                                   ALL
INFO  SAFSETUSPAR0  DATE  TIMESKLPR4SCRAT6 SHTPTSHTCODINSNUM
INFO  SAFSETSHTLIN SHTPT  DATE  TIMESCRAT3
INFO  SAFPRAACCEPTSHTLIN
INFO  SFOR12         343           1         343
INFO  The TIME might become negative for shots with almost the same time
INFO  due to rounding.  Therefore set to zero.
INFO
SQMANI
SQEXPR TIME = 0.0;
SQEXPR DATE = 0.0;
SAFPRAACCEPT  TIME
SFOR12 -999999999.         0.1        -0.1
INFO
INFO  remove temporary working idents
INFO
SQUTILDELETE
SAFSETUSPAR0
INFO
INFO  ================================================
INFO  END OF SRC2SAF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
