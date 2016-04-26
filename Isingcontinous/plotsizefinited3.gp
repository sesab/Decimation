r=.63
p=1.9
Tc=3.8

set multiplot
set size .5,.5
set origin 0,0

set xrange [-40:40] 
set yrange [0:6000]
p "d3ptrans25.txt" u (($1-Tc)*25**r):($2/25**p)  w lp title "25"
rep "d3ptrans20.txt" u (($1-Tc)*20**r):($2/20**p) w lp title "20"
rep "d3ptrans15.txt" u (($1-Tc)*15**r):($2/15**p) w lp title "15"
p "d3ptrans10.txt" u (($1-Tc)*10**r):($2/10**p) w lp title "10"

set origin 0,0.5

set xrange [1.2:6] 
set yrange [0:3100000]
p "d3ptrans25.txt" u 1:2   w lp title "25"
rep "d3ptrans20.txt" u 1:2  w lp title "20"
rep "d3ptrans15.txt" u 1:2  w lp title "15"
rep "d3ptrans10.txt" u 1:2 w lp title "10"

set origin 0.5,0
b=.50

set xrange [-10:10]
set yrange [0:4]
p "d3ptrans25.txt" u (($1-Tc)*25**r):($3*25**b) w lp title ""
rep "d3ptrans20.txt" u (($1-Tc)*20**r):($3*20**b) w lp title ""
rep "d3ptrans15.txt" u (($1-Tc)*15**r):($3*15**b) w lp title ""
rep "d3ptrans10.txt" u (($1-Tc)*10**r):($3*10**b) w lp title ""

set origin 0.5,0.5
set xrange [1.2:6]
set yrange [0:1]
p "d3ptrans25.txt" u 1:3 w lp title "25"
rep "d3ptrans20.txt" u 1:3   w lp title "20"
rep "d3ptrans15.txt" u 1:3  w lp title "15"
rep "d3ptrans10.txt" u 1:3  w lp title "10"
