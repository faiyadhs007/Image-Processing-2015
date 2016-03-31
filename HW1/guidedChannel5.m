function [I_rf ] = guidedChannel5(Channel, eps)
row =512; col=512;
% Red Channel
I_r =double(Channel); p_r = double(Channel);
% Extension for I_r
I_rex = extension5(double(Channel));
% Extension for p_r
p_rex = extension5(double(Channel));

mu_pr = averageFilter5(p_rex);
mu_Ir = averageFilter5(I_rex);

for r = 1:516
    for c = 1:516
        Ip_rex(r,c) = I_rex(r,c)*p_rex(r,c);
    end
end
Ip_r = averageFilter5(Ip_rex);

mu_Ir2 = extension5(mu_Ir);
mu_Ir2m = mu_Ir2^2;
mu_Ir2a = averageFilter5(mu_Ir2m);
mu_Ir2b = mu_Ir.*mu_Ir;
var_Ir = mu_Ir2a - mu_Ir2b;

for r=1:row
    for c=1:col
        ak_r(r,c) = (Ip_r(r,c)- (mu_Ir(r,c) * mu_pr(r,c)))/(var_Ir(r,c)+eps);
    end
end

for r=1:row
    for c=1:col
        bk_r(r,c) = mu_pr(r,c) - (ak_r(r,c)*mu_Ir(r,c));
    end
end

ak_rex = extension5(ak_r);
bk_rex = extension5(bk_r);
a = averageFilter5(ak_rex);
b = averageFilter5(bk_rex);
I_rf = a.*I_r + b;
end

