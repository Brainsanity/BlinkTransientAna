% Paired Z-test for independent samples
%
% Check statistical significance for proportion data using a z-test
% For each point the null hp p1=p2 is tested vs. p1 ne p2 
% Use this test to compare two proportions, for example compare the
% proportion of correct responses a subject gave in two conditions 
% of an experiment. See Snedecor and Cochran page 220 for details.
% Test is corrected for continuity. 
%
%  [E1, E2, z, hh] = Z_TestProrp(# hits Condition 1,# trials Condition 1,# hits Condition 2,# trials Condition 2,alpha,Test Type, print)
%
%  E1, E2: Confidence intervals of data points in conditions 1 and 2 
%  z: z-score
%  hh: significance (1 significant, 0 not significant)
%
%  Optional parameters:
%  alpha: significance level (default 0.05)
%  Test Type:  "One Sided" or "Two Sided" (default Two Sided)
%  print:  verbose, 0 no written output (default verbose).
%


function [E1, E2, E, z, hh] = Z_TestProrp(varargin)

x1 = varargin{1};
n1 = varargin{2};
x2 = varargin{3};
n2 = varargin{4};
k = 4;

alpha = 0.05;
TestType = 2;
Print = 1;

if (nargin>4) 
    alpha = varargin{5};
end

if (nargin>5)
    switch (lower(varargin{6}))
      case 'one sided'
        TestType = 1;
      case 'two sided'
        TestType = 2;
    end
end
  
if (nargin > 6) 
    Print = varargin{7};
end

% Correct for continuity -- See Snedecor and Cochran page 220
xx1 = x1; xx2 = x2;
p1 = x1./n1;
p2 = x2./n2;
if (p1 >= p2) 
    x1 = x1 -0.5;
    x2 = x2 + 0.5;
else
    x2 = x2 - 0.5;
    x1 = x1 + 0.5;
end
p1 = x1./n1;
p2 = x2./n2;


% Determine if test can be used reliably 
if (n1 + n2 < 20) 
    display('test cannot be used because of too few samples\n')
    return;
end
if ( (n1 + n2 < 40) & (min(x1,x2)<5))
    display('test cannot be performed because of low number of events');
    return;
end


p = (x1 + x2)./(n1 +n2);
q = 1-p;
S = sqrt(p.*q.*(1./n1 + 1./n2));
if (S) 
    z = (p1-p2)./S;
else
    fprintf('Standard deviation undetermined\n');
    return;
end

if (TestType == 1) 
    zc = norminv(1-alpha); 
    hh = abs(z)  > abs(zc) ; 
else
    zc = norminv(1-(alpha/2)); 
    hh = abs(z)  > abs(zc) ; 
end


% Calculate confidence intervals
E1 = zc *sqrt(p1.*(1-p1)./(n1+n2)); 
E2 = zc *sqrt(p2.*(1-p2)./(n1+n2));
E = zc *sqrt(S);
if (~hh) 
    E = zc*sqrt(p1.*(1-p1)./n1 + p2.*(1-p2)./n2);
end


if (Print)
    if (TestType == 1)
        fprintf('\nCondition 1: %.2f (%d %d)',[xx1./n1 xx1 n1]'); 
        fprintf('\tCondition 2: %.2f (%d %d)',[xx2./n2 xx2 n2]'); 
        fprintf('\nStatistical Significance (p1 n.e. p2): %d (z = %f, p = %f; one-tailed test)\n',...
            [hh z (1-2*(normcdf(abs(z)) -normcdf(0)))/2]'); 
    else
        fprintf('\nCondition 1: %.3f (%d %d)',[xx1./n1 xx1 n1]'); 
        fprintf('\tCondition 2: %.3f (%d %d)',[xx2./n2 xx2 n2]'); 
        fprintf('\nStatistical Significance (p1 n.e. p2): %d (z = %f, p = %f; two-tailed test)\n',...
            [hh z 1-2*(normcdf(abs(z)) -normcdf(0))]'); 
    end
end
