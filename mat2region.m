%%%
% 1 先从结果中找到200次的边，此时的边是1-30135格式
%每条边其实是两个脑区之间的连接 涉及两个脑区
% 2 找出涉及的边，cpm中分为正向和负向的边
% 3 分别找出在这些脑区 哪些基因高表达 哪些低表达
% 需要函数 输入边的索引 找出次数 得到
% 输入 pos或negmaskmat,得到脑区编号。根据脑区编号进行t检验
%% part 1
function [i,j] = mat2region(resultmat,fnum,th,ttest_thresh)
filename = inputname(1);
brain_index = find(resultmat>=fnum);
if isempty(brain_index)==1
    disp([filename 'try smaller fnum']);
    return
else
    ltmat = tril(ones(246),-1);
    ltmat(ltmat>0)=1:length(find(ltmat>0));
    brain_index = sort(brain_index); %%%
    [i,j] = find(ismember(ltmat,brain_index));
    Brian_regions = union(i,j);%%%%%%这个地方开始是求交集，写错了
    Allregions = 1:246;
    other_regions = setdiff(Allregions, Brian_regions);
    load('regionxGene.mat');
    %%%%%%注意第一列是label%%%%%%%
    expressiondata = regionxGene.data(:,2:end);
    %%%%NaN%%%%
    %% t-test
    %     brain_expression = expressiondata(Brian_regions,:);
    %     other_expression = expressiondata(other_regions,:);
    %     [h,p,ci,stats] = ttest2(brain_expression,other_expression);
    %% permutation t-test
    brain_expression = expressiondata(Brian_regions,:);
    other_expression = expressiondata(other_regions,:);
    [orig_t,perm_p,perm_h] = zxynewpermtest_t2(brain_expression,other_expression,10000,0.05);
%    [t,stats,orig,param] = permtest_t2(brain_expression,other_expression);
    %%find high and low expressed genes
    high_express_gene = perm_p<ttest_thresh&perm_h==1&orig_t>0;%%%%%%%%%0 1
    low_express_gene = perm_p<ttest_thresh&perm_h==1&orig_t<0;
    gene = regionxGene.colheaders(2:end);
    high_genelist = gene(high_express_gene);
    low_genelist =gene(low_express_gene);
    %save([filename 'res.mat'],'h','p','ci','stats','i','j');%%%有pos和neg的ij需要分开
    writecell(high_genelist',[num2str(th) filename 'Highgene.txt']);
    writecell(low_genelist',[num2str(th) filename 'Lowgene.txt']);
end
end


