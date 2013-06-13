%% by Chuhang Zou
% 2013.6.11

function if_no_interaction(Polygon,Clipwin)
% output the result when no interactions
% naive version 
%
% Input:        Clipwintab: table of the vertex of the clipping window
%               Polgontab: table of the vertex of the polygon
% Output:       none
%
   % calculate the total outside points number of the polygon
    nPolyVertex = size(Polygon,2);
    outofwinsum = 0;
    for i = 1:(nPolyVertex-1)
          [sign]= inwindow(Polygon(:,i),Clipwin);
          if sign == -1
              outofwinsum = outofwinsum + 1;
          end
    end
  % 1.if the polygon is totally outside the window clipped polygon is the
  % window itself
  if outofwinsum == (nPolyVertex-1)
      plot(Clipwin(1,:),Clipwin(2,:),'k-','LineWidth',2);
      return;
  end
  % 2.if the polygon is totally inside the window
  if outofwinsum == 0
      plot(Polygon(1,:),Polygon(2,:),'k-','LineWidth',2);
      return;
  end
  
end