function CSI = create_CSI_by_angle(Model_paras)
%% ͨ��steering_matrix����ģ������

% ��������֮����� ��λ��m
antenna_space = (Model_paras.speed_light/Model_paras.frequency) * Model_paras.antenna_space_ofwaveLen;

% ����complex_gain
Model_paras.complex_gain = create_complexGain(Model_paras);

% ����ģ��CSI
CSI = complex(zeros(Model_paras.num_antenna,Model_paras.num_sample));

for T = 1:Model_paras.num_sample
    for A = 1:length(Model_paras.angle_info_input)
    CSI(:,T) = CSI(:,T)...
        + exp(-1i * 2*pi * (0:Model_paras.num_antenna-1) * antenna_space * cos(deg2rad(Model_paras.angle_info_input(A))) * Model_paras.frequency / Model_paras.speed_light).'...
        * Model_paras.complex_gain(A,T);
    end
end

% �������
if Model_paras.has_noise == 1
    CSI = awgn(CSI,Model_paras.SNR);
end

end

%% ���ݸ��������ϵ���������complex_gain
function complex_gain = create_complexGain(Model_paras)

% ���ɳ�ʼ��Э�������
signalCovMat = 1*eye(length(Model_paras.angle_info_input));

% Ϊ�˼�� �ҽ�����������ͬ��Դ֮������ϵ������ͬһ��ֵ
for t = 1:length(Model_paras.angle_info_input)
    for k = 1:length(Model_paras.angle_info_input)
        if t == k
            continue;
        else
            signalCovMat(t,k) = Model_paras.correlation_coefficient;
        end
    end
end
rand_phase = mvnrnd(zeros(length(Model_paras.angle_info_input), 1), signalCovMat, Model_paras.num_sample).';

% Ϊ�˼������ �����޸ģ������޸���񣬶���Ӱ�����ǵ�ʵ��Ч����
complex_gain = exp(1i * rand_phase);
end