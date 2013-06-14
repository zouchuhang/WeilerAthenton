function [ encode ] = Encodefunction( Polygon,Clipwin,nPolyVertex,nClipVertex )
%  此程序进行编码工作
% Input:        Polygon: 需要裁减的多边形
%               Clipwin: the clipping window
% Output:       encode：所完成的编码
minline = min(Clipwin');
maxline = max(Clipwin');
xmin = minline(1); %找到x最小的值；
ymin = minline(2); %找到y最小的值；
xmax = maxline(1); %找到x最大的值；
ymax = maxline(2); %找到y最大的值；
encode = [];
for i = 1 : (nPolyVertex)
    x = Polygon(1,i);
    y = Polygon(2,i);
    if x<=xmax & x>=xmin 
        if y<=ymax & y>=ymin
            encode = [encode;0,0,0,0];
        elseif y>ymax
            encode = [encode;1,0,0,0];
        else
            encode = [encode;0,1,0,0];
        end
    elseif x>xmax
            if y>=ymax
                encode = [encode;1,0,1,0];
            elseif y<=ymin
                encode = [encode;0,1,1,0];
            else
                encode = [encode;0,0,1,0];
            end
    else
        if y>=ymax
                encode = [encode;1,0,0,1];
            elseif y<=ymin
                encode = [encode;0,1,0,1];
            else
                encode = [encode;0,0,0,1];
        end
    end
end
end

