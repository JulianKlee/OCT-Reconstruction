clear all;
segsize=hex2dec('1000');
N=12;
filename = '20170912-190814794.orof';

fid = fopen(filename);
header = fread(fid, hex2dec('83000'),'*char');
k=0;
while ~feof(fid) && k<1
    N=12;
    %a=fread(fid, [N segsize], 'ubit12=>unit16');
    data = fread(fid,segsize,'ubit12=>uint16','l');
    k=k+1;
end

fclose(fid);
fid = fopen(filename);
header = fread(fid, hex2dec('83000'),'*char');
k=0;
while ~feof(fid) && k<1
    N=12;
    %a=fread(fid, [N segsize], 'ubit12=>unit16');
    data1 = fread(fid,segsize,'uint8');
    k=k+1;
end

fclose(fid);
