% Student name: UNAL FARUK
% Student ID : LS1925224

%%HW2-1
%a
A=ones(6)+ones(6);
%b
v=[1 2 3 4 3 2 1];
B=diag(v);
%c
k=[1:1:100];
C=reshape(k,[10,10]);
%d
D=10*rand(5,3);
D=floor(D);

%%HW2-2
a=2;
b=[-2,3;6,0];
c=[0,3;2,0];
d=[-2.2,-0.1;1.9,1.2;2.1,0.1];
%a
e=round(d);
disp('e=')
disp(e);

%b
b_result=b*c;

%c
c_result=b.*c;

%d
d_result=~(a>e);

%e
e_result=a>c & b>c;

%%HW2-3
%Manual solving - a
syms a b c
eqn1 = ((-2)^2)*a + (-2)*b + c == -9.8;
eqn2 = ((-1)^2)*a + (-1)*b + c == -8.8;
eqn3 = ((0)^2)*a + 0*b + c == -6.3;

[unkA,unkB] = equationsToMatrix([eqn1, eqn2, eqn3], [a, b, c]);

unkX = linsolve(unkA,unkB);

%Polyfit solving -b
x=[-2 -1 0];
y=[-9.8 -8.8 -6.3];
p=polyfit(x,y,2);

%c
curve=polyval(p,x);
plot(x,y,'o',x,curve);

%%HW2-4
A=[];
for number=1:999
    number_str=num2str(number);
    [number_1,number_2,number_3]=deal(0);
    try
        number_1=str2double(number_str(1));
        number_2=str2double(number_str(2));
        number_3=str2double(number_str(3));
    catch 
        warning('No digit in this step, dont worry :)');
    end
    
    comp_1=((number_1^3)+(number_2^3)+(number_3^3));
    comp_2=((number_1*100)+(number_2*10)+(number_3));
    
    if comp_1==comp_2
        A(end+1)=number;
    end
end

%%HW2-5
format long;
f=@(x) x/2-sin(x);
roots=fsolve(f,[pi/8 pi]);
disp(roots);


