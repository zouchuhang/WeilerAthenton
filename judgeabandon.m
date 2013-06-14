function [ flag ] = judgeabandon( encode,numencode,i )
%  此程序判断被裁剪的多边形的某条边是否
% Input:        encode: 编码
%               numencode: 编码次数
%               i:表征被裁剪多边形的某条边
% Output:       flag：1 表示该边需要求交
%                     0 表示该边需要舍弃
   flag = 1; %flag=1表示该边需要求交
   for k = 1 : numencode
       if (encode(i,4*k-3:4*k)&encode(i+1,4*k-3:4*k))==zeros(1,4);
       else
           flag = 0;%表示舍弃
           break;
       end
   end

end

