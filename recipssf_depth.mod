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
& module recipssf_depth(           	  		&
& )
INFO  ================================================
INFO  START OF RECIPSSF_DEPTH SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
INFO  swap idents
INFO
THMANI
THEXPR SCRAT3 = ZREC;
THEXPR ZREC = ZSHT;
THEXPR ZSHT = SCRAT3;
THEXPR ZRECST = ZREC;
THEXPR ZSHTST = ZSHT;
THEXPR SHOTDP = ZSHT;
THEXPR RCVRDP = ZREC;
INFO  ================================================
INFO  END OF RECIPSSF_DEPTH SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
