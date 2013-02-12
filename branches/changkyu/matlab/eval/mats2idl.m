function idl = mats2idl(detdir, imgprefix)

%%%%%%%%%%%%%%%%%%%%%%%
detfiles = dir(fullfile(detdir, '*.mat'));

idl = struct('bb', cell(length(detfiles), 1), 'img', cell(length(detfiles), 1), 'score', cell(length(detfiles), 1));
for i = 1:length(detfiles)
    dets = load(fullfile(detdir, detfiles(i).name), 'bbox', 'top');     
% 	[top] = load_confidence([detdir detfiles(i).name]);
    idl(i).bb = dets.bbox(dets.top, 1:4);
    idl(i).score = dets.bbox(dets.top, 5);
    
    idx = find(idl(i).score > -2);
    idl(i).bb = idl(i).bb(idx, :);
    idl(i).score = idl(i).score(idx);
    
    idx = find(detfiles(i).name == '.', 1, 'last');
    idl(i).img = [imgprefix, detfiles(i).name(1:idx) 'png'];
end

end