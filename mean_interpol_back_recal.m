function [] = mean_interpol_back_recal()

global TrgOff;
global SizeNBuffSpl;
global FSizeNBuffSpl;
global MittelungBack;
global MittelungRecal;
global SplBack;
global SplRecal;
global Interpolfactor;
global ret;
global filenameB;
global filenameR;



% Mittelungbackground=int16(mean(reshape(dataBack,[N*floor(SplPerAscan),MittelungBack]),2));
% figure;plot(1:length(Mittelungbackground),Mittelungbackground);
% MittelungRecal=mean(reshape(dataRecal,[N*floor(SplPerAscan),MittelungRecal]),2);
% figure;plot(1:length(MittelungRecal),MittelungRecal);

fid = fopen(filenameB);
fread(fid, hex2dec('83000'),'*char');
fread(fid,TrgOff,'bit12=>int16');
dataBack = fread(fid,SplBack,'bit12=>int16');
fclose(fid);
for k=1:MittelungBack
    
    indexl=floor((k-1)*SizeNBuffSpl)+1;
    indexr=indexl+floor(SizeNBuffSpl)-1;
    intDataBack=double(dataBack(indexl:indexr));
    x=indexl:indexr;
    [ TimeRecon, dataSincInter ]=Upsample_Via_Zero_Padding(x ,intDataBack );
    %figure;plot(x,intDataBack);hold on;plot(TimeRecon,dataSincInter);
    if k==1
        meanDataBack=dataSincInter;
    else
        meanDataBack=meanDataBack+dataSincInter;
    end
end
ret(1).meanDataBack=meanDataBack/MittelungBack;

%%

fid = fopen(filenameR);
fread(fid, hex2dec('83000'),'*char');
fread(fid,TrgOff,'bit12=>int16');
dataRecal = fread(fid,SplRecal,'bit12=>int16');
fclose(fid);
for k=1:MittelungRecal
    indexl=floor((k-1)*SizeNBuffSpl)+1;
    indexr=indexl+floor(SizeNBuffSpl)-1;
    intDataRecal=double(dataRecal(indexl:indexr));
    x=indexl:indexr;
    [ TimeRecon, dataSincInter ]=Upsample_Via_Zero_Padding(x ,intDataRecal );
    if k==1
        meanDataRecal=dataSincInter-ret(1).meanDataBack;
    else
        meanDataRecal=meanDataRecal+(dataSincInter-ret(1).meanDataBack);
    end
end
ret.meanDataRecal=meanDataRecal/MittelungRecal;



end