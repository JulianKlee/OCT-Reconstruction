function []= interpol_sub_back_recal_orof_data()

global BperCScan; 
global SizeNBuffSpl;
global FSizeNBuffSpl;
global ret;
global N;
m=1;

for j=1:BperCScan
    k=1;
    while k*FSizeNBuffSpl<length(ret(j).dataRaw)
        indexl=floor((k-1)*SizeNBuffSpl)+1;
        indexr=indexl+floor(SizeNBuffSpl)-1;
        dataRaw8Buf=double(ret(j).dataRaw(indexl:indexr));
        x=indexl:indexr;
        [ TimeRecon, dataSincInter ]=Upsample_Via_Zero_Padding(x ,dataRaw8Buf );
        dataSincInterSubBack=(dataSincInter-ret(1).meanDataBack);
        for m=1:N
            DataStart=(m-1)*floor(length(dataSincInterSubBack)/N)+1;
            DataEnd=(m)*floor(length(dataSincInterSubBack)/N);
            data=dataSincInterSubBack(DataStart:DataEnd);
            a=ret(1).invertVectA(DataStart:DataEnd);
            y=ret(1).invertedVectY(DataStart:DataEnd);
            dataRecal=interp1(a,data,y);
            dataSincInterSubBackRecalFFT=FFT_Log10(dataRecal);
            ret(j).BFrame((k-1)*N+m).dataSincInterSubBackRecalFFT =dataSincInterSubBackRecalFFT;
        end
        %ret(j).BFrame(k).dataSincInterSubBackRecal =dataSincInterSubBackRecal;%not needed
        k=k+1;
        
        %figure; plot(dataSincInter);hold on;plot(ret(1).meanDataBack)
        %figure; plot(dataSincInter-ret(1).meanDataBack);
    end
    disp(['B-Scans processed: ',num2str(j)])
end
end




%        xt=linspace((k-1)*SizeNBuffSpl+1,k*SizeNBuffSpl,Interpolfactor*FSizeNBuffSpl);
%        dataSincInter=zeros(1,length(xt));
%         for i=1:length(xt)
%             dataSincInter( i ) = sum(dataRaw8Buf'.*(sinc((xt(i) - x) )) );
%         end