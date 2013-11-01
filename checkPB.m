
%input data
input = rep;
t=1:(length(input));%時間軸 
%源使波
subplot(4,1,1);
plot(t,rep);

%以下


out = lfhf_sliding_win(input,300,0.9); %0.9 means take a 5min segment every 30 seconds!
subplot(4,1,2);
t_hr=1:(length(out.hr));%時間軸 
plot(t_hr,out.hr)
%axis([min(out.t/3600) max(out.t/3600) min(60./out.hr) max(60./out.hr)])
ylabel('HR')
xlabel('time (hours)');

%微分
df = diff(out.hr);%做微分
dft =1:(length(df));%時間軸 
subplot(4,1,3);
plot(dft,df);




% input = rep;
% t=1:(length(input));%時間軸 
% X=t;
% Y=input;
% plot(X,Y);
% 
% % Calcute HR & HRV
%   [X,Y] = ginput(20);
%   plot(X,Y);
%     
%   for a = 1:length(X)-1
%       hr(a) = 60/(X(a+1)-X(a));
%   end
%   HeartRate = mean(hr);
%   HRV = std(hr);
% 
% % Result output
%   fprintf('平均心率=%4.2f\n',HeartRate);
%   fprintf('心率變異=%4.2f\n',HRV);


% fs=30;
% 
% defaverage = mean(input(1:fs));
% defmax=defaverage;
% 
% hrmax=190;
% 
% defcount_clear=hrmax/60;
% 
% maxdata=[];
% 
% %900 count?
% count=0;
% 
% while((count+1)>(length(input)))
% 
% %data = mat2cell(input, length(input)/fs, fs);
% 
% average = mean( input(count:count+fs) );
% 
% %maxdata = max(average);
% 
% 
% 
% 	% count
% 	for i=1:fs
% 	
% 	maxdata_temp = input(count+i+1)-input(count+i);
% 
% 
% 		if(defmax<maxdata_temp)
% 		
% 		defmax = maxdata_temp;
% 		temp_max=input(count+i+1);
% 		
% 		end
% 
% 	end
% 
% maxdata(end+1)=temp_max;
% 
% maxcount = maxcount +1;
% 
% if(maxcount > defcount_clear )
% 
% defmax = average;
% maxcount = 0;
% end	
% 
% count = count + 1;
% 
% end


