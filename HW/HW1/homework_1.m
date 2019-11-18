% Student name: UNAL FARUK
% Student ID : LS1925224

%%PART - 1
%1
matrix_A = eye(4);

%2
matrix_B = [101 91 81 71 61 51 41 31 21 11];
transpose_B = transpose(matrix_B);

%3
matrix_C=[1.3,-0.4,0.3,0.1,2.1;3.4,2.8,6.6,-1.1,1.0;0.5,0.0,-3.5,2.5,6.0;-2.0,1.1,1.0,5.1,1.1;6.8,-1.5,-3,3.2,0];
matrix_C_3=matrix_C; %for future-use

%4
matrix_C(1,2)=14;
matrix_C(1,4)=14;
matrix_C(3,2)=14;
matrix_C(3,4)=14;
matrix_C(5,2)=14;
matrix_C(5,4)=14;

%5
matrix_C(2,:)=[];
matrix_C(4,:)=[];

%6
matrix_X=inv(matrix_C_3);
matrix_X_alternative = eye([5])/matrix_C_3;

%7
matrix_F=[0:1/7:1];

%%PART - 2
%1
G = rand(10,8);
for row=1:10
    for column=1:8
        G(row,column)=input(['Type a value for G(' num2str(row) ',' num2str(column) ')=']);
    end
end

%2
H = round(G);
findOnes = numel(find(H==1));
findZeros = numel(find(H==0));

%%PART - 3
%1
a= (-360:360)*pi/180; 
b = 4*sin(a);


positive_b = find(b>0);
p=plot(a,b,'*-k','MarkerFaceColor','red','MarkerEdgeColor','red','MarkerIndices',positive_b);
hold on;
negative_b = find(b<0);
p=plot(a,b,'o-k','MarkerEdgeColor','green','MarkerIndices',negative_b);

%2
c = 2*cos(a);
k=plot(a,c,'-r');

%3
maximum_b = find(b == max(b));
minimum_b = find(b == min(b));
maximum_c = find(c == max(c));
minimum_c = find(c == min(c));
p=plot(a,b,'-*','MarkerFaceColor','cyan','MarkerEdgeColor','cyan','MarkerIndices',maximum_b);
hold on;
p=plot(a,b,'-s','MarkerFaceColor','magenta','MarkerEdgeColor','magenta','MarkerIndices',minimum_b);
hold on;
p=plot(a,c,'-*','MarkerFaceColor','cyan','MarkerEdgeColor','cyan','MarkerIndices',maximum_c);
hold on;
p=plot(a,c,'-s','MarkerFaceColor','magenta','MarkerEdgeColor','magenta','MarkerIndices',minimum_c);
hold on;
