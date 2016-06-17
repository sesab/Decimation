#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define MAX 1000

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
  int c, myrand, num,st,temp, NUM_TEMP,b,time_max=10, *perm, t;
  int N=1, L=20,i,j,cnt,tmp=0, Temp=20;
  double **J, *s, **corr, magn, *m, H, *h,prob, correlation, magnetization=0;
  double beta=.1, value,tmprary=0,sigma, **interactions; 
  int **vic,*neig;
  FILE *out;
  char outfilecorr[20], outfilem[20];
  int NUM_STORIE=100, *flag;
  FILE * inter;
  char *filec;
  int M,sum, ric,max,  number_average=0,k, transient;
  int dim=2;

  while((c=getopt(argc, argv, "b:s:l:t:n:")) != -1) {
    switch(c) {
    case 's':
      myrand=atoi(optarg);
      break;
    case 'l':
      L=atoi(optarg);
      break;
    case 'b':
      beta=atof(optarg);
      break;
    case 'n':
      NUM_STORIE=atoi(optarg);
      break;
    case 't':
      Temp=atoi(optarg);
      break;
    }
  }
  N=pow(L,dim);
  transient=N*100;
  filec=calloc(60,sizeof(char));
  srandom(myrand);
  //J=calloc(N,sizeof(double*));
  //for(i=0;i<N;i++)
  // J[i]=calloc(N,sizeof(double));

 
  // sigma=(double) 0.35/sqrt(N);

  
  
  vic=malloc(N*sizeof(int*));
  interactions=malloc(N*sizeof(double*));
  neig=malloc(N*sizeof(int));
  for(i=0;i<N;i++){
    vic[i]=malloc(30*sizeof(int));
    interactions[i]=malloc(30*sizeof(double));
  }
  perm=malloc(N*sizeof(int));
  sprintf(filec,"rinter%d.txt",L);
  inter=fopen(filec,"r");
  //fprintf(stderr,"%s\n",filec);
  while((fscanf(inter,"%d %d %lf\n",&i,&j, &value)) != EOF){
    interactions[i-1][neig[i-1]]=value;
    vic[i-1][neig[i-1]]=j-1;
    //  fprintf(stderr,"%lf %lf\n",value,interactions[i-1][neig[i-1]]);
    neig[i-1]++;
  }
  fclose(inter);
  M=0;
  for(i=0;i<N;i++)
    M += neig[i];

  h=malloc(N*sizeof(double));
  flag=calloc(N,sizeof(int));
  for(i=0;i<N;i++)
    h[i]=-0.00001*casual();
  tmp=0;
  
 
  for(i=0;i<N;i++){
    vic[i]=realloc(vic[i],neig[i]*sizeof(int));
    interactions[i]=realloc(interactions[i],neig[i]*sizeof(double));
  }
  //if((beta>.92)||(beta<.84))
  // NUM_TEMP=100*N;
  //else
  NUM_TEMP=MAX*N;
 
  s=malloc(N*sizeof(double));
  time_max=(int) NUM_TEMP/N;
  
  
  m=calloc(N,sizeof(double));
  corr=calloc(N,sizeof(double*));
  for(i=0;i<N;i++)
    corr[i]=calloc(N,sizeof(double));

  //fprintf(stderr,"%d %d %d\n",Temp,NUM_STORIE,NUM_TEMP);
  // getchar();
  magn=1.;
  for(b=0;b<Temp;b++) {
    beta=1./(.96+b*.01);
    for(i=0;i<N;i++){
      m[i]=0;
      for(j=0;j<N;j++)
	corr[i][j]=0;
    }
    number_average=0;
   
    for(st=0;st<NUM_STORIE;st++) {
      for(i=0;i<N;i++){
	if(magn>0) {
	  if(casual()<magn)
	    s[i]=1.;
	  else
	    s[i]=-1.;
	}
	else{
	  if(casual()<-magn)
	    s[i]=1.;
	  else
	    s[i]=-1.;
	}
	
      }
      
      for(t=0;t<NUM_TEMP;t++){
	//CREATE RANDOM PERTUMATION 
	for (k=0; k<N; ++k){
	  perm[i]=i;
	}
	for (k=0; k<N; ++k){
	  j = rand() % (k+1);
	  perm[k] = perm[j];
	  perm[j] = k;
	}
	
	for(k=0;k<N;k++) {
	  num=perm[k]; //pick sites permutated
	  H=h[num];
	  for(j=0;j<neig[num];j++)
	    H += .5* s[vic[num][j]] * interactions[num][j];
	  
	  prob=1./(1.+exp(2*beta*H*s[num]));
	  
	  if(rand()/(RAND_MAX+1.)<prob)
	    s[num] = -s[num];
	}

	cnt=(int) t%(10*N);
	
	if(cnt==0){
	  magn=0;
	  for(k=0;k<N;k++){
	    magn += s[k];
	  }
	  magn=(double)magn/N;
	  fprintf(stderr,"%d %lf\n",t, magn);
	}
	if((t>100*N) && (t%100==0)) {
	  number_average++;
	  for(i=0;i<N;i++){
	    m[i] += s[i];
	    for(j=0;j<N;j++)
	      corr[i][j] += s[i]*s[j];
	  }
	}
      }
      fprintf(stderr,"\n");
      //for(i=0;i<N;i++){
      // m[i] += s[i];
      // for(j=0;j<N;j++)
      //	corr[i][j] += s[i]*s[j];
      //}
    }
    // tmprary=0;
    // for(i=0;i<time_max;i++){
    //  tmprary+=magn[i];
    //  fprintf(stderr,"%d %lf %lf %d\n",i,magn[i]/number_average,tmprary/(i+1)/number_average,number_average);
    //}
    
    
  
    for(i=0;i<N;i++)
      m[i] *= (double)1./number_average;
    
      
  

    // sprintf(outfilecorr,"corr.txt");
    //if ((out = fopen(outfilecorr, "w"))==NULL){
    // fprintf(stderr,"Cannot open file \n");
    //}
  
    correlation=0;
    for(i=0;i<N;i++){
      for(j=0;j<N;j++) {
	//  fprintf(out,"%d %d %lf\n",i,j,corr[i][j]/NUM_STORIE-m[i]*m[j]);
	correlation += corr[i][j]/number_average-m[i]*m[j];
      }
      //printf("%d %lf\n",i,(double)magn[i]/NUM_STORIE);
    }
    //  fclose(out);
    
    //  sprintf(outfilem,"magn.txt");
    //if ((out = fopen(outfilem, "w"))==NULL){
    // fprintf(stderr,"Cannot open file \n");
    //}
    magnetization=0;
    for(i=0;i<N;i++) {
      //  fprintf(out,"%d %lf\n",i,m[i]);
      magnetization += m[i];
    }
    //  fclose(out); 
    
    fprintf(stdout,"%lf %lf %lf\n",1/beta,(double) magnetization/N, (double) correlation/N);
    fflush(stdout);
  }
  return(0);
  
}
