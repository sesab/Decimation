#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(void){

  int i,j,t, sample;
  int N=100, M=10000;
  double *J2,*J4, DJ2, DJ4;
  double delta, deltat=0.001, delta1;

  delta=(double) 0.01;
  delta1=.2;
  J2=calloc(M,sizeof(double));
  J4=calloc(M,sizeof(double));
  sample=0;

  for(i=1;i<2;i++) {
    J2[0]=1-i*delta;
    for(j=0;j<10;j++) {
      J4[0]= j*delta1+0.01;
      
	for(t=0;t<M-1;t++){
	  DJ2= (J2[t]-1)*deltat*J2[t];
	  DJ4= -deltat*J4[t]*(1+3*(1-J2[t])-J2[t]*(1-pow(J2[t],3)/(3*J4[t])));
	 
	    J4[t+1]=J4[t]+DJ4;
	    J2[t+1]=J2[t]+DJ2;
	  
	}
      
      //if(sample++%1000==0){
	for(t=0;t<M;t++)
	  if(t%100==0)
	    fprintf(stdout,"%d %lf %lf %lf %lf\n",t,J2[t],J4[t],(J2[t+1]-J2[t])*50,(J4[t+1]-J4[t])*50);
	fprintf(stdout,"#interruption\n");
	//}
      }
    
  }
  
}
