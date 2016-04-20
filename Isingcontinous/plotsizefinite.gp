r=1.1
p=1.75
Tc=1.67	

p "ptrans60.txt" u (($1-Tc)*60**r):($2/60**p) w lp
rep "ptrans50.txt" u (($1-Tc)*50**r):($2/50**p) w lp
rep "ptrans40.txt" u (($1-Tc)*40**r):($2/40**p)  w lp
rep "ptrans30.txt" u (($1-Tc)*30**r):($2/30**p) w lp
