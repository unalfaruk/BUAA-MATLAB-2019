% Student name: UNAL FARUK
% Student ID : LS1925224

%HW5-1
%Q-1
subplot(3,2,1);
x = 0:pi/30:4*pi;
y1 = real((exp(1).^(-0.2.*x)).*(sin(x)-(cos(x)*i)));
plot(x,y1,'c');
hold on;
y2 = imag((exp(1).^(-0.2.*x)).*(sin(x)-(cos(x)*i)));
plot(x,y2,'-.m');
xticks([0 pi 2*pi 3*pi 4*pi]);
xticklabels({'0','\pi','2\pi','3\pi','4\pi'});

%Q-2
subplot(3,2,2);
x = 0:pi/30:4*pi;
y1 = real((exp(1).^(-0.2.*x)).*(sin(x)-(cos(x)*i)));
stem(x,y1,'b');
hold on;
y2 = imag((exp(1).^(-0.2.*x)).*(sin(x)-(cos(x)*i)));
stem(x,y2,'r');
xticks([0 pi 2*pi 3*pi 4*pi]);
xticklabels({'0','\pi','2\pi','3\pi','4\pi'});

%Q-3
subplot(3,2,3);
x = 0:pi/30:4*pi;
y1 = real((exp(1).^(-0.2.*x)).*(sin(x)-(cos(x)*i)));
bar(x,y1,'b');
xticks([0 pi 2*pi 3*pi 4*pi]);
xticklabels({'0','\pi','2\pi','3\pi','4\pi'});

%Q-4
subplot(3,2,4);
x = 0:pi/30:4*pi;
y1 = (exp(1).^(-0.2.*x)).*(sin(x)-(cos(x)*i));
compass(y1);

%Q-5
subplot(3,2,5);
fplot(@(x_var) (exp(1).^(-x_var)).*sin(x_var),[-3 0],'b')
hold on
fplot(@(x_var) (exp(1).^(-x_var)).*sin(x_var),[0 3],'r')
hold off
grid on

%Q-6
subplot(3,2,6);
amounts = [5 15 5 10 15];
names = {'Wang','Zhang','Liu','Chen','Zhao'};
pie(amounts);
legend(names,'Location','eastoutside');
hold off;

%HW5-2
%Q-a
figure;
x=-1.8:0.02:1.8;
y=-1.2:0.01:1.2;
z=-1.8:0.02:1.8;
[X,Y,Z]=meshgrid(x,y,z);
D=(2.*X.^2+2.*Y.^2+Z.^2-1).^3-(1/10).*X.^2.*Z.^3-Y.^2.*Z.^3;
% isovalue = 0.2*(max(D(:))-min(D(:)))+min(D(:));
surf1 = isosurface(X,Y,Z,D,0);
p1 = patch(surf1);
% isonormals(x,y,z,D,p1);
set(p1,'FaceColor','red','EdgeColor','none','FaceAlpha',1); % set the color, mesh and transparency level of the surface
% daspect([1,1,1])
view(3); 
axis equal
camlight; lighting gouraud;
xlabel('X');
ylabel('Y');
zlabel('Z');


%Q-b
%%I found a code-example at stackoverflow (https://stackoverflow.com/a/47842456/6603006), the heart was bouncing in that
%%code, i changed some parts of the code and got what I want
%%In this method, we are shifting the axes not the object.
figure;
x=-1.8:0.02:1.8;
y=-1.2:0.01:1.2;
z=-1.8:0.02:1.8;
% isonormals(x,y,z,D,p1);
[X,Y,Z]=meshgrid(x,y,z);
D=(2.*X.^2+2.*Y.^2+Z.^2-1).^3-(1/10).*X.^2.*Z.^3-Y.^2.*Z.^3;
isosurface(X,Y,Z,D,0);
% set(p1,'FaceColor','red','EdgeColor','none','FaceAlpha',1); % set the color, mesh and transparency level of the surface


axis tight
axis equal
colormap flag
axis manual

ax = gca;

k=2;
ax.XLim = ax.XLim*k;
ax.YLim = ax.YLim*k;
ax.ZLim = ax.ZLim*k;

tempLims.XLim = ax.XLim;
tempLims.YLim = ax.YLim;
tempLims.ZLim = ax.ZLim;

t=0;
heartData = sin((1:250)/100*2*pi)/6.*hamming(250)';
heartData(251:400) = 0;

while 1
    t=t+1;
    t=mod(t, length(heartData))+1;

    k = 3*heartData(t);

%     ax.XLim = tempLims.XLim * k;
%     ax.YLim = tempLims.YLim * k;
    ax.ZLim = tempLims.ZLim - k;
    pause(0.01);
end