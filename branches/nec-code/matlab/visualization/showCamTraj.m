function showCamTraj(dirname)

resbase = '~/codes/mtt-umich/standalone_tracker/results/';
resdir = fullfile(resbase, dirname);

cam = load(fullfile(resdir, 'camera.txt'));
plot3(cam(:,2), cam(:, 4), cam(:, 1), 'b-', 'linewidth', 3);

cam([1 end], :)

cols = 'rgbmkyc';
pts = {'-' '-.' '--'};

targetfiles = dir(fullfile(resdir, 'target*.txt'));
hold on;
for i = 1:length(targetfiles)
    target = read_target(fullfile(resdir, ['target' num2str(i-1) '.txt']));
    
    col = cols(mod(i, 7) + 1);
    pt = pts{mod(i, 3) + 1};
    
    plot3(target.loc(:, 1), target.loc(:, 3), target.ts, [col pt], 'linewidth', 2);
end
hold off;

drawnow;

view([30 45]);
grid on;

xlabel('x');
ylabel('z');
zlabel('t');

title('All trajectories')

end