


%function fir_test(intput) %�Ƶ{��
%clear all;
%close all;
intput= rep; %����s�u
fsintput=30;
%t=1:(length(intput));%�ɶ��b 
%t=1:(length(intput)):30;%�ɶ��b
t=[0:length(intput)-1]/fsintput;
ttest=1:(length(intput));%�ɶ��b 
%t=logspace(1,(length(intput)),30); %�b1��x�̤j�� ������30���I

%�s�@���եΪ��T��
% fs=1000; 
% ttt=0:1/fs:5; 
% x=cos(2*pi*1*ttt)+cos(2*pi*400*ttt);   
% plot(ttt,x); 
%figure(2)

%�L��
%  df = diff(intput);%���L��
%  %dft =1:(length(df));%�ɶ��b 
%  dft=[0:length(df)-1]/fsintput;

%�a�q
n_hm=13;%����
fs=90;%���˥��v 30*3 = 90
fc1=0.25;%���q 0.2 
fc2=0.3; %�C�q 15

w1=2*fc1/fs; %���q
w2=2*fc2/fs; %�C�q 

bpass = fir1(n_hm,[w1 w2],'bandpass');%�a�q
y1 = fftfilt(bpass,intput);


%�C�q
n_hm=3;%����
fs=90;%���˥��v 30*3 = 90

fc2=0.4; %�C�q 15

w2=2*fc2/fs; %�C�q

%bpass = fir1(n_hm,[w1 w2],'bandpass');%�a�q
%load chirp       % Load y and fs.
b = fir1(n_hm,w2,'low');
y2_low = fftfilt(b,intput);


%���q
n_hm=3;%����
fs=90;%���˥��v 30*3 = 90

fc2=0.15; %���q 15

w2=2*fc2/fs; %���q

%bpass = fir1(n_hm,[w1 w2],'bandpass');%�a�q
%load chirp       % Load y and fs.
b = fir1(n_hm,w2,'high');
y2_high = fftfilt(b,y2_low);



%  y2t =1:(length(y1));%�ɶ��b
%  %low pass
%  n_hm2=13;%����
%  fs=90;%���˥��v 30*3 = 90
%  fc12=1;%���q 0.2 
%  fc22=5; %�C�q 15
%  
%  w12=2*fc12/fs; %���q
%  w22=2*fc22/fs; %�C�q
%  
%  bpass2 = fir1(n_hm2,w12);%�a�q
%  y2 = fftfilt(bpass2,y1);

DDSS=diff(sign(diff(y1)));
%�i�W�i��
subplot(4,1,4);
IndMin=find(diff(sign(diff(y1)))>0)+1;
IndMax=find(diff(sign(diff(y1)))<0)+1;
plot(1:length(y1),y1);
hold on;grid on;
plot(IndMin,y1(IndMin),'r^');
plot(IndMax,y1(IndMax),'k*');
legend('���u','�i���I','�i�p�I');
fprintf('�i�W�I: %i �i���I�G%i\n',length(IndMax),length(IndMin));

% %�֭ȥh���T
% for i=1:3000
% if (a(i)<0.5)
% a(i)=0;
% end
% end


% %��X�߸�




%averagelocs=mean(locscount(:));


mpd=1;%?�w?�p��?���̤p?�j?
[xyt,locs]=findpeaks(y1,'minpeakdistance',mpd);

locscount=[];

for i=1:length(locs)
    if(i+1<length(locs))
    locscount(end+1)=locs(i+1)-locs(i);
    end
end

 fprintf('HR�߸�: %i\n',length(xyt)*6);


%�P�_�o�Xĵ�T
%age=;
hrup=100;
hrdo=60;

%fprintf('�w�� HR�߸�: %i\n',(length(IndMax)-delete_count)*2);

if((length(xyt))>hrdo && (length(xyt))<hrup)
fprintf('���`�߸�~!!!!!\n'); 
else
fprintf('ĵ��~!!!! �нT�{�f�H�w�M~!!!\n'); 

%�o�Xĵ��
% load train
% sound(y,Fs)

end

%�M�D�i�W
%maxtest=findpeaks(y1);
%fprintf('�i�W�I: %f \n',maxtest);

%ica
%%mydata = int16(intput*100);
%[Out1,Out2,Out3]= fastica(intput, 'approach', 'symm', 'g', 'tanh');
 %ICA
 




% fc1_lowpass=40; %�C�q
% w1_lowpass=2*fc1/fs; %�C�q
% lowpass = fir1(1,w1_lowpass,'lowpass');%�C�q
% 
% y1 = fftfilt(lowpass,y1_bp);



%plot(f,abs(fft(x)))

%���Ƥ�
sm=smooth(y1,20);%�����Ƥ�


 subplot(4,1,1), plot(t,intput,'r'),title('��l��');
 subplot(4,1,2),plot(t,y1,'r'),title('�L��');
 subplot(4,1,3),plot(t,sm,'r'),title('firter');
  


 

%���W�Ф��R
fs=30;
N=length(ttest)-1;

Y=fft(intput);
magY=abs(Y(1:1:N/2))*2/N;
f=(0:N/2-1)*fs/N;
figure(3)
plot(f,magY);
xlabel('f(HZ)');
ylabel('����');
 
% figure(2);
% tt=1:length(Check);

% subplot(4,1,1),plot(tt,Check,'r'),title('��l��');

 %subplot(4,1,2),plot(t,Out1,'r'),title('ICA');

 %subplot(4,1,2),plot(t,y1,'r'),title('firear');
  
 %subplot(4,1,3),plot(dft,df,'r'),title('�վ���');

 %subplot(5,1,3),plot(dft,abs(fftshift(df)),'r'),title('���W��');
 
 
 
 %subplot(4,1,4),plot(dft,sm,'r'),title('���Ƥ�');
  
 