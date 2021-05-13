&!==========================================================================
&!
&! Module       : pltmap 
&! Function     : plot a previously calculated regular grid 
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : saf, fold, map
&! Author       : C. Willacy
&! Date         : 29-July-2020 
&!
&!==========================================================================
& module pltmap(             &
&	xvar		: character='XBINC',	&! X variable to plot
&	yvar		: character='YBINC',	&! Y variable to plot
&	mvar		: character='LSMULT',	&! variable to plot
&	col1		: character='RAINBOW',	&! colour map of variable to plot
&  	title       	: character='map',	&! plot title 
&  	xlabel      	: character='X', 	&! x-axis label 
&  	ylabel      	: character='Y', 	&! y-axis label
&  	cbartitle    	: character='',		&! colour bar title 
&  	clabel      	: character='Attribute',&! c-axis label
&  	filename    	: character='map.png',  &! filename for output image 
&  	timestamp   	: boolean=false,        &! plot a timestamp on the image 
&  	drawbox1    	: boolean=false,        &! switch to draw box on the plot 
&  	drawbox2    	: boolean=false,        &! switch to draw box on the plot 
&  	showgrid    	: boolean=false,        &! show grid on plot 
&  	path        	: character='~',        &! directory path for output image 
&	xsize		: integer=500,		&
&	ysize		: integer=500, 		&
&  	box1_xmin	: integer=0,		&! box xmin 
&  	box1_ymin	: integer=0,		&! box ymin
&  	box1_xmax	: integer=1,		&! box xmax
&  	box1_ymax	: integer=1,		&! box ymax 
&  	box2_xmin	: integer=0,		&! box xmin 
&  	box2_ymin	: integer=0,		&! box ymin
&  	box2_xmax	: integer=1,		&! box xmax
&  	box2_ymax	: integer=1,		&! box ymax 
&  	xmin		: integer=null,		&! xaxis minimum
&  	xmax		: integer=null,		&! xaxis maximum
&  	ymin		: integer=null,		&! yaxis minimum
&  	ymax		: integer=null,		&! yaxis maximum
&  	zmin		: integer=null,		&! zaxis minimum
&  	zmax		: integer=null,		&! zaxis maximum
&  	cmin		: integer=null,		&! colourbar min 
&  	cmax		: integer=null,		&! colourbar max
&	sqsort_maxrec	: integer=1000,		&! sqsort max memory
&  	crop   		: boolean=false,        &! switch to crop the output image 
&  	autoscale 	: boolean=false         &! switch to apply axis autoscaling 
& )
INFO  ======================================================================
& sub(@7,a6)  yvar
& sub(@19,a6) xvar
& sub(@67,i6) sqsort_maxrec
SQSORT                                                FULSRTMEMFIT  
INFO
& sub(@19,i0) xsize
& sub(@25,i0) ysize
GNUPLT   MAP   PNG            
INFO  GPCMAP RAINBOW_REVREVERSRAINBOW
& sub(@7,a6)   mvar
& sub(@13,a6)  yvar
& sub(@19,a6)  xvar
& sub(@25,a12) col1 
MAPDEF                       RAINBOW
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
& sub(#1,a0) '"' + clabel + '"'
GPADDLset clabel #1 
& if (timestamp) then
GPADDLset timestamp
& endif
& if (autoscale)
GPADDLset autoscale 
& else
&!----------------------------------------------------
&   if (xmin <> null) and (xmax = null) then
& sub(#1,i0) xmin
GPADDLset xrange [#1:]
& elseif (xmin = null) and (xmax <> null) then
& sub(#1,i0) xmax
GPADDLset xrange [:#1]
& elseif (xmin <> null) and (xmax <> null)  then
& sub(#1,i0) xmin
& sub(#2,i0) xmax
GPADDLset xrange [#1:#2]
&   endif
&!----------------------------------------------------
&   if (ymin <> null) and (ymax = null) then
& sub(#1,i0) ymin
GPADDLset yrange [#1:]
& elseif (ymin = null) and (ymax <> null) then
& sub(#1,i0) ymax
GPADDLset yrange [:#1]
& elseif (ymin <> null) and (ymax <> null)  then
& sub(#1,i0) ymin
& sub(#2,i0) ymax
GPADDLset yrange [#1:#2]
&   endif
&!----------------------------------------------------
&   if (zmin <> null) and (zmax = null) then
& sub(#1,i0) zmin
GPADDLset zrange [#1:]
& elseif (zmin = null) and (zmax <> null) then
& sub(#1,i0) zmax
GPADDLset zrange [:#1]
& elseif (zmin <> null) and (zmax <> null)  then
& sub(#1,i0) zmin
& sub(#2,i0) zmax
GPADDLset zrange [#1:#2]
&   endif
&!----------------------------------------------------
&   if (cmin <> null) and (cmax = null) then
& sub(#1,i0) cmin
GPADDLset cbrange [#1:]
& elseif (cmin = null) and (cmax <> null) then
& sub(#1,i0) cmax
GPADDLset cbrange [:#1]
& elseif (cmin <> null) and (cmax <> null)  then
& sub(#1,i0) cmin
& sub(#2,i0) cmax
GPADDLset cbrange [#1:#2]
&   endif
&!----------------------------------------------------
GPADDLset autoscale fix
& endif
& sub(#1,a0) '"' + cbartitle + '"' 
GPADDLset cblabel #1 
& if (drawbox1) then
& sub(#1,i0) box1_xmin 
& sub(#2,i0) box1_ymin 
& sub(#3,i0) box1_xmax 
& sub(#4,i0) box1_ymax 
GPADDLset object 1 rect from #1,#2 to #3,#4 front fs empty linecolor rgb "black" 
& endif
& if (drawbox2) then
& sub(#1,i0) box2_xmin 
& sub(#2,i0) box2_ymin 
& sub(#3,i0) box2_xmax 
& sub(#4,i0) box2_ymax 
GPADDLset object 2 rect from #1,#2 to #3,#4 front fs empty linecolor rgb "black" 
& endif
& if (showgrid) then
GPADDLset grid ytics front lt 0 lw 1 lc rgb "#bbbbbb"
GPADDLset grid xtics front lt 0 lw 1 lc rgb "#bbbbbb"
& endif
INFO
EXUNIX  EXEC                                             EOD
& sub(#1,a0) filename 
& sub(#2,a0) path 
UNIX  cp $TMPDIR_SHARED/#1 #2 
INFO  ================================================
INFO  END OF PLTMAP V03 SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
