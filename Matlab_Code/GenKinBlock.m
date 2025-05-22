clear all
clc

%-------------------------------------------------------------------------------------------------
% CINEMÁTICA DIRETA

% Tabela DH simbólica
DH = DHtable();

% Transformação homogénea total do end-effector
A06 = DKin(DH);

% Rotação e posição do end-effector
R06 = A06(1:3,1:3);
P6 = A06(1:3,4);

%-------------------------------------------------------------------------------------------------
% JACOBIANO GEOMÉTRICO

% Definir variáveis simbólicas
syms q1 q2 q3 q4 q5 q6 real

% Jacobiano da posição: derivadas parciais da posição em relação a cada qi
Jp = [diff(P6,q1), diff(P6,q2), diff(P6,q3), diff(P6,q4), diff(P6,q5), diff(P6,q6)];

% Eixos Z de cada frame (extraídos das transformações parciais)
Z00 = [0;0;1];
A01 = DKin(DH(1,:));     Z01 = A01(1:3,3);
A02 = DKin(DH(1:2,:));   Z02 = A02(1:3,3);
A03 = DKin(DH(1:3,:));   Z03 = A03(1:3,3);
A04 = DKin(DH(1:4,:));   Z04 = A04(1:3,3);
A05 = DKin(DH(1:5,:));   Z05 = A05(1:3,3);

% Jacobiano da orientação
Jo = [Z00, Z01, Z02, Z03, Z04, Z05];

% Jacobiano completo
J = simplify([Jp; Jo]);

%-------------------------------------------------------------------------------------------------
% BLOCO SIMULINK COM R06, P6 E J

new_system('RobotKinematics_Lib');             % Criar biblioteca
open_system('RobotKinematics_Lib');            % Abrir visualmente

% Criar bloco com três saídas: Rotação, Posição, Jacobiano
matlabFunctionBlock('RobotKinematics_Lib/Robot_Direct_Kinematics', ...
    R06, P6, J, ...
    'Outputs', {'R06', 'P6', 'J'}, ...
    'Optimize', false);

save_system('RobotKinematics_Lib');            % Guardar biblioteca
