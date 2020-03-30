clear all;
% Helium
cakerad=31e-12; %[m]
cakemass=2*4.002602*1.66054e-27; % [kg]

% Startparameter 
numofcake=10;
T_start= 300; % [K]
k_B=1.380649e-23; % [ m^2 kg s^-2 K^-1]
V_start = 1; % [m^3]

dt=1e-3; % [s]
timesteps=1e3; % [-]
error=0;

% coordinats of the Walls
length_of_Wall=nthroot(V_start,3); % [m]
% coordWall = length_of_Wall/2


% Jedes Teilchen hat folgenden eigenschaften
cakepos=zeros(3,numofcake); % 1-3 x-z

cakevel=zeros(3,numofcake);
bool_of_colusion=zeros(1,numofcake);
% aus U=3/2 * N*k_B*T folgt v^_=sqrt(3*T*k_B/m)

% v_ave = sqrt((3*T_start*k_B)/cakemass);

cakevel=rand(3,numofcake)*300;
cakepos=rand(3,numofcake)*length_of_Wall;
wallkoord=[[length_of_Wall;1] [0;1] [length_of_Wall;2] [0;2] [length_of_Wall;3] [0;3] ];

pos_over_time=zeros(numofcake,3,timesteps);
vel_over_time=zeros(numofcake,3,timesteps);

for i=1:timesteps
    if error==1
        break
    end
    %======================================================================
    % save the rave
    %======================================================================
    for j=1:numofcake
        
        pos_over_time(j,:,i)=cakepos(:,j);
        vel_over_time(j,:,i)=cakevel(:,j);
       
    end
    % grid
    % %     % minimale gridgröße
    %     vmax=max(max(cakespeed));
    %     mingrid_dist=2*dt*vmax;
    %     mingrid_num=ciel(lenth_of_Wall/(2*mingrid_dist));
    %
    %======================================================================
    % wall of colusion
    %======================================================================
    for j=1:numofcake
        for n=1:3
            [velOutput,posOutput,error,bool_of_colusion,rekusiv_timer] = WallofCollusion(velInput,posInput,radius,wallkoord,dt,rekusiv_timer)
            end
        end
    end

    %======================================================================
    %  colusion aganist each other
    %======================================================================
    for j=1:numofcake
        if bool_of_colusion(j)==0
            for l=1:numofcake
                if bool_of_colusion(l)==0 && j~=l && bool_of_colusion(j)==0
                    [ve1,ve2,t]=Collision(cakevel(:,j),cakevel(:,l),cakepos(:,j),cakepos(:,l),cakerad,cakerad);
                    %           es wird anegenommen das es jedes teilchen nur eien kollison pro
                    %           zeitschritt hat. unter dieser Annahme kann nach einer gefunden
                    %           kolision beide tielchen aus der betrchtung für diesen Schritt
                    %           entnommen werden
                    if t<=dt&&t~=-1
                        
                        cakepos(:,j)=cakepos(:,j)+cakevel(:,j)*t+ve1*(dt-t);
                        cakepos(:,l)=cakepos(:,l)+cakevel(:,l)*t+ve2*(dt-t);
                        
                        cakevel(:,j)=ve1;
                        cakevel(:,l)=ve2;
                        
                        bool_of_colusion(j)=1;
                        bool_of_colusion(l)=1;
                        
                    end
                end
            end
        end
    end
%  

for j=1:numofcake
    if bool_of_colusion(j)==0
        cakepos(:,j)=cakepos(:,j)+cakevel(:,j)*dt;
    end
end

bool_of_colusion=zeros(1,numofcake);

    
end