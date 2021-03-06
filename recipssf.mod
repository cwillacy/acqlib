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
& module recipssf(           	  		&
& )
INFO  ================================================
INFO  START OF RECIPSSF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
INFO  swap idents
INFO
THMANI
THEXPR SCRAT1 = XREC; SCRAT2 = YREC;SCRAT3 = ZREC;
THEXPR XREC = XSHT; YREC = YSHT;ZREC = ZSHT;
THEXPR XSHT = SCRAT1; YSHT = SCRAT2;ZSHT = SCRAT3;
THEXPR XRECST = XREC;
THEXPR YRECST = YREC;
THEXPR ZRECST = ZREC;
THEXPR XSHTST = XSHT;
THEXPR YSHTST = YSHT;
THEXPR ZSHTST = ZSHT;
THEXPR SHOTDP = ZSHT;
THEXPR RCVRDP = ZREC;
INFO  THEXPR SCRAT6= SHTLIN; SCRAT7= SHTPT; SCRAT8= RECLIN; 
INFO  THEXPR SCRAT9= RECPT;
INFO
INFO  THMANI
INFO  THEXPR SHTLIN = SCRAT8;
INFO  THEXPR SHTPT = SCRAT9;
INFO  THEXPR RECLIN = SCRAT6;
INFO  THEXPR RECPT = SCRAT7; 
INFO  ================================================
INFO  END OF RECIPSSF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
