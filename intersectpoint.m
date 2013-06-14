%% by XUE YEGUAGN

function [X Y flag]= intersectpoint( A1,B1,A2,B2 )
% Calculate the intersect between line A1-B1 and line A2-B2
% determine whether the intersection is on the line by comparing the
% value of the points
% naive version 
%
% Input:        A1,B1,A2,B2: 4 points, each has two elements x,y
% Output:       X: the intersect point's x coordinate
%               Y: the intersect point's y coordinate
%               flag: 1 if has intersection (on 2 line segments), 0 if not
% Error:		A1-B1,A2-B2 not a line, flag: -1 error
%
%

% initialization
flag = 0;
X=Inf;
Y=Inf;

A1X=A1(1);
A1Y=A1(2);
A2X=A2(1);
A2Y=A2(2);

B1X=B1(1);
B1Y=B1(2);
B2X=B2(1);
B2Y=B2(2);

L1=B1-A1; % line vector
L2=B2-A2;

% ensure input is ok
if ( ( (L1(1)==0) && (L1(2)==0) ) || ( ( (L1(1)==0) && (L1(2)==0) ) ) )
    flag=-1;
	'Error'
    return;
end
% begin

% Condition 1: parallel or coincidence
if L1(1)*L2(2)-L1(2)*L2(1) <1e-10
    flag=0;
    return;
end

% Condition 2: intersect

if A1X==B1X 
    X=A1X;
    k2=(B2Y-A2Y)/(B2X-A2X);
    b2=A2Y-k2*A2X; 
    Y=k2*X+b2;
    flag = 1;
end

if A2X==B2X
    X=A2X;
    k1=(B1Y-A1Y)/(B1X-A1X);
    b1=A1Y-k1*A1X;
    Y=k1*X+b1;
    flag = 1;
end

if A1X~=B1X && A2X~=B2X
    k1=(B1Y-A1Y)/(B1X-A1X);
    k2=(B2Y-A2Y)/(B2X-A2X);
    b1=A1Y-k1*A1X;
    b2=A2Y-k2*A2X;
    X=(b2-b1)/(k1-k2);
    Y=k1*X+b1;
    flag = 1;
end
    
% determine whether the intersection is on the line
if flag
    [flag1]= online(X,Y,A1,B1);
    [flag2]= online(X,Y,A2,B2);
    if flag1 && flag2
        flag = 1;
    else 
        flag = 0;
    end
end

end
