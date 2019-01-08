function [angle_info_output] = simulation_environment(num_sample,SNR,angle_info_input,has_noise,correlation_coefficient)
%% ȷ������
Model_paras.frequency = 3 * 10^9; % ����Ƶ��
Model_paras.num_sample = num_sample; 
Model_paras.antenna_space_ofwaveLen = 0.5; % ��������֮��ľ��루��ʾΪ�벨���Ĺ�ϵ��
Model_paras.num_antenna = 7; % ���ߵĸ���
Model_paras.speed_light = 3 * 10^8; % ����
Model_paras.has_noise = has_noise; % Ϊ1��������� �����������
Model_paras.SNR = SNR; % �����
Model_paras.angle_info_input = angle_info_input; % ģ���źŵ���Դ��Ӧ�ĽǶ�
Model_paras.correlation_coefficient = correlation_coefficient; % ��ͬ��Դ�������ź�֮�����ض�

%% ��������Ҫ���CSI���� ֮������L1-SVD�㷨�����Ӧ��AOA

    % ����ÿ��AP��Ӧ��CSI������������յ���·����Ϣ
    CSI = create_CSI_by_angle(Model_paras);

    % ʹ��MUSIC��δ��spatial-smoothing��
    angle_info_output = root_music(CSI,Model_paras,length(Model_paras.angle_info_input));
%     angle_info_output = MUSIC_Origin(CSI,Model_paras,length(Model_paras.angle_info_input));
end

    