function [ FPPI, recall, thlist ] = recallfppi_idls( annoidl, detidl, opt, quickrun)
if nargin < 3
    opt = 0;
end

recall = [];
FPPI = [];

thlist = [];

fidx = zeros(1, length(annoidl));
for i = 1:length(annoidl)
    fidx(i) = findIDLFrameIdx(detidl, annoidl(i).img);
end

if(sum(fidx < 0) > 0)
	disp('missing frames')
	return
end

thlist = [];
for i = 1:length(fidx)
    thlist = [thlist; detidl(fidx(i)).score(:)];
end
thlist = unique(floor(thlist .* 100) / 100)';

if(quickrun)
    thlist(thlist > 5) = [];
    numlist = length(thlist);
    thlist = thlist(1:max(1, floor(numlist/100)):end);
end

for th = thlist
	TP = 0;	FP = 0;	FN = 0;	frames = 0;
	for i = 1:length(annoidl)
		gt = annoidl(i).bb';
        if isempty(gt)
            gt = zeros(4, 0);
        end
        idx = fidx(i);
		bbs = detidl(idx).bb(detidl(idx).score > th, :)';
        if isempty(bbs)
            bbs = zeros(4, 0);
        end

        [e1, e2, e3] = get_one_frame_performance(gt, bbs, opt);
		frames = frames + 1;
		TP = TP + e1; 
		FP = FP + e2; 
		FN = FN + e3; 
	end

    recall(end+1) = TP / (TP + FN);
    FPPI(end + 1) = FP / frames;
end

end
