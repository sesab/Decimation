%%Computing covariance of downloaded data
clear all
%filename1='DATA/Historical_IBBdata6Y.mat';
filename1='DATA/Historical_data6Y.mat';
%filename1='DATA/Historical_SP500data.mat';
load(filename1);
%data2=load(filename2);
%data3=load(filename3);
l=1511;
%l=254;
%l=505;
cnt=1;
for i=1:length(stock);
    if (isempty(stock{i})==0)
     if isempty(stock{i}.DataError)
       data{cnt}=stock{i}.Close;
        time_data{cnt}=stock{i}.Date;
        cnt=cnt+1;
     end
    end
end

for i=1:cnt-1
    len(i)=size(data{i},1);
end

tmp=1;
for i=1:cnt-1  
    if(len(i)==l)
        time(tmp,:)=time_data{i};
        matrix(tmp,:)=data{i};
        tmp=tmp+1
    end
end

N=tmp-1;
%%
NSAMPLE=1;
YY = zeros(N*NSAMPLE,floor(l/NSAMPLE));
for t=1:floor(l/NSAMPLE);
    YY(:,t) = reshape(matrix(:,NSAMPLE*(t-1)+1:NSAMPLE*t),N*NSAMPLE,1);
end

CC8 = cov(YY');
[V8,E8] = eig(CC8);

starts = [1 floor( N*NSAMPLE/100) floor( N*NSAMPLE/64) ...
    floor( N*NSAMPLE/32) floor( N*NSAMPLE/16) floor( N*NSAMPLE/8) ...
    floor( N*NSAMPLE/4) floor(N*NSAMPLE/2) N*NSAMPLE-1]
for n=1:length(starts);
    n
    Y = V8(:,starts(n):N*NSAMPLE)*V8(:,starts(n):N*NSAMPLE)'*YY;
    Y = Y - mean(Y,2)*ones(1,floor(l/NSAMPLE));
    M4_8(n,:) = mean(Y.^4,2)./(mean(Y.^2,2).^2);
end
    
frac = (NSAMPLE*N-starts+1)/(NSAMPLE*N);


figure(1)
loglog(sort(1./diag(E8),'ascend')/mean(1./diag(E8)),[1:N*NSAMPLE]/(N*NSAMPLE),'r.',...
    [0.001:0.001:1],(0.3)*[0.001:0.001:1],'g--',...
    [0.001:0.001:1],(30)*[0.001:0.001:1].^2,'c--')
legend('one time bin','eight time bins','D_{eff} = 2','D_{eff} = 4')
xlabel('normalized eigenvalue')
ylabel('cumulative density')
axis([0.001 100 0.0005 1])
axis square
set(gca,'FontSize',16,'TickDir','Out')
%print -depsc2 160616_fig01.eps

figure(2)
plot(frac,M4_8,[0.001 1],[3 3],'k--')
xlabel('fraction of remaining modes')
ylabel('normalized fourth moments')
axis([0.001 1 1 10])
axis square
%set(gca,'FontSize',16,'TickDir','Out')
%print -depsc2 160616_fig02.eps

%%
N=length(Eig{1});
%NSAMPLE=10;
%y=sort(reshape(val,[N*NSAMPLE,1]),'descend');
y=mean(val)';
NSAMPLE=1;
loglog(1./y,[1:N*NSAMPLE]./(N*NSAMPLE),'o');
%init=NSAMPLE+1;
init=13;
X=log(1./y(init:end));
r=size(X,1);
Y=log([1:r]/r)';

out = excludedata(X,Y,'domain',[-6 0]);


f=fit(X(~out),Y(~out),'poly1')
%figure(2)
%plot(f)

Delta=(1-min(1./y)/10)/100;

figure(3)
loglog(exp(X),[1:r]/r,'o')
hold on
plot([min(1./y(init:end))/2:Delta:2],exp(f.p2)*[min(1./y(init:end))/2:Delta:2].^f.p1 ,'--r')
hold off


[pyeig,peig]=hist(y(50:end),100);
figure(1)
bar(peig(pyeig>0),pyeig(pyeig>0)./sum(pyeig));
hold on
%Delta=(max(y)-1)/100;
%plot([1:Delta:max(Eig)],exp(f.p2)*[1:Delta:max(Eig)].^(f.p1-1) ,'--r')
hold off


%%
%%
starts = [1 N*4+1 N*6+1 N*7+1 N*(7+1/2)+1 N*(7+3/4)+1 N*(7+7/8)+1 ...
    N*(7+15/16)+1 N*(7+31/32)+1 N*8-3 N*8-2 N*8-1]
for n=1:length(starts);
    n
    Y = V8(:,starts(n):N*8)*V8(:,starts(n):N*8)'*YY;
    Y = Y - mean(Y,2)*ones(1,floor(R*T/8));
    M4_8(n,:) = mean(Y.^4,2)./(mean(Y.^2,2).^2);
end
    
frac = (8*N-starts+1)/(8*N);


figure(1)
loglog(sort(1./diag(E),'ascend')/mean(1./diag(E)),[1:N]/N,'b.',...
    sort(1./diag(E8),'ascend')/mean(1./diag(E8)),[1:N*8]/(N*8),'r.',...
    [0.001:0.001:1],(0.3)*[0.001:0.001:1],'g--',...
    [0.001:0.001:1],(30)*[0.001:0.001:1].^2,'c--')
legend('one time bin','eight time bins','D_{eff} = 2','D_{eff} = 4')
xlabel('normalized eigenvalue')
ylabel('cumulative density')
axis([0.001 100 0.0005 1])
axis square
set(gca,'FontSize',16,'TickDir','Out')
print -depsc2 160616_fig01.eps


figure(2)
loglog(frac,M4_8,[0.001 1],[3 3],'k--')
xlabel('fraction of remaining modes')
ylabel('normalized fourth moments')
axis([0.001 1 1 1000])
axis square
set(gca,'FontSize',16,'TickDir','Out')
print -depsc2 160616_fig02.eps



