sets
i Number of Buses in System /1*33/
slackbus(i) Number of SlackBus in System /1/
PQ(i) P_Q Buses/2*33/
t time horizon /1*24/
k time horizon /1*24/
PV(i) PhotoVol /6,20,24,26,32/
DG(i) disel buses /7 ,12 ,15 ,24 /
Wind(i) Wind Buses/13,15,30/
ESS_1(i) Eneregy Storage1/6,21,24,30/
ESS_2(i) Eneregy Storage2/18,21,30/;


alias(i,j);

scalar Sbase/100/;

parameters
Pmaxdg(i) Maximum limit of power production by the diesel generators  /7 0.035,12 0.03,15 0.03,24 0.041/
Pmindg(i) minimum limit of power production by the diesel generators  /7 0.01,12 0.0075,15 0.0075,24  0.01/
UR(i)  Ramp up rate of diesel generators unit at bus i     /7 1.8,12 1.5,15 1.5,24  1.8/
DR(i)  Ramp down rate of diesel generators unit at bus i   /7 1.8,12 1.5,15 1.5,24  1.8/
UT(i)  Minimal up time of diesel generators unit at bus i   /7 2,12 1,15 1,24 2/
DT(i)  The minimal downtime of diesel generators unit at bus i   /7 2,12 1,15 1,24 2/
zpd(t) load coefficiant   /1 0.6,2 0.6,3 0.6,4 0.62,5 0.63,6 0.65,7 0.7,8 7.5,9 0.8,10 0.8,11 0.85,12 0.9,13 0.98,14 1,15 1.01,16 1.05,17 1.06,18 1.06,19 0.98,20 0.9,21 0.9,22 0.86,23 0.81,24 0.81/
*0.348,2   0.448,3  0.2148,4   0.2458,5  0.2648,6    0.2748,7   0.248,8   0.3536,9   0.3236,10  0.3036,11    0.3481,12   0.4428,13  0.2148,14   0.28458,15  0.2678,16    0.2728,17   0.848,18   0.7536,19   0.35,20  0.3036,21 0.05,22 0.89,23 0.78,24 0.747/
PVcap(i) Capacity of each Photo/6 0.002,20 0.003,24 0.0012,26 0.001,32 0.009/
Ta(t)     Time availability of PVs at time t /1 1.2,2 1,3 0.8,4 0.5,5 0.2,6 0.5,7 0.6,8 0.8,9 0.9,10 0.95,11 0.98,12 1,13 1,14 1,15 1,16  0.98,17 0.95,18 0.8,19 0.4,20 0,21 0,22 0,23 0,24 0/
pwmax(i)  /13 0.003,15 0.003, 30 0.003/
Pwind
vr        The rated velocity of wind turbines /8/
vcutin    The cut-in speed of wind turbines   /2/
vcutout   The cut-out speed of wind turbines  /18/
vw(t)     Wind velocity at time t  /1 7.95,2 8.8,3 9.65,4 1.55,5 9.45,6 8.45,7 7.15,8 6.04,9 6.45,10 5.1,11 4.35,12 4.7,13 5.1,14 6.2,15 7.2,16 8,17 9.35,18 10,19 9,20 8.5,21 7.4,22 7,23 6.75,24 7.15/
ep(t)     Energy price at time t   /1 50,2 50,3 45,4 45,5 50,6 52,7 52,8 55,9 66,10 70,11 90,12 90,13 140,14 200,15 230,16 230,17 260,18 300,19 240,20 210,21 140,22 120,23 120,24 80/
ag(i)  Diesel generators’ cost coefficients       /7 27,12 25,15 28,24 26/
bg(i)  Diesel generators’ cost coefficients       /7 7,12 87,15 9,24 81/
cg(i)  Diesel generators’ cost coefficients        /7 0.0025,12 0.0035,15 0.0035,24 0.184/;

Table GenD(i,*) 'generating units characteristics'
        Pg      Qg      Pmax    Pmin    Qmax    Qmin
1       0        0      10       0      10     -10       ;


Parameter rep1,rep2,rep3,rep4,rep5,rep6;


set
counter/c1*c2/
*3/
;




Table BD(i,*) 'demands of each bus in MW and MVar'
         Pd          Qd

1       0.00        0.00
2       0.10        0.06
3       0.09        0.04
4       0.12        0.08
5       0.06        0.03
6       0.06        0.02
7       0.20        0.10
8       0.20        0.10
9       0.06        0.02
10      0.06        0.02
11      0.05        0.03
12      0.06        0.04
13      0.06        0.04
14      0.12        0.08
15      0.06        0.01
16      0.06        0.02
17      0.06        0.02
18      0.09        0.04
19      0.09        0.04
20      0.09        0.04
21      0.09        0.04
22      0.09        0.04
23      0.09        0.05
24      0.42        0.20
25      0.42        0.20
26      0.06        0.03
27      0.06        0.03
28      0.06        0.02
29      0.12        0.07
30      0.20        0.60
31      0.15        0.07
32      0.21        0.10
33      0.06        0.04     ;


 Table   branch(i,j,*)

                 r            x            b       rateA    rateB   rateC     tap      an        st        min         max


1.2            0.0575        0.0293        0        0        0        0        0        0        1        -360        360
2.3            0.3076        0.1567        0        0        0        0        0        0        1        -360        360
3.4            0.2284        0.1163        0        0        0        0        0        0        1        -360        360
4.5            0.2378        0.1211        0        0        0        0        0        0        1        -360        360
5.6            0.5110        0.4411        0        0        0        0        0        0        1        -360        360
6.7            0.1168        0.3861        0        0        0        0        0        0        1        -360        360
7.8            0.4439        0.1467        0        0        0        0        0        0        1        -360        360
8.9            0.6426        0.4617        0        0        0        0        0        0        1        -360        360
9.10           0.6514        0.4617        0        0        0        0        0        0        1        -360        360
10.11          0.1227        0.0406        0        0        0        0        0        0        1        -360        360
11.12          0.2336        0.0772        0        0        0        0        0        0        1        -360        360
12.13          0.9159        0.7206        0        0        0        0        0        0        1        -360        360
13.14          0.3379        0.4448        0        0        0        0        0        0        1        -360        360
14.15          0.3687        0.3282        0        0        0        0        0        0        1        -360        360
15.16          0.4656        0.3400        0        0        0        0        0        0        1        -360        360
16.17          0.8042        1.0738        0        0        0        0        0        0        1        -360        360
17.18          0.4567        0.3581        0        0        0        0        0        0        1        -360        360
2.19           0.1023        0.0976        0        0        0        0        0        0        1        -360        360
19.20          0.9385        0.8457        0        0        0        0        0        0        1        -360        360
20.21          0.2555        0.2985        0        0        0        0        0        0        1        -360        360
21.22          0.4423        0.5848        0        0        0        0        0        0        1        -360        360
3.23           0.2815        0.1924        0        0        0        0        0        0        1        -360        360
23.24          0.5603        0.4424        0        0        0        0        0        0        1        -360        360
24.25          0.5590        0.4374        0        0        0        0        0        0        1        -360        360
6.26           0.1267        0.0645        0        0        0        0        0        0        1        -360        360
26.27          0.1773        0.0903        0        0        0        0        0        0        1        -360        360
27.28          0.6607        0.5826        0        0        0        0        0        0        1        -360        360
28.29          0.5018        0.4371        0        0        0        0        0        0        1        -360        360
29.30          0.3166        0.1613        0        0        0        0        0        0        1        -360        360
30.31          0.6080        0.6008        0        0        0        0        0        0        1        -360        360
31.32          0.1937        0.2258        0        0        0        0        0        0        1        -360        360
32.33          0.2128        0.3308        0        0        0        0        0        0        1        -360        360
21.8           1.2479        1.2479        0        0        0        0        0        0        0        -360        360
9.15           1.2479        1.2479        0        0        0        0        0        0        0        -360        360
12.22          1.2479        1.2479        0        0        0        0        0        0        0        -360        360
18.33          0.3120        0.3120        0        0        0        0        0        0        0        -360        360
25.29          0.3120        0.3120        0        0        0        0        0        0        0        -360        360         ;
*********************************************************************

Set line(i,j) /1.2,2.3,3.4,4.5,5.6,6.7,7.8,8.9,9.10,10.11,11.12
                 12.13,13.14,14.15,15.16,16.17,17.18,2.19,19.20,20.21,21.22,3.23,23.24,24.25,6.26,26.27,27.28
                  28.29,29.30,30.31,31.32,32.33,21.8,9.15,12.22,18.33,25.29/;

loop(t,
if((vw(t)>vcutin and vw(t)<vr),Pwind(i,t)$Wind(i)=pwmax(i) * ((vw(t) - vcutin) / (vr - vcutin)));
if((vcutout>vw(t)and vw(t)>vr),Pwind(i,t)$Wind(i)=pwmax(i));
if((vcutout<vw(t)or vw(t)<vcutin),Pwind(i,t)$Wind(i)=0););




variable
alpha
Rc
ratio
Qc
V
Pw
theta
Pg
Qg
Pfrom
Pto
Qfrom
Qto
Ploss
Fcb
PDG
P_cd
SOC
SOCmin
Cess
Pess
Pload_DRP
DD
TOU
P_PV
EIC
OPC
Cost_up
Cost_Loss
Cost_DG
Total_Cost
Fcb
pww
pvv;

Binary Variable
z_ess
z
UDG
yy;
equations
eq1
eq2
eq3
eq4
eq5
eq6
eq7
eq8
eq9
eq10
eq11
eq12
eq13
eq14
eq15
eq16
eq17
eq18
eq19
eq20
eq21
eq22
eq23
eq233
eq24
eq25
eq26
eq27
eq28
eq29
eq30
eq31
eq32
eq33
eq34
eq35
eq36
eq366
eq37
*eq38
eq39
eq40
eqq1;

******************************Step_1_Ybus_Formulation**************************


parameters
b
g
y;

b(i,j)$line(i,j) = -branch(i,j,'x')/(sqr(branch(i,j,'r'))+sqr(branch(i,j,'x')));
g(i,j)$line(i,j) = branch(i,j,'r')/(sqr(branch(i,j,'r'))+sqr(branch(i,j,'x')));


******************************Step_2_Ybus_Formulation**************************


y(i,j,'real')$(not sameas(i,j))= sum(line(i,j)$branch(i,j,'st'), -1 * (g(i,j)*cos(branch(i,j,'an')) - b(i,j)*sin(branch(i,j,'an'))))
                                                         + sum(line(j,i)$branch(j,i,'st'), -1* (g(j,i)*cos(-branch(j,i,'an')) - b(j,i)*sin(-branch(j,i,'an'))));


y(i,j,'imag')$(not sameas(i,j))= sum(line(i,j)$branch(i,j,'st'), -1 * (b(i,j)*cos(branch(i,j,'an')) + g(i,j)*sin(branch(i,j,'an'))))
                                                          + sum(line(j,i)$branch(j,i,'st'), -1* (b(j,i)*cos(-branch(j,i,'an')) + g(j,i)*sin(-branch(j,i,'an'))));


y(i,i,'real')=sum(j$branch(i,j,'st'), g(i,j)) + sum(j$branch(j,i,'st'), g(j,i));



y(i,i,'imag')= sum(j$branch(i,j,'st'), (b(i,j)+branch(i,j,'b')/2)) + sum(j$branch(j,i,'st'),(b(j,i)+branch(j,i,'b')/2));


display y;

*parameter plo;
*plo(i,t)= 5*BD(i,'pd')/sbase*zpd(t);
Parameter Beta/0.025/ ;

***************************AC_PowerFlow***************************************


eq1(i,t)..         Pg(i,t)$slackbus(i)+PDG(i,t)$DG(i)+P_PV(i,t)$PV(i)+pww(i,t)$Wind(i)+1*P_cd(i,t)$ESS_1(i)-Pload_DRP(i,t)=e=sum(j,(V(i,t)*V(j,t)*y(i,j,'real')*cos(theta(i,t)-theta(j,t))+V(i,t)*V(j,t)*y(i,j,'imag')*sin(theta(i,t)-theta(j,t))));

eq2(i,t)..         Qg(i,t)$slackbus(i)-BD(i,'Qd')/sbase=e=sum(j,(V(i,t)*V(j,t)*y(i,j,'real')*sin(theta(i,t)-theta(j,t))-V(i,t)*V(j,t)*y(i,j,'imag')*cos(theta(i,t)-theta(j,t))));



**************************Constraints*******************************************
eq3(i,j,t)$(line(i,j))..                   Pfrom(i,j,t)=e=(power(V(i,t),2)*y(i,j,'real')-V(i,t)*V(j,t)*[y(i,j,'real')*cos(theta(i,t)-theta(j,t))+y(i,j,'imag')*sin(theta(i,t)-theta(j,t))]);

eq4(i,j,t)$(line(i,j))..                   Pto(i,j,t)=e=(power(V(j,t),2)*y(i,j,'real')-V(i,t)*V(j,t)*[y(i,j,'real')*cos(theta(i,t)-theta(j,t))-y(i,j,'imag')*sin(theta(i,t)-theta(j,t))]);

eq5(i,j,t)$(line(i,j))..                   Qfrom(i,j,t)=e=(-power(V(i,t),2)*(branch(i,j,'b')/2+y(i,j,'imag'))-V(i,t)*V(j,t)*[y(i,j,'real')*sin(theta(i,t)-theta(j,t))-y(i,j,'imag')*cos(theta(i,t)-theta(j,t))]);

eq6(i,j,t)$(line(i,j))..                   Qto(i,j,t)=e=(-power(V(j,t),2)*(branch(i,j,'b')/2+y(i,j,'imag'))+V(i,t)*V(j,t)*[y(i,j,'real')*sin(theta(i,t)-theta(j,t))+y(i,j,'imag')*cos(theta(i,t)-theta(j,t))]);

*eq7(i,j)$(line(i,j))..                       100*sqrt(power(Pfrom(i,j),2)+power(Qfrom(i,j),2))=l=400;

*eq12(i,j)$(line(i,j))..                      100*sqrt(power(Pto(i,j,c),2)+power(Qto(i,j,c),2))=l=branch(i,j,c,'rateA');

eq7(i,t)$DG(i)..                           PDG(i,t)=g=Pmindg(i)*UDG(i,t);
eq8(i,t)$DG(i)..                           PDG(i,t)=l=Pmaxdg(i)*UDG(i,t);

eq9(i,t)$DG(i)..                           PDG(i,t)-PDG(i,t-1)=l=UR(i)*(1-yy(i,t))+Pmindg(i)*yy(i,t);
eq10(i,t)$DG(i)..                          PDG(i,t-1)-PDG(i,t)=l=DR(i)*(1-z(i,t))+Pmindg(i)*z(i,t);

eq11(i,t)$DG(i)..                          sum(k$(ord(k)<(ord(k)+UT(i)-1)),UDG(i,k))=g=UT(i)*yy(i,t);
eq12(i,t)$DG(i)..                          sum(k$(ord(k)<(ord(k)+DT(i)-1)),1-UDG(i,k))=g=DT(i)*z(i,t);

eq13(i,t)$DG(i)..                          yy(i,t)-z(i,t)=e=UDG(i,t)-UDG(i,t-1);
eq14(i,t)$DG(i)..                          yy(i,t)+z(i,t)=l=1;

eq15(i,t)$(ESS_1(i)and(ord(t)>1)and(ord(t)<>24))..                       SOC(i,t)=e=SOC(i,t-1)+P_cd(i,t);

eq16(i)$ESS_1(i)..   SOC(i,'1')=e=SOC(i,'24');


eq17(i)$ESS_1(i)..   SOC(i,'24')=e=SOCmin(i);


eq18(i)$ESS_1(i)..  SOCmin(i)=e=0.5*Cess(i);


eq19(i,t)$ESS_1(i)..SOC(i,t)=l=Cess(i);

eq20(i,t)$ESS_1(i)..SOC(i,t)=g=SOCmin(i);


eq21(i,t)$ESS_1(i)..P_cd(i,t)=l=0.4*Pess(i);

eq22(i,t)$ESS_1(i)..P_cd(i,t)=g=-0.4*Pess(i);

eq23.. sum(i$ESS_1(i),Sbase*Cess(i))=e=15;
eq233.. sum(i$ESS_1(i),Sbase*Pess(i))=e=5;

eq24(i,t)..Pload_DRP(i,t) =e=DD(i,t)-TOU(i,t);

*plo=dd  haman dd hast

eq25(i)..sum(t,DD(i,t))=e= sum(t,Pload_DRP(i,t));

eq26(i,t)..TOU(i,t)=l=0.2*DD(i,t);
eq27(i,t)..TOU(i,t)=g=-0.2*DD(i,t);

eq28(i,t)$PV(i)..P_PV(i,t)=l=PVcap(i)*Ta(t);

eq29(i,t)$PV(i)..P_PV(i,t)=g=0;

*******************************************************************************************************
eq30(t)..           Ploss(t)=e=((-Sbase)*sum(line(i,j),y(i,j,'real')*[power(V(i,t),2)+power(V(j,t),2)-2*V(i,t)*V(j,t)*cos(theta(i,t)-theta(j,t))]));
eq31..              EIC=e=Sum((i,t)$(ESS_1(i)),P_cd(i,t)*Sbase*11000+Cess(i)*Sbase*40000);
eq32..              Cost_up=e=20*sum((i,t)$slackbus(i),Pg(i,t)*Sbase*ep(t));
eq33..              Cost_Loss=e=sum(t,Ploss(t)*ep(t));
eq34..              Cost_DG=e=sum((i,t)$DG(i),ag(i)*sqr(PDG(i,t)*Sbase)+bg(i)*(PDG(i,t)*Sbase)+cg(i));
eq35..              OPC=e=Cost_up+Cost_Loss+Cost_DG;
eq36..              Total_Cost=e=EIC+OPC;

*eq36..              Total_Cost=e= Sum((i,t)$(ESS_1(i)),P_cd(i,t)*Sbase*11000+Cess(i)*Sbase*40000)+
*                                   20*sum((i,t)$slackbus(i),Pg(i,t)*Sbase*ep(t))+ sum(t,Ploss(t)*ep(t))+
*                                 sum((i,t)$DG(i),ag(i)*sqr(PDG(i,t)*Sbase)+bg(i)*(PDG(i,t)*Sbase)+cg(i));
*-10*sum((I,t), P_PV(i,t));
**********************************

alpha.lo=0;
alpha.up=1;

V.fx('1',t)=1;
V.lo(PQ,t)=0.95;
V.up(PQ,t)=1.05;

theta.lo(i,t)=-pi/2;
theta.up(i,t)=pi/2;

Pg.lo(slackbus,t) = GenD(slackbus,'Pmin')/Sbase;
Pg.up(slackbus,t)= GenD(slackbus,'Pmax')/Sbase;

Qg.lo(slackbus,t) = GenD(slackbus,'Qmin')/Sbase;
Qg.up(slackbus,t) = GenD(slackbus,'Qmax')/Sbase;





*eq37..              sum((i,t)$slackbus(i),Pg(i,t)*Sbase)=g=2;
model RPP/eq1,eq2,eq3,eq4,eq5,eq6,eq7,eq8,eq9,eq10,eq11,eq12,eq13,eq14,eq15,eq16,eq17,
eq18,eq19,eq20,eq21,eq22,eq23,eq233,eq24,eq25,eq26,eq27,eq28,eq29,eq30,eq36,eq366,eqq1/;


option reslim=10800;
option optca=0,optcr=0;
*option MIP=cplex,NLP=conopt4, minlp=lindo;
option MIP=cplex,NLP=conopt4, minlp=dicopt;
*option minlp =Knitro;
solve RPP using minlp minimizing Total_Cost;

*parameter EIC2;

*EIC2=e=Sum((i,t)$(ESS_1(i)),P_cd.l(i,t)*Sbase*11000+Cess.l(i)*Sbase*40000);




display Ploss.l,Total_Cost.l,V.l,Pwind,pdg.l,pg.l,P_PV.l;
