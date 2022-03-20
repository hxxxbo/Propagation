function [correlation_coefficient_normal] = temporal_correlation_function(cir)

%   cir 尺寸为 snapshots * delay

number_of_snapshots = size(cir,1);
Correlation_Matrix = zeros(number_of_snapshots,number_of_snapshots);
for j = 0:number_of_snapshots-1
    for i = 1:number_of_snapshots
        x = cir(i,:);
        try
            h = conj(cir(i+j,:));
        catch h = 0;
        end
        y=x.*h;
        Correlation_Matrix(i,j+1) = abs(sum(y));
    end
end
% j 纵轴 是 距离，所有 j 距离的相关系数，i 横轴 是 snapshots
index = (number_of_snapshots:-1:1);
correlation_coefficient = sum(Correlation_Matrix,1)./index;
correlation_coefficient_normal = correlation_coefficient/max(correlation_coefficient);

plot(correlation_coefficient_normal);
grid on
title('时间相关函数')
xlabel('snapshots')
ylabel('相关性')


%{
分段
a = 20;
for b = 1:180
    load('cir_results_trs_index_0_200_snapshots_typicalcase1.mat');
    
    %b = 90;
    cir = cir(b:b+a-1,:);
    correlation = zeros(a,a);
    for j = 0:a-1
        for i = 1:a
            x = cir(i,:);
            try
                h = conj(cir(i+j,:));
            catch h = 0;
            end
            y=x.*h;
            correlation(i,j+1) = abs(sum(y));
        end
    end
    % j 纵轴 是 距离，所有 j 距离的相关系数，i 横轴 是 snapshots
    index = [a:-1:1];
    cor_coef = sum(correlation,1)./index;
    cor_coef_all = cor_coef/cor_coef(1);
    dd(b) = cor_coef_all(2);
    %plot(cor_coef_all);
end

%}
end
