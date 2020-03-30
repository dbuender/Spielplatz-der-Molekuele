function [ve1,ve2,pe1,pe2] = Collision(vi1,vi2,pi1,pi2,r1,r2,dt)
%COLLISION Summary of this function goes here
%   Detailed explanation goes here

% distanc of contakt
d=r1+r2;


%  aus der glecihugn für den abstand ergibt sich die konaktzeit mit der
%  Mittanachtsformel t=(-b+-sqrt(b^2-4bc))/2a
vdiff=vi1-vi2;
pdiff=pi1-pi2;

b=dot(pdiff,vdiff);
c=dot(pdiff,pdiff)-d^2;
if b^2-4*b*c<0
    ve1=vi1;
%     ve2=vi2;
    pe1=pi1;
%     pe2=pi2;
else
a=dot(vdiff,vdiff);

t1=(-b+sqrt(b^2-4*b*c))/2*a;
t2=(-b-sqrt(b^2-4*b*c))/2*a;

t=min(t1,t2);

if t<dt
    
%     position till contact
    pt1=pi1+t*vi1;
    pt2=pi2+t*vi2;
    
    pt12diff=pt2-pt1;
    
%   velocity after the contact
    ve1=dot(vi1,pt12diff)*pt12diff/norm(pt12diff)^2;
    ve2=dot(vi2,pt12diff)*(-1*pt12diff)/norm(pt12diff)^2;
    
    
    pe1=pt1+vel*(dt-t);
    pe2=pt2+ve2*(dt-t);
else

    ve1=vi1;
%     ve2=vi2;
    pe1=pi1;
%     pe2=pi2;
end
end

