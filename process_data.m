clear all;
close all;
global N;               N=8;%anzahl Buffer
global ADCspl;          ADCspl=4;%GHz
global AperBScan;       AperBScan=330;
global SplPerAscan;     SplPerAscan=1191.276;
global TrgOff;          TrgOff=60;
global headersize;      headersize=hex2dec('83000');
global SplPerBScan;     SplPerBScan=SplPerAscan*AperBScan;
global SizeNBuffSpl;    SizeNBuffSpl=SplPerAscan*N;
global CSizeNBuffSpl;   CSizeNBuffSpl=ceil(SizeNBuffSpl);
global FSizeNBuffSpl;   FSizeNBuffSpl=floor(SizeNBuffSpl);
global MittelungBack;   MittelungBack=16;
global MittelungRecal;  MittelungRecal=8;
global SplBack;         SplBack=MittelungBack*N*floor(SplPerAscan);%problem with alignement
global SplRecal;        SplRecal=MittelungRecal*N*floor(SplPerAscan);
global Interpolfactor;  Interpolfactor=4;

global filename; filename = 'Z:\OCT Datasets\Video-Rate-OCT\20170915-174946903.orof';

global ret; ret=struct();
%%
read_orof_data;

%%
for k=1:10
    indexl=(k-1)*CSizeNBuffSpl+1;
    indexr=k*FSizeNBuffSpl;
    dataRaw8Buf=double(dataRaw(indexl:indexr));
    x=indexl:indexr;
    xt=linspace((k-1)*SizeNBuffSpl+1,k*SizeNBuffSpl,Interpolfactor*FSizeNBuffSpl);
    tic
    y=zeros(1,length(xt));
    for i=1:length(xt)
        y( i ) = sum(dataRaw8Buf'.*(sinc((xt(i) - x) )) );
    end
    y = reshape(y, size(xt));%not needed
    toc
    figure;plot(x,dataRaw8Buf);hold on;plot(xt,y);
    
end
%% Auf n-FachPuffer sinc interpolieren


%%


%%
%background

filename = 'Z:\OCT Datasets\Video-Rate-OCT\20170915-175216939.orof';
fid = fopen(filename);
header = fread(fid, hex2dec('83000'),'*char');
offset=fread(fid,TrgOff,'bit12=>int16');
dataBack = fread(fid,SplBack,'bit12=>int16');
fclose(fid);

%recal
filename = 'Z:\OCT Datasets\Video-Rate-OCT\20170915-175339054.orof';
fid = fopen(filename);
header = fread(fid, hex2dec('83000'),'*char');
offset=fread(fid,TrgOff,'bit12=>int16');
dataRecal = fread(fid,SplRecal,'bit12=>int16');

fclose(fid);

x=1:length(dataRecal);
figure;plot(x,dataRecal)

MittelungRecal=mean(reshape(dataRecal,[N*floor(SplPerAscan),MittelungRecal]),2);
figure;plot(1:length(MittelungRecal),MittelungRecal);
%%
xs=1:TrgOff;
figure;plot(xs,offset);
Mittelungbackground=int16(mean(reshape(dataBack,[N*floor(SplPerAscan),MittelungBack]),2));
figure;plot(1:length(Mittelungbackground),Mittelungbackground);

%% Rohdaten

filename = 'Z:\OCT Datasets\Video-Rate-OCT\20170915-174946903.orof';
fid = fopen(filename);
header = fread(fid, hex2dec('83000'),'*char');
offset=fread(fid,TrgOff,'bit12=>int16');
dataRaw = fread(fid,SplPerBScan,'bit12=>int16');

fclose(fid);
dataRaw8=reshape(dataRaw(1:(N*floor(SplPerAscan)*floor(length(dataRaw)/(N*floor(SplPerAscan))))),[N*floor(SplPerAscan),floor(length(dataRaw)/(N*floor(SplPerAscan)))]);
dataRaw8SubBack=dataRaw8(:,1)-Mittelungbackground;
%%
x=1:length(dataRaw);
figure;plot(x,dataRaw);
