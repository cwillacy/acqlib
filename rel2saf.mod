&!==========================================================================
&!
&! Module       : rel2saf
&! Function     : read an SPS relational file and output SAF 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : SPS, relational
&! Author       : C. Willacy
&! Date         : 29-July-2020 
&!
&!==========================================================================
& module rel2saf(           	  	&
&  filename         	: character,    &! SPS receiver filename 
&  sqsort_maxrec	: integer=1000	&! sqsort max memory
& )
INFO  ================================================
INFO  START OF REL2SAF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
DSCOUT                  relational_file                                               
CARDIM ASCII 
& sub(#1,a0) filename
FILNAM#1                                                                       
INFO
CON
INFO  --------------------------------------------------
INFO  SIPMAP ident mapping
INFO
INFO  X-TAPE = ID9004 	= field tape number 
INFO  X-RENR = SHT 	= field record number 
INFO  X-REIN = SHTMUL 	= field record increment 
INFO  X-INST = SCNTYP 	= instrument code 
INFO  X-SLIN = SHTLIN 	= source line name 
INFO  X-SPOI = SHTPT 	= source point number  
INFO  X-SIND = SHTIDX 	= source point index
INFO  X-FRCH = CHNBEG 	= from channel 
INFO  X-TOCH = CHNEND 	= to channel 
INFO  X-CHIN = CHNINC 	= channel increment
INFO  X-RLIN = RECLIN 	= receiver line name
INFO  X-FRRE = GRPBEG 	= from receiver 
INFO  X-TORE = GRPEND 	= to receiver 
INFO  X-RIND = RECIDX 	= receiver index 
INFO  --------------------------------------------------
DSCIN                   relational_file                                               
UKTOPO ASCII  SPSX                        999999
INFO
INFO  UKFOR X-TAPE  2  7
INFO  note. if X-TAPE is used it cannot contain ascii data which will cause an error 
INFO  with numerical idents
INFO
UKFOR X-RENR  8 15
UKFOR X-REIN 16 16
UKFOR X-INST 17 17
UKFOR X-SLIN 18 27
UKFOR X-SPOI 28 37
UKFOR X-SIND 38 38
UKFOR X-FRCH 39 43
UKFOR X-TOCH 44 48
UKFOR X-CHIN 49 49
UKFOR X-RLIN 50 59
UKFOR X-FRRE 60 69
UKFOR X-TORE 70 79
UKFOR X-RIND 80 80
UKSET X-RENRX-REINX-INSTX-SLINX-SPOIX-SINDX-FRCHX-TOCHX-CHINX-RLINX-FRRE
UKSET X-TOREX-RIND
SAFSET   SHTSHTMULSCNTYPSHTLINSHTPT SHTIDXCHNBEGCHNENDCHNINCRECLINGRPBEGGRPEND
SAFSETRECIDX
INFO
& sub(@67,i6) sqsort_maxrec
SQSORTSHTLIN       SHTPT                              FULSRT
INFO  ================================================
INFO  END OF REL2SAF SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
