#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(void){

  int i,j,t, sample;
  int N=100, M=100000000;
  double *J2,*J4, DJ2, DJ4;
  double delta, deltat=0.001, delta1;

  delta=(double) 0.00000001;
  delta1=.2;
  J2=calloc(M,sizeof(double));
  J4=calloc(M,sizeof(double));
  sample=0;

  for(i=1;i<2;i++) {
    J2[0]=1;
    for(j=0;j<5;j++) {
      J4[0]= j*.04+0.1;
      
	for(t=0;t<M-1;t++){
	  DJ2= J2[t]*(1-delta)/(1-J2[t]*(delta));
	  DJ4= pow(1-delta,3)*(-pow(J2[t],4)*delta+3*J4[t])/(3*pow(J2[t]*delta-1,4));
	 
	    J4[t+1]=DJ4;
	    J2[t+1]=DJ2;
	  
	}
      
      //if(sample++%1000==0){
	for(t=0;t<M;t++)
	  if(t%10000==0)
	    fprintf(stdout,"%lf %lf %lf %lf %lf\n",delta*t,J2[t],J4[t],(J2[t+1]-J2[t])*50,(J4[t+1]-J4[t])*50);
	fprintf(stdout,"#interruption\n");
	//}
      }
    
  }
  
}
