function [X,htnn,tsvd_rank] = prox_htnn_C_4(Y,rho)

% The proximal operator for the order-D tensor nuclear norm under learnable
% transform matrix

p = length(size(Y));
n = zeros(1,p);
for i = 1:p
    n(i) = size(Y,i);
end
X = zeros(n);


Y1 = Unfold(Y,n,3);
[u0,~,v0] = svd(Y1*Y1','econ');
M{1} = v0*u0';


L = ones(1,p);
for i = 3:p
     Y = tmprod(Y,M{i-2},i);
    L(i) = L(i-1) * n(i);
end

htnn = 0;
tsvd_rank = 0;
       
for i=1:L(p)
[U,S,V] = svd(Y(:,:,i),'econ');
S = diag(S);

gamma = 20;
S = firm_threshold(S,1.3*rho,gamma*rho*1.3);

X(:,:,i) = U*diag(S)*V';
htnn = htnn+sum(S);
tsvd_rank = 1;
end

rho=1;
for j=3:p
     Tran_M=M{j-2};
     a=sum(diag(Tran_M*(Tran_M)'))/n(j);
     rho=rho*a;
end

htnn = htnn/rho;

for i = p:-1:3
    X = tmprod(X,inv(M{i-2}),i);
end  

X = real(X);