function []=read_orof_data()
global headersize;
global TrgOff;
global SplPerBScan;
global filename;
global ret;
global BScanPlusExcess;

fid = fopen(filename);
ret.header = fread(fid, headersize,'*char');
ret.offset=fread(fid,TrgOff,'bit12=>int16');
k=1;
while~feof(fid) && k< 330
        ret(k).dataRaw = fread(fid,SplPerBScan,'bit12=>int16');
        excessBytes=BScanPlusExcess-length(ret(k).dataRaw);
        fread(fid,excessBytes,'bit12=>int16');
        disp(['B-Scans read: ',num2str(k)]);
    k=k+1;
end
fclose(fid);
end