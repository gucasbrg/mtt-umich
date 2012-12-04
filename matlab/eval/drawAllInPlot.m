function drawAllInPlot(dirname)

cam = load(fullfile(dirname, '/camera.txt'));
plot3(cam(:, 2), cam(:, 4), cam(:, 1), 'b.-'); 

cols = colormap;

targetfiles = dir(fullfile(dirname, 'target*.txt'));
for i = 1:length(targetfiles)
    fname = fullfile(dirname, targetfiles(i).name);
    target = load(fname);
    
    target(end, :) = [];
    
    col = cols(mod(i*11,64)+1, :);
    
    hold on;
    plot3(target(:, 2), target(:, 4), target(:, 1), 'LineWidth', 2, 'Color', col); 
    hold off;
end
grid on
title('All Trajectories');
xlabel('x')
ylabel('z')
zlabel('t')

view([30 30])

end