function draw_cone(origin, yaw, figid)

p1 = [-8.5; 14] .* 3;
p2 = [8.5; 14] .* 3;

R =  [cos(yaw), sin(yaw); -sin(yaw), cos(yaw)];

p1 = R' * p1 + origin;
p2 = R' * p2 + origin;

figure(figid);
hold on;
plot([origin(1) p1(1)], [origin(2) p1(2)], 'k-', 'linewidth', 2);
plot([origin(1) p2(1)], [origin(2) p2(2)], 'k-', 'linewidth', 2);
hold off;

end
