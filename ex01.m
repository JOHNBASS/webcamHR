
clear all
clc
close all;



%連接webcam
vid = videoinput('winvideo',1,'RGB24_640x480');%設定為RGB 640 480
dev_info=imaqhwinfo('winvideo',1);
vid_src = getselectedsource(vid);

preview(vid); %開啟視訊 

reply=input('要繼續嗎？y/n [y]','s');

if isempty(reply)   
    
%reply='y';　%若為空矩陣，將其reply設為'y'，以利程式進行
  


else
    
closepreview(vid); %關閉視訊

%set(vid_src,'FrameRate', '30');% 設定fps 30

%例如設定連續擷取影像次數(設定觸發訊號個數)
set(vid,'TriggerRepeat',inf);
%set(vid, 'TriggerRepeat', 9);

% % Configure the acquisition to collect 5 frames
%每5張圖片就取1張  6f/1s
%framesPerTrigger = 30;
%set(vid, 'FramesPerTrigger',30);

%例如設定每間隔幾張擷取一次  
vid.FrameGrabInterval = 1;

%set(vid,'FramesPerTrigger',15)%設定開始擷取影像時擷取10張
%Create a figure window.

%figure;
% tic; 
% Start acquiring frames.
start(vid);

%人臉辨識
% 60s = 6 * 60 = 360f  
%1秒鐘30張
%30秒 900張
%60秒 1800張
%15秒 450

%1分鐘  請多給一秒確保資料完整
frames_count = 300;

%切割大小
facebox = test1(getsnapshot(vid)); %截取單張影像

% I=getsnapshot(vid);
% kk = waitforbuttonpress;
% point1 = get(gca,'CurrentPoint');  %mouse pressed
% rectregion = rbbox;  
% point2 = get(gca,'CurrentPoint');
% point1 = point1(1,1:2);              % extract col/row min and maxs
% point2 = point2(1,1:2);
% lowerleft = min(point1, point2);
% upperright = max(point1, point2);
% cmin = round(lowerleft(1));
% cmax = round(upperright(1));
% rmin = round(lowerleft(2));
% rmax = round(upperright(2));
% data2=I(rmin:rmax,cmin:cmax,:);

 rep=[];%宣告要push的array
 count1=[];
% sw1=0;

% while(sw1==0)  % Stop after 100 frames
while(length(rep)<=frames_count)
    % preview(vid);    %預覽webcam的畫面
        %data =getdata(vid,1);
        %data = getdata(vid,1);%抓取webcam的資料
        %data = getsnapshot(vid);    %截取單張影像
        data = imcrop(getsnapshot(vid),[facebox(1) ,facebox(2) ,facebox(3) ,facebox(4)]);
        


    %取綠色色像
    [m n d]=size(data);
    G(:,:,1)= zeros(m,n);
    G(:,:,2)= data(:,:,2);
    G(:,:,3)=zeros(m,n);
    G=uint8(G);
    
    array_data=G(:,:,2);%取出綠色分量
    
    %i=i+1;
   
    %average=mean(array_data(:));%做平均
    [test1,n] = size(array_data(:));
    test2 = sum(array_data(:));
    average = test2/test1;
    %average=mean(,2);
    rep(end+1)=average;%push array
    count1(end+1)=1;
    
    imshow(data);%顯示出每一張圖片
%  timecheck=toc;
%  tCP = cputime; 
 
%   if timecheck>=frames_count
%     sw1=1;    
%   end
 
 end
 stop(vid);
 t=1:(length(rep));%時間軸 

   

 
 %t=1:1/6:(length(rep));

 %t=1:6:length(rep); %時間軸 6個畫一點
 
 %plot(t,rep,'r');% ㄒ顯示波形
 %plot(t,rep,'r:diamond');
 
% fir_test(rep); %fir
 fprintf('量測結束謝謝您 %i\n',length(rep)); 
 %發出警報
% load train
% sound(y,Fs)
 
 end


