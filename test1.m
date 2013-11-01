% clc;
% clear ;
% close all;

function outdata=test1(iimage)


%(衣服與背景必需與膚色相異，影像解析度以 240x320 為宜，如果臉部以下露出太多也會影響判斷%% 讀取受測影像
%RGB=imread('images.jpg');
RGB=iimage;
RGB=double(RGB);
Gray_img=rgb2gray(RGB);
subplot(2,4,1),imshow(uint8(RGB)),title('原始圖');
%% 膚色偵測 以 Soriano et al. (2000)的常態化 RGB 空間作膚色偵測。
%S 代表二值影像，1 為膚色區域。W 的作用在除去接近灰軸的顏色(特別是黑色與白色)。
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);
r=R./((R+G+B));
g=G./((R+G+B));
Qupper=-1.376.*r.^2+1.0743*r+0.1452;
Qlower=-0.776.*r.^2+0.5601*r+0.1776;
W=(r-0.33).^2+(g-0.33).^2;
S=(Gray_img.*(g>Qlower))&(Gray_img.*(W>0.004)&(Gray_img.*(r>0.2))&(Gray_img.*(r<0.6)));
skin_segment=Gray_img.*S;
%subplot(2,4,2),imshow(skin_segment),title('膚色偵測');
%% 閉合 closing (也就是先膨脹 dilation 再侵蝕 erosion)
%目的是連結小區塊，避免臉部破碎。
se = strel('square',3); %使用3x3結構元素
afterClosing = imclose(S, se);
%subplot(2,4,3),imshow(afterClosing),title('閉合closing');

%% 連通成份抽取(標記) labeling 
afterLabeling = bwlabel(afterClosing,4); %4代表4鄰接?通，亦可用8(8鄰接?通)
rgbLabels = label2rgb(afterLabeling, @jet, 'k'); %以色彩標記?同區塊，背景為黑色’k’
%subplot(2,4,4),imshow(rgbLabels),title('聯通成份labeling');
%% 將各區塊分別編號。
stats=regionprops(afterLabeling,'basic'); %找出相同的並統計
allArea=[stats.Area];tt=max(allArea); % 找出最大的區塊pixel,此例為34
idx=find(allArea==tt);
biggest_block=ismember(afterLabeling,idx);% afterLabeling中有哪些元素在idx中
% subplot(2,4,5),imshow(biggest_block),title('人臉區塊');%過濾後的人臉圖像
%% 框出矩形興趣區域(region of interest, ROI) 
%根據上個步驟所選取區塊的x與y方向最小座標值(x min , y min )，定義矩形興趣區域。
%為避免受到脖子長度的影響
%。矩形的左上小座標為(x min , y min )
%為(x min +height, y min +width) 
boudingbox = stats(idx).BoundingBox; %選擇切出最大塊的圖片抓出xy軸

%subplot(2,4,6),imshow(uint8(RGB)),title('region of interest,ROI');


if boudingbox(3)>1.3*boudingbox(4)
    boudingbox(3)=1.3*boudingbox(4);
end
rectangle('Position',[boudingbox(1) ,boudingbox(2) ,boudingbox(3) ,boudingbox(4) ],'Curvature',[0.1,0.1],...
         'LineWidth',2,'LineStyle','--','EdgeColor','w')
%% 切除測試
image1=uint8(RGB);
%I = imread('circuit.tif');
I2 = imcrop(image1,[boudingbox(1) ,boudingbox(2) ,boudingbox(3) ,boudingbox(4) ]);
%subplot(2,4,8),imshow(I2),title('切圖ROI');
outdata=[boudingbox(1) ,boudingbox(2) ,boudingbox(3) ,boudingbox(4)];%切割後的圖輸出

%% Sobel 濾鏡作 ROI 內的影像邊緣偵測
 image_crop = imcrop(RGB,[boudingbox(1) ,boudingbox(2) ,boudingbox(3) ,boudingbox(4) ]);
 Gray_crop=rgb2gray(uint8(image_crop));
 h_H = fspecial('sobel');
BW_H= imfilter(Gray_crop,h_H,'replicate');
h_V= (h_H )';
BW_V= imfilter(Gray_crop,h_V,'replicate');
  edgeROI=abs(BW_V)+abs(BW_H);
%subplot(2,4,7),imshow(edgeROI);
%title('人臉影像邊緣偵測');

