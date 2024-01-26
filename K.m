%Kunction(0.2,0.5,0.001,0.3,0.3)

function K = Kunction(Z1, Z2, r1, r2, L)
K = 0;
Z = [Z1, Z2];
r = [r1, r2];
for ii = 1:1:2
    for jj = 1:1:2
        K = K + (-1)^(ii+jj)*(f(Z(ii),r(jj), 0)-f(Z(ii), r(jj), L));
    end
end
end