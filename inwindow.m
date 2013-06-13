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

%initialization
intercount = 0;
sign = 1;

% define the end point of the vertical line
p2(1) = p1(1);
p2(2) = -30;
nClipVertex = size(Clipwin,2);

% draw vertical line
for  i = 1 : (nClipVertex-1)
    [X Y flag]= intersectpoint( p1,p2,Clipwin(:,i),Clipwin(:,i+1));
    if flag 
        intercount = intercount + 1;
    end
end

 if (mod(intercount,2)==0)
     sign = -1;
 end
end