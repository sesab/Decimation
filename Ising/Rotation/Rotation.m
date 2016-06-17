%%%%
% This software take as an input the matrix of interaction in d=2 and size
% L and rotate a fraction of nodes (MAX/L*L) of an angle x the output is an
% interaction matrix V and a list of nn inter
%%%%
L=30
x=20.5

%2D Rotation matrix counter-clockwise.
%
%R=R2d(deg)
%
%Input is in degrees.
%
%See also Rx,Ry,Rz,,R3d,M2d,M3d
N=L*L
R=eye(N);
T=dlmread('/Users/sbradde/Documents/Projects/Decimation/Ising/Rotation/lattice2d30.txt');
sum(sum(T>0))

temp=randperm(N);

MAX=100;

vect=zeros(MAX,1);
vect(1)=temp(1);
cnt=1;
t=2;
while cnt < MAX && t < N
     vic=0;
    for i=1:cnt
        if(T(temp(t),vect(i))~=0) %Pick them if they are not nn so we won't create frustrated plaquette
             vic=vic+1;
        end
    end
    if(vic==0)
     cnt=cnt+1;
     vect(cnt)=temp(t);
    end
    t=t+1;
end

nn=0;
for t=2:MAX
    for i=1:t-1
         if(T(vect(t),vect(i))~=0) %They are already nn so we can create frustrated plaquette
             nn=nn+1;
         end
    end
end
nn

for t=1:MAX;
  i=vect(t);
  j=vect(end-t+1);
  R(i,i) = cosd(x);
  R(i,j)= -sind(x);
  R(j,j) = cosd(x);
  R(j,i)= -sind(x);
end


%T =  diag(ones(N-1,1),1) + diag(ones(N-1,1),-1);



Eig=eig(T);
Matrix=diag(Eig);


V=R'*T*R;
Symm=issymmetric(V)
TT=R'*Matrix*R;
figure(1)
imagesc(T)
figure(2)
imagesc(V)
%imagesc(TT)

Eignew=eig(V);
eigsym=eig(TT);

check=Eignew-real(Eignew);
sum(check);
val(:,1)=Eig;
val(:,2)=real(Eignew);
%val(:,3)=eigsym;
figure(3)
hist(val,50);


dlmwrite('/Users/sbradde/Documents/Projects/Decimation/Ising/Rotation/rotatelattice2d30.txt',V,' ');

M=length(find(V~=0))
inter=zeros(M,3);
cnt=1;
for i=1:N
    for j=1:N
        if(V(i,j)~=0.)
            inter(cnt,1)=i;
            inter(cnt,2)=j;
            inter(cnt,3)=V(i,j);
            cnt=cnt+1;
        end
    end
end
dlmwrite('/Users/sbradde/Documents/Projects/Decimation/Ising/Rotation/newrinter30.txt',inter,' ');

