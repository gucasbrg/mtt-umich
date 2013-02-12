function [FPPI, recall] = evalTrackDetections(resdir, anno, opt)
[results, ts] = readTrackResults(resdir); %'../../standalone_tracker/results/seq02.11/'
scores = zeros(1, length(results));
for i = 1:length(results)
	scores(i) = sum(results(i).conf);
end

[dummy, idx] = sort(scores);

FPPI = [];
recall = [];

step = 2;
for i = 1:step:length(scores)
    [TP, FP, FN, frames] = evalOneVideo(ts, results(idx(i:end)), anno, 0, opt); % , imlist);
    recall(end+1) = TP / (TP + FN);
    FPPI(end + 1) = FP / frames;
end

end
