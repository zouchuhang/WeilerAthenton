%% by Chuhang Zou
% 2013.6.11

function [FinalTab]= construct_fintab(Polygontab,Clipwintab,bilinktab)
% construct the final table of clipped polygon  
% naive version 
% start from the intersect point in the polygontab
%  1. if the point is in-point, continue in the polygontab
%  2. if the point is out-point, goto the Clipwintab
%  stop until back to the original start point.
%
% Input:        Clipwintab: table of the vertex of the clipping window
%               Polgontab: table of the vertex of the polygon
%               bilinktab: linked table for the intersection in the two tab
% Output:       FinalTab: final table of clipped polygon  
%

   nPolytab = size (Polygontab,2);
   nCliptab = size (Clipwintab,2);
   nbitab = size (bilinktab,2); 
   flag = 1;
   track = 1;
   bilinktab(3, track) = 1;
   fintabindex = 1;
   % start from the intersect point in the polygontab
   FinalTab(:,fintabindex) = Polygontab(:,bilinktab(1,track));
   
   while flag
        % check if closed
        if fintabindex ~= 1 && FinalTab(1,fintabindex) == FinalTab(1,1) && FinalTab(2,fintabindex) == FinalTab(2,1) && FinalTab(3,fintabindex) == FinalTab(3,1)
            break;
        end
        % check point type
        if FinalTab(3,fintabindex) == 1
            i = bilinktab(1,track);
            track = track +1;
            bilinktab(3, track) = 1;
            if track < nbitab + 1
                ed = bilinktab(1,track);
                while i < ed
                    i = i+1;
                    fintabindex = fintabindex+1;  
                    FinalTab(:,fintabindex) = Polygontab(:,i);            
                end
            else 
                track = track -1;
                while i < nPolytab
                    i = i+1;
                    fintabindex = fintabindex+1;  
                    FinalTab(:,fintabindex) = Polygontab(:,i);   
                end
                ed = bilinktab(1,1);
                while i- nPolytab < ed
                    i = i+1;
                    fintabindex = fintabindex+1;  
                    FinalTab(:,fintabindex) = Polygontab(:,i-nPolytab);
                    flag = 0;
                end
            end
            
        else
            i = bilinktab(2,track);
            track = track +1;
            bilinktab(3, track) = 1;
            if track < nbitab + 1
                ed = bilinktab(2,track);
                while i < ed
                    i = i+1;
                    fintabindex = fintabindex+1;  
                    FinalTab(:,fintabindex) = Clipwintab(:,i);            
                end
            else 
                track = track -1;
                while i < nCliptab
                     i = i+1;
                    fintabindex = fintabindex+1;  
                    FinalTab(:,fintabindex) = Clipwintab(:,i);   
                end
                ed = bilinktab(2,1);
                while i - nCliptab < ed
                    i = i+1;
                    fintabindex = fintabindex+1;  
                    FinalTab(:,fintabindex) = Clipwintab(:,i- nCliptab);
                    flag = 0; 
                end
            end          
        end
   end
   