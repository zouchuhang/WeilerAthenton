%% by XUE YEGUAGN

function [X Y flag]= intersectpoint( Poly1,Poly2,Clipwin1,Clipwin2 )
% Calculate the intersect between line segments Poly1-Poly2 and Clipwin1-Clipwin2
% determine whether the intersection is on the line by comparing the
% value of the points
% naive version
%
% Input:        Poly1,Poly2,Clipwin1,Clipwin2: 4 points, each has two elements x,y
% Output:       X: the intersect point's x coordinate
%               Y: the intersect point's y coordinate
%               flag: 1 if has intersection (on 2 line segments), 0 if not
% Error:		Poly1-Poly2,Clipwin1-Clipwin2 not a line, flag: -1 error
%
%

% initialization
flag = 0;
X=Inf;
Y=Inf;

Poly1X=Poly1(1);
Poly1Y=Poly1(2);
Clipwin1X=Clipwin1(1);
Clipwin1Y=Clipwin1(2);

Poly2X=Poly2(1);
Poly2Y=Poly2(2);
Clipwin2X=Clipwin2(1);
Clipwin2Y=Clipwin2(2);

% line vector
L1=Poly2-Poly1;
L2=Clipwin2-Clipwin1;

% ensure input is ok
if ( ( (L1(1)==0) && (L1(2)==0) ) || ( ( (L1(1)==0) && (L1(2)==0) ) ) )
    flag=-1;
    'Error'
    return;
end
% begin

% Condition 1: parallel or coincidence

if abs(L1(1)*L2(2)-L1(2)*L2(1)) <1e-10    
    if isinline(Poly1(1),Poly1(2),Clipwin1,Clipwin2 )
        X=Clipwin2(1);
        Y=Clipwin2(2);
        flag=1;
    else
        flag=0;
        return;
    end
else
    % Condition 2: intersect
    
    if Poly1X==Poly2X
        X=Poly1X;
        k2=(Clipwin2Y-Clipwin1Y)/(Clipwin2X-Clipwin1X);
        b2=Clipwin1Y-k2*Clipwin1X;
        Y=k2*X+b2;
        flag = 1;
    end
    
    if Clipwin1X==Clipwin2X
        X=Clipwin1X;
        k1=(Poly2Y-Poly1Y)/(Poly2X-Poly1X);
        b1=Poly1Y-k1*Poly1X;
        Y=k1*X+b1;
        flag = 1;
    end
    
    if Poly1X~=Poly2X && Clipwin1X~=Clipwin2X
        k1=(Poly2Y-Poly1Y)/(Poly2X-Poly1X);
        k2=(Clipwin2Y-Clipwin1Y)/(Clipwin2X-Clipwin1X);
        b1=Poly1Y-k1*Poly1X;
        b2=Clipwin1Y-k2*Clipwin1X;
        X=(b2-b1)/(k1-k2);
        Y=k1*X+b1;
        flag = 1;
    end
    
end

% determine whether the intersection is on the line
if flag
    [flag1]= online(X,Y,Poly1,Poly2);
    [flag2]= online(X,Y,Clipwin1,Clipwin2);
    if flag1 && flag2
        flag = 1;
    else
        flag = 0;
    end
end



end
