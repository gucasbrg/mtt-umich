function idx = findIDLFrameIdx(idl, imgname)

idx  = -1;
for i = 1:length(idl)
    if(strcmp(idl(i).img, imgname))
        idx = i;
        return;
    end
end

end