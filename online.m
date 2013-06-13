%% by Yeguang Xue
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
%                     -1 - out of line segment
%
flag = 1;

if X > max (P1(1),P2(1))|| X < min (P1(1),P2(1)) || Y > max (P1(2),P2(2))|| Y < min (P1(2),P2(2))
    flag = 0;
    return;
end
    
end