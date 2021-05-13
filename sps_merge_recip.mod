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
& module sps_merge_recip(           	  		&
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
SQMANI  EXPR
SQEXPR SCRAT0 = XSHT;
SQEXPR SCRAT1 = XREC;
SQEXPR SCRAT2 = YSHT;
SQEXPR SCRAT3 = YREC;
SQEXPR SCRAT4 = RECPT;
SQEXPR SCRAT5 = SHT;
SQEXPR XSHT = SCRAT1;
SQEXPR XREC = SCRAT0;
SQEXPR YSHT = SCRAT3;
SQEXPR YREC = SCRAT2;
SQEXPR RECPT = SCRAT5;
SQEXPR SHT = RECSTA;
INFO
SQUTILDELETE
SAFSETSCRAT0SCRAT1SCRAT2SCRAT3SCRAT4SCRAT5
INFO  recalculate the station idents 
SQMANI  EXPR
SQEXPR USPAR0 = ZSHT ;
SQEXPR USPAR1 = ZREC ;
SQEXPR ZSHT = USPAR1;
SQEXPR ZREC = USPAR0;
INFO
& if (ident) then
INFO  Some re-calculation of the main index idents should be performed
INFO  in order to ensure FWI will work correctly.
INFO  This should be applied even if reciprocity is not used.
INFO
SQMANI  EXPR
SQEXPR RECLIN=1.;
SQEXPR RECPT=1.;
SQEXPR SHTLIN=1.;
INFO  SQEXPR SHT= 1.;
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
INFO  & sub(@67,i6) sqsort_maxrec
INFO  SQSORT  XSHT      
INFO  RNIDNT SHTPT      INCPAN
INFO  SAFSET  XSHT      
INFO
INFO  update SHT
INFO
INFO  & sub(@67,i6) sqsort_maxrec
INFO  SQSORT  YSHT        XSHT
INFO  RNIDNT   SHT      INCPAN
INFO  SAFSET  YSHT  XSHT
INFO
INFO  update RECPT 
INFO
& sub(@67,i6) sqsort_maxrec
SQSORT  XREC
RNIDNT RECPT      INCPAN
SAFSET  XREC  
INFO
INFO  update RECLIN
INFO
& sub(@67,i6) sqsort_maxrec
SQSORT  YREC     
RNIDNTRECLIN      INCPAN
SAFSET  YREC
INFO
& endif
INFO  ================================================
INFO  END OF SPS_MERGE SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
