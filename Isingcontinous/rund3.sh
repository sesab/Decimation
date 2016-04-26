gcc -o langevin_isingd3.exe -lm langevin_isingd3.c -O3
#wait

for l in {0..3}
do
    L=`echo "$l"*5+10 | bc -l`
    echo $L
    ./langevin_isingd3.exe -s $RANDOM -l $L > d3file$L.txt 2> d3ptrans$L.txt &
done