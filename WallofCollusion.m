function [velOutput,posOutput,error,bool_of_colusion,rekusiv_timer] = WallofCollusion(velInput,posInput,radius,wallkoord,dt,rekusiv_timer)
%WALLOFCOLLUSION Summary of this function goes here
%   Detailed explanation goes here

% Timer witch give the number of rekursiv  calls 
rekusiv_timer=rekusiv_timer+1;
for i=3
if wallkoord(1)<0
    warning('negative koordianten!!!')
    error=1;
else
    diff=wallkoord(1)-radius;
    
    % Time till contact
    t=(diff-posInput(wallkoord(2)))/velInput(wallkoord(2));
    
    if t<dt
        % position at time t
        pos_temp=posInput+t*velInput;
        
        % change in velocity
        vel_temp(wallkoord(2))=-1*velInput(wallkoord(2));
        
        [velOutput,posOutput,error,bool_of_colusion,rekusiv_timer] = WallofCollusion(vel_temp,pos_temp,radius,wallkoord,dt-t,rekusiv_timer);
        
        bool_of_colusion=1;
    end
end


end

