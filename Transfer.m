function [ newPolygon,newClipwin ] = Transfer( Polygon,Clipwin,nPolyVertex,nClipVertex,r )
%  此程序进行坐标系的旋转
% Input:        Polygon: 需要裁减的多边形
%               Clipwin: the clipping window
%               nPolyVertex:被裁剪多边形顶点个数+1
%               nClipVertex:裁剪多边形顶点个数+1
%               r：所旋转的角度（对应关系见下）
% 
% Output:       newPolygon：旋转坐标后新的被裁剪多边形坐标
%               newClipwin：旋转坐标后新的裁剪多边形坐标

ROT15 = (sqrt(6)+sqrt(2))/4*[1,-2+sqrt(3);2-sqrt(3),1];%15度旋转，转移矩阵(r=1)
ROT30 = sqrt(3)/2*[1,-sqrt(3)/3;1,sqrt(3)/3];%30度旋转，转移矩阵(r=2)
ROT45 = sqrt(2)/2*[1,-1;1,1];%45度旋转，转移矩阵(r=3)
ROT60 = 1/2*[1,-sqrt(3);1,sqrt(3)];%60度旋转，转移矩阵(r=4)
ROT75 = (sqrt(6)-sqrt(2))/4*[1,-2-sqrt(3);2+sqrt(3),1];%75度旋转，转移矩阵(r=5)
Trans = { ROT15,ROT30,ROT45,ROT60,ROT75 };
newPolygon = [];
newClipwin = [];
   for i = 1 : nPolyVertex
       A = Trans{r}*[Polygon(1,i);Polygon(2,i)];
       newPolygon = [newPolygon,A];  %二次编码坐标系下的坐标矩阵
   end
   for i = 1 : nClipVertex
       A = Trans{r}*[Clipwin(1,i);Clipwin(2,i)];
       newClipwin = [newClipwin,A];
   end
end

