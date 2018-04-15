clear all;
close all;
global N;               N=8;%anzahl Buffer
global ADCspl;          ADCspl=4;%GHz
global SplPerAscan;     SplPerAscan=1191.276;
global AperBScan;       AperBScan=330;%394368 datenpunkte in einem Bscan
global BScanPlusExcess; BScanPlusExcess=394368;
global BperCScan;       BperCScan=330;
global TrgOff;          TrgOff=60;
global headersize;      headersize=hex2dec('83000');
global SplPerBScan;     SplPerBScan=SplPerAscan*AperBScan;
global SizeNBuffSpl;    SizeNBuffSpl=SplPerAscan*N;
global CSizeNBuffSpl;   CSizeNBuffSpl=ceil(SizeNBuffSpl);
global FSizeNBuffSpl;   FSizeNBuffSpl=floor(SizeNBuffSpl);
global MittelungBack;   MittelungBack=16;
global MittelungRecal;  MittelungRecal=8;
global SplBack;         SplBack=ceil(MittelungBack*N*SplPerAscan);%problem with alignement
global SplRecal;        SplRecal=ceil(MittelungRecal*N*SplPerAscan);
global Interpolfactor;  Interpolfactor=4;

global filename;        filename    = 'Z:\OCT Datasets\Video-Rate-OCT\Live_Imaging_Recording\20170915-174946903.orof';
global filenameB;       filenameB   = 'Z:\OCT Datasets\Video-Rate-OCT\Live_Imaging_Recording\20170915-175216939.orof';
global filenameR;       filenameR   = 'Z:\OCT Datasets\Video-Rate-OCT\Live_Imaging_Recording\20170915-175339054.orof';
global ret; ret=struct();
%%
disp('Start mean_interpol_back_recal')
mean_interpol_back_recal;
disp('Done mean_interpol_back_recal')
disp('Start get_recal_orof_data')
get_recal_orof_data;
disp('Done get_recal_orof_data')
disp('Start read_orof_data')
read_orof_data;
disp('Done read_orof_data')
disp('Start interpol_sub_back_recal_orof_data')
interpol_sub_back_recal_orof_data;
disp('Done interpol_sub_back_recal_orof_data')
disp('Start get_full_BScan')
get_full_BScan;
disp('Done get_full_BScan')

%%
