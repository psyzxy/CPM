%输入自己的基因集
%和大的基因集对比 找出交集
%在大的基因集里找出这些行
function genematch(txtname)
% e.g.   genematch('0.001negmaskmatHighgene')
% txtname = string(txtname);
genelist = importdata(txtname);
[~,~,data]=xlsread('NCBIgene.xlsx');
allgene = data(:,6);
[C,ia,ib] = intersect(allgene,genelist);
selectedgene = data(ia,:);
txtname(end-4:end)=[];
writecell(selectedgene,[txtname 'Select.txt'],'Delimiter','tab');
end


