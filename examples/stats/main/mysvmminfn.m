function [f,viol,nsupp] = mysvmminfn(x,cdata,grp,c)
SVMModel = fitcsvm(cdata,grp,'KernelFunction','rbf',...
    'KernelScale',x.sigma,'BoxConstraint',x.box);
f = kfoldLoss(crossval(SVMModel,'CVPartition',c));
viol = [];
nsupp = sum(SVMModel.IsSupportVector);
end