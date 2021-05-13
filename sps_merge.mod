&!==========================================================================
&!
&! Module       : sps_merge 
&! Function     : merge the SPS source, receiver and relational files and output SAF 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : SPS, merge, source, receiver, relational
&! Author       : C. Willacy
&! Date         : 29-July-2020 
&!
&!==========================================================================
& module sps_merge(           	  		&
&  ident		: boolean=true,  	&! switch to perform re-identing 
&  sqsort_maxrec	: integer=1000		&! sqsort max recs
& )
INFO  ================================================
INFO  START OF SPS_MERGE SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
SQTOPCSHTLIN SHTPTRECLIN RECPTCHNBEGCHNENDGRPBEGGRPEND
SAFLIB            SAF_X           
SAFLIB            SAF_S           
SAFLIB            SAF_R           
INFO
INFO
SQMANI  EXPR
SQEXPR SHT = SHTPT ;
INFO
& if (ident) then
INFO  Some re-calculation of the main index idents should be performed
INFO  in order to ensure FWI will work correctly.
INFO  This should be applied even if reciprocity is not used.
INFO
SQMANI  EXPR
INFO  SQEXPR RECLIN 	= 1.;
INFO  SQEXPR RECPT 	= 1.;
SQEXPR SHTLIN 	= 1.;
SQEXPR SHTPT 	= 1.;
INFO
INFO  update SHTLIN
INFO
& sub(@67,i6) sqsort_maxrec
SQSORT  YSHT  
RNIDNTSHTLIN      INCPAN
SAFSET  YSHT
INFO
INFO  update SHTPT
INFO
& sub(@67,i6) sqsort_maxrec
SQSORT  XSHT      
RNIDNT SHTPT      INCPAN
SAFSET  XSHT      
INFO
INFO  update SHT
INFO
& sub(@67,i6) sqsort_maxrec
SQSORT  YSHT        XSHT
RNIDNT   SHT      INCPAN
SAFSET  YSHT  XSHT
INFO
INFO  update RECPT 
INFO
INFO  & sub(@67,i6) sqsort_maxrec
INFO  SQSORT  XREC
INFO  RNIDNT RECPT      INCPAN
INFO  SAFSET  XREC  
INFO
INFO  update RECLIN
INFO
INFO  & sub(@67,i6) sqsort_maxrec
INFO  SQSORT  YREC     
INFO  RNIDNTRECLIN      INCPAN
INFO  SAFSET  YREC
& endif
INFO  ================================================
INFO  END OF SPS_MERGE SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
