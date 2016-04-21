/***********************************/
/* This program is defining default matrices and diagonalize using llapack*/
/* Run in the following way gcc -lm -llapack -O3 file.c */
/* Default Regular lattice in d=2 dimension OPTION*/
/* PLOT if you want to print the graph*/
/***********************************/

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
#define ITER 1000

extern void dsyev_( char *jobz, char *uplo, int *n, double *a, int *lda, double *w, double *work, int *lwork, int *info );


int main(int argc, char** argv){
  int PLOT=1,OPTION=0;
  int i, j, *k, xi, xj, yi, yj, N, L=70, n, *index, nrun, cont, *conta, d;
  double D0=1,kappa,*theta,dij,dx,dy,*lambda,m,err,aus, *value;
  double *a=NULL, *work=NULL, *w=NULL;
  int lwork,info, myrand;
  //char filec[60];
  //FILE *prova;
  FILE *prova;


  if(argc!=5){
    printf("3 entries :\nL:square root of the number of points  of the square lattice, \nD0:range of the exponential interaction (total linear N of lenght 1),\nkappa>3: power-law of the theta distribution \n");
    exit(1);
  }
  
  sscanf(argv[1],"%d",&L);
  sscanf(argv[2],"%lf",&D0);
  sscanf(argv[3],"%lf",&kappa);
  sscanf(argv[4],"%d", &myrand);

 //  sprintf(filec,"eigL%03d_%1.2fD0%1.2fkappa.txt",L,D0,kappa);
  //if ((eig = fopen(filec, "w"))==NULL){
  // printf("Cannot open file \n");
  //}
  
  
  N=L*L;
  k=(int*)calloc(N,sizeof(int));
  theta=(double*)calloc(N,sizeof(double));
  srand48(myrand); 
  value=calloc(N,sizeof(double));
  conta=calloc(N,sizeof(int));
  a = (double *)malloc(N*N*sizeof(double));
  w = (double *)malloc(N*sizeof(double));  

  if(OPTION==1) {
    m=2.0;
    
    for (i=0;i<N;i++){
      k[i]=m*pow(drand48(),1./(1.-kappa));
      while(k[i]>(int)(sqrt(N/2)))
	k[i]=m*(int)pow(drand48(),1./(1.-kappa));
      theta[i]=k[i];      
    }
    //  fprintf(stderr," mean k %lf\n",(double)value/N);
    
    for(nrun=1;nrun<2000;nrun++){
      err=0;
      for(n=0;n<N;n++){
	i=(float)N*drand48();
	aus=0;
	for(j=0;j<N;j++){
	  if(i!=j){
	    xi = (int)((float)i/(float)L);
	    yi = i-L*xi;
	  xj = (int)((float)j/(float)L);
	  yj = j-L*xj;
	  dx = xi-xj;
	  dy = yi-yj;
	  dij = sqrt((double)(dx*dx+dy*dy));
	  aus += exp(-dij/D0)*theta[j];
	  }
	}
	if(err<fabs(1-theta[i]/((double)k[i]/aus)))
	  err=fabs(1.-theta[i]/((double)k[i]/aus));
	theta[i]=(double)k[i]/aus;
      }
      //    fprintf(stderr,"%lf %lf\n",err,theta[i]);
      if(err<0.01)
	break;
    }
    
    //    for(j=0;j<N;j++){
    // fprintf(stderr,"=%lf\n",);
    
    cont=0;
    for(i=0;i<N;i++){
      for(j=0;j<N;j++){
	if(i!=j){
	  xi=(int)((float)i/(float)L);
	  yi=i-L*xi;
	  xj=(int)((float)j/(float)L);;
	  yj=j-L*xj;
	  dx=fabs(xi-xj);
	  dy=fabs(yi-yj);
	  dij=sqrt(dx*dx+dy*dy);
	  d=abs(i-j);
	//	value[d] += theta[i]*theta[j]*exp(-dij/D0);
	//conta[d]++;
	  a[cont++]=theta[i]*theta[j]*exp(-dij/D0);
	  //printf("%lf %lf %lf\n",dx,dy,a[cont-1]);
	}
	else
	  a[cont++]=0.;
      }
    }
    
    prova=fopen("test.dat","w");
    //for(d=0;d<N;d++) {
    //fprintf(prova,"%d %lf\n", d,(double)value[d]/conta[d]);
    for(i=0;i<N;i++) {
      for(j=0;j<N;j++)
	fprintf(prova,"%lf ",a[i*N+j]);
      fprintf(prova,"\n");
    }
    fclose(prova);
  }
  else {
   
    cont=0;
    for(i=0;i<N;i++){
      for(j=0;j<N;j++){
	if(i!=j){
	  xi=(int)((float)i/(float)L);
	  yi=i-L*xi;
	  xj=(int)((float)j/(float)L);;
	  yj=j-L*xj;
	  dx=fabs(xi-xj);
	  dy=fabs(yi-yj);
	  dij=sqrt(dx*dx+dy*dy);
	  d=abs(i-j);
	  if( ((dx==1)&& (dy==0)) || ((dy==1) && (dx==0)))
	    a[cont++]=1.;
	  else
	    a[cont++]=0.;
	  //printf("%lf %lf %lf\n",dx,dy,a[cont-1]);
	}
	else
	  a[cont++]=0.;
      }
    }
    if(PLOT==1){
      prova=fopen("test.dat","w");
      for(i=0;i<N;i++) {
	for(j=0;j<N;j++)
	  fprintf(prova,"%lf ",a[i*N+j]);
	fprintf(prova,"\n");
      }
      fclose(prova);
    }
  }


  work = (double *)malloc(1*sizeof(double));
  lwork=-1;
  dsyev_( "N", "L", &N, a, &N, w, work, &lwork, &info );
  lwork= work[0];
  free(work);
  work = (double *)malloc(lwork*sizeof(double));
  dsyev_( "N", "L", &N, a, &N, w, work, &lwork, &info );
  lambda=calloc(N+1,sizeof(double));
  index=(int*)calloc(N+1,sizeof(int));
  for(i=0;i<N;++i){
    lambda[i+1]=w[i];
  }
  
  if(lambda[N]>1) 
    for(i=1;i<=N;i++){
      fprintf(stdout, "%lf %lf\n",lambda[i],lambda[N]);
    }
  //fclose(eig);

  
  //free(w);
  free(a);
  
  return 0;
}
