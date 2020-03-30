for i=1:1:timesteps
    plot3(pos_over_time(:,1,i),pos_over_time(:,2,i),pos_over_time(:,3,i),'*')
    axis([0 1 0 1 0 1])
    pause(0.001)
    n=i
end