N=50*8;
S=10000;
m=1;
beta=1.02;
eigenC=zeros(N,1);
%J =  diag(ones(N-1,1),1) + diag(ones(N-1,1),-1); %1d
J=dlmread('/Users/sbradde/Documents/Projects/Decimation/Ising/Rotation/lattice2d20.txt');

% This is the interaction matrix
    %----------------------------------
proteins = zeros(S,N);
E_o=zeros(S);
    
    %Generating the proteins to be a sequence of -1 and 1s.
    %-------------------------------------------------------
for i=1:S
        proteins(i,:) = randi(0:1,1,N);
        proteins(i,:) = (proteins(i,:)*2) - ones(size(proteins(i,:)));
        
        %Calculating the corresponding energy.
        %-------------------------------------
        E_o(i) = proteins(i,:)*(beta*J/2*proteins(i,:)');
end
    
    %Monte Carlo Algorithm
    %-----------------------
for i=1:S
    for M=1:m
            hot = randi(N);
            proteins(i,hot)=-proteins(i,hot);
            E_new(i) = proteins(i,:)*(beta*J/2*proteins(i,:)');
            DeltaE= E_new(i)-E_o(i);
            if(DeltaE>0)
                ProbAccept=exp(-DeltaE);
                decider=rand;
                if rand>ProbAccept
                    E_new(i)=E_o(i);
                    proteins(i,hot)=-proteins(i,hot);
                end
            end
            E_o(i) =E_new(i);
        Y*Y
    end    
end
C=cov(proteins);
[V8,E8] = eig(C);


%%
%%
clear M4_8
clear Y
R=S;
init=100;
N=50;
matrix=proteins(init:end,:)';

starts = [1 N*4+1 N*6+1 N*7+1 N*(7+1/2)+1 N*(7+3/4)+1 N*(7+7/8)+1 ...
    N*(7+15/16)+1 N*(7+31/32)+1 N*8-3 N*8-2 N*8-1]

for n=1:length(starts);
    n
    Y = V8(:,starts(n):N*8)*V8(:,starts(n):N*8)'* matrix;
    Y = Y - mean(Y,2)*ones(1,R-init+1);
    M4_8(n,:) = mean(Y.^4,2)./(mean(Y.^2,2).^2);
end

for n=1:length(starts);
    n
    Y = V8(:,starts(n):N*8)*V8(:,starts(n):N*8)'* matrix;
    Y = Y - mean(Y,2)*ones(1,R-init+1);
    for i=1:N;
        for j=1:N;
            for k=1:N;
                for l=1:N;
            M4_all(n,i,j) = mean(Y(i).^2*Y(j,:).^2,2)./(mean(Y(i,:)*Y(j,:),2).^2);
        end
    end
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
print -depsc2 160616_fig05.eps


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
print -depsc2 160616_fig06.eps
hold off
