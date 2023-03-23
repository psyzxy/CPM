thresh = [0.001 0.0005 0.0001 0.01 0.05 0.005];
ttest_thresh = 0.05;
fnum = 170;%%% 80%  次出现
for t = 1:length(thresh)
    th = thresh(t);
    load([num2str(th) 'negmaskmat.mat'])
    mat2region(negmaskmat,fnum,th,ttest_thresh)
    load([num2str(th) 'posmaskmat.mat']);
    mat2region(posmaskmat,fnum,th,ttest_thresh)
end