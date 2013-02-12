function bbs = correctBBox(bbs)

for i =1:size(bbs, 1)
    bbox(1) = min(bbs(i, [1 3]));
    bbox(2) = min(bbs(i, [2 4]));
    bbox(3) = max(bbs(i, [1 3]));
    bbox(4) = max(bbs(i, [2 4]));
    
    bbs(i, :) = bbox;
end

end