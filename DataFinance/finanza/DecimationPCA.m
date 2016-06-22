%Compute the eigenvalue using decimation of a covariance matrix
%with some signal


%% Introducing a random matrix + signal
clear YY
M=10000; %timepoints
N=200; % number of variables
X=randn(N,M);
R=floor(M/8);
YY = zeros(N*8,floor(M/8));
for t=1:R;
    YY(:,t) = reshape(X(:,8*(t-1)+1:8*t),N*8,1);
    %YY(:,t) = reshape(X(:,8*(t-1)+1:8*t),N*8,1);    
end

%%SIGNAL
x=[1:1:N*8];
Eigenvalues=10*rand(N*8,1);
M1=zeros(N*8,N*8);
%Create the matrix with eigenvalues Eigenvalues
for i = 1:length(Eigenvalues)
   e_current = zeros(1,N*8); % make standard unit vector
    e_current(i) = 1;
    M1 = M1 + Eigenvalues(i)*(ones(N*8)-eye(N*8)) + eye(N*8); % add mode to Signal matrix
end

%R=M;
%X=randn(N*8,M);
%YY=X;

C_Matrix=YY';
%CC8 = cov(YY');
CC8=cov(C_Matrix);
matrix=C_Matrix';
[V8,E8] = eig(CC8);
%[V8,E8] = eig(matrix);

%%
clear M4_8
clear Y



starts = [1 N*4+1 N*6+1 N*7+1 N*(7+1/2)+1 N*(7+3/4)+1 N*(7+7/8)+1 ...
    N*(7+15/16)+1 N*(7+31/32)+1 N*8-3 N*8-2 N*8-1]

for n=1:length(starts);
    n
    Y = V8(:,starts(n):N*8)*V8(:,starts(n):N*8)'* matrix;
    Y = Y - mean(Y,2)*ones(1,R);
    M4_8(n,:) = mean(Y.^4,2)./(mean(Y.^2,2).^2);
end
    
frac = (N*8-starts+1)/(N*8);

figure(11)
loglog(sort(1./diag(E8),'ascend')/mean(1./diag(E8)),([1:N*8]/N*8),'r.',...
    [0.001:0.001:1],(0.3)*[0.001:0.001:1],'g--',...
    [0.001:0.001:1],(30)*[0.001:0.001:1].^2,'c--')
legend('one time bin','eight time bins','D_{eff} = 2','D_{eff} = 4')
xlabel('normalized eigenvalue')
ylabel('cumulative density')
axis([0.001 1 0.0005 1])
axis square
set(gca,'FontSize',16,'TickDir','Out')
print -depsc2 160616_fig03.eps


figure(10)
colors=distinguishable_colors(N*8);
for k=1:N*8
    loglog(frac,M4_8(:,k),'-','color', colors(k,:));
    hold on
end
loglog([0.001 1],[3 3],'k--');
xlabel('fraction of remaining modes')
ylabel('normalized fourth moments')
axis([0.001 1 1 10])
axis square
set(gca,'FontSize',16,'TickDir','Out')
print -depsc2 160616_fig04.eps
hold off
