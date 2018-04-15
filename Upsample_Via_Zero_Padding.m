function [ TimeRecon, SamplesRecon ] = Upsample_Via_Zero_Padding( time,samples)

global Interpolfactor;

DeltaTime = diff(time);
SampleRate = 1/mean(DeltaTime);
SampleRateRecon = SampleRate * Interpolfactor; 
NumberSamples = length(samples);

%% Upsample

% Zeropadding
SamplesRecon = upsample(samples,Interpolfactor); 
% zeitachse anpassen
TimeRecon = min(time) : 1/SampleRateRecon : min(time) + 1/SampleRateRecon * (NumberSamples*Interpolfactor-1);
% FFT
Signal = fft(SamplesRecon);

% FFT 0 Hz ins zetrum mit fftshift
Signal = fftshift(Signal);

% FFT-shift Vector generieren
FrequenzenRecon = FFTShift(SampleRateRecon,NumberSamples*Interpolfactor);

%Nyquist
SingalNyquist = Signal;
SingalNyquist(abs(FrequenzenRecon)>SampleRate*0.5) = 0;
SingalNyquist(abs(FrequenzenRecon)==SampleRate/2) = SingalNyquist(abs(FrequenzenRecon)==SampleRate/2)/2;
SingalNyquist = SingalNyquist * Interpolfactor; % Restore Signal Energy

% Rücktransformation
SamplesRecon = ifft(ifftshift(SingalNyquist),'symmetric');


end



function Frequenzen = FFTShift(SampleRateRecon,NumberSamplesRecon)
% Frequenzvecter wird erstellt
DeltaFrequenz = SampleRateRecon/NumberSamplesRecon;
Frequenzen = 0 : DeltaFrequenz : DeltaFrequenz*(NumberSamplesRecon-1);
Frequenzen = fftshift(Frequenzen);
Frequenzen(Frequenzen>=SampleRateRecon/2) = Frequenzen(Frequenzen>=SampleRateRecon/2)-SampleRateRecon;
end



