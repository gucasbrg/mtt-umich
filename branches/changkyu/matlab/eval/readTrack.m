function [Track] = readTrack(filename)
fp = fopen(filename, 'r');

cnt = 1;
while(1)
	tline = fgets(fp);
	if(~ischar(tline)) break; end
	temp = sscanf(tline, '%f');
    if(length(temp) > 10)
        Track.ts(cnt) = temp(1);
        Track.loc(:, cnt) = temp(2:4);
        Track.vel(:, cnt) = temp(5:7);
        Track.rect(:, cnt) = temp(8:11);
        Track.conf(:, cnt) = temp(12);
    end
	cnt = cnt + 1;
end

fclose(fp);

end
