%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%UMDA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���������Ա�����������ĵ�Ŀ���Ż�����
%��Ը��ʵ����ɷ�ʽ���ɸ���
clear all
clc
N = 20;                           %��Ⱥ��ģ
t_max = 20;                      %����������
n = 13;                           %�Ա�������
P = [0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5];               
                                 %��ʼ����ģ��,P�ĳ��ȱ������n
                                 %�����и���ģ��ѡ���ø�������P=[P_1,P_2,P_3]��ʾ��
                                 %P_i��ʾiȡ1�ĸ���
update_num = N/2;                %����Pʱ����Ҫ�ĸ���������������Ϊ���ⳣ��                            
%-------------------------------��ʼ����Ⱥ------------------------------
pop = zeros(N,n);                        
num_of_1 = N*P;                  %ÿ���Ա���Ӧȡ1�ĸ���ĸ���
for j = 1:n
    rand_num = randperm(N);
    select_location = rand_num(1: num_of_1(j));
                                 %select_locationָʾλ�õ����ֱ�Ϊ1��
    for k = 1:num_of_1(j)
        pop(select_location(k),j) = 1;
    end
end
fitness = fit_cal(pop);
pop = [pop,fitness];
for t = 1 : t_max
%------------------------------���¸���ģ��P-----------------------------
    pop = sortrows(pop,n+1);
    update_pop = pop(1:update_num,:);  %ѡȡǰupdate_num���������ڸ��¸���ģ��P
                                       %���������Ŀ�꺯������Сֵ����Ŀ�꺯��ʼ��>=0��
                                       %����ȡǰupdate_num������
    for i = 1:n
        P(i) = sum(update_pop(:,i))/update_num;
    end
%------------------------------�������-----------------------------
    pop = zeros(N,n);
    num_of_1 = N*P;                  %ÿ���Ա���Ӧȡ1�ĸ���ĸ���
    for j = 1:n
        rand_num = randperm(N);
        select_location = rand_num(1: num_of_1(j));
                                     %select_locationָʾλ�õ����ֱ�Ϊ1��
        for k = 1:num_of_1(j)
            pop(select_location(k),j) = 1;
        end
    end
    fitness = fit_cal(pop);
    pop = [pop,fitness];
    fit(t,:) = sum(pop(:,n+1));      %fitָÿ�����и������Ӧ��ֵ֮�ͣ���Ӧ��Ⱥ����仯����
end
%------------------------------������Ⱥ��Ӧ�Ⱥͱ仯����ͼ-----------------
plot(fit,'*-')
xlabel('��������')
ylabel('��Ⱥ��Ӧ��֮��')
title('x_1+...+x_n, x\in{0,1}^n')
