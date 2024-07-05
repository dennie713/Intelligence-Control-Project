function a = Gfield(M,X,G,iter,max_iter,final_per)
[N,dim]=size(X);

kbest=final_per+(1-iter/max_iter)*(100-final_per); 
kbest=round(N*kbest/100);%¥|±Ë¤­¤J
[~, index]=sort(M,'descend');
F = zeros(N, dim);
for i=1:N
    for ii=1:kbest
        j=index(ii);
        if j~=i
            R=norm(X(i,:)-X(j,:),2); %eq.8
            for k=1:dim 
                F(i,k)=F(i,k)+rand*(M(j))*((X(j,k)-X(i,k))/(R+eps));%eq.7 ¡B9
            end
        end
    end
end
a=F.*G; %eq. 10