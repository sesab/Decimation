gcc -o langevin_ising2d.exe -lm langevin_isingnewc.c -O3


for l in {2..2}
do
 #d=2
    L=`echo "$l"*10 | bc -l`
    for t in {0..15}
    do
	temp=`echo 1.22-"$t"*.03 | bc -l`
	echo $temp
	L1=`echo "$L"+10 | bc -l`
	L2=`echo "$L"+20 | bc -l`
	L3=`echo "$L"+30 | bc -l`
	echo $L 
	echo $L1
	echo $L2
	echo $L3
	./langevin_ising2d.exe -s $RANDOM -l $L -t $temp > d2filel$L.$temp.txt 2>> d2ptrans$L.txt &
	./langevin_ising2d.exe -s $RANDOM -l $L1 -t $temp > d2filel$L1.$temp.txt 2>> d2ptrans$L1.txt &
	./langevin_ising2d.exe -s $RANDOM -l $L2 -t $temp > d2filel$L2.$temp.txt 2>> d2ptrans$L2.txt &
	./langevin_ising2d.exe -s $RANDOM -l $L3 -t $temp > d2filel$L3.$temp.txt 2>> d2ptrans$L3.txt 
    done
done
#wait

#for l in {0..3}
#do
#    L=`echo "$l"*5+10 | bc -l`
#    echo $L
#    ./langevin_ising.exe -s $RANDOM -l $L > d3file$L.txt 2> d3ptrans$L.txt &
#done