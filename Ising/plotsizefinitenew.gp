v=1.
g=1.8
Tc=1.13

set multiplot
set size .5,.5
set origin 0,0

set xrange [-11:10] 
set yrange [0:1]

p "d2m_beta50.txt" u (($1-Tc)*50**(1/v)):($3/50**(g/v)) w lp title "50"
rep "d2m_beta40.txt" u (($1-Tc)*40**(1/v)):($3/40**(g/v))  w lp title "40"
rep "d2m_beta30.txt" u (($1-Tc)*30**(1/v)):($3/30**(g/v)) w lp title "30"
rep "d2m_beta20.txt" u (($1-Tc)*20**(1/v)):($3/20**(g/v)) w lp title "20"
#ricorda che ho divisto corr/N

set origin 0,0.5

set xrange [.8:1.6] 
set yrange [0:1000]
p "d2m_beta50.txt" u 1:($3) w lp title "50"
rep "d2m_beta40.txt" u 1:($3)  w lp title "40"
rep "d2m_beta30.txt" u 1:($3)  w lp title "30"
rep "d2m_beta20.txt" u 1:($3)  w lp title "20"

set origin 0.5,0
b=.12

set xrange [-11:10]
set yrange [0:2]
p "d2m_beta50.txt" u (($1-Tc)*50**(1/v)):($2*50**(b/v)) w lp title ""
rep "d2m_beta40.txt" u (($1-Tc)*40**(1/v)):($2*40**(b/v))  w lp title ""
rep "d2m_beta30.txt" u (($1-Tc)*30**(1/v)):($2*30**(b/v)) w lp title ""
rep "d2m_beta20.txt" u (($1-Tc)*20**(1/v)):($2*20**(b/v)) w lp title ""


set origin 0.5,0.5
set xrange [.8:1.6]
set yrange [0:1]

p "d2m_beta50.txt" u  1:2 w lp title ""
rep "d2m_beta40.txt" u  1:2  w lp title ""
rep "d2m_beta30.txt" u 1:2 w lp title ""
rep "d2m_beta20.txt" u 1:2 w lp title ""