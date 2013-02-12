function bboxes = get_boxes(cam, targets)

% bboxes = struct('tid', cell(size(cam, 1), 1), 'rect', cell(size(cam, 1), 1), 'idx', cell(size(cam, 1), 1));
bboxes = struct('tid', cell(size(cam, 1), 1), 'idx', cell(size(cam, 1), 1));
for i = 1:length(targets)
    for j = 1:length(targets(i).ts)
        idx = find(cam(:, 1) == targets(i).ts(j), 1);
        if(~isempty(idx))
%             bboxes(idx).rect(end+1, :) = targets(i).rect(j, :);
%             [x, bb] = get_projection(targets(i).loc(j, :), cam(idx, :));
%             bboxes(idx).rect(end+1, :) = bb;
            bboxes(idx).idx(end+1) = j;
			bboxes(idx).tid(end+1) = i;
        end
    end
end

end

