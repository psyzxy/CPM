function [indloc,idx] = orginalidx(features)
ltmat = tril(ones(246),-1);
ltmat(ltmat>0)=1:length(find(ltmat>0));
features = sort(features); %%%
indloc = find(ismember(ltmat,features));
[i,j] = find(ismember(ltmat,features));
idx = union(i,j);
end
%%%2023.2.16更新，indloc = find……
%indloc是索引 idx是脑区