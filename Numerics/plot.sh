#PRENDI I DATI E PLOTTALI CON COLORI SFUMATI

awk 'BEGIN{tmp=0}{if($1!~"\#interruption") {val[count++]=$1; val2[$1,tmp]=$3/$2;} else {tmp++;count=0;} }END{ for(j=0;j<=100;j++) { printf("%d ",val[j]); for(i=0;i<=tmp;i++) printf("%lf ",val2[val[j],i]); printf("\n");}}' prova.dat > file.txt

