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
  int c, myrand,t,num,st,temp;
  int N=1, L=20,i,j,cnt,tmp=0;
  double **J, *s, **corr, *magn, *m, H, *h,prob, correlation, magnetization=0;
  double beta=.1, value,tmprary=0,sigma; 
  int **vic,*neig;
  FILE *out;
  char outfilecorr[20], outfilem[20];
  int NUM_STORIE=1000, *flag;
  FILE * inter;
  char *filec;
  int M,sum, ric,max;
  int dim=2;

  while((c=getopt(argc, argv, "b:s:l:n:")) != -1) {
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
    }
  }
  N=pow(L,dim);

  filec=calloc(60,sizeof(char));
  srandom(myrand);
  //J=calloc(N,sizeof(double*));
  //for(i=0;i<N;i++)
  // J[i]=calloc(N,sizeof(double));

 
  // sigma=(double) 0.35/sqrt(N);

  
  
  vic=malloc(N*sizeof(int*));
  neig=malloc(N*sizeof(int));
  for(i=0;i<N;i++)
    vic[i]=malloc(N*sizeof(int));
 
  sprintf(filec,"inter%d.txt",L);
  inter=fopen(filec,"r");
  //fprintf(stderr,"%s\n",filec);
  while((fscanf(inter,"%d %d\n",&i,&j)) != EOF){
    vic[i][neig[i]++]=j;
    
  }
  fclose(inter);
  M=0;
  for(i=0;i<N;i++)
    M += neig[i];

  h=malloc(N*sizeof(double));
  flag=calloc(N,sizeof(int));
  for(i=0;i<N;i++)
    h[i]=0.0001;
  tmp=0;
  
  
  /*  for(i=0;i<N;i++){
      J[i][i]=0;
    for(j=i+1;j<N;j++){
      if(i!=j) {
	if(casual()<0.6) {
	  if(casual()<0.5)
	    J[i][j]= gaussian(sigma);
	  else
	    J[i][j]=-gaussian(sigma);
	}
	else
	  J[i][j]=0;
	
	J[j][i]=J[i][j];
	vic[i][neig[i]++]=j;
	vic[j][neig[j]++]=i;
      }
    }
    }*/

  /*  Tmp=0;
  do{
    i=casual()*N;
    j=casual()*N;
    if(casual()>0.5)
      J[i][j]=casual();
    else
      J[i][j]= -casual();
    J[j][i]=J[i][j];
    
    vic[i][neig[i]++]=j;
    vic[j][neig[j]++]=i;
    tmp++;
  }while(tmp>N*N);
  */
  
  /*  sprintf(outfilem,"interhalf.txt");
  if ((out = fopen(outfilem, "w"))==NULL){
    fprintf(stderr,"Cannot open file \n");
  }
  //  fprintf(out,"#TRUE\n");
  for(i=0;i<N/2;i++){
    for(j=0;j<N/2;j++)
      if(i!=j)
	fprintf(out,"%lf\n",beta*J[i][j]);
  }
  fclose(out);

  sprintf(outfilem,"inter.txt");
  if ((out = fopen(outfilem, "w"))==NULL){
    fprintf(stderr,"Cannot open file \n");
  }
  fprintf(out,"#TRUE\n");
  for(i=0;i<N;i++){
    for(j=0;j<N;j++)
      if(i!=j)
	fprintf(out,"%lf\n",beta*J[i][j]);
  }
  fclose(out);
  */
  for(i=0;i<N;i++)
    vic[i]=realloc(vic[i],neig[i]*sizeof(int));
  
  s=malloc(N*sizeof(double));
  magn=calloc(NUM_TEMP,sizeof(double));
  m=calloc(N,sizeof(double));
  corr=calloc(N,sizeof(double*));
  for(i=0;i<N;i++)
    corr[i]=calloc(N,sizeof(double));
  
  for(st=0;st<NUM_STORIE;st++) {
    for(i=0;i<N;i++){
      if(casual()<1)
	s[i]=1.;
      else
	s[i]=-1.;
    }
    
    for(t=0;t<NUM_TEMP*N;t++){
     
      num = (int) rand()/(RAND_MAX+1.)*N;
      
      H=h[num];
      for(j=0;j<neig[num];j++)
	H += .5* s[vic[num][j]];
      
      prob=1./(1.+exp(2*beta*H*s[num]));
      
      if(rand()/(RAND_MAX+1.)<prob)
	s[num] = -s[num];
      
      
      cnt=(int) t%N;
      
      if(cnt==0){
	
	temp= t/N;
	//      for(i=0;i<N;i++){
	magn[temp]+=s[1];
       
	
	
	//}
      }
    }
   
    for(i=0;i<N;i++){
      m[i] += s[i];
      for(j=0;j<N;j++)
	corr[i][j] += s[i]*s[j];
    }
  }
  tmprary=0;
  for(i=0;i<NUM_TEMP;i++){
    tmprary+=magn[i];
    fprintf(stderr,"%d %lf %lf\n",i,magn[i]/NUM_STORIE,tmprary/(i+1)/NUM_STORIE);
  }
  
  
  
  for(i=0;i<N;i++)
    m[i] *= (double)1./NUM_STORIE;
  
 

  // sprintf(outfilecorr,"corr.txt");
  //if ((out = fopen(outfilecorr, "w"))==NULL){
  // fprintf(stderr,"Cannot open file \n");
  //}
  correlation=0;
  for(i=0;i<N;i++){
    for(j=0;j<N;j++) {
      //  fprintf(out,"%d %d %lf\n",i,j,corr[i][j]/NUM_STORIE-m[i]*m[j]);
      correlation += corr[i][j]/NUM_STORIE-m[i]*m[j];
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
  return(0);
  
}
