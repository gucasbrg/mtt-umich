function draw_topview(basedir, imlist, resdir, outdir, flist)

if nargin >= 4
	if(~exist(outdir, 'dir'))
		mkdir(outdir);
	end
end
addpath ~/Codes/plottingTools/savefig
threshold = 0.5;

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

if nargin < 5
	flist = 1:length(bboxes);
else
	flist = intersect(flist, 1:length(bboxes));
end

for i = flist
	figure(1);
	clf;
	
	origin = cam(i, [4 6])';
	yaw = cam(i, 7);

	draw_cone(origin, yaw, 1);
	hold on;
	tailidx = 1:i;

	plot(cam(tailidx, 4), cam(tailidx, 6), 'k-.', 'linewidth', 2);

    for j = 1:length(bboxes(i).tid)
        col = get_color(cols, bboxes(i).tid(j));

        state = targets(bboxes(i).tid(j)).loc(bboxes(i).idx(j), :);
        thickness = 30 * targets(bboxes(i).tid(j)).conf(bboxes(i).idx(j));
		
        if(targets(bboxes(i).tid(j)).conf(bboxes(i).idx(j)) < threshold)
            continue;
        end
        
		plot(state(1), state(3), '.', 'color', col, 'MarkerSize', thickness);
        draw_tail(targets(bboxes(i).tid(j)), bboxes(i).idx(j), col);
	end
	hold off;

	grid on;
	axis([origin(1) - 50 origin(1) + 50 origin(2) - 50 origin(2) + 50]);
    h=title(['frame ' num2str(i)]);
    set(h, 'fontsize', 25);
    drawnow;

    if nargin >= 4
        savefig(fullfile(outdir, ['top' num2str(i, '%05d')]), 'png');
%         saveas(gcf, fullfile(outdir, ['top' num2str(i, '%05d') '.fig']), 'fig');
%         saveas(gcf, fullfile(outdir, ['top' num2str(i, '%05d') '.png']), 'png');
%         saveas(gcf, fullfile(outdir, ['top' num2str(i, '%05d') '.pdf']), 'pdf');
    end
end
% close all;
end

function draw_tail(target, idx, col)

i0 = max(1, idx - 30);
x = zeros(0, 2);

for i = i0:idx
    z = target.loc(i, [1 3]);
    x(end + 1, :) = z;
end

plot(x(:, 1), x(:, 2), '-.', 'color', col, 'linewidth', 2);

end

