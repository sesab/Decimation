gcc -lm ising.c -o ising.exe


for l in {2..3}
do
 #d=2
    L=`echo "$l"*10 | bc -l`
  
    for t in {1..25}
    do
	beta=`echo 1.20-"$t"*.02 | bc -l`
	echo $beta
	./ising.exe -s $RANDOM -l $L -b $beta > tmp$L.$t.txt 2> tmpr$L.$t.txt 
#	./a.out -s $RANDOM -l $L1 -b $beta > tmp$L1.$t.txt 2>  tmpr$L1.$t.txt 
	#./a.out -s $RANDOM -l $L2 -b $beta >  tmp$L2.$t.txt 2> tmpr$L2.$t.txt &
	#./a.out -s $RANDOM -l $L3 -b $beta >  tmp$L3.$t.txt 2> tmpr$L3.$t.txt 
	echo $L

	cat tmp$L.$t.txt >> d2m_beta$L.txt 
#	cat tmp$L1.$t.txt >> d2m_beta$L1.txt 
#	cat tmp$L2.$t.txt >> d2m_beta$L2.txt 
#	cat tmp$L3.$t.txt >> d2m_beta$L3.txt 
    done
    #echo -n > d2m_beta$L.txt

    #for t in {0..10}
    #do
#	cat tmp$L.$t.txt >> d2m_beta$L.txt 
#	cat tmp$L1.$t.txt >> d2m_beta$L1.txt 
#	cat tmp$L2.$t.txt >> d2m_beta$L2.txt 
#	cat tmp$L3.$t.txt >> d2m_beta$L3.txt 
#    done
done

#wait

#for l in {0..3}
#do
#    L=`echo "$l"*5+10 | bc -l`
#    echo $L
#    ./langevin_ising.exe -s $RANDOM -l $L > d3file$L.txt 2> d3ptrans$L.txt &
#done