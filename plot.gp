#set term post color eps solid "Times-Roman" 18 enhanced
#set out "BelowTc.eps"
set multiplot         # engage multiplot mode
set style line 11 lc rgb '#808080' lt 1
set border back ls 11
set tics nomirror

set multiplot
set size .45,.6

set xrange[0:1]
set yrange[0:10]

f(x,a)=(x-1)/(a*x-1)
g(x,a)=4*a**3*(x-1)*x**4/(4*a**5*x**5+sqrt(24-19*a*x)*sqrt(5*a**5*x**5)-4*a**4*x**4-5*a**3*x**3)
set ylabel "J_2/J"
set xlabel "x"
p  x<1./1.1 ? f(x,1.1) : g(x,1.1) w l lw 2 lt -1 title "J=1.1"
rep x<1./1.3 ? f(x,1.3) : g(x,1.3) w l lw 2 lt 1 title "J=1.3"
rep x<1./1.5 ? f(x,1.5) : g(x,1.5) w l lw 2 lt 2 title "J=1.5"
rep x<1./2 ? f(x,2) : g(x,2) w l lw 2 lt 3  title  "J=2"

set origin .45,0
set ylabel "J_4/J_2"




h(x,a)=(64*a**15*(-1+x)**3*x**12*(960*a**11*x**11+416*a**12*x**12+112*a**13*x**13-192*a**14*x**14+64*a**15*x**15-2700*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x))-1350*sqrt(5)*a*x*sqrt(-a**5*x**5*(-24+19*a*x))+375*sqrt(5)*a**2*x**2*sqrt(-a**5*x**5*(-24+19*a*x))+16*a**10*x**10*(-160+sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))-16*a**9*x**9*(1295+6*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))-10*a**6*x**6*(-435+8*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))+48*a**8*x**8*(795+8*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))-105*a**5*x**5*(215+16*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))-2*a**7*x**7*(-2155+32*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))+90*a**3*x**3*(750+89*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))-10*a**4*x**4*(6795+319*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))))/(3*(-5*a**3*x**3-4*a**4*x**4+4*a**5*x**5+sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))**4*(-270*a**6*x**6+104*a**7*x**7-12*a**8*x**8-48*a**9*x**9+16*a**10*x**10+30*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x))-5*sqrt(5)*a*x*sqrt(-a**5*x**5*(-24+19*a*x))+30*sqrt(5)*a**2*x**2*sqrt(-a**5*x**5*(-24+19*a*x))-18*a**3*x**3*(25+sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))+6*a**5*x**5*(95+2*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))-a**4*x**4*(35+24*sqrt(5)*sqrt(-a**5*x**5*(-24+19*a*x)))))

r(x,a)=a**4*(1-x)**4*x/(6*(-1+x*a)**4)
p  x<1./1.1 ? r(x,1.1)/f(x,1.1) : h(x,1.1)/g(x,1.1) w l lw 2 lt -1 title "J=1.1"
rep  x<1./1.3 ? r(x,1.3)/f(x,1.3) : h(x,1.3)/g(x,1.3) w l lw 2 lt 1 title "J=1.3"
rep  x<1./1.5 ? r(x,1.5)/f(x,1.5) : h(x,1.5)/g(x,1.5) w l lw 2 lt 2 title "J=1.5"
rep  x<1./2 ? r(x,2)/f(x,2) : h(x,2)/g(x,2) w l lw 2 lt 3 title "J=2"
