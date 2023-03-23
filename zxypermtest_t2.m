function [orig_t,perm_p,perm_h] = zxypermtest_t2(X1,X2,nperm,alpha)
alpha = alpha;
node1 = size(X1,1);
perm_t = zeros(1,nperm);
commat = [X1;X2];
[~,~,~,STATS] = ttest2(X1,X2);
orig_t = STATS.tstat;%%原始t值
perm_tmax = zeros(1,nperm);
perm_tmin = zeros(1,nperm);
for i=1:nperm
    randorder = randperm(246);
    randX1 = commat(randorder(1:node1),:);
    randX2 = commat(randorder(node1+1:end),:);
    [~,~,~,stats] = ttest2(randX1,randX2);
    perm_tmax(i) = max(stats.tstat);
    perm_tmin(i) = min(stats.tstat);
    disp(['the',' ', num2str(i),' ','permutation'])
end
% compute_p=@(x) mean(abs(x)<perm_t)*2;
perm_p = zeros(1,length(orig_t));
%
for j = 1:length(orig_t)
    if orig_t(j)>0
        perm_p(j) = length(find(orig_t(j)<perm_tmax))/length(perm_tmax);
    else
        perm_p(j) = length(find(orig_t(j)>perm_tmin))/length(perm_tmin);
    end
%     permtup = prctile(perm_t,100*(1-alpha/2));
%     permtdown = prctile(perm_t,100*(alpha/2));
    perm_h = cast(perm_p<alpha,'like',perm_p);
    save('permtres.mat',"orig_t","perm_p","perm_h","perm_t");
end
%%%%取最大值和最小值两个分布

