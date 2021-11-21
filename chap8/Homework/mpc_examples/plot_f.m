x=-8:0.5:8; % x��Χ

y=-8:0.5:8; % y��Χ

[xx,yy]=meshgrid(x,y); %���ɸ�����

c=sqrt(xx.^2+yy.^2)+eps; %����z�ķ�ĸ��Ϊ����Ϊ0����eps

z=sin(c)./c; + exp((cos(2 * pi * xx) + sin(2 * pi * yy))/2)-2.71289          %����z

subplot(2,2,1)

surf(xx,yy,z);title('Surfplot'); %��ͼ1��������άͼ��

subplot(2,2,2)

mesh(xx,yy,z);title('Meshplot'); %��ͼ2��������ά����

subplot(2,2,3)

surf(xx,yy,z);title('Surplot with shading interp'); %��ͼ3��������ά���棬����Ϊ�⻬

shading interp;

subplot(2,2,4)

contour(xx,yy,z);title('Meshplot'); %��ͼ4�����Ƶȸ�����