function basic_model
% 椭圆的离心率在0,1之间，取初值0.5，由上图极坐标系大概转动了45度，取初值0.7
q = lsqnonlin('ellipse',[0.5 2 0.7])
% 可视化
hold on
k = 0:0.01:2*pi;
plot(q(1).*q(2)./(1-q(1).*cos(k-q(3))).*cos(k),...
     q(1).*q(2)./(1-q(1).*cos(k-q(3))).*sin(k),'linewidth',3)
hold on
plot(0,0,'k*','markersize',10)
