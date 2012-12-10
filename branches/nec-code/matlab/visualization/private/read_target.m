function target = read_target(filename)

data = load(filename);

if(data(end, 1) == 0)
    data(end, :) = [];
end

target.ts = data(:, 1);
target.loc = data(:, 2:4);
target.v = data(:, 5:7);
target.rect = data(:, 8:11);
target.conf = data(:, 12);
end

