function [average, maximum, minimum, standard, homogeneity1, entropy1, homogeneity2, entropy2] = calcul_parameters(matrix2,mask)
% function which calculates textural parameters for thermal imaging
%
% input:
%       matrix: original thermal image
%       mask: region of interest (binary information)
%       accuracy to be used for the calculation of parameters (eg: 0.1)
warning ('off','all');
clearvars -except matrix2 mask accuracy


% convert all the pixels out of the mask to NaN values
matrix2(mask==0)=NaN;

% calculate both the mean value and standard deviation of the mask
average=nanmean(matrix2(:));
standard=std(matrix2(:),'omitnan');
% estimate the amount of levels to use based on camera accuracy
% matrix=round(matrix,1);
maximum=nanmax(matrix2(:));
minimum=nanmin(matrix2(:));
temp_difference=maximum-minimum;
levels=ceil(temp_difference/0.1);

% calculate rotationally invariant homogeneity index at 0.1 accuracy
offset=[0 1;-1 0;-1 1; -1 -1];
glcm_temp=graycomatrix(matrix2, 'Graylimits', [minimum maximum], 'NumLevels',levels,'Offset',offset);
tot_glcm=sum(glcm_temp,3);
stats=graycoprops(tot_glcm,'Homogeneity');
homogeneity1=stats.Homogeneity;

% calculate the entropy
matrix3=round(matrix2/0.1);
tot=histcounts(matrix3(isnan(matrix2)==0));
counta=double(tot)/sum(tot,2);
Hgram1=zeros(1,size(tot,2));
     for m=1:size(tot,2)
         if counta(m)~=0
             Hgram1(m)=counta(m).*log2(counta(m));
         end
     end

 entropy1=abs(sum(Hgram1(:)));

clearvars -except average maximum minimum standard homogeneity1 entropy1 temp_difference maximum minimum offset matrix2

levels=ceil(temp_difference/0.2);
% calculate rotationally invariant homogeneity index at 0.2 accuracy
glcm_temp=graycomatrix(matrix2, 'Graylimits', [minimum maximum], 'NumLevels',levels,'Offset',offset);
tot_glcm=sum(glcm_temp,3);
stats=graycoprops(tot_glcm,'Homogeneity');
homogeneity2=stats.Homogeneity;

% calculate the entropy
matrix3=round(matrix2/0.2);
tot=histcounts(matrix3(isnan(matrix2)==0));
counta=double(tot)/sum(tot,2);
Hgram1=zeros(1,size(tot,2));
     for m=1:size(tot,2)
         if counta(m)~=0
             Hgram1(m)=counta(m).*log2(counta(m));
         end
     end

 entropy2=abs(sum(Hgram1(:)));

 clearvars -except average maximum minimum standard homogeneity1 entropy1 homogeneity2 entropy2
end