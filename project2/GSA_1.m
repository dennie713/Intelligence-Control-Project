function  [last_fitness,Fbest,Lbest,BestData,MeanData,MedianData, fitness]=GSA_1(N,max_iter,min_flag,final_per)
    %初始化 
    dim = 3;
    up = 350;
    down = 0;
    X=rand(N,dim).*(up-down)+down;
    V=zeros(N,dim);
    last_fitness = zeros(1,N);
    %存數據
    BestData=[];
    MeanData=[];
    MedianData=[];
    fitness = zeros(N, 2); % 初始化 fitness 向量
    
    for iter=1:max_iter
        %檢查是否越界，越界則該X重新初始化!!!
        i=1;
        while i<=N
            for j = 1:dim
                if any(X(i,:)>up) || any(X(i,:)< down)
                    X(i,:) = rand(1,dim).*(up-down)+down;            
                end
                
            end
            i=i+1;
    
        end
        %計算agent的fitness
        A = 1;
        fitness = zeros(N, 1);
        for i=1:N
            [fitness(i), y, ~, ~] = ballbeam(X(i,:), A);
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
        end
        if min_flag==1
          if best<Fbest  %minimization.
    
           Fbest=best;Lbest=X(best_X,:);
          end
        else 
          if best>Fbest  %maximization
           Fbest=best;Lbest=X(best_X,:);
          end
        end
    
    BestData=[BestData Fbest];
    MeanData=[MeanData mean(fitness)];
    MedianData =[MedianData median(fitness)];
    
    %eq.14-20計算
    [M]=massCal(fitness,min_flag); 
    %參考投影片p41公式
    G = Gconstant(iter,max_iter);
    %Calculation of accelaration in gravitational field. eq.7-10,21.
    a=Gfield(M,X,G,iter,max_iter,final_per);
    %Agent movement. eq.11-12
    [X,V]=move(X,a,V);
end %iteration