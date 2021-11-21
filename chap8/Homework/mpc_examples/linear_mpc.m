clear all;
close all;
clc;
%设置系统初始状态
p_0 = 10;
v_0 = 0;
a_0 = 0;
K=20;
dt=0.2;

log=[0 p_0 v_0 a_0];
w1 = 100;
w2 = 1;
w3 = 1;
w4 = 1;
for t=0.2:0.2:10
    %% Construct the prediction matrix
    [Tp, Tv, Ta, Bp, Bv, Ba] = getPredictionMatrix(K,dt,p_0,v_0,a_0);
    %https://ww2.mathworks.cn/help/optim/ug/quadprog.html
    %x = quadprog(H,f,A,b,Aeq,beq) 在满足 Aeq*x = beq 的限制条件下求解上述问题。
    %Aeq 是由双精度值组成的矩阵，beq 是由双精度值组成的向量。如果不存在不等式，则设置 A = [] 和 b = []。
    
    %% Construct the optimization problem
    H = w4*eye(K)+w1*(Tp'*Tp)+w2*(Tv'*Tv)+w3*(Ta'*Ta);
    F = w1*Bp'*Tp+w2*Bv'*Tv+w3*Ba'*Ta;
    
    %% Solve the optimization problem
    J = quadprog(H,F,[],[]);
    
    %% Apply the control
    j = J(1);
    p_0 = p_0 + v_0*dt + 0.5*a_0*dt^2 + 1/6*j*dt^3;
    v_0 = v_0 + a_0*dt + 0.5*j*dt^2;
    a_0 = a_0 + j*dt; 
    
    %% Log the states
    log = [log; t p_0 v_0 a_0];
end

%% Plot the result
plot(log(:,1),log(:,2:4));
grid on;
xlabel('t(s)');
legend('p','v','a');
