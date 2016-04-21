function controlla(value,i) {

    for(j=i;j<=Nint;j++){
	if(value <= init+j*D+0.000000001) {
	    return j;
	}
    }
}
BEGIN{
    Nint=ENVIRON["bin"]
    if(Nint>0);
    else
	Nint=51;
    temp=0;
    
}
length($1)!=0{
    val[tmp++]= ($1);
    direct=0;
    
}
END{
    tmp--;
    if(direct==0){
	init=val[0];
	end=val[tmp];
	D=(end-init)/Nint;
	j=0;
	for (i=0;i<=tmp;i++) {
	    j=controlla(val[i],j);
	    k[j]++;    
	}
    }
    else{
	init=val[tmp];
	end=val[0];
	D=(end-init)/Nint;

	j=0;
	for (i=tmp;i>=0;i--) {
	    j=controlla(val[i],j);
	    k[j]++;    
	}
    }

  
#    print D,val[tmp],val[0];
   
	
	nomr=0;
	for(j=0;j<=Nint;j++) 
	    norm += k[j]*D;
	for(j=0;j<=Nint;j++) 
	    print (init+D*j +D/2.),k[j]/norm;
    }