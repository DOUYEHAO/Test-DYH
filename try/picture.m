%%
clc
clear
close all
%% Newflume_u(ȫ������)
% close all
% % x=0.025:0.05:29.975;
% % y=0.025:0.05:7.975;
% x=-3.975:0.05:25.975;
% y=-3.975:0.05:3.975;
% y=y';
% w=load('E:\Desktop\�����޸�\��Բ������\newflume\w8500');
% obs=load('E:\Desktop\�����޸�\��Բ������\newflume\obs');
% [m,n]=size(w);
% %
% axis_all=[-4 16.0 -4.0 4.0];
% gcf=figure(1);
% surf(x,y,w)
% view([0,90])
% hold on
% contour(x,y,obs(2:m+1,2:n+1), 2, 'r')%���ݸ���Ԫ�� obs ֵ���е�ֵ�߻�ͼ��ע��obs�ļ��ķ�Χ
% hold on
% % rectangle('Position', [2-0.5,4-0.5,2*0.5,2*0.5], 'Curvature', [1 1],'EdgeColor', 'k','facecolor','k');
% % xlabel('x','Fontsize',12);
% % ylabel('y','Fontsize',12);
% % ���� ylabel
% ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
%     'FontName','Times New Roman');
% % ���� xlabel
% xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
%     'FontName','Times New Roman');
% % title('Newflume-w(m/s)','Fontsize',20);
% title('Velocity-${v}$(m/s)', 'Interpreter', 'latex','FontWeight','bold','FontAngle','italic','FontSize',18,...
%     'FontName','Times New Roman')
% shading interp
% colormap('jet')
% %set(gca,'xtick',0:1:10) 
% %set(gca,'ytick',0:0.2:2)
% % set(gca, 'FontSize', 12);%������������
% % caxis([-1,1]) %������ɫ��-ˮƽ�ٶ�
% % caxis([-0.5,0.5]) %������ɫ��-�����ٶ�
% % caxis([-0.2,0.1]) %������ɫ��-ѹǿ
% colorbar %��ʾ��ɫ��
% set (gcf,'Position',[200,200,1000,500]);
% % set(gca,'Position',[0.1 0.1 0.8 0.9]);
% axis equal
% axis(axis_all)
%% Newflume_u(�ֲ�����)
% x=0.025:0.05:29.975;
% y=0.025:0.05:7.975;
% x=-3.975:0.05:25.975;
% y=-3.975:0.05:3.975;
x=-3.95:0.05:26.0;
y=-3.95:0.05:4.0;
y=y';
x=x(100:260);
y=y(40:120);
w=load('E:\Desktop\�����޸�\��Բ������\newflume\w9100');
w2=w(40:120,100:260);
ww=reshape(w2',13041,1);
[m,n]=size(w);
% axis_all=[9.975 17.975 1.975 5.975];
% axis_all=[5.975 13.975 -1.975 1.975];
axis_all=[1 9 -2 2];
gcf=figure(2);
surf(x,y,w2)
view([0,90])
hold on
% ���� ylabel
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');

% ���� xlabel
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
% title('LP-Pressure','Fontsize',18);
title('CFD-${v}$', 'Interpreter', 'latex','FontWeight','bold','FontAngle','italic','FontSize',18,...
    'FontName','Times New Roman');
shading interp
colormap('jet')
%set(gca,'xtick',0:1:10) 
%set(gca,'ytick',0:0.2:2)
colorbar %��ʾ��ɫ��
% caxis([-0.2,1.2]) %������ɫ��-ˮƽ�ٶ�
caxis([-0.6,0.61]) %������ɫ��-�����ٶ�
% caxis([-0.2,0.1]) %������ɫ��-ѹǿ
set (gcf,'Position',[500,300,600,300]);
axis equal
set(gca,'xtick',1:1:9) 
set(gca,'ytick',-2:1:2)
axis(axis_all)
%% pinns����_p
p_p=load('E:\Desktop\�����޸�\��Բ������\85s-90.99s\v600.txt');
% axis_all=[9.975 17.975 1.975 5.975];
axis_all=[1 9 -2 2];
% x=linspace(9.975, 17.975, 161);
% y=linspace(1.975, 5.975, 81);
x=linspace(1, 9, 161);
y=linspace(-2, 2, 81);
y=y';
p_p=reshape(p_p, 161, 81); %�ȱ��161��81�У�������ת��ȷ������������
p_p=p_p';
gcf=figure(3);
surf(x,y,p_p)
colormap('jet')
view([0,90])
hold on
% xlabel('x','Fontsize',12);
% ylabel('y','Fontsize',12);
% title('PINN-v(m/s)','Fontsize',20);
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');

% ���� xlabel
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
% title('LP-Pressure','Fontsize',18);
title('PINN-${v}$', 'Interpreter', 'latex','FontWeight','bold','FontAngle','italic','FontSize',18,...
    'FontName','Times New Roman');
shading interp
colorbar
set (gcf,'Position',[500,300,600,300]);
% caxis([-0.2,1.2]) %������ɫ��-ˮƽ�ٶ�
caxis([-0.6,0.61]) %������ɫ��-�����ٶ�
% caxis([-0.2,0.1]) %������ɫ��-ѹǿ
axis equal
axis(axis_all)
%% ���cfd-pinns
% axis_all=[9.975 17.975 1.975 5.975];
axis_all=[1 9 -2 2];
% load('cylinder_wake.mat')
% p=p_star;
% p=p(:,1);
% p=reshape(p,100,50); %�ȱ��100��50�У�������ת��ȷ������������
% p=p';
% p_p=load('p0.txt');
% p_p=reshape(p_p,100,50); %�ȱ��100��50�У�������ת��ȷ������������
% p_p=p_p';
e_p=w2-p_p;
% x=linspace(9.975, 17.975, 161);
% y=linspace(1.975, 5.975, 81);
x=linspace(1, 9, 161);
y=linspace(-2, 2, 81);
y=y';
gcf=figure(4);
surf(x,y,e_p);
colormap('jet')
view([0,90])
xlabel('x','Fontsize',12);
ylabel('y','Fontsize',12);
title('Error','Fontsize',30);
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');

% ���� xlabel
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
title('Error','Fontsize',18);
shading interp
colorbar
set(gcf,'Position',[500,300,600,300]);
% caxis([0,0.02])
axis equal
axis(axis_all)
%% ���ٷֱȷֲ�
percent_p=abs(e_p)./w2;
% x=linspace(9.975, 17.975, 161);
% y=linspace(1.975, 5.975, 81);
x=linspace(1, 9, 161);
y=linspace(-2, 2, 81);
y=y';
gcf=figure(5);
surf(x,y,percent_p);
colormap('jet')
view([0,90])
% xlabel('x','Fontsize',12);
% ylabel('y','Fontsize',12);
% title('Percent','Fontsize',30);
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');

% ���� xlabel
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
title('Relative error','Interpreter', 'latex','Fontsize',18);
set(gcf,'Position',[500,300,600,300]);
shading interp
caxis([-1,1]) %������ɫ��
colorbar
axis equal
axis(axis_all)
%% ������ʧ��������
axis_all=[0,50000,0.00001,1];
loss=load('loss.txt');
loss_f=load('loss_F.txt');
loss_d=load('loss_D.txt');
size=length(loss);
x=1:size;
% loss(50:x)=loss(50:x)*0.01;
% loss_f(1:x)=loss_f(1:x)*0.01;
% loss_d(1:x)=loss_d(1:x)*0.01;
x=x*50000/size;
gcf=figure(5);
axes1 = axes('Parent',gcf);
plot(x(10:size),loss(10:size),'r','LineWidth',2);
hold on
plot(x(10:size),loss_d(10:size),'m','LineWidth',2);
hold on
plot(x(10:size),loss_f(10:size),'k','LineWidth',2);
grid on
% xlabel('Epochs','Fontsize',15);
% ylabel('Loss','Fontsize',15);
% title('Loss-LP','Fontsize',15)
ylabel('Loss','FontWeight','bold','FontAngle','italic','FontSize',15,...
    'FontName','Times New Roman');

% ���� xlabel
xlabel('Epochs','FontWeight','bold','FontAngle','italic','FontSize',15,...
    'FontName','Times New Roman');
title('PINN','FontWeight','bold','Interpreter', 'latex','Fontsize',15);
legend('Loss','Loss-Data','Loss-PDE','Interpreter', 'latex','Location','southeast','Location','best')
set(axes1,'YMinorTick','on','YScale','log','YTick',...
    [0.00001 0.0001 0.001 0.01 0.1 1],'YTickLabel',...
    {'10^{-5}','10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}'});
% ���ú������귶Χ
% xlim([0, 12]) % ���ú����귶ΧΪ0��12
% ylim([0.0001, 1]) % ���������귶ΧΪ0��120
axis(axis_all)
%% ��ճ����ճ�Ա�
axis_all=[0,50000,0.00001,1];
loss=load('loss.txt');
loss2=load('loss2.txt');
size1=length(loss);
size2=length(loss2);
x1=1:size1;
x2=1:size2;
x1=x1*50000/size1;
x2=x2*50000/size2;
gcf=figure(6);
axes1 = axes('Parent',gcf);
plot(x1(20:size1),loss(20:size1),'r','LineWidth',2);
hold on
plot(x2(20:size2),loss2(20:size2),'m','LineWidth',2);
grid on
% xlabel('Epochs','Fontsize',15);
% ylabel('Loss','Fontsize',15);
% title('Loss-LP','Fontsize',15)
ylabel('Loss','FontWeight','bold','FontAngle','italic','FontSize',15,...
    'FontName','Times New Roman');

% ���� xlabel
xlabel('Epochs','FontWeight','bold','FontAngle','italic','FontSize',15,...
    'FontName','Times New Roman');
title('Comparison of two models','FontWeight','bold','Interpreter', 'latex','Fontsize',15);
legend('Loss-PINN(a)','Loss-PINN(b)','Interpreter', 'latex','Location','southeast','Location','best')
set(axes1,'YMinorTick','on','YScale','log','YTick',...
    [0.00001 0.0001 0.001 0.01 0.1 1],'YTickLabel',...
    {'10^{-5}','10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}'});
% ���ú������귶Χ
% xlim([0, 12]) % ���ú����귶ΧΪ0��12
% ylim([0.0001, 1]) % ���������귶ΧΪ0��120
axis(axis_all)