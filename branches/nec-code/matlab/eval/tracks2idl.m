function idl = tracks2idl(resdir, imgformat, basenum)
if nargin < 2
	imgformat = 'left/image_%08d_0.png';
	basenum = 930 - 1;
elseif nargin < 3
	basenum = 930 - 1;
end

[tracks, ts] = readTrackResults(resdir);
idl = struct('bb', cell(length(ts), 1), 'img', cell(length(ts), 1), 'score', cell(length(ts), 1));
for i = 1:length(ts)
	idl(i).bb = zeros(0, 4);
	idl(i).score = zeros(0, 1);
	idl(i).img = sprintf(imgformat, basenum + i);
end

for i = 1:length(tracks)
	iid = find(ts == tracks(i).ts(1), 1);
	for j = 1:length(tracks(i).ts)
		fid = iid + j - 1;
		rt = tracks(i).rect(:, j)'; % convert_width(tracks(i).rect(:, j), 2.3)';
		idl(fid).bb(end + 1, :) = [rt(1:2), rt(3:4) + rt(1:2) - 1];
		idl(fid).score(end + 1) =  tracks(i).conf(j);
	end
end

end

function rts = convert_width(rts, hw_ratio)

h = rts(4, :);
w = rts(3, :);

x = rts(1, :) + w ./ 2;
w = h ./ hw_ratio;

rts(1, :) = x - w ./ 2;
rts(3, :) = w;

end
