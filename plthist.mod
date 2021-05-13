&!==========================================================================
&!
&! Module       : plthist 
&! Function     : create a historgram plot
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : saf, histogram 
&! Author       : C. Willacy
&! Date         : 30-July-2020 
&!
&!==========================================================================
& module plthist(             	 	&
&  hvar        	: character='XDIST',    &! X variable to plot 
&  nbin        	: integer=500,	      	&! number of bins 
&  col1        	: character='RED',      &! colour for dataset 
&  title       	: character,		&! plot title 
&  xlabel      	: character='Bins',	&! x-axis label 
&  ylabel      	: character='Var',	&! y-axis label
&  timestamp   	: boolean=false,        &! plot a timestamp on the image 
&  path        	: character='~',        &! directory path for output image 
&  filename    	: character='hist.png', &! filename for output image 
&  xsize	: integer=500,		&! x size of image
&  ysize	: integer=500,		&! y size of image
&  crop   	: boolean=false,        &! switch to crop the output image 
&  autoscale   	: boolean=false         &! switch to apply axis autoscaling 
& )
INFO  ======================================================================
& sub(@19,i0) xsize
& sub(@25,i0) ysize
GNUPLTHIST     PNG                              ECHOCM
& sub(@7,a6)   hvar
& sub(@13,i6)  nbin 
& sub(@19,a12) col1 
HISDEF                          FREQ
& sub(#1,a0) filename 
FILNAM#1 
& sub(#1,a0) title
TITLE #1 
& if (crop) then
GPOPTSCROP                                                                  
& else
GPOPTSNOCROP                                                                  
& endif                                                                  
& sub(#1,a0) '"' + xlabel + '"'
GPADDLset xlabel #1                                                     
& sub(#1,a0) '"' + ylabel + '"'
GPADDLset ylabel #1                                                       
& if (timestamp) then
GPADDLset timestamp
& endif
& if (autoscale)
GPADDLset autoscale 
& else
GPADDLset autoscale fix
& endif
INFO
EXUNIX  EXEC                                             EOD
& sub(#1,a0) filename 
& sub(#2,a0) path 
UNIX  cp $TMPDIR_SHARED/#1 #2 
INFO  ================================================
INFO  END OF PLTHIST SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
