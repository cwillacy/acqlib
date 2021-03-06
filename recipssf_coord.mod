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
& module recipssf_coord(           	  		&
& )
INFO  ================================================
INFO  START OF RECIP SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
INFO  swap idents
INFO
THMANI
THEXPR SCRAT1 = XREC; SCRAT2 = YREC;
THEXPR XREC = XSHT; YREC = YSHT;
THEXPR XSHT = SCRAT1; YSHT = SCRAT2;
THEXPR XRECST = XREC;
THEXPR YRECST = YREC;
THEXPR ZRECST = ZREC;
THEXPR XSHTST = XSHT;
THEXPR YSHTST = YSHT;
THEXPR ZSHTST = ZSHT;
THEXPR SHOTDP = ZSHT;
THEXPR RCVRDP = ZREC;
INFO  ================================================
INFO  END OF RECIP SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
