function [alpha beta] = moindre_carre(y,t)

MS=[sum(t) length(y); sum((t).^2) sum(t)];
Sigma(1,1) = sum(y);
Sigma(2,1) = sum(t.*y);
result=inv(MS)*Sigma;
alpha=result(1);
beta=result(2);
end