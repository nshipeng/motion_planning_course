clc;
h=20;
v = -0.5;
omega = 0.08;
p0 = [];
xp= [];yp = [];zp = [];rp = [];

for t = 0:0.1:40
    r = 0.25 * t;
    x=r * sin(omega * t);
    y=r * cos(omega * t);
    z= h - 0.5*t;
    xp = [xp;x];
    yp = [yp;y];
    zp = [zp;z];
end
    
 
plot3(xp,yp,zp,'bo','linewidth',0.5)
 
grid on