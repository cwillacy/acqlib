&!==========================================================================
&!
&! Module       : addrnoise
&! Function     : add random noise to trace data 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : random, noise
&! Author       : C. Willacy
&! Date         : 14-Sept-2020 
&!
&!==========================================================================
& module addrnoise(             		&
&	faclev		: real=2.,		&! noise level
&	flow		: real=0.,		&! -3dB frequency of low frequency slope 
&	iorlow		: integer=3,		&! order of low slope
&	fhigh		: real=0.,		&! -3dB freqeuncy of high frequency slope
&	iorhig		: integer=3,		&! order of high slope
&	noimod		: character='SNR',	&! noise mode 
&	mode		: character='ZBUT'	&! filter mode: ZBUT or MBUT
& )
INFO  ======================================================================
INFO  ================================================
INFO  START OF ADDRNOISE SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
& sub(@7,a0) noimod
& sub(@13,f0) faclev
NOSADD   
& sub(@19,f0) flow 
& sub(@25,i0) iorlow 
& sub(@31,f0) fhigh 
& sub(@37,i0) iorhig 
& sub(@43,a0) mode
BANDPS                                                     4
INFO
INFO  ================================================
INFO  END OF ADDRNOISE SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
