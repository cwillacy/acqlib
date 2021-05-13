&!==========================================================================
&!
&! Module       : pltscat 
&! Function     : plot a scatter plot
&! Package      : -
&! Environment  : EXTERNAL
&! Portability  : SIPMAP
&! Precondition : -
&! Notes        : -
&! Keywords     : saf, scatter, map
&! Author       : C. Willacy
&! Date         : 29-July-2020 
&!
&!==========================================================================
& module pltscat(             	 	&
&  xvar1       	: character='XSHT',     &! X variable to plot 
&  yvar1       	: character='YSHT',     &! Y variable to plot 
&  col1        	: character='RAINBOW',  &! colour for first dataset 
&  cvary1     	: boolean=false,        &! switch to vary the symbol colour 
&  zvar1       	: character='ZREC',     &! attribute for colour variation
&  symb1       	: character='CROSS',    &! symbol shape for var1 
&  xvar2       	: character='XREC',     &! X2 variable to plot 
&  yvar2       	: character='YREC',     &! Y2 variable to plot 
&  col2        	: character='RAINBOW',  &! colour for second dataset 
&  cvary2      	: boolean=false,        &! switch to vary the symbol colour 
&  zvar2       	: character='ZREC',     &! attribute for colour variation
&  symb2       	: character='CIRCLE',   &! symbol shape for var2 
&  title       	: character,		&! plot title 
&  xlabel      	: character='X',	&! x-axis label 
&  ylabel      	: character='Y',	&! y-axis label
&  cbartitle   	: character='',		&! colour bar title 
&  filename    	: character='scat.png', &! filename for output image 
&  path        	: character='~',        &! directory path for output image 
&  timestamp   	: boolean=false,        &! plot a timestamp on the image 
&  polar       	: boolean=false,        &! plot in polar coordinates 
&  second      	: boolean=false,        &! switch to plot second attribute 
&  drawbox1    	: boolean=false,        &! switch to draw box on the plot 
&  drawbox2    	: boolean=false,        &! switch to draw box on the plot 
&  showgrid    	: boolean=false,        &! show grid on plot 
&  size		: real=5.0,		&! symbol size
&  size2	: real=5.0,		&! symbol size
&  xsize	: integer=500,		&! x size of image
&  ysize	: integer=500,		&! y size of image
&  box1_xmin	: integer=0,		&! box xmin 
&  box1_ymin	: integer=0,		&! box ymin
&  box1_xmax	: integer=1,		&! box xmax
&  box1_ymax	: integer=1,		&! box ymax 
&  box2_xmin	: integer=0,		&! box xmin 
&  box2_ymin	: integer=0,		&! box ymin
&  box2_xmax	: integer=1,		&! box xmax
&  box2_ymax	: integer=1,		&! box ymax 
&  xmin		: integer=null,		&! xaxis minimum
&  xmax		: integer=null,		&! xaxis maximum
&  ymin		: integer=null,		&! yaxis minimum
&  ymax		: integer=null,		&! yaxis maximum
&  zmin		: integer=null,		&! zaxis minimum
&  zmax		: integer=null,		&! zaxis maximum
&  cmin		: integer=null,		&! colourbar min 
&  cmax		: integer=null,		&! colourbar max
&  crop		: boolean=false,	&! switch to crop the output image 
&  autoscale	: boolean=false		&! switch to apply axis autoscaling 
& )
INFO  ======================================================================
& sub(@19,i0) xsize
& sub(@25,i0) ysize
GNUPLT GEN     PNG
& if (cvary1) then
& sub(@13,a6)  yvar1
& sub(@19,a6)  xvar1
& sub(@25,a12) col1 
& sub(@37,a6)  zvar1 
& sub(@43,f0)  size 
& sub(@55,a12) symb1 
PLITEMPOINTS                                                      var1  
& else
& sub(@13,a6)  yvar1
& sub(@19,a6)  xvar1
& sub(@25,a12) col1 
& sub(@43,f0)  size 
& sub(@55,a12) symb1 
PLITEMPOINTS                                                      var1        
& endif
& if (second) then
& 	if (cvary2) then
& 		sub(@13,a6)  yvar2
& 		sub(@19,a6)  xvar2
& 		sub(@25,a12) col2 
& 		sub(@37,a6)  zvar2 
& 		sub(@43,f0)  size2 
&		sub(@55,a12) symb2 
PLITEMPOINTS                                                      var2  
& 	else
& 		sub(@13,a6)  yvar2
& 		sub(@19,a6)  xvar2
& 		sub(@25,a12) col2 
& 		sub(@43,f0)  size2 
& 		sub(@55,a12) symb2 
PLITEMPOINTS                                                      var2        
& 	endif
& endif
PLKEY    OFF
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
& if (cvary1) then
& sub(#1,a0) '"' + cbartitle + '"' 
GPADDLset cblabel #1 
& endif
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
& if (polar) then
INFO  GPADDLset size square 
GPADDLset angle degrees
GPADDLunset border
INFO  GPADDLunset tics
GPADDLset cbtics
GPADDLset polar 
GPADDLset border polar 
INFO  GPADDLunset raxis
INFO  GPADDLset style fill noborder
INFO  GPADDLset xtics axis nomirror
INFO  GPADDLset ytics axis nomirror
GPADDLset grid polar front 
INFO  GPADDLset rrange[*:*] reverse
& endif
INFO
EXUNIX  EXEC                                             EOD
& sub(#1,a0) filename 
& sub(#2,a0) path 
UNIX  cp $TMPDIR_SHARED/#1 #2 
INFO  ================================================
INFO  END OF PLTSCAT V03 SLANG MODULE PROCESSING SEQUENCE
INFO  ================================================
INFO
