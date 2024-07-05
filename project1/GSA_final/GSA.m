
function  [last_fitness,Fbest,Lbest,BestData,MeanData,MedianData]=GSA(index_F,N,max_iter,min_flag,final_per)
% function [last_fitness,Fbest,Lbest_x,Lbest_y,BestData_x,MeanData_x,MedianData_x,BestData_y]=GSA(index_F,N,max_iter,min_flag,final_per)

[down,up,dim]=test_functions_range_modify(index_F); 
% [down_x,down_y,up_x,up_y,dim]=extra_functions_range_modify(index_F);
%初始化 
X=rand(N,dim).*(up-down)+down;
V=zeros(N,dim);
last_fitness = zeros(1,N);
% X1=rand(N,1).*(up_x-down_x)+down_x;
% X2=rand(N,1).*(up_y-down_y)+down_y;
% V1=zeros(N,1);
% V2=zeros(N,1);
% last_fitness = zeros(1,N);
%存數據
BestData=[];
MeanData=[];
MedianData=[];
% BestData_x=[];
% MeanData_x=[];
% MedianData_x=[];
% BestData_y=[];
% MeanData_y=[];
% MedianData_y=[];
% [N, dim] = size(X1);
fitness = zeros(N, 2); % 初始化 fitness 向量

for iter=1:max_iter
    %檢查是否越界，越界則該X重新初始化!!!
    i=1;
    while i<=N
        for j = 1:dim
            if any(X(i,:)>up) || any(X(i,:)< down)
                X(i,:) = rand(1,dim).*(up-down)+down;            
            end
            % while (-sin(4.*pi.*X1(i,:))+2*sin(2.*pi.*X2(i,:)).^2) > 1.5
            %     X1(i,:) = rand(1)*(up_x-down_x)+down_x;
            %     X2(i,:) = rand(1)*(up_y-down_y)+down_y;
            % end
            % if any(X1(i,:)>up_x) || any(X1(i,:)< down_x)
            %     X1(i,:) = rand(1)*(up_x-down_x)+down_x;            
            % end
            % if any(X2(i,:)>up_y) || any(X2(i,:)< down_y)
            %     X2(i,:) = rand(1)*(up_y-down_y)+down_y;            
            % end
            
        end
        i=i+1;

    end
    %計算agent的fitness
    fitness = zeros(N, 1);
    for i=1:N 
        fitness(i)=test_functions_modify(X(i,:),index_F,dim);
        % x = X1(i,:);
        % y = X2(i,:);
        % fitness(i)=extra_functions_modify(x,y,index_F,dim);
        % 
    end
    if i == N
        last_fitness = fitness;
       
    end
    if min_flag==1
    [best, best_X]=min(fitness); %minimization.

    else
    [best, best_X]=max(fitness); %maximization.
    
    end        
    
    if iter==1%第一代
       Fbest=best;Lbest=X(best_X,:);
       % Fbest=best;Lbest_x=X1(best_X,:);
       % Lbest_y=X2(best_X,:);
    end
    if min_flag==1
      if best<Fbest  %minimization.

       Fbest=best;Lbest=X(best_X,:);
       % Fbest=best;Lbest_x=X1(best_X,:);
       % Fbest=best;Lbest_y=X2(best_X,:);
      end
    else 
      if best>Fbest  %maximization
       Fbest=best;Lbest=X(best_X,:);
       % Fbest=best;Lbest_x=X1(best_X,:);
       % Fbest=best;Lbest_y=X2(best_X,:);
      end
    end
      
BestData=[BestData Fbest];
MeanData=[MeanData mean(fitness)];
MedianData =[MedianData median(fitness)];
      
% BestData_x=[BestData_x Fbest];
% MeanData_x=[MeanData_x mean(fitness)];
% MedianData_x =[MedianData_x median(fitness)];

%eq.14-20計算
[M]=massCal(fitness,min_flag); 
%參考投影片p41公式
G = Gconstant(iter,max_iter);
%Calculation of accelaration in gravitational field. eq.7-10,21.
a=Gfield(M,X,G,iter,max_iter,final_per);
% a1=Gfield(M,X1,G,iter,max_iter,final_per);
% a2=Gfield(M,X2,G,iter,max_iter,final_per);
%Agent movement. eq.11-12
[X,V]=move(X,a,V);
% [X1,V1]=move(X1,a1,V1);
% [X2,V2]=move(X2,a2,V2);
end %iteration