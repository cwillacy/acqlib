&!==========================================================================
&!
&! Module       : sqbin
&! Function     : Bin an attribute from a saf file and count the frequency
&! 		: per bin.  This can be used to calculate a fold plot.
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : saf, fold
&! Author       : C. Willacy
&! Date         : 29-July-2020 
&!
&!==========================================================================
& module sqbin(             		&
&	xbin		: real=100.,	&
&	ybin		: real=100.,	&
&	sqsort_maxrec	: integer=1000	&! sqsort max mem
& )
INFO  ======================================================================
INFO  ================================================
INFO  START OF SQBIN SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
SQBINRREJECT      XYBINC BDIST                0.      
BINGRD-99999     1999999      -99999     1999999       10000     0     0
& sub(#1,f0) xbin
PARAM spin = #1
& sub(#1,f0) ybin
PARAM spcr = #1 
TRANSF           0           0    0.000000
BINUNTMETRES
INFO
& sub(@67,i6) sqsort_maxrec
SQSORTIBLSEQASC   IBPSEQASC                           FULSRTMEMFIT  
INFO  
INFO  ========================================================================
INFO  Get the bin multiplicities
INFO  ========================================================================
SQPNST XBINC YBINCNONE  NONE             1           1
SAFSET XBINC YBINCIBLSEQIBPSEQ
PSTMODFIRST  XBINC YBINC
INFO
INFO  ================================================
INFO  END OF SQBIN SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
