%% 用于从magma第一步得到的annotation文件中提取snp
[~,~,data]=xlsread("Negannot.xlsx");
snp = data(:,3:end);
snaplist = snp(:);
snaplist(cellfun(@(x) any(isnan(x)),snaplist))=[];
writecell(snaplist,'Neglist.txt');