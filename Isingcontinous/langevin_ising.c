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
#define Delta .0001


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


double gaussian ( double sigma)
{
  double x, y, r2;

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
  return sigma * y * sqrt (-2.0 * log (r2) / r2);
}



int main(int argc, char* argv[]){
  int c, dim=1, N=1000, def=0, nn=1, **list, L, *vec, nnei;
  int i,j,k;
  double *s;

   
   while((c=getopt(argc, argv, "s:D:l:c:n:d:")) != -1) {
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
    }
   }
   
   //if default use square lattice using the dimension dim and lattice size L//
   if(def==0)
     N=pow(L,dim);

   //INITIALIZE//
   Init_Random();
   s=calloc(N,sizeof(double));
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
   

   //RUN LANGEVIN USING LIST OF NN
  
   for(i=0;i<N;i++) {
   }
   
}
