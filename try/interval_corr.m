%%
clc
clear
close all
%% 准备数据
data1 = [1 3 2 4 5];  % 第一组数据
data2 = [2 6 5 8 10]; % 第二组数据
%% CFD数据
v=load('E:\Desktop\论文修改\单圆柱数据\newflume\w9020');
v=v(40:120,100:260);
v=reshape(v,1,13041);
p=v;
p_all=p;
%% PINNs数据—LSTM-PINNs
p_p=load('E:\Desktop\论文修改\单圆柱数据\85s-90.99s\v520.txt');
p_p=reshape(p_p,161,81); %先变成100行50列，后续倒转，确保数据连续性
p_p=p_p';
p_p=reshape(p_p,1,13041);
pp_all=p_p;
%% PINNs数据—缺少数据
p_pp=load('E:\Desktop\论文修改\单圆柱数据\85s-89.99s\v520.txt');
p_pp=reshape(p_pp,161,81); %先变成100行50列，后续倒转，确保数据连续性
p_pp=p_pp';
p_pp=reshape(p_pp,1,13041);
ppp_all=p_pp;
%% 接上
for i = 540:20:600
    p=load(['E:\Desktop\论文修改\单圆柱数据\newflume\w',num2str(8500+i)]);
    p=p(40:120,100:260);
    p=reshape(p,1,13041);
    p_p=load(['E:\Desktop\论文修改\单圆柱数据\85s-90.99s\v',num2str(i),'.txt']);
    p_p=reshape(p_p,161,81); %先变成100行50列，后续倒转，确保数据连续性
    p_p=p_p';
    p_p=reshape(p_p,1,13041);
    p_pp=load(['E:\Desktop\论文修改\单圆柱数据\85s-89.99s\v',num2str(i),'.txt']);
    p_pp=reshape(p_pp,161,81); %先变成100行50列，后续倒转，确保数据连续性
    p_pp=p_pp';
    p_pp=reshape(p_pp,1,13041);
    p_all=horzcat(p_all,p);
    pp_all=horzcat(pp_all,p_p);
    ppp_all=horzcat(ppp_all,p_pp);
    disp(['步数：', num2str(i)]);
end
save('预测外拓数据集-v.mat','p_all','pp_all','ppp_all');
%% 计算相关系数、误差
mean1=p_all-mean(p_all);
mean2=pp_all-mean(pp_all);
a=sum(mean1.*mean2)/(sqrt(sum(mean1.^2))*sqrt(sum(mean2.^2)))
b=sum(mean1.*mean2)/(sqrt(sum(mean1.^2)*sum(mean2.^2)))
c1=1-sum((p_all-pp_all).^2)/(sum((p_all-mean(p_all)).^2))
c2=1-sum((p_all-ppp_all).^2)/(sum((p_all-mean(p_all)).^2))
rmse1=sqrt(sum((p_all-pp_all).^2)/13041)
rmse2=sqrt(sum((p_all-ppp_all).^2)/13041)
%% 绘制相关系数图
load('预测外拓数据集-u')
gcf=figure(3);
scatter(ppp_all, p_all, 40,[1,0,0],'Marker','*','LineWidth',1); %作为16s缺失数据外推的PINNs结果
hold on;
scatter(pp_all, p_all, 40,[0,0,1],'Marker','+','LineWidth',1); %作为优化后的LP结果
hold on;
x=linspace(-0.4,1.6,100);
n = 1;
p = polyfit(pp_all, p_all, n);
y_fit = polyval(p, x); % 评估拟合的多项式
plot(x,y_fit,'g','Linewidth',3);

hold on;
y=x;
plot(x,y,'k','Linewidth',1.5);

% 添加标题和标签
% title(['Correlation Coefficient: ', num2str(correlation)]);
xlabel('Predicted-${u}$(m/s)','Interpreter', 'latex','Fontsize',15);
ylabel('CFD-${u}$(m/s)','Interpreter', 'latex','Fontsize',15);
grid on
box on
axis equal
xlim([-0.4,1.6])
ylim([-0.4,1.6])
% 设置 X 轴的网格间距
xticks = -0.4:0.2:1.6; % 从0到10，间隔为2
set(gca, 'XTick', xticks);

% 设置 Y 轴的网格间距
yticks = -0.4:0.2:1.6; % 从0到1，间隔为0.2
set(gca, 'YTick', yticks);
% legend('Data-PINNs','Data-LP','Fit:y=R^2*x','Identity:y=x','Location','best')
% legend('Data-PINN','Data-LP','Fit:y=a*x+b','Identity:y=x','Interpreter', 'latex','Location','southeast')
legend('Data-PINN','Data-LP','Best fit line','Identity:y=x','Interpreter', 'latex','Location','southeast')
% title('Coefficient-Pressure:R^2=0.9996','Fontsize',13)
title('Coefficient-${u}$:R${^2}$=0.9998', 'Interpreter', 'latex','Fontsize',15);
set (gcf,'Position',[500,300,550,500]);
%% rmse变化曲线绘制
load('v-rmse变化曲线对比.mat');
rmse1=rmse1_all;
rmse2=rmse2_all;
t=linspace(5, 6, 21);
gcf=figure(7);
plot(t,rmse1,'r-*','LineWidth',2)
hold on 
plot(t,rmse2,'m-+','LineWidth',2)
hold on
grid on
ylabel('RMSE','FontWeight','bold','FontAngle','italic','FontSize',15,...
    'FontName','Times New Roman');
xlabel('t','FontWeight','bold','FontAngle','italic','FontSize',15,...
    'FontName','Times New Roman');
title('Predicted-${v}$', 'Interpreter', 'latex','FontWeight','bold','FontAngle','italic','FontSize',17,...
    'FontName','Times New Roman');
legend('LSTM-PINN','PINN','Interpreter', 'latex','Location','southeast','Location','northwest')