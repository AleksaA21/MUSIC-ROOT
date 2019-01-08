%% �˳��������ڽǶȼ�ľ����ʵ������Ӱ��
num_sample = 100; % ��������
SNR = 20; % �����
angle_option = [11.36,36.87,78.55,109.66,127.83];
space_range = 2:2:40;
num_experiment = 1000;
has_noise = 1; % Ϊ1��������� �����������
correlation_coefficient = 0.02; % ��ͬ�Ƕȵ����ϵ��
error = zeros(1,length(space_range));

for space = 1:length(space_range)
    for experim = 1:num_experiment
        % ȷ�������
        angle_info_input = zeros(1,2);
        angle_info_input(1) = angle_option(mod(experim,length(angle_option)) +1 );
        angle_info_input(2) = angle_info_input(1) + space_range(space);
        
        % ����root_music �㷨
        angle_info_output = simulation_environment(num_sample,SNR,angle_info_input,has_noise,correlation_coefficient);
        error(space) = error(space) + sum(abs(angle_info_input - sort(angle_info_output)));
    end
end

error = error / (num_experiment * 2);
% �����������浽�ļ�
file_name = '.\data_experiment\test1.mat';
save(file_name,'error') ;

% ���ͼ��
plot(space_range,error,'b-s','DisplayName','root music','LineWidth',1);
legend();
xlabel('Angel Space(��)');
ylabel('error(��)');
