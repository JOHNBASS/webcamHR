% clc;
% clear ;
% close all;

function outdata=test1(iimage)


%(��A�P�I�����ݻP����۲��A�v���ѪR�ץH 240x320 ���y�A�p�G�y���H�U�S�X�Ӧh�]�|�v�T�P�_%% Ū�������v��
%RGB=imread('images.jpg');
RGB=iimage;
RGB=double(RGB);
Gray_img=rgb2gray(RGB);
subplot(2,4,1),imshow(uint8(RGB)),title('��l��');
%% ���ⰻ�� �H Soriano et al. (2000)���`�A�� RGB �Ŷ��@���ⰻ���C
%S �N���G�ȼv���A1 ������ϰ�CW ���@�Φb���h����Ƕb���C��(�S�O�O�¦�P�զ�)�C
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
%subplot(2,4,2),imshow(skin_segment),title('���ⰻ��');
%% ���X closing (�]�N�O������ dilation �A�I�k erosion)
%�ت��O�s���p�϶��A�קK�y���}�H�C
se = strel('square',3); %�ϥ�3x3���c����
afterClosing = imclose(S, se);
%subplot(2,4,3),imshow(afterClosing),title('���Xclosing');

%% �s�q�������(�аO) labeling 
afterLabeling = bwlabel(afterClosing,4); %4�N��4�F��?�q�A��i��8(8�F��?�q)
rgbLabels = label2rgb(afterLabeling, @jet, 'k'); %�H��m�аO?�P�϶��A�I�����¦⡦k��
%subplot(2,4,4),imshow(rgbLabels),title('�p�q����labeling');
%% �N�U�϶����O�s���C
stats=regionprops(afterLabeling,'basic'); %��X�ۦP���òέp
allArea=[stats.Area];tt=max(allArea); % ��X�̤j���϶�pixel,���Ҭ�34
idx=find(allArea==tt);
biggest_block=ismember(afterLabeling,idx);% afterLabeling�������Ǥ����bidx��
% subplot(2,4,5),imshow(biggest_block),title('�H�y�϶�');%�L�o�᪺�H�y�Ϲ�
%% �إX�x�ο���ϰ�(region of interest, ROI) 
%�ھڤW�ӨB�J�ҿ���϶���x�Py��V�̤p�y�Э�(x min , y min )�A�w�q�x�ο���ϰ�C
%���קK�����l���ת��v�T
%�C�x�Ϊ����W�p�y�Ь�(x min , y min )
%��(x min +height, y min +width) 
boudingbox = stats(idx).BoundingBox; %��ܤ��X�̤j�����Ϥ���Xxy�b

%subplot(2,4,6),imshow(uint8(RGB)),title('region of interest,ROI');


if boudingbox(3)>1.3*boudingbox(4)
    boudingbox(3)=1.3*boudingbox(4);
end
rectangle('Position',[boudingbox(1) ,boudingbox(2) ,boudingbox(3) ,boudingbox(4) ],'Curvature',[0.1,0.1],...
         'LineWidth',2,'LineStyle','--','EdgeColor','w')
%% ��������
image1=uint8(RGB);
%I = imread('circuit.tif');
I2 = imcrop(image1,[boudingbox(1) ,boudingbox(2) ,boudingbox(3) ,boudingbox(4) ]);
%subplot(2,4,8),imshow(I2),title('����ROI');
outdata=[boudingbox(1) ,boudingbox(2) ,boudingbox(3) ,boudingbox(4)];%���Ϋ᪺�Ͽ�X

%% Sobel �o��@ ROI �����v����t����
 image_crop = imcrop(RGB,[boudingbox(1) ,boudingbox(2) ,boudingbox(3) ,boudingbox(4) ]);
 Gray_crop=rgb2gray(uint8(image_crop));
 h_H = fspecial('sobel');
BW_H= imfilter(Gray_crop,h_H,'replicate');
h_V= (h_H )';
BW_V= imfilter(Gray_crop,h_V,'replicate');
  edgeROI=abs(BW_V)+abs(BW_H);
%subplot(2,4,7),imshow(edgeROI);
%title('�H�y�v����t����');
