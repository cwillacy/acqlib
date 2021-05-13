&!==========================================================================
&!
&! Module       : calcazi 
&! Function     : calculate source receiver azimuth 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : azimuth 
&! Author       : C. Willacy
&! Date         : 31-July-2020 
&!
&!==========================================================================
& module calcazi(           	  &
& )
INFO  ================================================
INFO  START OF CALCAZI SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
SQMANI
SQEXPR SCRAT0 = 3.14159265;
SQEXPR XDISTX = XSHT - XREC;
SQEXPR XDISTY = YSHT - YREC;
SQEXPR AZITNA = 0.0;
SQEXPR FLAG = 0.0;
INFO
SQMANI
SQEXPR FLAG = 1.0; 
SAFPRAACCEPTXDISTY      
SFOR12         0.0         0.0         0.0  
INFO
INFO  if positive
INFO
SQMANI
SQEXPR AZITNA =  ATAN(abs(XDISTX) / abs(XDISTY)) * (180./SCRAT0) ;
SAFPRAACCEPTXDISTXXDISTY  FLAG
SFOR12         0.0.0000000000199999999999.         0.0.00000000001999999999999
SFOR34         0.0         0.0         0.0
INFO
SQMANI
SQEXPR AZITNA =  (ATAN(abs(XDISTX) / abs(XDISTY)) * (180./SCRAT0) ) + 90.;
SAFPRAACCEPTXDISTXXDISTY  FLAG
SFOR12         0.0.0000000000199999999999.-99999999999.00000000001         0.0
SFOR34         0.0         0.0         0.0
INFO
INFO  if negative
INFO
SQMANI
SQEXPR AZITNA =  (ATAN(abs(XDISTX) / abs(XDISTY)) * (180./SCRAT0) ) + 180.;
SAFPRAACCEPTXDISTXXDISTY  FLAG
SFOR12-99999999999.00000000001         0.0-99999999999.00000000001         0.0
SFOR34         0.0         0.0         0.0
INFO
SQMANI
SQEXPR AZITNA =  (ATAN(abs(XDISTX) / abs(XDISTY)) * (180./SCRAT0) ) + 270.;
SAFPRAACCEPTXDISTXXDISTY  FLAG
SFOR12-99999999999.00000000001         0.0         0.0.00000000001999999999999
SFOR34         0.0         0.0         0.0
INFO
SQLIST
SAFSETXDISTXXDISTYAZITNA
INFO  ================================================
INFO  END OF CALCAZI SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
