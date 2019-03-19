function fitness = fit_cal(pop)
%适应度值计算，输入的pop是N行，n列
fitness = [];
for i = 1:size(pop,1)
    sum = 0;
    for j = 1:size(pop,2)
        sum = sum + pop(i,j);
    end
    fitness(i,:) = sum;
end

    