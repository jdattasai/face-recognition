
trainfea=zeros(20,1554);
 load train
 h = waitbar(0,'Reading Training Images,Please wait...');
for ii=1:20
    waitbar(ii/20);
    im=imread(['Granularity Data\',num2str(ii),'.jpg']);
    [m n]=size(im);
    res=im;
H = fspecial('gaussian',10,45);
G1 = imfilter(im,H,'replicate');

H2 = fspecial('gaussian',10,25);

G2 = imfilter(G1,H2,'replicate');

H3 = fspecial('gaussian',10,25);
G3 = imfilter(G2,H3,'replicate');

G4 = imfilter(G3,H3,'replicate');

H4 = fspecial('gaussian',10,25);
G5 = imfilter(G4,H3,'replicate');
G6 = imfilter(G5,H3,'replicate');

[m n c]=size(res);
if c==3
res=rgb2gray(res);
end

lbp1=LBP(G1,1);
lbp2=LBP(G2,1);
lbp3=LBP(G3,1);
lbp4=LBP(G4,1);
lbp5=LBP(G5,1);
lbp6=LBP(G6,1);



feature=[lbp1' lbp2' lbp3' lbp4' lbp5' lbp6'];
trainfea(ii,1:1554)=feature;
pause(1);
end
close(h)
save trainfea trainfea