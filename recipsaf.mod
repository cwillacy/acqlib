&!==========================================================================
&!
&! Module       : recip 
&! Function     : apply reciprocity to corrdinate idents 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : ident, reciprocity 
&! Author       : C. Willacy
&! Date         : 09-October-2020 
&!
&!==========================================================================
& module recipsaf(           	  		&
& )
INFO  ================================================
INFO  START OF RECIPSAF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
INFO  swap idents
INFO
SQMANI
SQEXPR SCRAT1 = XREC; SCRAT2 = YREC;SCRAT3 = ZREC;
SQEXPR XREC = XSHT; YREC = YSHT;ZREC = ZSHT;
SQEXPR XSHT = SCRAT1; YSHT = SCRAT2;ZSHT = SCRAT3;
INFO  ================================================
INFO  END OF RECIPSAF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
