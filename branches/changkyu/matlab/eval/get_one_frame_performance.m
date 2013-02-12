function [TP, FP, FN] = get_one_frame_performance(gt_bb, res_bb, opt)
if 1
    % minsize = 60;
    minsize = 20;
    minov = 0.5;
    
    TP = 0;
    FP = 0;
    FN = 0;
    o = zeros(size(res_bb, 2), size(gt_bb, 2));
    
    gtidx = find(gt_bb(4, :) - gt_bb(2, :) >= minsize);
    residx = find(res_bb(4, :) - res_bb(2, :) >= minsize);

    for i = 1:size(res_bb, 2)
        for j = 1:size(gt_bb, 2)
            o(i, j) = boxoverlap(res_bb(:, i)', gt_bb(:, j)) > minov;
        end
    end
    
    TP = sum(sum(o(:, gtidx), 1) > 0); % sum(sum(Matching));
    FN = length(gtidx) - TP;
    FP = length(residx) - sum(sum(o(residx, :), 2) > 0);
else
    TP = 0;
    FP = 0;
    FN = 0;
    o = zeros(size(res_bb, 2), size(gt_bb, 2));
    
    if (opt == 0)
        gt_bb = filter_bbs(gt_bb, 60);
        res_bb = filter_bbs(res_bb, 60);
    end
    for i = 1:size(res_bb, 2)
        for j = 1:size(gt_bb, 2)
            o(i, j) = -log(boxoverlap(res_bb(:, i)', gt_bb(:, j)));
            if(o(i, j) > -log(0.5)) 
                o(i, j) = Inf;
            end
        end
    end
    [Matching, Cost] = Hungarian(o);
    TP = sum(sum(Matching));
    FN = size(gt_bb, 2) - TP;
    FP = size(res_bb, 2) - TP;
end
% for i = 1:size(res_bb, 2)
%     for j = 1:size(gt_bb, 2)
%         o(j) = boxoverlap(res_bb(:, i)', gt_bb(:, j));
%     end
%     if(max(o) >= 0.5)
%         TP = TP + 1;
%     else
%         FP = FP + 1;
%     end
% end
% 
% for j = 1:size(gt_bb, 2)
%     for i = 1:size(res_bb, 2)
%         o(i) = boxoverlap(res_bb(:, i)', gt_bb(:, j));
%     end
%     if (i > 0)
%         if(max(o) < 0.5)
%             FN = FN + 1;
%         end
%     end
% end

% keyboard;
end