% Student name: UNAL FARUK
% Student ID : LS1925224

%%HW3-1
%1
P = @(k,n,p) binopdf(k,n,p);
%3
result=Binomial_Function(6,10,0.5);
%4
for step=0:5
    disp(P(step,5,0.6));
end

%%HW3-2
%b
leap_year(1952,2019);

%%HW3-3
% I took the algorithm from MathWorks File Exchange after I understood algorithm.
A=randi([-500,500],1,20);
A_sorted = quicksort(A);


%%FUNCTIONS
%3-3
function x = quicksort(x)
%--------------------------------------------------------------------------
% Syntax:       sx = quicksort(x);
%               
% Inputs:       x is a vector of length n
%               
% Outputs:      sx is the sorted (ascending) version of x
%               
% Description:  This function sorts the input array x in ascending order
%               using the quicksort algorithm
%               
% Complexity:   O(n * log(n))    best-case performance
%               O(n * log(n))    average-case performance
%               O(n^2)           worst-case performance
%               O(log(n))        auxiliary space (stack)
%               
% Author:       Brian Moore
%               brimoor@umich.edu
%               
% Date:         January 5, 2014
%--------------------------------------------------------------------------
% Knobs
kk = 5; % Insertion sort threshold, kk >= 1
% Quicksort
n = length(x);
x = quicksorti(x,1,n,kk);
end
function x = quicksorti(x,ll,uu,kk)
% Sort x(ll:uu) via quick sort 
% Note: In practice, x xhould be passed by reference
% Select pivot and partition data around it
[x mm] = partition(x,ll,uu);
% Divide-and-conquer
if ((mm - ll) <= kk)
    % Sort x(ll:(mm - 1)) via insertion sort 
    x = insertionsorti(x,ll,mm - 1);
else
    % Sort x(ll:(mm - 1)) via quick sort 
    x = quicksorti(x,ll,mm - 1,kk);
end
if ((uu - mm) <= kk)
    % Sort x((mm + 1):uu) via insertion sort 
    x = insertionsorti(x,mm + 1,uu);
else
    % Sort x((mm + 1):uu) via quick sort 
    x = quicksorti(x,mm + 1,uu,kk);
end
end
function [x mm] = partition(x,ll,uu)
% Partition x(ll:uu) around index mm
% Note: In practice, x xhould be passed by reference
%--------------------------------------------------------------------------
% Select pivot
%--------------------------------------------------------------------------
% Method 1: Median-of-3 pivot
pp = medianofthree(x,ll,uu); % Median-of-three pivot index
% Method 2: Random pivot
%pp = randi([ll uu]); % Random pivot index
%--------------------------------------------------------------------------
% Partition around pivot
x = swap(x,ll,pp);
mm = ll;
for j = (ll + 1):uu
    if (x(j) < x(ll))
        mm = mm + 1;
        x = swap(x,mm,j);
    end
end
x = swap(x,ll,mm);
end
function pp = medianofthree(x,ll,uu)
% Compute median of {x(ll),x(mm),x(uu)}
% Note: In practice, x xhould be passed by reference
% Middle element (avoiding overflow)
mm = ll + floor((uu - ll) / 2);
% Compute median of {x(ll),x(mm),x(uu)}
if (x(ll) <= x(mm))
    if (x(uu) >= x(mm))
        pp = mm;
    elseif (x(uu) >= x(ll))
        pp = uu;
    else
        pp = ll;
    end
else
    if (x(uu) >= x(ll))
        pp = ll;
    elseif (x(uu) >= x(mm))
        pp = uu;
    else
        pp = mm;
    end
end
end
function x = insertionsorti(x,ll,uu)
% Sort x(ll:uu) via insertion sort 
% Note: In practice, x xhould be passed by reference
% Insertion sort
for j = (ll + 1):uu
    pivot = x(j);
    i = j;
    while ((i > ll) && (x(i - 1) > pivot))
        x(i) = x(i - 1);
        i = i - 1;
    end
    x(i) = pivot;
end
end
function x = swap(x,i,j)
% Swap x(i) and x(j)
% Note: In practice, x xhould be passed by reference
val = x(i);
x(i) = x(j);
x(j) = val;
end



%%FUNCTIONS
%3-2
%a
function result4=leap_year(beginning,ending)
    for year=beginning:ending
        if(mod(year,4)==0)
            if(mod(year,100)==0)
                if(mod(year,400)==0)
                    disp(year + " is a leap year.");
                else
                    disp(year + " is not a leap year.");
                end
            else
                disp(year + " is a leap year.");
            end
        else
            disp(year + " is not a leap year.");
        end
    end
end



%%FUNCTIONS
%3-1
%%Functions by me
function result1 = myFact(n)
    temp=n;
    for n=n:-1:2
       temp=temp*(n-1);
    end
    result1=temp;
end

function result2=binCoef(n,k)
    result2=myFact(n);
    result2=result2/(myFact(k)*myFact(n-k));
end

function result3 = probab(k,n,p)
    result3=(p^k)*((1-p)^(n-k));
end
%%Answer
function result=Binomial_Function(k,n,p)
    result=binCoef(n,k)*probab(k,n,p);
end