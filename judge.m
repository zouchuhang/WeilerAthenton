%% by Chuhang Zou
% 2013.6.11

function [sign]= judge( p,p1,p2,Clipwin,place)
% Judge whether the point is in-point or out-point
% Move the intersection point clock-wise, if the moved point is in the
% polygon, then in-point, othterwise out-point
% naive version - may have wrong
%
% Input:        p: the intersection one
%               p1: start of the polygon vector(in clock-wise)
%               p2: end of the polygon vector(in clock-wise)
%               Clipwin: the clipping window
%               i: the place of p1 in Clipwin 
% Output:       sign: 1  - in point
%                     -1 - out point
%

%if p2 = p; vertex of the polygon is on the clipwindow
if p2(1) == p(1) && p2(2) == p(2)
    [sign]  = inwindow(Clipwin(:,place+2),Clipwin);
    if sign == -1
        return;
    end
end

% calculate the moved point p1
delta = (p2(1)-p1(1))/abs(p2(1)-p1(1));
k = (p2(2)-p1(2))/(p2(1)-p1(1));
p1(1) = p(1)+delta;
p1(2) = p(2)+ k * delta;

%determine if the point is in the clipping window
[sign]  = inwindow(p1,Clipwin);
