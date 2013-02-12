function [x, bb] = get_projection(z, cam)

cam = [cam(2); cam(5); cam(3); cam(9); cam(7) ;cam(8); cam(4); cam(6)];
z = [z(1); z(3); 0; 0; z(2)];

% cam = [focal, height, xcenter, yhorizon, panning, v, x, z];
% x = [x, y, imhiehgt]
% z = [x, z, vx, vz, heihgt]


R = [cos(cam(5)), sin(cam(5)); -sin(cam(5)), cos(cam(5))];
if(length(cam) == 8)
    z(1:2) = z(1:2) - cam(7:8);
end
z(1:2) = R * z(1:2);
if(z(2) < 0)
    x = nan(1, 3);
    bb = nan(1, 4);
    return;
end

x = zeros(1, 3);
x(1) = cam(1) / z(2) * z(1) + cam(3);
x(2) = cam(1) / z(2) * cam(2) + cam(4);
x(3) = cam(1) / z(2) * z(5);

if nargout > 1 
    bb = zeros(1, 4);
    bb(1) = x(1) - x(3) / 4;
    bb(2) = x(2) - x(3);
    bb(3) = x(3) / 2;
    bb(4) = x(3);
end

end
