function traj = loadCamTrajectory(base_dir, frames)
oxts = loadOxtsliteData(base_dir, frames);
pose = convertOxtsToPose(oxts);

for i = 1:length(pose)
    if(isempty(pose{i}))
        continue;
    end
    
    temp(:, i) = pose{i}(1:3, end);
end

traj(:, 1) = -temp(2, :);
traj(:, 2) = temp(1, :);

end