function showIDL(imbase, idl, th)

for i = 1:10 % length(idl)
    imshow([imbase, idl(i).img]);
    for j = 1:size(idl(i).bb, 1)
        if(idl(i).score(j) > th)
            rectangle('position', bb2rect(idl(i).bb(j, :)), 'edgecolor', 'y', 'linewidth', 2);
        end
    end
    drawnow
%     keyboard
end

end
