%funct(10,5,3)
function f = funct(Z,r,L)
f = sqrt((Z-L).^2+r.^2)-(Z-L).*log((Z-L)+sqrt((Z-L).^2+r.^2));
end
