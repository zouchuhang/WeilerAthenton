%% by Chuhang Zou
% 2013.6.11

function [bilinktab]= construct_link(Polygontab,Clipwintab)
% construct the linked table  
% naive version 
%
% Input:        Clipwintab: table of the vertex of the clipping window
%               Polgontab: table of the vertex of the polygon
% Output:       bilinktab: linked table for the intersection in the two tab
%

nPolyVertex = size (Polygontab,2);
nClipVertex = size (Clipwintab,2);

bitabindex = 1;
for i = 1:nPolyVertex-1
    if Polygontab(3,i) ~= 0
        bilinktab(1,bitabindex) = i;
        bitabindex = bitabindex+1;
    end
end

bitabindex = 1;
for i = 1:nClipVertex-1
    if Clipwintab(3,i) ~= 0
        bilinktab(2,bitabindex) = i;
        bitabindex = bitabindex+1;
    end
end

bilinktab = [bilinktab;zeros(1,size(bilinktab,2))];


