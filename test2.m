%% �˳����ⲻͬ������ȶ�ʵ������Ӱ��
num_sample = 100; % ��������
angle_space = 20;
maxNum_angle = 3;
SNR = -10:2:30; % �����
angle_option = [11.36,36.87,78.55,109.66,127.83]';
angle_option = [angle_option,angle_option + angle_space,angle_option + angle_space*2];
num_experiment = 100;
has_noise = 1; % Ϊ1��������� �����������
correlation_coefficient = 0.02; % ��ͬ�Ƕȵ����ϵ��
error = zeros(maxNum_angle,length(SNR));

parfor angle_num = 1:maxNum_angle
    error_tmp = zeros(1,length(SNR));
    for noi = 1:length(SNR)
        for experim = 1:num_experiment
            % ȷ�������
            angle_info_input = angle_option(mod(experim,length(angle_option)) +1,1:angle_num);

            % ����root_music �㷨
            angle_info_output = simulation_environment(num_sample,SNR(noi),angle_info_input,has_noise,correlation_coefficient);
            error_tmp(noi) = error_tmp(noi) + sum(abs(angle_info_input - sort(angle_info_output)));
        end
    end
    error(angle_num,:) = error_tmp / angle_num;
end

error = error / num_experiment;

% �����������浽�ļ�
file_name = '.\data_experiment\test2.mat';
save(file_name,'error') ;

% ���ͼ��
mark = {'c-.s','r-+','g--o','b*:','m-p','y--h'};
hold on;
for angle_num = 1:maxNum_angle
    plot(SNR,error(angle_num,:),mark{angle_num},'DisplayName',['number of angle = ',num2str(angle_num)],'LineWidth',1);
end
legend();
xlabel('SNR(dB)');
ylabel('error(��)');
hold off;
