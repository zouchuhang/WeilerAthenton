% by Chuhang Zou
% modifyied by GUANG
% 2013.6.11

function [Polygontab]= construct_table(inter,Polygon)
% construct the linked table  
% naive version 
%
% Input:        inter: table of intersactions, 
%                      1st line: x-coordinate,2nd line: y-coordinate,3rd
%                      line: in-point or out-point
%               Polgon: table of the vertex of the polygon
% Output:       Polgontab: linked table
%

    nPolyVertex = size(Polygon,2);
    nInterVertex = size(inter,2);
    
    Polygontab=zeros(3,nPolyVertex+nInterVertex);
    
    polygonindex = 1;
    index = 1;
    
    Polygontab(1,index) =  Polygon(1,polygonindex);
    Polygontab(2,index) =  Polygon(2,polygonindex);
    Polygontab(3,index) =  0;
        
    while polygonindex<nPolyVertex
 %   for  i = 1 : (nPolyVertex-1)
        Polygontabtemp = [];
        intercount = 0;

        for j = 1 : nInterVertex
            if  isinline( inter(1,j),inter(2,j),Polygon(:,polygonindex),Polygon(:,polygonindex+1) )
                if online(inter(1,j),inter(2,j),Polygon(:,polygonindex),Polygon(:,polygonindex+1))  
                    intercount = intercount +1;
                    Polygontabtemp(1,intercount) =  inter(1,j);
                    Polygontabtemp(2,intercount) =  inter(2,j);
                    Polygontabtemp(3,intercount) =  inter(3,j);
                    
                end
            end
        end
        
         % modify the placement of intersection to be clock-wise
        if size(Polygontabtemp,2)==1;
            index = index +1;
            Polygontab(:,index) = Polygontabtemp(:,1); 
        end
        if size(Polygontabtemp,2)==2;
            d1 = (Polygon(1,polygonindex)-Polygontabtemp(1,1))^2+(Polygon(2,polygonindex)-Polygontabtemp(2,1))^2;
            d2 = (Polygon(1,polygonindex)-Polygontabtemp(1,2))^2+(Polygon(2,polygonindex)-Polygontabtemp(2,2))^2;
            if d1 > d2
                index = index +1;
                Polygontab(:,index) = Polygontabtemp(:,2);
                index = index +1;
                Polygontab(:,index) = Polygontabtemp(:,1);
            else
                index = index +1;
                Polygontab(:,index) = Polygontabtemp(:,1);
                index = index +1;
                Polygontab(:,index) = Polygontabtemp(:,2);
            end
        end
        
        index = index +1;
        polygonindex = polygonindex +1;
        Polygontab(1,index) =  Polygon(1,polygonindex);
        Polygontab(2,index) =  Polygon(2,polygonindex);
        Polygontab(3,index) =  0;
    end
 
%     % Delete Duplicate
%     nPolyVertex = size (Polygontab,2);
%     Polygontab2 = Polygontab(:,1);
%     index = 1;
%     for i = 1:(nPolyVertex-1)
%         if Polygontab(1,i) ~= Polygontab(1,i+1) || Polygontab(2,i) ~= Polygontab(2,i+1) || Polygontab(3,i) ~= Polygontab(3,i+1)
%             index = index +1;
%         end
%            Polygontab2(:,index) = Polygontab(:,i+1);
%     end
            
end