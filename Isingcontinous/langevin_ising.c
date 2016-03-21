/*Langevin dynamics of interacting continous variables s*/
/*Interaction is J (default Lattice) */

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
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
  int c, dim=1, N=1000, def=1;
  double *s, **J;

   
   while((c=getopt(argc, argv, "s:D:n:d:")) != -1) {
    switch(c){
    case 's':
      myrand=atoi(optarg);
      break;
    case 'n':
      N=atoi(optarg);
      break;
    case 'D':
      dim=atoi(optarg);
      break;
    case 'c':
      def=atoi(optarg);
      break;
    }
   }
   
   //INITIALIZE//
   Init_Random();
   s=calloc(N,sizeof(double));
   J=calloc(N,sizeof(double*));
   for(i=0;i<N;i++)
     J[i]=calloc(N,sizeof(double));

   //DEFINE THE INTERACTION


 

}
