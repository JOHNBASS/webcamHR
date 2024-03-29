


%function fir_test(intput) %副程式
%clear all;
%close all;
intput= rep; %單機連線
fsintput=30;
%t=1:(length(intput));%時間軸 
%t=1:(length(intput)):30;%時間軸
t=[0:length(intput)-1]/fsintput;
ttest=1:(length(intput));%時間軸 
%t=logspace(1,(length(intput)),30); %在1到x最大值 等份取30個點

%製作測試用的訊號
% fs=1000; 
% ttt=0:1/fs:5; 
% x=cos(2*pi*1*ttt)+cos(2*pi*400*ttt);   
% plot(ttt,x); 
%figure(2)

%微分
%  df = diff(intput);%做微分
%  %dft =1:(length(df));%時間軸 
%  dft=[0:length(df)-1]/fsintput;

%帶通
n_hm=13;%階數
fs=90;%取樣平率 30*3 = 90
fc1=0.25;%高通 0.2 
fc2=0.3; %低通 15

w1=2*fc1/fs; %高通
w2=2*fc2/fs; %低通 

bpass = fir1(n_hm,[w1 w2],'bandpass');%帶通
y1 = fftfilt(bpass,intput);


%低通
n_hm=3;%階數
fs=90;%取樣平率 30*3 = 90

fc2=0.4; %低通 15

w2=2*fc2/fs; %低通

%bpass = fir1(n_hm,[w1 w2],'bandpass');%帶通
%load chirp       % Load y and fs.
b = fir1(n_hm,w2,'low');
y2_low = fftfilt(b,intput);


%高通
n_hm=3;%階數
fs=90;%取樣平率 30*3 = 90

fc2=0.15; %高通 15

w2=2*fc2/fs; %高通

%bpass = fir1(n_hm,[w1 w2],'bandpass');%帶通
%load chirp       % Load y and fs.
b = fir1(n_hm,w2,'high');
y2_high = fftfilt(b,y2_low);



%  y2t =1:(length(y1));%時間軸
%  %low pass
%  n_hm2=13;%階數
%  fs=90;%取樣平率 30*3 = 90
%  fc12=1;%高通 0.2 
%  fc22=5; %低通 15
%  
%  w12=2*fc12/fs; %高通
%  w22=2*fc22/fs; %低通
%  
%  bpass2 = fir1(n_hm2,w12);%帶通
%  y2 = fftfilt(bpass2,y1);

DDSS=diff(sign(diff(y1)));
%波鋒波谷
subplot(4,1,4);
IndMin=find(diff(sign(diff(y1)))>0)+1;
IndMax=find(diff(sign(diff(y1)))<0)+1;
plot(1:length(y1),y1);
hold on;grid on;
plot(IndMin,y1(IndMin),'r^');
plot(IndMax,y1(IndMax),'k*');
legend('曲線','波谷點','波峰點');
fprintf('波鋒點: %i 波谷點：%i\n',length(IndMax),length(IndMin));

% %閥值去雜訊
% for i=1:3000
% if (a(i)<0.5)
% a(i)=0;
% end
% end


% %抓出心跳




%averagelocs=mean(locscount(:));


mpd=1;%?定?峰值?的最小?隔?
[xyt,locs]=findpeaks(y1,'minpeakdistance',mpd);

locscount=[];

for i=1:length(locs)
    if(i+1<length(locs))
    locscount(end+1)=locs(i+1)-locs(i);
    end
end

 fprintf('HR心跳: %i\n',length(xyt)*6);


%判斷發出警訊
%age=;
hrup=100;
hrdo=60;

%fprintf('預估 HR心跳: %i\n',(length(IndMax)-delete_count)*2);

if((length(xyt))>hrdo && (length(xyt))<hrup)
fprintf('正常心跳~!!!!!\n'); 
else
fprintf('警報~!!!! 請確認病人安危~!!!\n'); 

%發出警報
% load train
% sound(y,Fs)

end

%尋求波鋒
%maxtest=findpeaks(y1);
%fprintf('波鋒點: %f \n',maxtest);

%ica
%%mydata = int16(intput*100);
%[Out1,Out2,Out3]= fastica(intput, 'approach', 'symm', 'g', 'tanh');
 %ICA
 




% fc1_lowpass=40; %低通
% w1_lowpass=2*fc1/fs; %低通
% lowpass = fir1(1,w1_lowpass,'lowpass');%低通
% 
% y1 = fftfilt(lowpass,y1_bp);



%plot(f,abs(fft(x)))

%平滑化
sm=smooth(y1,20);%做平滑化


 subplot(4,1,1), plot(t,intput,'r'),title('原始圖');
 subplot(4,1,2),plot(t,y1,'r'),title('微分');
 subplot(4,1,3),plot(t,sm,'r'),title('firter');
  


 

%做頻譜分析
fs=30;
N=length(ttest)-1;

Y=fft(intput);
magY=abs(Y(1:1:N/2))*2/N;
f=(0:N/2-1)*fs/N;
figure(3)
plot(f,magY);
xlabel('f(HZ)');
ylabel('振福');
 
% figure(2);
% tt=1:length(Check);

% subplot(4,1,1),plot(tt,Check,'r'),title('原始圖');

 %subplot(4,1,2),plot(t,Out1,'r'),title('ICA');

 %subplot(4,1,2),plot(t,y1,'r'),title('firear');
  
 %subplot(4,1,3),plot(dft,df,'r'),title('調整基準');

 %subplot(5,1,3),plot(dft,abs(fftshift(df)),'r'),title('看頻普');
 
 
 
 %subplot(4,1,4),plot(dft,sm,'r'),title('平滑化');
  
 