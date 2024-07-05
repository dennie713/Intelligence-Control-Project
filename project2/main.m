clear;clc;close all;
format long e;
dt = 0.001;
t = linspace(0, 10, 10/dt) ;
    
fid1 = fopen('problem1.txt','w');
fid3 = fopen('problem3.txt','w');
fid4 = fopen('problem4.txt','w');
for A = 1:1
    tic
    %�i�հѼ�
     % index_F=12; %testbench  function�s��
     max_iter=500; %���N����
     run = 1;
     N=50;%agent�ƶq 
     min_flag=0; % 1: minimization, 0: maximization
     
     % alpha = 20;G0 = 100;%p41���O�����Ѽ�
     final_per = 2;%�̫�@�����Nagent�ѻP�����
     % best = [];
     for runn = 1:run
        [last_fitness(runn,:),Fbest,Lbest,BestData(runn,:),MeanData(runn,:),MedianData(runn,:)]=GSA_1(N,max_iter,min_flag,final_per);
     end
     toc
     time = toc;%�s�bproblem 2
     last_fitness = mean(last_fitness,1);
     %�N��Ʀs�J�ɮפ�
     %problem 1
    
     p1 = BestData(1,:);
     figure();
     plot(1:1:max_iter,p1);
     title(['A = ',num2str(A),'-searching results ,iteration =',num2str(max_iter)]);
     for kk = 1:max_iter
         fprintf(fid1,'%f\t',p1(kk));
     end
     
     fprintf(fid1,'\r\n');
    fprintf("K: ");
    for i=1:3
        fprintf("%f  ", Lbest(i));
    end
    [fitness, y, u, err] = ballbeam(Lbest, A);

    t = 0:0.001:10;
    figure();
    plot(t, y, 'r-', t, A*cos(t*pi/5), 'b--');
    title('��ڰl�ܭy��');
    legend('y','yd');

    figure();
    plot(t, err, 'r-');
    title('�l�ܻ~�t');
    legend('e');
    
    tspan = 0.001:0.001:10;
    figure();
    plot(tspan, u);
    title('u');
    legend('u');
end

fclose(fid1);
fclose(fid3);
fclose(fid4);
