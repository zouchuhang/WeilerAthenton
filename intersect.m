%% by Chuhang Zou
% 2013.6.11
% revised from http://blog.sina.com.cn/s/blog_60b9b8890100t2b9.html

function [X Y flag]= intersect( X1,Y1,X2,Y2 )
% Calculate the intersect between line X1Y1 and line X2Y2
% determine whether the intersection is on the line by comparing the
% value of the points
% naive version 
%
% Input:        X1,Y1,X2,Y2: 4 points, each has two elements x,y
% Output:       X: the intersect point's x coordinate
%               Y: the intersect point's y coordinate
%               flag: 1 if has intersection, 0 if no
%
% exception condition:  1.  coincidence
%                       2.  vertex of the polygon is on the
%                       clipwindow¡ª¡ªjudge.mÀïÃæÅÐ¶Ï
%

%initialization
flag = 0;
X=Inf;
Y=Inf;
        
if X1(1)==Y1(1) 
    % exception condition:  1
    if X2(1)==Y2(1)
        flag = 0;
        return;
    end
    X=X1(1);
    k2=(Y2(2)-X2(2))/(Y2(1)-X2(1));
    b2=X2(2)-k2*X2(1); 
    Y=k2*X+b2;
    flag = 1;
end
if X2(1)==Y2(1)
    X=X2(1);
    k1=(Y1(2)-X1(2))/(Y1(1)-X1(1));
    b1=X1(2)-k1*X1(1);
    Y=k1*X+b1;
    flag = 1;
end
if X1(1)~=Y1(1) && X2(1)~=Y2(1)
    k1=(Y1(2)-X1(2))/(Y1(1)-X1(1));
    k2=(Y2(2)-X2(2))/(Y2(1)-X2(1));
    b1=X1(2)-k1*X1(1);
    b2=X2(2)-k2*X2(1);
    % exception condition:  1
    if k1==k2
       flag = 0;
       return;
    else
    X=(b2-b1)/(k1-k2);
    Y=k1*X+b1;
    flag = 1;
    end
end
    
% determine whether the intersection is on the line
if flag
    [flag1]= online(X,Y,X1,Y1);
    [flag2]= online(X,Y,X2,Y2);
    if flag1 && flag2
        flag = 1;
    else 
        flag = 0;
    end
end

end
