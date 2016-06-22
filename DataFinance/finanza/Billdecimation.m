%   let's look carefully at the idea of RG for neurons
%   start with published retinal data on 160 cells
clear all
 load('bint_fishmovie32.mat')
[R,N,T] = size(bint);


for kk=1:100;
    kk
    idx = randperm(R);
    idx = idx(1:round(R/2));
    for n=1:N;
        XX(n,:) = reshape(bint(idx,n,:),1,round(R/2)*T);
    end
    A = sort(eig(cov(XX')),'descend');
    A = A/mean(A);
    LL1(kk,:) = 1./A;
end

figure(1)
loglog(mean(LL1),[1:N]/N,'b.')
hold on
for n=1:N;
    plot([mean(LL1(:,n))-std(LL1(:,n)) mean(LL1(:,n))+std(LL1(:,n))],...
        (n/N)*[1 1],'b-')
end
hold off
xlabel('normalized eigenvalue')
ylabel('cumulative density')
axis square
set(gca,'FontSize',16,'TickDir','Out')

clear XX
for n=1:N;
   XX(n,:) = reshape(bint(:,n,:),1,R*T);
end

CC = cov(XX');
[V,E] = eig(CC);

starts=[1 floor(N/64) floor(N/32) floor(N/16)...
    floor(N/8) floor(N/4) floor(N/2) N-1]
for n=1:length(starts);
    n
    Y = V(:,starts(n):N)*V(:,starts(n):N)'*XX;
    Y = Y - mean(Y,2)*ones(1,R*T);
    M4(n,:) = mean(Y.^4,2)./(mean(Y.^2,2).^2);
end

frac = (N-starts+1)/(N);
figure(2)
loglog(frac,M4,[.01 1], [3 3],'k--')
xlabel('fraction of remaining modes')
ylabel('normalized fourth moments')
axis([0.01 1 1 1000])
axis square
set(gca,'FontSize',16,'TickDir','Out')
print -depsc2 Alldegreesfreedom.eps


%   we had the idea of looking at 8 consecutive time points
YY = zeros(N*8,floor(R*T/8));
for t=1:floor(R*T/8);
    YY(:,t) = reshape(XX(:,8*(t-1)+1:8*t),N*8,1);
end
CC8 = cov(YY');
[V8,E8] = eig(CC8);

starts = [1 N*4+1 N*6+1 N*7+1 N*(7+1/2)+1 N*(7+3/4)+1 N*(7+7/8)+1 ...
    N*(7+15/16)+1 N*(7+31/32)+1 N*8-3 N*8-2 N*8-1]
for n=1:length(starts);
    n
    Y = V8(:,starts(n):N*8)*V8(:,starts(n):N*8)'*YY;
    Y = Y - mean(Y,2)*ones(1,floor(R*T/8));
    M4_8(n,:) = mean(Y.^4,2)/(mean(Y.^2,2).^2);
end
    
frac = (8*N-starts+1)/(8*N);


figure(3)
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


figure(4)
colors=distinguishable_colors(N*8);
for k=1:N*8
 loglog(frac,M4_8(:,k),'-','color', colors(k,:))
 hold on
end
loglog([0.001 1],[3 3],'k--')
xlabel('fraction of remaining modes')
ylabel('normalized fourth moments')
axis([0.001 1 1 1000])
axis square
set(gca,'FontSize',16,'TickDir','Out')
print -depsc2 160616_fig02.eps
hold off
%save 160616.mat


    