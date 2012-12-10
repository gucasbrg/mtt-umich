function rt = bb2rect(bb)
rt = bb;
rt(3:4) = rt(3:4) - rt(1:2) + 1;
end