gcc -o langevin_ising.exe -lm langevin_isingnewc.c -O3


for l in {1..7}
do
    L=`echo "$l"*10 | bc -l`
    echo $L
    ./langevin_ising.exe -s 3 -l $L > file$L.txt 2> ptrans$L.txt
done