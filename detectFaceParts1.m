
% bbox: bbox(:, 1: 4) is bounding box for face
%       bbox(:, 5: 8) is bounding box for left eye
%       bbox(:, 9:12) is bounding box for right eye
%       bbox(:,13:16) is bounding box for mouth
%       bbox(:,17:20) is bounding box for nose
%       please see the documentation of the computer vision toolbox for details of the bounding box.

function [bbox,im_eye,im_no,im_mo,tran_im] = detectFaceParts(detector,X)

if( nargin < 3 )
 thick = 1;
end

%%%%%%%%%%%%%%%%%%%%%%% detect face %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detect faces
bbox = step(detector.detector{5}, X);

bbsize = size(bbox);
partsNum = zeros(size(bbox,1),1);

%%%%%%%%%%%%%%%%%%%%%%% detect parts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];

stdsize = detector.stdsize;

for k=1:4
 if( k == 1 )
  region = [1,int32(stdsize*2/3); 1, int32(stdsize*2/3)];
 elseif( k == 2 )
  region = [int32(stdsize/3),stdsize; 1, int32(stdsize*2/3)];
 elseif( k == 3 )
  region = [1,stdsize; int32(stdsize/3), stdsize];
 elseif( k == 4 )
  region = [int32(stdsize/5),int32(stdsize*4/5); int32(stdsize/3),stdsize];
 else
  region = [1,stdsize;1,stdsize];
 end

 bb = zeros(bbsize);
 for i=1:size(bbox,1)
  XX = X(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
  XX = imresize(XX,[stdsize, stdsize]);
  XX = XX(region(2,1):region(2,2),region(1,1):region(1,2),:);
  
  b = step(detector.detector{k},XX);
  
  if( size(b,1) > 0 )
   partsNum(i) = partsNum(i) + 1;
   
   if( k == 1 )
    b = sortrows(b,1);
   elseif( k == 2 )
    b = flipud(sortrows(b,1));
   elseif( k == 3 )
    b = flipud(sortrows(b,2));
   elseif( k == 4 )
    b = flipud(sortrows(b,3));
   end
   
   ratio = double(bbox(i,3)) / double(stdsize);
   b(1,1) = int32( ( b(1,1)-1 + region(1,1)-1 ) * ratio + 0.5 ) + bbox(i,1);
   b(1,2) = int32( ( b(1,2)-1 + region(2,1)-1 ) * ratio + 0.5 ) + bbox(i,2);
   b(1,3) = int32( b(1,3) * ratio + 0.5 );
   b(1,4) = int32( b(1,4) * ratio + 0.5 );
   
   bb(i,:) = b(1,:);
  end
 end
 bbox = [bbox,bb];
 p = ( sum(bb') == 0 );
 bb(p,:) = [];
end
bbox = [bbox,partsNum];
bbox(partsNum<=2,:)=[];
im=X;
e_s_r=min([bbox(6),bbox(10)]);
e_s_c=min([bbox(5),bbox(9)]);
e_e_c=bbox(9)+bbox(11);
e_e_r=max([bbox(6)+bbox(8),bbox(10)+bbox(12)]);
im_eye=im(e_s_r:e_e_r,e_s_c:e_e_c);%if it is color need to add 1:3 atlast
im_no=im(bbox(18):bbox(18)+bbox(20),bbox(17):bbox(17)+bbox(19));
im_mo=im(bbox(14):bbox(14)+bbox(16),bbox(13):bbox(13)+bbox(15));
[re,ce,pe]=size(im_eye);
[rn,cn,pn]=size(im_no);
[rm,cm,pm]=size(im_mo);
tran_im=zeros(re+rn+rm,max([ce,cn,cm]));

tran_im(1:re,1:ce)=im_eye;
tran_im(re+1:re+rn,1:cn)=im_no;
tran_im(re+rn+1:re+rn+rm,1:cm)=im_mo;
tran_im=uint8(tran_im);



