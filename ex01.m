
clear all
clc
close all;



%�s��webcam
vid = videoinput('winvideo',1,'RGB24_640x480');%�]�w��RGB 640 480
dev_info=imaqhwinfo('winvideo',1);
vid_src = getselectedsource(vid);

preview(vid); %�}�ҵ��T 

reply=input('�n�~��ܡHy/n [y]','s');

if isempty(reply)   
    
%reply='y';�@%�Y���ůx�}�A�N��reply�]��'y'�A�H�Q�{���i��
  


else
    
closepreview(vid); %�������T

%set(vid_src,'FrameRate', '30');% �]�wfps 30

%�Ҧp�]�w�s���^���v������(�]�wĲ�o�T���Ӽ�)
set(vid,'TriggerRepeat',inf);
%set(vid, 'TriggerRepeat', 9);

% % Configure the acquisition to collect 5 frames
%�C5�i�Ϥ��N��1�i  6f/1s
%framesPerTrigger = 30;
%set(vid, 'FramesPerTrigger',30);

%�Ҧp�]�w�C���j�X�i�^���@��  
vid.FrameGrabInterval = 1;

%set(vid,'FramesPerTrigger',15)%�]�w�}�l�^���v�����^��10�i
%Create a figure window.

%figure;
% tic; 
% Start acquiring frames.
start(vid);

%�H�y����
% 60s = 6 * 60 = 360f  
%1����30�i
%30�� 900�i
%60�� 1800�i
%15�� 450

%1����  �Цh���@��T�O��Ƨ���
frames_count = 300;

%���Τj�p
facebox = test1(getsnapshot(vid)); %�I����i�v��

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

 rep=[];%�ŧi�npush��array
 count1=[];
% sw1=0;

% while(sw1==0)  % Stop after 100 frames
while(length(rep)<=frames_count)
    % preview(vid);    %�w��webcam���e��
        %data =getdata(vid,1);
        %data = getdata(vid,1);%���webcam�����
        %data = getsnapshot(vid);    %�I����i�v��
        data = imcrop(getsnapshot(vid),[facebox(1) ,facebox(2) ,facebox(3) ,facebox(4)]);
        


    %�����⹳
    [m n d]=size(data);
    G(:,:,1)= zeros(m,n);
    G(:,:,2)= data(:,:,2);
    G(:,:,3)=zeros(m,n);
    G=uint8(G);
    
    array_data=G(:,:,2);%���X�����q
    
    %i=i+1;
   
    %average=mean(array_data(:));%������
    [test1,n] = size(array_data(:));
    test2 = sum(array_data(:));
    average = test2/test1;
    %average=mean(,2);
    rep(end+1)=average;%push array
    count1(end+1)=1;
    
    imshow(data);%��ܥX�C�@�i�Ϥ�
%  timecheck=toc;
%  tCP = cputime; 
 
%   if timecheck>=frames_count
%     sw1=1;    
%   end
 
 end
 stop(vid);
 t=1:(length(rep));%�ɶ��b 

   

 
 %t=1:1/6:(length(rep));

 %t=1:6:length(rep); %�ɶ��b 6�ӵe�@�I
 
 %plot(t,rep,'r');% ����ܪi��
 %plot(t,rep,'r:diamond');
 
% fir_test(rep); %fir
 fprintf('�q���������±z %i\n',length(rep)); 
 %�o�Xĵ��
% load train
% sound(y,Fs)
 
 end


