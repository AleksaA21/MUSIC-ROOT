num_sample = 10; % ��������
SNR = 20; % �����
angle_info_input =[40.2547,65.23,83.55]; % ���ģ���źŵ���Դ��Ӧ�������
has_noise = 1; % Ϊ1��������� �����������
correlation_coefficient = 0.9999; % ��ͬ�Ƕȵ����ϵ��
format longE
angle_info_output = simulation_environment(num_sample,SNR,angle_info_input,has_noise,correlation_coefficient);