%%%%
% This software take as an input the matrix of interaction in d=2 and size
% L and rotate a fraction of nodes (MAX/L*L) of an angle x the output is an
% interaction matrix V and a list of nn inter
%%%%
function Rotation(x,L)
%2D Rotation matrix counter-clockwise.
%
%R=R2d(deg)
%
%Input is in degrees.
%
%See also Rx,Ry,Rz,,R3d,M2d,M3d
N=L*L
R=eye(N);
temp=randperm(N);
MAX=10;
for t=1:MAX;
  i=temp(t);
  j=temp(end-t);
  R(i,i) = cosd(x);
  R(i,j)= -sind(x);
  R(j,j) = cosd(x);
  R(j,i)= -sind(x);
end


%T =  diag(ones(N-1,1),1) + diag(ones(N-1,1),-1);

T=dlmread('/Users/sbradde/Documents/Projects/Decimation/Ising/Rotation/lattice2d20.txt')
sum(sum(T>0))

Eig=eig(T);

V=R^-1*T*R;
figure(1)
imagesc(T)
figure(2)
imagesc(V)

Eignew=eig(V);

check=Eignew-real(Eignew);
sum(check)
val(:,1)=Eig;
val(:,2)=real(Eignew);
figure(3)
hist(val,50);


dlmwrite('/Users/sbradde/Documents/Projects/Decimation/Ising/Rotation/rotatelattice2d20.txt',V,' ');

M=sum(sum(V>0))
inter=zeros(M,3);
cnt=1;
for i=1:N
    for j=1:N
        if(V(i,j)>0)
            inter(cnt,1)=i;
            inter(cnt,2)=j;
            inter(cnt,3)=V(i,j);
            cnt=cnt+1;
        end
    end
end
dlmwrite('/Users/sbradde/Documents/Projects/Decimation/Ising/Rotation/rinter50.txt',inter,' ');

