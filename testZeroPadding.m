
global N;
global ADCspl;
global AperBScan;
global SplPerAscan;
global TrgOff;
global headersize;
global SplPerBScan;
global SizeNBuffSpl;
global CSizeNBuffSpl;
global FSizeNBuffSpl;
global MittelungBack;
global MittelungRecal;
global SplBack;
global SplRecal;
global Interpolfactor;
global ret;



fid = fopen(filenameB);
fread(fid, hex2dec('83000'),'*char');
fread(fid,TrgOff,'bit12=>int16');
tx = fread(fid,SplBack,'bit12=>int16');
fclose(fid);
[ time_rec, samples_rec ] = Upsample_Via_Zero_Padding(1:length(tx) ,tx );
figure; plot(1:length(tx),tx); hold on; plot(time_rec, samples_rec);

%%

pad=zeros(1,Interpolfactor);
padOne=[1,pad];
xtest=linspace(0,4*pi,50);
ytest=0.5*sin(2*xtest)+2*sin(1.2*xtest);
figure;plot(ytest,'.');hold on;
fytest=fft(ytest);
Mfytest = abs(fytest);
Pfytest =unwrap(angle(fytest));
Mfres=kron(Mfytest,padOne);
Pfres=kron(Pfytest,padOne);
fnew = Mfres.*exp(1i*Pfres);
resample=abs(ifft(fnew));
plot(resample,'.');


%%

fid = fopen(filenameB);
fread(fid, hex2dec('83000'),'*char');
fread(fid,TrgOff,'bit12=>int16');
tx = fread(fid,SplBack,'bit12=>int16');
fclose(fid);
ty = fft(tx);                               % Compute DFT of x
tm = abs(ty);                               % Magnitude
tp = unwrap(angle(ty));
figure;plot(tm);figure;plot(tp);
tmPad=kron(tm,padOne);
tpPad=kron(tp,padOne);
figure;plot(tmPad);figure;plot(tpPad);
