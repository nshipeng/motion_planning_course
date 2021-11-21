clear all;
close all;
clc;

p_0 = [0 8 20];
v_0 = [0 0 0];
a_0 = [0 0 0];
K=20;
dt=0.2;

P=[];
V=[];
A=[];

for t=0.2:0.2:48
    %% Construct the reference signal
    for i = 1:20
        if t<=8                 %先运动到圆锥顶点
            pt(i,1) = 0;        %x方向上的位置、速度、加速度
            vt(i,1) = 0;
            at(i,1) = 0;

            pt(i,2) = 8 - t;     %y方向上的位置、速度、加速度
            vt(i,2) = -1;
            at(i,2) = 0;
            
            pt(i,3) = 20;        %z方向上的位置、速度、加速度
            vt(i,3) = 0;
            at(i,3) = 0;
        else
            tref = t-8 + i*0.2;
            r=0.25*tref;
            pt(i,1) = r*sin(0.2*tref);    
            vt(i,1) = r*cos(0.2*tref);
            at(i,1) = -r*sin(0.2*tref);

            pt(i,2) = r*cos(0.2*tref);    
            vt(i,2) = -r*sin(0.2*tref);
            at(i,2) = -r*cos(0.2*tref);

            pt(i,3) = 20 - 0.5*tref;     
            vt(i,3) = -0.5;
            at(i,3) = 0;
        end
    end
    %% Do the MPC
    %% Please follow the example in linear mpc part to fill in the code here to do the tracking
    j(1)= xy_axis_mpc(K,dt,p_0(1),v_0(1),a_0(1),pt(20,1),vt(20,1),at(20,1)); 
    j(2)= xy_axis_mpc(K,dt,p_0(2),v_0(2),a_0(2),pt(20,2),vt(20,2),at(20,2));
    j(3) = z_axis_mpc(K,dt,p_0(3),v_0(3),a_0(3),pt(20,3),vt(20,3),at(20,3));
 
    for i=1:3
       [p_0(i),v_0(i),a_0(i)] = forward(p_0(i),v_0(i),a_0(i),j(i),dt);
    end
    
    %% Log the states
    P = [P;p_0 pt(1,:)];
    V = [V;v_0 vt(1,:)];
    A = [A;a_0 at(1,:)];
end

%% Plot the result
figure(1)
plot(P);
grid on;
legend('x','y','z');
figure(2)
plot3(P(:,1),P(:,2),P(:,3),'bo','linewidth',0.5);
axis equal;
grid on;