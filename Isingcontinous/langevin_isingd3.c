/*Langevin dynamics of interacting continous variables s*/
/*Interaction is determined by the list of nn (default Lattice of size L) */

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#define FNORM   (2.3283064365e-10)
#define RANDOM  ((ira[ip++] = ira[ip1++] + ira[ip2++]) ^ ira[ip3++])
#define FRANDOM (FNORM * RANDOM)
#define MaxT 1000000
#define Delta .01
#define NUMSAMPLES 10
#define NTEMP 1
#define PLOT 1

int par=0;
int myrand;
unsigned ira[256];
unsigned char ip, ip1, ip2, ip3;

unsigned rand4init(void){

  unsigned long long y;
  
  y = myrand * 16807LL;
  myrand = (y & 0x7fffffff) + (y >> 31);
  if (myrand & 0x80000000)
    myrand = (myrand & 0x7fffffff) + 1;
  return myrand;
}

void Init_Random(void){

  int i;
  
  ip = 128;    
  ip1 = ip - 24;    
  ip2 = ip - 55;    
  ip3 = ip - 61;
  
  for (i=ip3; i<ip; i++)
    ira[i] = rand4init();
}

float gasdev(float sdv,int init){
  static int iset = 0;
  static float gset;
  float fac,rsq,v1,v2;

  if (init){iset = 0;}
  if (iset == 0){
    do{
      v1   = 2.0* FRANDOM - 1.0;
      v2   = 2.0* FRANDOM - 1.0;
      rsq  = v1*v1 + v2*v2;
    }while(rsq>=1.0 || rsq == 0.0);

    fac  = sqrt(-2.0*log(rsq)/rsq);
    gset = v1*fac*sdv;
    iset = 1;
    return v2*fac*sdv;
  }
  else{
    iset = 0;
    return gset;
  }
}

double gaussian ( double sigma)
{
  double x, y, r2;
  double remember;

 
    do
      {
	/* choose x,y in uniform square (-1,-1) to (+1,+1) */
	
	x = -1 + 2 * FRANDOM;
	y = -1 + 2 * FRANDOM;
	
	/* see if it is in the unit circle */
	r2 = x * x + y * y;
      }
    while (r2 > 1.0 || r2 == 0);
    
    /* Box-Muller transform */
    //par=1;
    //remember=sigma * x * sqrt (-2.0 * log (r2) / r2);
    return sigma * y * sqrt (-2.0 * log (r2) / r2);
}



int main(int argc, char* argv[]){
  int c, dim=3, N=1000, def=0, nn=1, **list, L=10, *vec, nnei, *nni;
  int i, j, k, t, num, temp;
  double **s, T=1, tmp, lambda=.1, **D, sum, r, sqsigma, sqsigma2=0, noise, *m, w=1, **corr, *nm, **nmc, num1=0, num2=0, val, total_c, aver;

   
   while((c=getopt(argc, argv, "s:D:l:t:c:n:d:")) != -1) {
    switch(c){
    case 's':
      myrand=atoi(optarg);
      break;
    case 'l':
      L=atoi(optarg);
      break;
    case 'D':
      dim=atoi(optarg);
      break;
    case 'n':
      N=atoi(optarg);
      break;
    case 'c':
      def=atoi(optarg);
      break;
    case 't':
      T=atof(optarg);
      break;
    }
   }
   
  
   //if default use square lattice using the dimension dim and lattice size L//
   if(def==0)
     N=pow(L,dim);

   //INITIALIZE//
   Init_Random();
   gasdev(w,1);
   
   s=calloc(N,sizeof(double *));
   corr=calloc(N,sizeof(double *));
   nmc=calloc(N,sizeof(double *));
   m=calloc(N,sizeof(double));
   nm=calloc(N,sizeof(double));
   for(i=0;i<N;i++){
     s[i]=calloc(NUMSAMPLES,sizeof(double));
     corr[i]=calloc(N,sizeof(double));
     nmc[i]=calloc(N,sizeof(double));
   }
   
   list=calloc(N,sizeof(int*));
   if(def==0)
     nn=2*dim;
   else
     nn=N;

   for(i=0;i<N;i++)
     list[i]=calloc(nn,sizeof(int));


   //DEFINE THE LIST OF NN IN A d-dim LATTICE
   if(def==0) {
     vec=calloc(dim,sizeof(int));
     nni=calloc(N,sizeof(int));
     
     for(i=0;i<N;i++) {
       for(j=0;j<dim;j++)
	 vec[j]= (int) (i/pow(L,j)) % L ;
       
       //   fprintf(stdout,"%d %d %d %d\n",i,vec[0],vec[1],vec[2]);
       for(j=0;j<nn/2;j++){
	 nnei=0;
	 for(k=0;k<dim;k++)
	   if(k==j)
	     if(vec[k]==L-1)
	       nnei += pow(L,k) * 0;
	     else
	       nnei += pow(L,k)*(vec[k]+1);
	   else
	     nnei += pow(L,k)*vec[k];
	 list[i][j] = nnei;
	 nni[i]++;
       }
       for(j=nn/2;j<nn;j++){
	 nnei=0;
	 //CHECK BOUNDARY
	 for(k=0;k<dim;k++)
	   if(dim+k==j)
	     if(vec[k]==0)
	       nnei += pow(L,k) * (L-1);
	     else
	       nnei += pow(L,k)*(vec[k]-1);
	   else
	     nnei += pow(L,k)*vec[k];
	 list[i][j] = nnei;
	 nni[i]++;
       }
     }
   }

   //CHECK NN
 /* for(i=0;i<N;i++) { */
 /*     fprintf(stdout,"%d ",i); */
 /*     for(j=0;j<nn;j++) */
 /*       fprintf(stdout,"%d ",list[i][j]); */
 /*     fprintf(stdout,"\n"); */
 /*   } */

   //INITIALIZE SPINS
  
  
   //fprintf(stderr,"%lf %d\n",sum,N);
   //for(i=0;i<N;i++)
   //s[i] *= (double) N/sum;
   


   //RUN LANGEVIN USING LIST OF NN in the array NNI 
   
   D=calloc(N,sizeof(double*));
   for(i=0;i<N;i++)
     D[i]=calloc(NUMSAMPLES,sizeof(double));
   lambda=.5;

   for(temp=0;temp<NTEMP;temp++) {
  
     //REINITIALIZE ALL THE AVERAGE VALUES

     for(i=0;i<N;i++){
       m[i]=0;
       nm[i]=0;
       for(j=0;j<N;j++){
	 corr[i][j]=0;
	 nmc[i][j]=0;
       }
     }


     if(NTEMP>1)
       T= 2.05+(double)temp * .25;
     
     for(j=0;j<NUMSAMPLES;j++){
       for(i=0;i<N;i++) {
	 s[i][j]=1;       
	 //fprintf(stderr,"%lf\n",gaussian(1));
       } 
     }
     for(t=0;t<MaxT;t++) { 
       sqsigma2=0; 
       sqsigma=0;
       for(i=0;i<N;i++) {
	 sum=0;
	 
	 //RUN SEVERAL PARALLEL DYNAMICS
	 for(num=0;num<NUMSAMPLES;num++) {
	   tmp=0;
	   for(k=0;k<nni[i];k++)
	     tmp += s[list[i][k]][num];  
	   noise=gasdev(sqrt(2*T),0);   
	 
	   val =   s[i][num]*s[i][num]*s[i][num];
	   D[i][num] = tmp*Delta + noise*sqrt(Delta)-3*lambda*val*Delta;
	 
	   //sum += (s[i][num]+ D[i][num])*(s[i][num]+ D[i][num]);
	   //D[i] = sqrt(2*T)*noise*sqrt(Delta)-r[i]*s[i]*Delta;
	   //sum += (s[i]+D[i])*noise;
	   //sqsigma += (s[i][num]*s[i][num] -1) + Delta*noise*noise + 2*Delta*s[i][num]*tmp+2*sqrt(Delta)*noise*s[i][num];
	   sqsigma2 += s[i][num]*tmp;
	   sqsigma += val*s[i][num];
	 }
       }
       
       r=T+(double)(sqsigma2-3*lambda*sqsigma)/N/NUMSAMPLES;
     
       for(i=0;i<N;i++) {
	 for(num=0;num<NUMSAMPLES;num++){
	   s[i][num]=s[i][num]*(1-r*Delta)+D[i][num];
	   
	 }
	 //UPDATE THE SPIN AND PRINT
	 if((t%100==0)&&(i==20)&& (PLOT)){
	   fprintf(stdout,"%lf ",t*Delta);
	   
	   sum=0;
	   aver=0;
	   for(j=0;j<NUMSAMPLES;j++){
	     aver +=s[i][j];
	     sum += s[i][j]*s[i][j];
	   }
	   fprintf(stdout,"%lf %lf\n", aver/NUMSAMPLES,sum/NUMSAMPLES);
	   fflush(stdout);
	   //COMPUTE CORRELATION
	 }
       }	
       
       /*        if((t%100==0)&&(i==20)) {
	 fprintf(stdout,"\n");
	 fflush(stdout);
	 }*/
       
       
       if((t%200==0)&&(t>300000)) {
	 
	 for(i=0;i<N;i++) {	   
	   for(k=0;k<NUMSAMPLES;k++) {
	     m[i] += s[i][k];
	     nm[i]++;
	    
	   
	   }
	   for(j=i;j<N;j++) 
	     for(k=0;k<NUMSAMPLES;k++) {
	       corr[i][j] += s[i][k]*s[j][k]; 
	       nmc[i][j]++;
	     }
	 }
       }
     }
     
     total_c=0;
     aver=0;
     for(i=0;i<N;i++) {
       aver += m[i]/nm[i];
       
       for(j=i;j<N;j++)
	 if((nm[i]>0) && (nmc[i][j]>0))
	   total_c += corr[i][j]/nmc[i][j]-m[i]/nm[i]*m[j]/nm[j];
     }
     fprintf(stderr,"%lf %lf %lf\n",T,(double)total_c,(double) aver/N);
     fflush(stderr);   
     fprintf(stdout,"\n\n"); 
   }
}



