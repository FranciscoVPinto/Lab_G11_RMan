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

Jp = [diff(P_tool,q1), diff(P_tool,q2), diff(P_tool,q3), diff(P_tool,q4), diff(P_tool,q5), diff(P_tool,q6)];

Z00 = [0;0;1];
A01 = DKin(DH(1,:));     Z01 = A01(1:3,3);
A02 = DKin(DH(1:2,:));   Z02 = A02(1:3,3);
A03 = DKin(DH(1:3,:));   Z03 = A03(1:3,3);
A04 = DKin(DH(1:4,:));   Z04 = A04(1:3,3);
A05 = DKin(DH(1:5,:));   Z05 = A05(1:3,3);

Jo = [Z00, Z01, Z02, Z03, Z04, Z05];

J = simplify([Jp; Jo]);

%-------------------------------------------------------------------------------------------------

new_system('RobotKinematics_Lib');            
open_system('RobotKinematics_Lib');            

matlabFunctionBlock('RobotKinematics_Lib/Robot_Direct_Kinematics', ...
    R_tool, P_tool, J, ...
    'Outputs', {'R_tool', 'P_tool', 'J'}, ...
    'Optimize', false);

save_system('RobotKinematics_Lib');           
