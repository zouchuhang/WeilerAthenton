%% A demo of clipping of polygon by Weiler-Authenton algorithm

% Author: Chuhang Zou 
% Yeguang Xue
% 2013.6.13
% naive version - could be speeded up
%
% if you have any quesion. qq or phone me!!
%
% In the figure: blue - clipping window, red - polygon, black - result


%% Initializing

% Screen definition
width=10;
height=10;

hold on
axis on
axis equal
axis([-3*width 3*width -3*height 3*height])

% main polygon, points listed in clock-wise in .txt file
fid=fopen('poly.txt','r');
Polygon = fscanf(fid,'%f%f',[2 inf]);
fclose(fid);
plot(Polygon(1,:),Polygon(2,:),'r-','LineWidth',2);

% clipping window, points listed in clock-wise in .txt file
fid=fopen('clipwin.txt','r');
Clipwin = fscanf(fid,'%f%f',[2 inf]);
fclose(fid);
plot(Clipwin(1,:),Clipwin(2,:),'b-','LineWidth',2);

nPolyVertex = size(Polygon,2);  %被裁剪多边形的顶点个数+1
nClipVertex = size(Clipwin,2);  %裁剪多边形的顶点个数+1

% If the polygon has been input correctly
% ...write if have time.....

%% Preprocessing

% times of coding
numencode = 2;

encode = [];

%进行一次编码
[ encode1 ] = Encodefunction( Polygon,Clipwin,nPolyVertex,nClipVertex );
encode=[encode,encode1];

%进行二次编码
[ newPolygon,newClipwin ] = Transfer( Polygon,Clipwin,nPolyVertex,nClipVertex,3 );
[ encode2 ] = Encodefunction( newPolygon,newClipwin,nPolyVertex,nClipVertex );
encode = [encode,encode2];

% random形式的编码
% for k = 1 : numencode
%     r = unidrnd(5);%生成1-5的随机数
%     [ newPolygon,newClipwin ] = Transfer( Polygon,Clipwin,nPolyVertex,nClipVertex,r );
%     [ encodek ] = Encodefunction( newPolygon,newClipwin,nPolyVertex,nClipVertex );
%     encode = [encode,encodek];
% end

%% Find intersaction
interindex = 1;
inter = [];
for  i = 1 : (nPolyVertex-1)
    secnum = 0;
    intertemp = [];
    flag = Judgeabondon( encode,numencode,i );
    if flag==1 %经过编码后该边无法舍弃
        for j = 1 : (nClipVertex-1)
            % 这里添加，以在特定情况下免除下一条语句 (码这个已经码的快哭了。。接口有点不好弄。。就将就着吧。。)
            % 可喜可贺的是求交点的算法我用的是最笨速度最慢的，对比起来会明显。
            % ....
            % calculate intersaction, save intersection points in inter[]
            [X, Y, flag] = intersectpoint(Polygon(:,i), Polygon(:,i+1), Clipwin(:,j), Clipwin(:,j+1));
            % if have intersaction
            if  flag == 1 && secnum ~= 2
                secnum = secnum + 1;
                intertemp(1,secnum) = X;
                intertemp(2,secnum) = Y;
                % determine in-point and out-point
                [intertemp(3,secnum)]= judge( intertemp(:,secnum),Polygon(:,i), Polygon(:,i+1),Clipwin,i);
            end
            % intersection point no more than 2
            if secnum == 2;
                break;
            end
        end
    end
    % modify the placement of intersection to be clock-wise
    if size(intertemp,2)==1;
        inter(:,interindex) = intertemp(:,1);
        interindex = interindex +1;
    end
    if size(intertemp,2)==2;
        d1 = (Polygon(1,i)-intertemp(1,1))^2+(Polygon(2,i)-intertemp(2,1))^2;
        d2 = (Polygon(1,i)-intertemp(1,2))^2+(Polygon(2,i)-intertemp(2,2))^2;
        if d1 > d2
            inter(:,interindex) = intertemp(:,2);
            interindex = interindex +1;
            inter(:,interindex) = intertemp(:,1);
            interindex = interindex +1;
        else
            inter(:,interindex) = intertemp(:,1);
            interindex = interindex +1;
            inter(:,interindex) = intertemp(:,2);
            interindex = interindex +1;
        end
    end
end
%% Build Tables

% if no interaction points, draw result and return
if size(inter,2) == 0
    if_no_interaction(Polygon,Clipwin);
    return
end

% Step 3: save to tables && construct bi-link table
% polygon's table
[Polygontab] = construct_table(inter,Polygon);
% Clipping window's table
[Clipwintab] = construct_table(inter,Clipwin);

% Adjust table
PolyIN=find( Polygontab(3,:)==1 );
WinIN=find( Clipwintab(3,:)==1 );
nPoly=size(Polygontab,2)-1;
nWin=size(Clipwintab,2)-1;
NewPolytab=zeros(size(Polygontab));
NewWintab=zeros(size(Clipwintab));

NewPolytab(:,1:(nPoly-PolyIN(1)+1) )=Polygontab(:,PolyIN(1):nPoly);
NewPolytab(:,(nPoly-PolyIN(1)+2):nPoly )=Polygontab(:,1:PolyIN(1)-1);
NewPolytab(:,nPoly+1 )=Polygontab(:,PolyIN(1));

NewWintab(:,1:(nWin-WinIN(1)+1) )=Clipwintab(:,WinIN(1):nWin);
NewWintab(:,(nWin-WinIN(1)+2):nWin )=Clipwintab(:,1:WinIN(1)-1);
NewWintab(:,nWin+1 )=Clipwintab(:,WinIN(1));

% bi-link table
% first row: the place of intersection in Polygontab
% second row: the place of intersection in Clipwintab
% third row: track record 1-tracked, 0-untracked （是方便窗口为环形时用的，暂时这行是没有意义的，可以不理）
[bilinktab] = construct_link(NewPolytab,NewWintab);

% Step 4: get the final clipped polygon in FinalTab
[FinalTab] = construct_fintab(NewPolytab,NewWintab,bilinktab);

% Show the clipped window
plot(FinalTab(1,:),FinalTab(2,:),'k-','LineWidth',2);



