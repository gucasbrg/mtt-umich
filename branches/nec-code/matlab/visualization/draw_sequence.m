function draw_sequence(basedir, imlist, resdir, outdir, fstep)
if nargin < 5
    fstep = 1;
end

threshold = 0.5;

addpath ~/Codes/plottingTools/savefig
mkdir(outdir);

fid = fopen(fullfile(basedir, imlist), 'r');
imfiles = textscan(fid, '%s\n'); imfiles = imfiles{1};
fclose(fid);

cam = load(fullfile(resdir, '/camera.txt'));

targetfiles = dir(fullfile(resdir, 'target*.txt'));
for i = 1:length(targetfiles)
%     targets(i) = read_target(fullfile(resdir, targetfiles(i).name));
    targets(i) = read_target(fullfile(resdir, ['target' num2str(i-1) '.txt']));
end
bboxes = get_boxes(cam, targets);

assert(length(bboxes) == length(imfiles));
cols = colormap;
for i = 1:fstep:length(bboxes)
    imshow(fullfile(basedir, imfiles{i}));
    hold on;
    
    for j = 1:length(bboxes(i).tid)
        col = get_color(cols, bboxes(i).tid(j));
        
        rect = targets(bboxes(i).tid(j)).rect(bboxes(i).idx(j), :);
        rect = convert_width(rect', 0.6)';
        thickness = 3 * targets(bboxes(i).tid(j)).conf(bboxes(i).idx(j));
        if(targets(bboxes(i).tid(j)).conf(bboxes(i).idx(j)) < threshold)
            continue;
        end
        rectangle('position', rect, 'Curvature', 0.1, 'edgecolor', col, 'Linewidth', thickness);
        draw_traj(cam(i, :),  targets(bboxes(i).tid(j)), bboxes(i).idx(j), col);
    end
    hold off;
    h = text(20, 20, ['frame ' num2str(i, '%03d')], 'color', 'r');
    set(h, 'fontsize', 25);
    drawnow;
    
    if nargin >= 4
        savefig(fullfile(outdir, ['frame' num2str(i, '%05d')]), 'png');
%         saveas(gcf, fullfile(outdir, ['frame' num2str(i, '%05d') '.fig']), 'fig');
%         saveas(gcf, fullfile(outdir, ['frame' num2str(i, '%05d') '.png']), 'png');
%         saveas(gcf, fullfile(outdir, ['frame' num2str(i, '%05d') '.pdf']), 'pdf');
    end
end
close all;
end

function draw_traj(cam, target, idx, col)

i0 = max(1, idx - 30);
x = zeros(0, 3);

for i = i0:idx
    z = target.loc(i, :);
    x(end + 1, :) = get_projection(z, cam);
end

x(x(:, 2) < 0, :) = [];
plot(x(:, 1), x(:, 2), 'color', col, 'linewidth', 3);

end


function rts = convert_width(rts, hw_ratio)

h = rts(4, :);
w = rts(3, :);

x = rts(1, :) + w ./ 2;
w = h ./ hw_ratio;

rts(1, :) = x - w ./ 2;
rts(3, :) = w;

end