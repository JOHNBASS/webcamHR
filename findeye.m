%眼睛定位函数 
function findeye(face)
 
%读入图像 
pic1=imread(face); 
%转化为灰度图 
pic2=rgb2gray(pic1); 
figure 
imhist(pic2) 
figure 
imshow(pic2) 
pic=histeq(pic2); 
figure 
imhist(pic) 
figure 
imshow(pic) 
%进行图像预处理 
%转化为double型进行处理 
pic3=double(pic2); 
%中值滤波，去噪 
pic4=medfilt2(pic3,[3 3]); 
%对数变换 
pic5=35*log(pic3+1); 
pic6=uint8(pic5); 
% figure 
% imhist(pic6) 
% figure 
% imshow(pic6); 
 
%预处理后，用最大类间方差求阀值 
%先求图像均值 
age=mean2(pic6); 
[hist1 hist2]=imhist(pic6); 
%再求灰度为0<p<x和x<p<255两组的均值 
for x=0:255; 
    age0=sum(hist1(1:(x+1)).*hist2(1:(x+1)))/sum(hist1(1:(x+1))); 
    age1=sum(hist1((x+2):256).*hist2((x+2):256))/sum(hist1((x+2):256)); 
    vage(x+1)=(age-age0)^2+(age-age1)^2; 
end 
 
%求出阀值 
[vage1 vage2]=max(vage); 
pic7=im2bw(pic6/255,(vage2-1)/255); 
figure 
imshow(pic7) 
 
     
 
 
% pic=imread('me.jpg'); 
% pic1=medfilt2(pic,[3 3]); 
% pic2=double(pic1); 
% pic3=uint8(46*log(pic2+1)); 
% figure 
% imshow(pic) 
% figure 
% imshow(pic1) 
% figure 
% imshow(pic2) 
% figure 
% imshow(pic3) 
% figure 
% imhist(pic3)


