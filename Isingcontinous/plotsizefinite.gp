r=1.
p=1.75
Tc=1.67	

set multiplot
set size .5,.8
set origin 0,0

set xrange [-50:50] 
set yrange [0:600]
p "ptrans70.txt" u (($1-Tc)*70**r):($2/70**p) w lp
rep "ptrans60.txt" u (($1-Tc)*60**r):($2/60**p) w lp
rep "ptrans50.txt" u (($1-Tc)*50**r):($2/50**p) w lp
rep "ptrans40.txt" u (($1-Tc)*40**r):($2/40**p)  w lp
rep "ptrans30.txt" u (($1-Tc)*30**r):($2/30**p) w lp
rep "ptrans20.txt" u (($1-Tc)*20**r):($2/20**p) w lp
rep "ptrans10.txt" u (($1-Tc)*10**r):($2/10**p) w lp

set origin 0.5,0
b=.15

set xrange [-50:50] 
set yrange [0:2]
p "ptrans70.txt" u (($1-Tc)*70**r):($2*70**b) w lp
rep "ptrans60.txt" u (($1-Tc)*60**r):($3*60**b) w lp
rep "ptrans50.txt" u (($1-Tc)*50**r):($3*50**b) w lp
rep "ptrans40.txt" u (($1-Tc)*40**r):($3*40**b)  w lp
rep "ptrans30.txt" u (($1-Tc)*30**r):($3*30**b) w lp
rep "ptrans20.txt" u (($1-Tc)*20**r):($3*20**b) w lp
rep "ptrans10.txt" u (($1-Tc)*10**r):($3*10**b) w lp