%% 椭圆函数
function z = ellipse(q)
%% 计算半径r和反正切值
x = [5.764 6.286 6.759 7.168 7.408];
y = [6.648 1.202 1.823 2.526 3.360];
plot(x, y ,'ro','markersize',10);
r = (x.^2 + y.^2).^0.5; % r值
xita = atan(y./x); % 反正切值
for i = 1:5
    z(i) = r(i)-q(1)*q(2)/(1-q(1)*cos(xita(i)-q(3)));
end


