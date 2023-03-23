load 0.0005negmaskmat.mat;
load 0.0005posmaskmat.mat;
posfeatures = find(posmaskmat>=160);
negfeatures = find(negmaskmat>=160);
ptemp=zeros(246,246);
ntemp = zeros(246,246);

[posloc,posidx] = orginalidx(posfeatures);
[negloc,negidx] = orginalidx(negfeatures);

ntemp(negloc) = 1;
ptemp(posloc)=1;

ntemp=ntemp+triu(ntemp',1);
ptemp=ptemp+triu(ptemp',1);

ptemp=ptemp+ptemp';
csvwrite('posmat.csv',ptemp);
csvwrite('negmat.csv',ntemp);
%   csvwrite([num2str(th) 'posmat.csv'],ptemp)

