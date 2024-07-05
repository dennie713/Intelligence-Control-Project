clear;clc;close all;
format long e;
dt = 0.001;
t = linspace(0, 10, 10/dt) ;
    
% benchmark function select
fid1 = fopen('problem1.txt','w');
% fid1_x = fopen('problem1.txt','w');
% fid1_y = fopen('problem1.txt','w');
% fid2 = fopen('problem2.txt','w');
fid3 = fopen('problem3.txt','w');
fid4 = fopen('problem4.txt','w');
% fid5 = fopen('problem5.txt','w');
for A = 1:1
    tic
    %秸把计
     % index_F=12; %testbench  function絪腹
     max_iter=500; %Ω计
     run = 1;
     N=50;%agent计秖 
     min_flag=0; % 1: minimization, 0: maximization
     
     % alpha = 20;G0 = 100;%p41そΑ把计
     final_per = 2;%程Ωagent把籔ゑㄒ
     % best = [];
     for runn = 1:run
        [last_fitness(runn,:),Fbest,Lbest,BestData(runn,:),MeanData(runn,:),MedianData(runn,:)]=GSA_1(N,max_iter,min_flag,final_per);
        % [last_fitness(runn,:),Fbest,Lbest_x,Lbest_y,BestData_x(runn,:),MeanData_x(runn,:),MedianData_x(runn,:)]=GSA(index_F,N,max_iter,min_flag,final_per);
     end
     toc
     time = toc;%problem 2
     last_fitness = mean(last_fitness,1);
     %盢戈郎い
     %problem 1
    
     p1 = BestData(1,:);
     % p1_x = BestData_x(1,:);
     % p1_y = BestData_y(1,:);
     figure();
     plot(1:1:max_iter,p1);
     % plot(1:1:max_iter,p1_x);
     title(['A = ',num2str(A),'-searching results ,iteration =',num2str(max_iter)]);
     % fprintf(fid1,'%d\t',index_F);fprintf(fid1,'%d\t',max_iter);
     for kk = 1:max_iter
         fprintf(fid1,'%f\t',p1(kk));
     end
     % for kk = 1:max_iter
     %     fprintf(fid1_x,'%f\t',p1_x(kk));
     % end
     
     fprintf(fid1,'\r\n');
     % fprintf(fid1_x,'\r\n');
     
     %problem 2
     % p2 = mean(BestData,1);
     % p2_x = mean(BestData_x,1);
     
     % average_best_so_far = p2(1,max_iter);
     % figure();
     % plot(1:1:max_iter,p2);
     % title(['A = ',num2str(A),'-best-so-far solution,iteration =',num2str(max_iter)]);
     % figure();
     % % plot(1:1:max_iter,p2_x);
     % % title(['function-',num2str(index_F),'-average best-so-far solution of,iteration =',num2str(max_iter)]);
     % %problem 3
     % fprintf(fid3,'%d\t',index_F);
     % fprintf(fid3,'%d\t',max_iter);
     % fprintf(fid3,'%d\t',time);
     % average_best_so_far = p2(1,max_iter);
     % % average_best_so_far_x = p2_x(1,max_iter);
     % average_mean_fitness = mean(last_fitness);
     % median_best_so_far = MedianData(1,max_iter);
     % % median_best_so_far = MedianData_x(1,max_iter);
     % % time
     % fprintf(fid3,'%e\t',average_best_so_far);
     % % fprintf(fid3,'%e\t',average_best_so_far_x);
     % 
     % fprintf(fid3,'%e\t',average_mean_fitness);
     % fprintf(fid3,'%e\t',median_best_so_far);
     % fprintf(fid3,'\r\n');
     % %problem 4
     % fprintf(fid4,'%d\t',index_F);
     % fprintf(fid4,'%d\t',max_iter);
     % average = average_mean_fitness;
     % stddd = std(last_fitness);
     % fprintf(fid4,'%e\t',average);
     % fprintf(fid4,'%e\t',stddd);
     % fprintf(fid4,'\r\n');
    
    fprintf("K: ");
    for i=1:3
        fprintf("%f  ", Lbest(i));
    end
    [fitness, y, u, err] = ballbeam(Lbest, A);

    t = 0:0.001:10;
    figure();
    plot(t, y, 'r-', t, A*cos(t*pi/5), 'b--');
    title('龟悔發萝瓂格');
    legend('y','yd');

    figure();
    % for i = 0:10001
    %     e(i) = y(i)-(A*cos(t*pi/5));
    % end
    plot(t, err, 'r-');
    title('發萝粇畉');
    legend('e');
    
    tspan = 0.001:0.001:10;
    figure();
    plot(tspan, u);
    title('u');
    legend('u');
end


fclose(fid1);
% fclose(fid1_x);
% fclose(fid1_y);
% fclose(fid2);
fclose(fid3);
fclose(fid4);
% fclose(fid5);
