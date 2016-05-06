#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define NUM_TEMP 100000



double casual( ){
  double r = (double) random()/(double)(RAND_MAX+1.0);
  return r;
}

double gaussian ( double sigma)
{
  double x, y, r2;

  do
    {
      /* choose x,y in uniform square (-1,-1) to (+1,+1) */

      x = -1 + 2 * casual();
      y = -1 + 2 * casual();
      
      /* see if it is in the unit circle */
      r2 = x * x + y * y;
    }
  while (r2 > 1.0 || r2 == 0);

  /* Box-Muller transform */
  return sigma * y * sqrt (-2.0 * log (r2) / r2);
}



int main(int argc, char *argv[]){

  int c,dim=2, N, L, **vic, *neig;
  int i,j,num, num2;
  int myrand;
  double **J, **O, theta;
  FILE *inter;
  char *filec;


  while((c=getopt(argc, argv, "s:l:n:")) != -1) {
    switch(c) {
    case 's':
      myrand=atoi(optarg);
      break;
    case 'l':
      L=atoi(optarg);
      break;
    }
  }
  N=pow(L,dim);
  srandom(myrand);


  vic=malloc(N*sizeof(int*));
  neig=malloc(N*sizeof(int));
  J=malloc(N*sizeof(double*));
  for(i=0;i<N;i++){
    vic[i]=malloc(N*sizeof(int));
    J[i]=malloc(N*sizeof(double));
  }
  filec=calloc(60,sizeof(char));
  sprintf(filec,"inter%d.txt",L);
  //inter=fopen(filec,"r");
  //fprintf(stderr,"%s\n",filec);
  //while((fscanf(inter,"%d %d\n",&i,&j)) != EOF){
  //  vic[i][neig[i]++]=j;
  //  J[i][j]=1.;
  // }
  //fclose(inter);



  for(i=0;i<N;i++)
    vic[i]=realloc(vic[i],neig[i]*sizeof(int));

  /*ROTATE THE 2 spins*/
  O=calloc(N,sizeof(double*));
  for(i=0;i<N;i++)
    O[i]=calloc(N,sizeof(double));

  for(i=0;i<N;i++) 
    O[i][i]=1;
  theta=3.14/5.;
  for(i=0;i<1;i++) {
    do{
      num = (int) rand()/(RAND_MAX+1.)*N;
      num2= (int)rand()/(RAND_MAX+1.)*N;
    }while(num==num2);
    
    O[num][num]=cos(theta);
    O[num2][num2]=cos(theta);
    O[num][num2]=sin(theta);
    O[num2][num]=-sin(theta);
  }

  for(i=0;i<N;i++) {
    for(j=0;j<N;j++) {
      // if(O[i][j]!=0)
	fprintf(stderr,"%lf ",J[i][j]);
    }
    fprintf(stderr,"\n");
  }
}


  
