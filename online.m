%% by Dage
% 2013.6.12

function [flag]= online(X,Y,P1,P2)
% determine if the point (X,Y) is between the point P1 and P2, not on P1, P2
% pre-knowledge: X,Y must be on the line P1P2
% naive version 
%
% Input:        X: x-coordinate of the intersection point
%               Y: y-coordinate of the intersection point
%               P1: point
%               P2: point
% Output:       flag: 1  - on line segment
%                     0  - out of line segment
%

flag = 0;

if P1(1)>P2(1)
    if X>=P2(1)&&X<P1(1)
        flag=1;
    end
elseif P1(1)==P2(1)
    if P1(2)>P2(2)
        if Y>=P2(2)&&Y<P1(2)
            flag=1;
        end
    else
        if Y>P1(2)&&Y<=P2(2)
            flag=1;
        end
    end
else
    if X>P1(1)&&X<=P2(1)
        flag=1;
    end
end    
end