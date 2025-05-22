function DH = DHtable()

d1 = 0;
a1 = 0;

d2 = 0;
a2 = 0;

d3 = 0.4;
a3 = 0;

d4 = 0;
a4 = 0.1;

d5 = 0.5;
a5 = 0;

d6 = 0.1;
a6 = 0;

d7 = 0.15;
gamma = pi/8;

syms q1 q2 q3 q4 q5 q6 real

DH = [ d1   q1  a1   pi/2        pi/2;
       d2   q2  a2   -pi/2       pi/2;
       d3   q3  a3   pi/2        pi/2;
       d4   q4  a4   pi/2        -pi/2;
       d5   q5  a5   -pi/2       0;
       d6   q6  a6   pi/2-gamma  -pi/2
       d7   0    0   0           0];

end

