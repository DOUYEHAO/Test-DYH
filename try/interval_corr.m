%%
clc
clear
close all
%% ׼������
data1 = [1 3 2 4 5];  % ��һ������
data2 = [2 6 5 8 10]; % �ڶ�������
%% CFD����
v=load('E:\Desktop\�����޸�\��Բ������\newflume\w9020');
v=v(40:120,100:260);
v=reshape(v,1,13041);
p=v;
p_all=p;
%% PINNs���ݡ�LSTM-PINNs
p_p=load('E:\Desktop\�����޸�\��Բ������\85s-90.99s\v520.txt');
p_p=reshape(p_p,161,81); %�ȱ��100��50�У�������ת��ȷ������������
p_p=p_p';
p_p=reshape(p_p,1,13041);
pp_all=p_p;
%% PINNs���ݡ�ȱ������
p_pp=load('E:\Desktop\�����޸�\��Բ������\85s-89.99s\v520.txt');
p_pp=reshape(p_pp,161,81); %�ȱ��100��50�У�������ת��ȷ������������
p_pp=p_pp';
p_pp=reshape(p_pp,1,13041);
ppp_all=p_pp;
%% ����
for i = 540:20:600
    p=load(['E:\Desktop\�����޸�\��Բ������\newflume\w',num2str(8500+i)]);
    p=p(40:120,100:260);
    p=reshape(p,1,13041);
    p_p=load(['E:\Desktop\�����޸�\��Բ������\85s-90.99s\v',num2str(i),'.txt']);
    p_p=reshape(p_p,161,81); %�ȱ��100��50�У�������ת��ȷ������������
    p_p=p_p';
    p_p=reshape(p_p,1,13041);
    p_pp=load(['E:\Desktop\�����޸�\��Բ������\85s-89.99s\v',num2str(i),'.txt']);
    p_pp=reshape(p_pp,161,81); %�ȱ��100��50�У�������ת��ȷ������������
    p_pp=p_pp';
    p_pp=reshape(p_pp,1,13041);
    p_all=horzcat(p_all,p);
    pp_all=horzcat(pp_all,p_p);
    ppp_all=horzcat(ppp_all,p_pp);
    disp(['������', num2str(i)]);
end
save('Ԥ���������ݼ�-v.mat','p_all','pp_all','ppp_all');
%% �������ϵ�������
mean1=p_all-mean(p_all);
mean2=pp_all-mean(pp_all);
a=sum(mean1.*mean2)/(sqrt(sum(mean1.^2))*sqrt(sum(mean2.^2)))
b=sum(mean1.*mean2)/(sqrt(sum(mean1.^2)*sum(mean2.^2)))
c1=1-sum((p_all-pp_all).^2)/(sum((p_all-mean(p_all)).^2))
c2=1-sum((p_all-ppp_all).^2)/(sum((p_all-mean(p_all)).^2))
rmse1=sqrt(sum((p_all-pp_all).^2)/13041)
rmse2=sqrt(sum((p_all-ppp_all).^2)/13041)
%% �������ϵ��ͼ
load('Ԥ���������ݼ�-u')
gcf=figure(3);
scatter(ppp_all, p_all, 40,[1,0,0],'Marker','*','LineWidth',1); %��Ϊ16sȱʧ�������Ƶ�PINNs���
hold on;
scatter(pp_all, p_all, 40,[0,0,1],'Marker','+','LineWidth',1); %��Ϊ�Ż����LP���
hold on;
x=linspace(-0.4,1.6,100);
n = 1;
p = polyfit(pp_all, p_all, n);
y_fit = polyval(p, x); % ������ϵĶ���ʽ
plot(x,y_fit,'g','Linewidth',3);

hold on;
y=x;
plot(x,y,'k','Linewidth',1.5);

% ��ӱ���ͱ�ǩ
% title(['Correlation Coefficient: ', num2str(correlation)]);
xlabel('Predicted-${u}$(m/s)','Interpreter', 'latex','Fontsize',15);
ylabel('CFD-${u}$(m/s)','Interpreter', 'latex','Fontsize',15);
grid on
box on
axis equal
xlim([-0.4,1.6])
ylim([-0.4,1.6])
% ���� X ���������
xticks = -0.4:0.2:1.6; % ��0��10�����Ϊ2
set(gca, 'XTick', xticks);

% ���� Y ���������
yticks = -0.4:0.2:1.6; % ��0��1�����Ϊ0.2
set(gca, 'YTick', yticks);
% legend('Data-PINNs','Data-LP','Fit:y=R^2*x','Identity:y=x','Location','best')
% legend('Data-PINN','Data-LP','Fit:y=a*x+b','Identity:y=x','Interpreter', 'latex','Location','southeast')
legend('Data-PINN','Data-LP','Best fit line','Identity:y=x','Interpreter', 'latex','Location','southeast')
% title('Coefficient-Pressure:R^2=0.9996','Fontsize',13)
title('Coefficient-${u}$:R${^2}$=0.9998', 'Interpreter', 'latex','Fontsize',15);
set (gcf,'Position',[500,300,550,500]);
%% rmse�仯���߻���
load('v-rmse�仯���߶Ա�.mat');
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