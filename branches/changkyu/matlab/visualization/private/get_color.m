function col = get_color(cols, idx)
col = cols(mod(idx*11, 64) + 1, :);
end
