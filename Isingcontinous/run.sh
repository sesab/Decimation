#gcc -o langevin_ising.exe -lm langevin_isingnewc.c -O3


for l in {1..1}
do
 #d=2
    L=`echo "$l"*10 | bc -l`
    echo $L
    ./langevin_isingd2.exe -s $RANDOM -l $L > file$L.txt 2> pnewtrans$L.txt &
done

#wait

#for l in {0..3}
#do
#    L=`echo "$l"*5+10 | bc -l`
#    echo $L
#    ./langevin_ising.exe -s $RANDOM -l $L > d3file$L.txt 2> d3ptrans$L.txt &
#done