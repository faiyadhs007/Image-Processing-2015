function [I_rf ] = guidedChannel7(Channel, eps)
row =512; col=512;
% Red Channel
I_r =double(Channel); p_r = double(Channel);
% Extension for I_r
I_rex = extension7(double(Channel));
% Extension for p_r
p_rex = extension7(double(Channel));

mu_pr = averageFilter7(p_rex);
mu_Ir = averageFilter7(I_rex);

for r = 1:518
    for c = 1:518
        Ip_rex(r,c) = I_rex(r,c)*p_rex(r,c);
    end
end
Ip_r = averageFilter7(Ip_rex);

mu_Ir2 = extension7(mu_Ir);
mu_Ir2m = mu_Ir2^2;
mu_Ir2a = averageFilter7(mu_Ir2m);
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

ak_rex = extension7(ak_r);
bk_rex = extension7(bk_r);
a = averageFilter7(ak_rex);
b = averageFilter7(bk_rex);
I_rf = a.*I_r + b;
end

