set term post color eps solid "Times-Roman" 18 enhanced
set out "AboveTc.eps"
set multiplot         # engage multiplot mode
set style line 11 lc rgb '#808080' lt 1
set border back ls 11
set tics nomirror

set size .45,.6



set xrange[0:1]
set yrange[0:1.1]

f(x,a)=(x-1)/(a*x-1)
g(x,a)=a**4*(1-x)**4*x/(6*(-1+x*a)**4)
set ylabel "J_2/J"
set xlabel "x"

p f(x,0.1) w l lt -1 lw 2 title ""
rep f(x,0.5) w l lt 1 lw 2 title ""
rep f(x,.9) w l lt 2 lw 2 title ""
rep f(x,.99) w l lt 3 lw 2 title ""
rep f(x,1) w l lt 5 lw 2 title ""


set origin .45,0
set ylabel "(1-x)J_4/J_2"

set yrange[0:.5]
p g(x,0.1)/f(x,0.1) w l lt -1 lw 2 title "J=0.1"
rep g(x,0.5)/f(x,0.5) w l lt 1 lw 2 title "J=0.5"
rep g(x,0.9)/f(x,.9)  w l lt 2 lw 2 title "J=0.9"
rep g(x,0.99)/f(x,.99) w l lt 3 lw 2 title "J=0.99"
rep g(x,1)/f(x,1) w l lt 5 lw 2 title "J=1"



