clear all
clc

%-------------------------------------------------------------------------------------------------
% DK

DH = DHtable();

A06 = DKin(DH);

R_tool = A06(1:3,1:3);
P_tool = A06(1:3,4);

%-------------------------------------------------------------------------------------------------
% JACOB

syms q1 q2 q3 q4 q5 q6 real
assume([q1 q2 q3 q4 q5 q6], 'real');

% Posição da tool final
A06 = DKin(DH);
P_e = A06(1:3,4);

% Inicialização - linear e angular
Jp = sym(zeros(3,6));
Jo = sym(zeros(3,6));

for i = 1:6
    A_prev = eye(4);
    if i > 1
        A_prev = DKin(DH(1:i-1,:));
    end

    Z = A_prev(1:3,3);
    P = A_prev(1:3,4);

    Jp(:,i) = simplify(cross(Z, P_e - P));
    Jo(:,i) = Z;
end

J = [Jp; Jo];  % Jacobiana geométrica


%-------------------------------------------------------------------------------------------------

new_system('RobotKinematics_Lib');            
open_system('RobotKinematics_Lib');            

matlabFunctionBlock('RobotKinematics_Lib/Robot_Direct_Kinematics', ...
    R_tool, P_tool, J, ...
    'Outputs', {'R_tool', 'P_tool', 'J'}, ...
    'Optimize', false);

save_system('RobotKinematics_Lib');           
