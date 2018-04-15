function []=get_recal_orof_data()
global ret;
global N;

recalData=ret(1).meanDataRecal;

phaseRecal=zeros(size(recalData));
invertVectA=zeros(size(recalData));
invertedVectY=zeros(size(recalData));
for k=1:8
    DataStart=(k-1)*floor(length(recalData)/N)+1;
    DataEnd=(k)*floor(length(recalData)/N);
    phaseR=unwrap(angle(hilbert(recalData(DataStart:DataEnd))));%(DataStart:DataEnd)
    invertVecta=linspace(0,max(phaseR),length(phaseR));%0 oder 1?
    invertedVecty=interp1(phaseR,invertVecta,invertVecta,'pchip');
    phaseRecal(DataStart:DataEnd)=phaseR;
    invertVectA(DataStart:DataEnd)=invertVecta;
    invertedVectY(DataStart:DataEnd)=invertedVecty;
end
ret(1).phaseRecal=phaseRecal;
ret(1).invertVectA=invertVectA;
ret(1).invertedVectY=invertedVectY;
end
% function []=get_recal_orof_data()
% global ret;
% global N;
% 
% recalData=ret(1).meanDataRecal;
% 
% phaseRecal=zeros(size(recalData));
% for k=1:8
%     DataStart=(k-1)*floor(length(recalData)/N)+1;
%     DataEnd=(k)*floor(length(recalData)/N);
%     phaseRecal=unwrap(angle(hilbert(recalData(DataStart:DataEnd))));%(DataStart:DataEnd)
%     a=linspace(0,max(phaseRecal),length(phaseRecal));%0 oder 1?
%     y=interp1(phaseRecal,a,a,'pchip');
%     
%     tR=recalData(DataStart:DataEnd);
%     yR=interp1(a,tR,y);    
%     %figure; plot(unwrap(angle(hilbert(yR))));hold on;plot(phaseRecal);hold on;plot(y)
%     Y=fft(yR);
%     P2=abs(Y/length(yR));
%     P1=P2(1:length(yR)/2+1);
%     P1(2:end-1) = 2*P1(2:end-1);
%     figure;plot(P1) 
%     
% end
% ret(1).phaseRecal=phaseRecal;
% a=linspace(0,max(phaseRecal));
% y=interp1(phaseRecal,a,a,'spline');
% figure;plot(y);%hold on;plot(phaseRecal);
% 
% end