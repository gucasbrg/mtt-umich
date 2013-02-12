function merge_images(dirname)
files1 = dir(fullfile(dirname, 'frame*.png'));
files2 = dir(fullfile(dirname, 'top*.png'));

assert(length(files1) == length(files2));

height = 400;
width = 1800;
for i = 1:length(files1)
    img1 = imread(fullfile(dirname, files1(i).name));
    img2 = imread(fullfile(dirname, files2(i).name));
    
    r1 = 400 / size(img1, 1);
    r2 = 400 / size(img2, 1);
    
    img1 = imresize(img1, r1);
    img2 = imresize(img2, r2);
    
    im = uint8(zeros(height, width, 3));
    im(:, 1:size(img1, 2), :) = img1;
    im(:, 1320:1319+size(img2, 2), :) = img2;
    
    imwrite(im, fullfile(dirname, ['merged' num2str(i, '%05d') '.png']), 'PNG');
end

end