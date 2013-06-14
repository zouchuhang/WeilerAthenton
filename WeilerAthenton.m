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
clc,clear
% Screen definition
width=10;
height=10;

hold on
axis on
axis equal
axis([-3*width 3*width -3*height 3*height])

% main polygon, points listed in clock-wise in .txt file
fid=fopen('poly3.txt','r');
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
[ encode1 ] = encodefunction( Polygon,Clipwin,nPolyVertex,nClipVertex );
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
    
    intertemp = zeros(3,1);
    %abandonflag = judgeabandon( encode,numencode,i );
    abandonflag=1;
    if abandonflag==1 % can't be abandoned
        for j = 1 : (nClipVertex-1)
            % calculate intersaction point
            [X, Y, flag] = intersectpoint(Polygon(:,i), Polygon(:,i+1), Clipwin(:,j), Clipwin(:,j+1));   

            % if have intersaction
            if  flag == 1 
                intertemp(1) = X;
                intertemp(2) = Y;
                
                'debug-----------------'
                [Polygon(:,i), Polygon(:,i+1), Clipwin(:,j), Clipwin(:,j+1)]
                [i,j,X,Y,flag]
                
                % determine in-point and out-point
                intertemp(3)= judgeinout ( intertemp(:,1), Polygon, Clipwin,i,j)
                                
                '-------------------end'
                
                if intertemp(3)==0
                    continue
                end
                inter(:,interindex) = intertemp(:,1);
                interindex = interindex +1;
            end
        end
    end
end

inter
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
Polygontab
Clipwintab

PolyIN=find( Polygontab(3,:)==1 );
WinIN=find( Clipwintab(3,:)==1 );

ID1=find( (Clipwintab(1,WinIN)==Polygontab(1,PolyIN(1)))  );
ID2=find( (Clipwintab(2,WinIN)==Polygontab(2,PolyIN(1)))  );
ID=intersect(ID1,ID2)

nPoly=size(Polygontab,2)-1;
nWin=size(Clipwintab,2)-1;
NewPolytab=zeros(size(Polygontab));
NewWintab=zeros(size(Clipwintab));

NewPolytab(:,1:(nPoly-PolyIN(1)+1) )=Polygontab(:,PolyIN(1):nPoly);
NewPolytab(:,(nPoly-PolyIN(1)+2):nPoly )=Polygontab(:,1:PolyIN(1)-1);
NewPolytab(:,nPoly+1 )=Polygontab(:,PolyIN(1));

NewWintab(:,1:(nWin-WinIN(ID)+1) )=Clipwintab(:,WinIN(ID):nWin);
NewWintab(:,(nWin-WinIN(ID)+2):nWin )=Clipwintab(:,1:WinIN(ID)-1);
NewWintab(:,nWin+1 )=Clipwintab(:,WinIN(ID));

NewPolytab
NewWintab

% bi-link table
% first row: the place of intersection in Polygontab
% second row: the place of intersection in Clipwintab
% third row: track record 1-tracked, 0-untracked （是方便窗口为环形时用的，暂时这行是没有意义的，可以不理）
[bilinktab] = construct_link(NewPolytab,NewWintab);

% Step 4: get the final clipped polygon in FinalTab
[FinalTab] = construct_fintab(NewPolytab,NewWintab,bilinktab);

% Show the clipped window
plot(FinalTab(1,:),FinalTab(2,:),'k-','LineWidth',5);



