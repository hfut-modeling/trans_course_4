function basic_model
% ��Բ����������0,1֮�䣬ȡ��ֵ0.5������ͼ������ϵ���ת����45�ȣ�ȡ��ֵ0.7
q = lsqnonlin('ellipse',[0.5 2 0.7])
% ���ӻ�
hold on
k = 0:0.01:2*pi;
plot(q(1).*q(2)./(1-q(1).*cos(k-q(3))).*cos(k),...
     q(1).*q(2)./(1-q(1).*cos(k-q(3))).*sin(k),'linewidth',3)
hold on
plot(0,0,'k*','markersize',10)
