v=0.67
g=1.32
Tc=1.1	

set multiplot
set size .5,.5
set origin 0,0

set xrange [-500:300] 
set yrange [0:10]
#p "pnewtrans90.txt" u (($1-Tc)*90**(1/v)):($2/90**(1+g/v)) w lp title "90"
#rep "pnewtrans80.txt" u (($1-Tc)*80**(1/v)):($2/80**(1+g/v)) w lp title "80"
#rep "pnewtrans70.txt" u (($1-Tc)*70**(1/v)):($2/70**(1+g/v)) w lp title "70"
#rep "pnewtrans60.txt" u (($1-Tc)*60**(1/v)):($2/60**(1+g/v)) w lp title "60"
p "d2ptrans50.txt" u (($1-Tc)*50**(1/v)):($2/50**(1+g/v)) w lp title "50"
rep "d2ptrans40.txt" u (($1-Tc)*40**(1/v)):($2/40**(1+g/v))  w lp title "40"
rep "d2ptrans30.txt" u (($1-Tc)*30**(1/v)):($2/30**(1+g/v)) w lp title "30"
rep "d2ptrans20.txt" u (($1-Tc)*20**(1/v)):($2/20**(1+g/v)) w lp title "20"
rep "d2ptrans10.txt" u (($1-Tc)*10**(1/v)):($2/10**(1+g/v)) w lp title "10"

set origin 0,0.5

set xrange [.9:2.] 
set yrange [0:50000]
#p "pnewtrans90.txt" u 1:($2/90) w lp title "90"
#rep "pnewtrans80.txt" u 1:($2/80) w lp title "80"
#rep "pnewtrans70.txt" u 1:($2/70) w lp title "70"
#rep "pnewtrans60.txt" u 1:($2/60) w lp title "60"
p "d2ptrans50.txt" u 1:($2/50) w lp title "50"
rep "d2ptrans40.txt" u 1:($2/40)  w lp title "40"
rep "d2ptrans30.txt" u 1:($2/30)  w lp title "30"
rep "d2ptrans20.txt" u 1:($2/20)  w lp title "20"
#rep "d2ptrans10.txt" u 1:($2/10)  w lp title "10"

set origin 0.5,0
b=.34

set xrange [-500:300]
set yrange [0:1]
#p "pnewtrans90.txt" u (($1-Tc)*90**(1/v)):($3*90**(b/v)) w lp title ""
#rep "pnewtrans80.txt" u (($1-Tc)*80**(1/v)):($3*80**(b/v)) w lp title ""
#rep "pnewtrans70.txt" u (($1-Tc)*70**(1/v)):($3*70**(b/v)) w lp title ""
#rep "pnewtrans60.txt" u (($1-Tc)*60**(1/v)):($3*60**(b/v)) w lp title ""
p "d2ptrans50.txt" u (($1-Tc)*50**(1/v)):($3*50**(b/v)) w lp title ""
rep "d2ptrans40.txt" u (($1-Tc)*40**(1/v)):($3*40**(b/v))  w lp title ""
rep "d2ptrans30.txt" u (($1-Tc)*30**(1/v)):($3*30**(b/v)) w lp title ""
rep "d2ptrans20.txt" u (($1-Tc)*20**(1/v)):($3*20**(b/v)) w lp title ""
#rep "d2pnewtrans10.txt" u (($1-Tc)*10**(1/v)):($3*10**(b/v)) w lp title ""


set origin 0.5,0.5
set xrange [.9:2.]
set yrange [0:1]
#p "pnewtrans90.txt" u 1:3 w lp title ""
#rep "pnewtrans80.txt" u 1:3 w lp title ""
#rep "pnewtrans70.txt" u  1:3 w lp title ""
#rep "pnewtrans60.txt" u  1:3 w lp title ""
p "d2ptrans50.txt" u  1:3 w lp title ""
rep "d2ptrans40.txt" u  1:3  w lp title ""
rep "d2ptrans30.txt" u 1:3 w lp title ""
rep "d2ptrans20.txt" u 1:3 w lp title ""
#rep "d2pnewtrans10.txt" u 1:3 w lp title ""