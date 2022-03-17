&!==========================================================================
&!
&! Module       : interpz 
&! Function     : interpolate an attribute from a horizon to a trace ident 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : interpolate, node depths
&! Author       : C. Willacy & S. Last
&! Date         : 28-July-2020 
&!
&!==========================================================================
& module interpz(           	  		&
&  	wbot         	: character,       	&! water bottom filename 
&  	smooth         	: real=0.01,		&! spline smoothing factor 
&  	recip          	: boolean=false,	&! boolean switch for reciprocity 
&	sqsort_maxrec	: integer=1000		&! sqsort max memory
& )
INFO  ================================================
INFO  START OF INTERPZ SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
INFO  reverse reciprocity if previously applied
INFO
& if (recip) then
INFO
INFO  swap idents
INFO
SQMANI
SQEXPR SCRAT1 = XREC; SCRAT2 = YREC;SCRAT3 = ZREC;
SQEXPR XREC = XSHT; YREC = YSHT;ZREC = ZSHT;
SQEXPR XSHT = SCRAT1; YSHT = SCRAT2;ZSHT = SCRAT3;
& endif
INFO
INFO  sort the input acq geom file and store locally 
INFO
& sub(@67,i6) sqsort_maxrec
SQSORT  XREC   ASC  YREC   ASC  XSHT        YSHT                  
INFO
DSCOUT                  temp.saf                                              
MEDCTLFILE_SIZE=250GB
SQSAF
SAFID TEMP            
CON
INFO
INFO  input the acquisition geometry and the waterbottom saf
INFO  and perform the interpolation for ZREC using XREC and 
INFO  YREC keys
INFO
DSCIN                   temp.saf                                              
SQSAF
INFO
& sub(#1,a0) wbot 
DSCIN                   #1 
SAF
SAFID WATERBOTTOM     
INFO
SQUARE         100000000
TIMHOR  NONE                    XREC  YREC
VELHOR         100000000
SAFSET  ZREC
SAFLIB            WATERBOTTOM     
AREALI
& sub(@19,f0) smooth
SPLINE   100   100 
INFO
INFO  copy ZREC to SCRAT0 for later merging
INFO
SQUTIL  COPY
DATINP
SAFSET  ZREC
DATOUT
SAFSETSCRAT0
INFO
SQUTILDELETE
SAFSET
SAFSET  ZREC
INFO
DSCOUT                  interp_z.saf                                          
MEDCTLFILE_SIZE=250GB
SQSAF
CON
INFO
INFO  add the interpolated ZREC values to the original acq geom file 
INFO
DSCIN                   temp.saf                                              
SQSAF                      
INFO
DSCIN                   interp_z.saf             
SAF                                             
INFO
SQJOININCLUD  XREC  YREC
SAFSETSCRAT0
SAFLIB            TEMP            
INFO
SQUTIL  COPY
DATINP
SAFSETSCRAT0
DATOUT
SAFSET  ZREC
INFO
SQUTILDELETE
SAFSET
SAFSETSCRAT0
INFO
& if (recip) then
INFO
INFO  swap idents
INFO
SQMANI
SQEXPR SCRAT1 = XREC; SCRAT2 = YREC;SCRAT3 = ZREC;
SQEXPR XREC = XSHT; YREC = YSHT;ZREC = ZSHT;
SQEXPR XSHT = SCRAT1; YSHT = SCRAT2;ZSHT = SCRAT3;
& endif
INFO  ================================================
INFO  END OF INTERPZ SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
