%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%UMDA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%本题仅解决自变量互相独立的单目标优化问题
%相对概率的生成方式生成个体
clear all
clc
N = 20;                           %种群规模
t_max = 20;                      %最大迭代次数
n = 13;                           %自变量个数
P = [0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5];               
                                 %初始概率模型,P的长度必须等于n
                                 %本题中概率模型选择用概率向量P=[P_1,P_2,P_3]表示，
                                 %P_i表示i取1的概率
update_num = N/2;                %更新P时所需要的个体数，可以设置为任意常数                            
%-------------------------------初始化种群------------------------------
pop = zeros(N,n);                        
num_of_1 = N*P;                  %每个自变量应取1的个体的个数
for j = 1:n
    rand_num = randperm(N);
    select_location = rand_num(1: num_of_1(j));
                                 %select_location指示位置的数字变为1；
    for k = 1:num_of_1(j)
        pop(select_location(k),j) = 1;
    end
end
fitness = fit_cal(pop);
pop = [pop,fitness];
for t = 1 : t_max
%------------------------------更新概率模型P-----------------------------
    pop = sortrows(pop,n+1);
    update_pop = pop(1:update_num,:);  %选取前update_num个个体用于更新概率模型P
                                       %此题是针对目标函数求最小值，且目标函数始终>=0，
                                       %所以取前update_num个个体
    for i = 1:n
        P(i) = sum(update_pop(:,i))/update_num;
    end
%------------------------------随机采样-----------------------------
    pop = zeros(N,n);
    num_of_1 = N*P;                  %每个自变量应取1的个体的个数
    for j = 1:n
        rand_num = randperm(N);
        select_location = rand_num(1: num_of_1(j));
                                     %select_location指示位置的数字变为1；
        for k = 1:num_of_1(j)
            pop(select_location(k),j) = 1;
        end
    end
    fitness = fit_cal(pop);
    pop = [pop,fitness];
    fit(t,:) = sum(pop(:,n+1));      %fit指每代所有个体的适应度值之和，反应种群整体变化趋势
end
%------------------------------绘制种群适应度和变化曲线图-----------------
plot(fit,'*-')
xlabel('迭代次数')
ylabel('种群适应度之和')
title('x_1+...+x_n, x\in{0,1}^n')
