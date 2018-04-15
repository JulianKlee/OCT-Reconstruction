function [P1]=FFT_Log10(data)
    Y=fft(data);
    P2=abs(Y/length(data));
    P1=P2(1:floor(length(data)/2+1));
    P1(2:end-1) = 2*P1(2:end-1);
    P1=log10(P1);
end