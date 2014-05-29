function main

%% ����ռ�
clc
clear
close all
%% ������
addpath('dataset'); % ���·��
train_data = importdata('train.data');
test_data = importdata('test.data');
%% ��������
% ����������ݵ�������0-1֮�䣬���������һ��
train_input = train_data(:,1:10)';
train_output = train_data(:,11)';
test_input = test_data(:,1:10)';
test_output = test_data(:,11)';
%% �����������
NodeNum1 = 20; % �����һ��ڵ���
NodeNum2 = 40;   % ����ڶ���ڵ���
TypeNum = 1;   % ���ά��
% ���㴫�亯����TF3Ϊ����㴫�亯��
TF1 = 'tansig';TF2 = 'tansig'; TF3 = 'tansig';
% ���ѵ����������룬���Գ��Ը��Ĵ��亯����������Щ�Ǹ��ഫ�亯��
% TF1 = 'tansig';TF2 = 'logsig';
% TF1 = 'logsig';TF2 = 'purelin';
% TF1 = 'tansig';TF2 = 'tansig';
% TF1 = 'logsig';TF2 = 'logsig';
% TF1 = 'purelin';TF2 = 'purelin';
% ע�ⴴ��BP���纯��newff()�Ĳ�������
net = newff(train_input,train_output,[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'traingdx');%�����Ĳ�BP����
%% ����ѵ������
net.trainParam.epochs = 2000; % ѵ����������
net.trainParam.goal = 1e-7; % ѵ��Ŀ������
net.trainParam.lr = 0.01; % ѧϰ������,Ӧ����Ϊ����ֵ��̫����Ȼ���ڿ�ʼ�ӿ������ٶȣ����ٽ���ѵ�ʱ�����������������ʹ�޷�����
%% ָ��ѵ������
net.trainfcn='traingdm';
[net, tr] = train(net,train_input,train_output);
% net.trainFcn = 'traingd'; % �ݶ��½��㷨
% net.trainFcn = 'traingdm'; % �����ݶ��½��㷨
% net.trainFcn = 'traingda'; % ��ѧϰ���ݶ��½��㷨
% net.trainFcn = 'traingdx'; % ��ѧϰ�ʶ����ݶ��½��㷨
% (�����������ѡ�㷨)
% net.trainFcn = 'trainrp'; % RPROP(����BP)�㷨,�ڴ�������С
% (�����ݶ��㷨)
% net.trainFcn = 'traincgf'; % Fletcher-Reeves�����㷨
% net.trainFcn = 'traincgp'; % Polak-Ribiere�����㷨,�ڴ������Fletcher-Reeves�����㷨�Դ�
% net.trainFcn = 'traincgb'; % Powell-Beal��λ�㷨,�ڴ������Polak-Ribiere�����㷨�Դ�
% (�����������ѡ�㷨)
% net.trainFcn = 'trainscg'; % Scaled Conjugate
% Gradient�㷨,�ڴ�������Fletcher-Reeves�����㷨��ͬ,�����������������㷨��С�ܶ�
% net.trainFcn = 'trainbfg'; % Quasi-Newton Algorithms - BFGS
% Algorithm,���������ڴ�������ȹ����ݶ��㷨��,�������ȽϿ�
% net.trainFcn = 'trainoss'; % One Step Secant
% Algorithm,���������ڴ��������BFGS�㷨С,�ȹ����ݶ��㷨�Դ�
% (�����������ѡ�㷨)
% net.trainFcn = 'trainlm'; % Levenberg-Marquardt�㷨,�ڴ��������,�����ٶ����
% net.trainFcn = 'trainbr'; % ��Ҷ˹�����㷨
% �д����Ե������㷨Ϊ:'traingdx','trainrp','trainscg','trainoss', 'trainlm'
%% ѵ����ɺ󣬾Ϳ��Ե���sim()���������з�����
test_output_pre = sim(net,test_input);%���������9��p���ݣ�BP�õ��Ľ��t
%% ���ݷ����ͻ�ͼ
figure
plot(1:length(test_output),test_output,'ro',1:length(test_output),test_output_pre,'b+');
xlabel('��������')
ylabel('Ԥ��ֵ')
test_output_pre(find(test_output_pre < 0)) = -1;
test_output_pre(find(test_output_pre >= 0)) = 1;
% Ԥ����ȷ�ı���
right_count = length(find(abs(test_output - test_output_pre) == 0));
display('Right Ratio: ');
right_ratio = right_count / length(test_output)


