function [t p b R Outliers] = LinearRegression(Xp,Yp,RemoveOutliers,Graph)

% function [t p b R Outliers] = LinearRegression(X,Y,RemoveOutliers)
%
% INPUT : X - independent variable data points
%         Y - dependent variable data points
%         RemoveOutliers - a vector of outliers indeces not to be included
%         in the analysis
%
% OUTPUT : t - t value associated with the linear regression coefficient
%          p - p value associated with the linear regression coefficient
%          b - b linear regression coefficient (i.e., slope of the fitted
%              line)
%          Outliers: Indeces of the points beyond .99th percentile in the
%          correlation
% from - "statistical methods"  by Snedecor & Cochran. Sixth Edition.
% Chapter 6 pg. 153

t= 0; b= 0; p=0; R = 0; Outliers = []; Graph = 1;

% Check input
if length(Xp)~=length(Yp)
    fprintf('Error: input vectors must have identical size\n')
    return
end
   

% Remove selected outliers and order data points on X-axis
SelectedIndeces = ones(length(Xp),1);
SelectedIndeces(RemoveOutliers) = 0;
Xps = Xp(logical(SelectedIndeces));
Yps = Yp(logical(SelectedIndeces));

[X SortedIndeces] = sort(Xps); 
Y = Yps(SortedIndeces);

% degrees of freedom
N = length(X);
df = N-2;
x = X-mean(X);
y = Y-mean(Y);
% coefficient estimate
b = sum(x.*y)/sum(x.^2);
Y_a = mean(Y) + b.*x;
D_yx = Y - Y_a;
S_yx2 = sum(D_yx.^2)/df;
% standard deviation of the coefficient estimate
S_b = sqrt(S_yx2/sum(x.^2));
% t stat for the null hypothesis that b=beta, where beta=0
%(absence of correlation between the two variables).
t = b/S_b;
% p value for a two tail test
p = 2*tcdf(-abs(t), df);
% 95% confidence intervals
S_yx = sqrt(S_yx2);
S_a = S_yx*sqrt((1/N)+(x.^2./sum(x.^2)));
t_95 = tinv(.05/2,df);
delta = t_95*S_a;

[R P] = corrcoef(X,Y);
R = R(2);
P = P(2);

[p_reg S_reg] = polyfit(X,Y,1);

if (Graph) 
    scatter(Xp,Yp,'k')
    hold on
    scatter(X,Y,'FaceMarker','k')
    plot([min(X) max(X)], polyval(p_reg,[min(X) max(X)]),'b', 'LineWidth', 2)
    plot(X, Y_a+delta, '-r')
    plot(X, Y_a-delta, '-r')
    axis([0.8*min(Xp) 1.1*max(Xp) 0.8*min(Yp) 1.1*max(Yp)])
    title(sprintf('r^2=%.2f p=%.3f b=%.2f', R.^2, P, b), 'FontSize',12)
    hold off
else
    fprintf('r^2=%.2f p=%f b=%.2f\n', R.^2, P, b)
end


c = p_reg(2);
% testing deviations that look suspiciously large (from p. 157)
% identify the suspicious values 

Yfit = polyval(p_reg,X,S_reg);
dyx = Y - Yfit;
Dev99 = tinv(.01/2,df)*S_yx*sqrt((1/N)+(x.^2./sum(x.^2)));

Outliers = SortedIndeces(abs(dyx)>abs(Dev99));


% scatter(Xp,Yp,'k')
% hold on
% scatter(X,Y,'FaceMarker','k')
% [p_reg S_reg] = polyfit(X,Y,1);
% plot([min(X) max(X)], polyval(p_reg,[min(X) max(X)]),'b', 'LineWidth', 2)
% plot(X, Y_a+delta, '-r')
% plot(X, Y_a-delta, '-r')
% axis([0.8*min(Xp) 1.1*max(Xp) 0.8*min(Yp) 1.1*max(Yp)])
% title(sprintf('r^2=%.2f p=%.3f b=%.2f', R.^2, P, b), 'FontSize',12)
% hold off
% 
% c = p_reg(2);
% % testing deviations that look suspiciously large (from p. 157)
% % identify the suspicious values 
% 
% Yfit = polyval(p_reg,X,S_reg);
% dyx = Y - Yfit;
% Dev99 = tinv(.01/2,df)*S_yx*sqrt((1/N)+(x.^2./sum(x.^2)));
% 
% Outliers = SortedIndeces(abs(dyx)>abs(Dev99));
% 
% 
% 
% 



