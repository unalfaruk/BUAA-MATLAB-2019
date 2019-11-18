% Student name: UNAL FARUK
% Student ID : LS1925224

u=1;
v=3;

a=(4*u)/(3*v); %Paranthesis are first
disp(a);

b=(4/3)*pi*(v^2);
disp(b);

c=2*(v^2)/((u+v)^2);
disp(c);

d=((u-3*v)^(1/2))/(3*v);
disp(d);

e=((u+cos(v))^2)/(v-u);
disp(e);

f=(pi/3)*sin(0.7*pi);
disp(f);

fprintf("a=%f\nb=%f\nc=%f\nd=%f%+fj\ne=%e\nf=%f\n",a,b,c,real(d),imag(d),e,f);
