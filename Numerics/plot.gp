#set term post color eps  "Verdana" 10 enhanced 
#set out "Jrenormal.eps"
reset
set multiplot         # engage multiplot mode
set xlabel 'x'


set tics nomirror
set size .46,.5
set xtics .2
set ytics .1
set yrange[0:1]
set xrange[0:1]
set origin 0,0

set style line 11 lc rgb '#808080' lt 1
set border 3 back ls 11

set style fill solid noborder
set style line 2  lc rgb '#0025ad' lt 1 lw 2
set style line 3  lc rgb '#0042ad' lt 1 lw 2
set style line 4  lc rgb '#0060ad' lt 1 lw 2
set style line 5  lc rgb '#007cad' lt 1 lw 2
set style line 6  lc rgb '#0099ad' lt 1 lw 2
set style line 7  lc rgb '#00ada4' lt 1 lw 2
set style line 8  lc rgb '#00ad88' lt 1 lw 2
set style line 9  lc rgb '#00ad6b' lt 1 lw 2
set style line 10 lc rgb '#00ad4e' lt 1 lw 2
set style line 11 lc rgb '#00ad31' lt 1 lw 2
set style line 12 lc rgb '#00ad14' lt 1 lw 2
set style line 13 lc rgb '#09ad00' lt 1 lw 2

f(x,J)=(1-x)/(1-J*x)
g(x,J,J4)= (1-x)**3*(-J**4*x+3*J4)/(3*(1-J*x)**4)*(1-x)/J4
h(x,J,J4,J6)= (x-1)**5*(x*(-2*J**6 + 12*J**3*J4+9*J4**2-3*J**7*x+18*J**4*J4*x-54*J*J4**2*x)-3*J6*(1-7*J*x+6*J**2*x**2))/(3*(1-J*x)**7)/J6*(1-x)**2

set ylabel 'J"_2/J_2'
J=0.0
plot f(x,J) w l ls 13 title ""
J=0.1
rep f(x,J) w l ls 11 title ""
J=0.5
rep f(x,J) w l ls 9 title ""
J=0.7
rep f(x,J) w l ls 7 title ""
J=0.8
rep f(x,J) w l ls 5 title ""
J=0.9
rep f(x,J) w l ls 3 title ""
J=0.99
rep f(x,J) w l ls 2 title ""







set origin 0.5,0
set ylabel 'J"_4/J_4'
set yrange[-.3:1]

J6=0

J=0.8	

J4=0.05
plot g(x,J,J4) w l ls 13 title ""
J4=0.1
rep g(x,J,J4) w l  ls 11 title ""
J4=.15
rep g(x,J,J4)  w l  ls 9 title ""
J4=0.2
rep g(x,J,J4)  w l  ls 7 title ""
J4=0.25
rep g(x,J,J4) w l  ls 5 title ""
J4=.3
rep g(x,J,J4)  w l  ls 3 title ""
J4=0.33
rep g(x,J,J4) w l  ls 2 title ""


#set origin 0.,0.5 
#set yrange[-1:1]
#set xrange[0:1]

J4=.2
J=1

J6=0.01
set ylabel 'J"_6/J_6'
#plot h(x,J,J4,J6) w l ls 13 title ""
J6=0.05
#rep h(x,J,J4,J6) w l  ls 11 title ""
J6=0.1
#rep h(x,J,J4,J6) w l  ls 9 title ""
J6=0.15
#rep h(x,J,J4,J6) w l  ls 7 title ""
J6=0.18
#rep h(x,J,J4,J6)  w l  ls 5 title ""
J6=.19
#rep h(x,J,J4,J6) w l  ls 3 title ""
J6=.2
#rep h(x,J,J4,J6) w l  ls 2 title ""


#set origin 0.5,0.48
#set yrange[-1:1]
#set xrange[0:1]

#J4=0.1

#set ylabel 'J"_6/J"_4" / (J_6/J_4)'
#J6=0.0
#plot h(x,J,J4,J6)/g(x,J,J4) w l ls 11 title ""
#J6=0.05
#rep h(x,J,J4,J6)/g(x,J,J4) w l  ls 10 title ""
#J6=0.1
#rep h(x,J,J4,J6)/g(x,J,J4) w l  ls 9 title ""
#J6=0.2
#rep h(x,J,J4,J6)/g(x,J,J4) w l  ls 8 title ""
#J6=0.3
#rep h(x,J,J4,J6)/g(x,J,J4)  w l  ls 7 title ""
#J6=0.4
#rep h(x,J,J4,J6)/g(x,J,J4) w l  ls 6 title ""