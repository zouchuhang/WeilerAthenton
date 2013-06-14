%% by Chuhang Zou
% 2013.6.11

function [sign]= inwindow(p1,Clipwin)
% determine if the point is in the clipping window
% draw a vertical line down from p1, if have odd intersection, in-point, otherwise out-point 
% vertical line: start:p1, end: x coordinate on the screen
% naive version 
%
% Input:        p1: start of the polygon vector(in clock-wise)
%               Clipwin: the clipping window
% Output:       sign: 1  - in point
%                     -1 - out point
%
%进行一次编码
minline = min(Clipwin');
maxline = max(Clipwin');
xmin = minline(1); %找到x最小的值；
ymin = minline(2); %找到y最小的值；
xmax = maxline(1); %找到x最大的值；
ymax = maxline(2); %找到y最大的值；

if p1(1)<=xmax & p1(1)>=xmin & p1(2)<=ymax & p1(2)>=ymin  %表示点在焦点内（将边界上的点算作内部）
    sign=1;
else
    sign=-1;
end
end