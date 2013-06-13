%% by Yeguang Xue
% 2013.6.12

function [flag]= isinline(X,Y,A,B)

% determine if the point (X,Y) is on line AB
% naive version 
%
% Input:        X: x-coordinate of the intersection point
%               Y: y-coordinate of the intersection point
%               A: point
%               B: point
% Output:       flag: 1  - on line segment
%                     0  - not online
%
flag = 0;

% vertical line
if A(1)==B(1)
    if X==A(1)
        flag=1;
        return;
    end
end

% horizontal line
if A(2)==B(2)
    if Y==A(2)
        flag=1;
        return;
    end
end

% general case
if (X-A(1))/(B(1)-A(1)) - (Y-A(2))/(B(2)-A(2)) <1e-10
    flag=1;
    return;
end
    
end
