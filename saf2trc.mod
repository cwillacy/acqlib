&!==========================================================================
&!
&! Module       : saf2trc 
&! Function     : convert saf geometry file to ssf traces for use in the fwi 
&!		: in the modelling wizard 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : saf, ssf 
&! Author       : C. Willacy
&! Date         : 29-July-2020 
&!
&!==========================================================================
& module saf2trc(           	  &
&  srtall_maxsize	: integer=4000	&! srtall max memory
& )
INFO  ================================================
INFO  START OF SAF2TRC SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
INFO  create a dummy T0, this is needed for the ssf files creation
INFO 
SQUTILCREATE
SAFSET    T0
SQMANI  EXPR
SQEXPR T0 = 0.0 ;
SQSORT  XSHT        YSHT          T0                  FULSRTMEMFIT
INFO
INFO   convert to SSF
INFO
SQGTRA     0     1     1NOBLNK
SAFSET   SHT  XSHT  YSHT  ZSHT  XREC  YREC  ZRECSHTLINSHTCOD SHTPTINSNUM
THSET    SHT  XSHT  YSHT  ZSHT  XREC  YREC  ZRECSHTLINSHTCOD SHTPTINSNUM
INFO
INFO  THMANI
INFO  THEXPR SHT = SHTPT;
INFO
& sub(@31,i12) srtall_maxsize
SRTALL  XSHT  YSHT                            MB
INFO  ================================================
INFO  END OF SAF2TRC SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
