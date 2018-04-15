function []= get_full_BScan()

global ret;

for j=1:length(ret)
    numberOfElements=length(ret(1).BFrame);
    for k=1:numberOfElements
        if k==1
            Bframe=ret(j).BFrame(k).dataSincInterSubBackRecalFFT;
        else
            Bframe=cat(2,Bframe,ret(j).BFrame(k).dataSincInterSubBackRecalFFT);
        end
    end
    
end
end