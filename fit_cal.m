function fitness = fit_cal(pop)
%��Ӧ��ֵ���㣬�����pop��N�У�n��
fitness = [];
for i = 1:size(pop,1)
    sum = 0;
    for j = 1:size(pop,2)
        sum = sum + pop(i,j);
    end
    fitness(i,:) = sum;
end

    