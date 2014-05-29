function main

%% 清理空间
clc
clear
close all
%% 读数据
addpath('dataset'); % 添加路径
train_data = importdata('train.data');
test_data = importdata('test.data');
%% 处理数据
% 这里面的数据档量都在0-1之间，所以无需归一化
train_input = train_data(:,1:10)';
train_output = train_data(:,11)';
test_input = test_data(:,1:10)';
test_output = test_data(:,11)';
%% 设置网络参数
NodeNum1 = 20; % 隐层第一层节点数
NodeNum2 = 40;   % 隐层第二层节点数
TypeNum = 1;   % 输出维数
% 各层传输函数，TF3为输出层传输函数
TF1 = 'tansig';TF2 = 'tansig'; TF3 = 'tansig';
% 如果训练结果不理想，可以尝试更改传输函数，以下这些是各类传输函数
% TF1 = 'tansig';TF2 = 'logsig';
% TF1 = 'logsig';TF2 = 'purelin';
% TF1 = 'tansig';TF2 = 'tansig';
% TF1 = 'logsig';TF2 = 'logsig';
% TF1 = 'purelin';TF2 = 'purelin';
% 注意创建BP网络函数newff()的参数调用
net = newff(train_input,train_output,[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'traingdx');%创建四层BP网络
%% 设置训练参数
net.trainParam.epochs = 2000; % 训练次数设置
net.trainParam.goal = 1e-7; % 训练目标设置
net.trainParam.lr = 0.01; % 学习率设置,应设置为较少值，太大虽然会在开始加快收敛速度，但临近最佳点时，会产生动荡，而致使无法收敛
%% 指定训练函数
net.trainfcn='traingdm';
[net, tr] = train(net,train_input,train_output);
% net.trainFcn = 'traingd'; % 梯度下降算法
% net.trainFcn = 'traingdm'; % 动量梯度下降算法
% net.trainFcn = 'traingda'; % 变学习率梯度下降算法
% net.trainFcn = 'traingdx'; % 变学习率动量梯度下降算法
% (大型网络的首选算法)
% net.trainFcn = 'trainrp'; % RPROP(弹性BP)算法,内存需求最小
% (共轭梯度算法)
% net.trainFcn = 'traincgf'; % Fletcher-Reeves修正算法
% net.trainFcn = 'traincgp'; % Polak-Ribiere修正算法,内存需求比Fletcher-Reeves修正算法略大
% net.trainFcn = 'traincgb'; % Powell-Beal复位算法,内存需求比Polak-Ribiere修正算法略大
% (大型网络的首选算法)
% net.trainFcn = 'trainscg'; % Scaled Conjugate
% Gradient算法,内存需求与Fletcher-Reeves修正算法相同,计算量比上面三种算法都小很多
% net.trainFcn = 'trainbfg'; % Quasi-Newton Algorithms - BFGS
% Algorithm,计算量和内存需求均比共轭梯度算法大,但收敛比较快
% net.trainFcn = 'trainoss'; % One Step Secant
% Algorithm,计算量和内存需求均比BFGS算法小,比共轭梯度算法略大
% (中型网络的首选算法)
% net.trainFcn = 'trainlm'; % Levenberg-Marquardt算法,内存需求最大,收敛速度最快
% net.trainFcn = 'trainbr'; % 贝叶斯正则化算法
% 有代表性的五种算法为:'traingdx','trainrp','trainscg','trainoss', 'trainlm'
%% 训练完成后，就可以调用sim()函数，进行仿真了
test_output_pre = sim(net,test_input);%正常输入的9组p数据，BP得到的结果t
%% 数据分析和绘图
figure
plot(1:length(test_output),test_output,'ro',1:length(test_output),test_output_pre,'b+');
xlabel('迭代次数')
ylabel('预测值')
test_output_pre(find(test_output_pre < 0)) = -1;
test_output_pre(find(test_output_pre >= 0)) = 1;
% 预测正确的比例
right_count = length(find(abs(test_output - test_output_pre) == 0));
display('Right Ratio: ');
right_ratio = right_count / length(test_output)


