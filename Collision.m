function [ve1,ve2,t] = Collision(vi1,vi2,pi1,pi2,r1,r2)
%COLLISION Summary of this function goes here
%   Detailed explanation goes here

% distanc of contakt
d=r1+r2;

% d=abs(pdiff+t*vdiff)
% 0=vdiff^2*t^2+pdiff*vdiff+pdiff^2-d^2
%  aus der glecihung  für den abstand ergibt sich die konaktzeit mit der
%  Mittanachtsformel t=(-b+-sqrt(b^2-4bc))/2a
vdiff=vi1-vi2;
pdiff=pi1-pi2;

b=dot(pdiff,vdiff);
c=dot(pdiff,pdiff)-d^2;
if b^2-4*b*c<0
    t=-1;
    ve1=vi1;
    ve2=vi2;
else
a=dot(vdiff,vdiff);

t1=(-b+sqrt(b^2-4*b*c))/2*a;
t2=(-b-sqrt(b^2-4*b*c))/2*a;

    t=min(t1,t2);
if t<=0
    t=-1;
    ve1=vi1;
    ve2=vi2;
end
    
    pi12diff=pi2-pi1;
    
%   velocity after the contact
    ve1=dot(vi1,pi12diff)*pi12diff/norm(pi12diff)^2;
    ve2=dot(vi2,pi12diff)*(-1*pi12diff)/norm(pi12diff)^2;
end

end

