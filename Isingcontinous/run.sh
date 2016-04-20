gcc -o langevin_ising.exe -lm langevin_isingnewc.c -O3


#for l in {1..9}
#do
 #   L=`echo "$l"*10 | bc -l`
 #   echo $L
 #   ./langevin_ising.exe -s $RANDOM -l $L > filenew$L.txt 2> pnewtrans$L.txt &
#done

#wait

for l in {8..9}
do
    L=`echo "$l"*10 | bc -l`
    echo $L
    ./langevin_ising.exe -s $RANDOM -l $L > filenew$L.txt 2> pnewtrans$L.txt &
done