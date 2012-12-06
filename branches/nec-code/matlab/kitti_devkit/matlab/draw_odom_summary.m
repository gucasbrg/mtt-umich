function draw_odom_summary(gt, est)
%%
subplot(121);
plot(gt(:, 1), gt(:, 2), 'b.-')
hold on
plot(est(:, 1), est(:, 2), 'm.-');
hold off
grid on
legend({'GT' 'EST'});
title('x-z location');
xlabel('x');
ylabel('z');
axis equal
%%
fps = 10;
vgt = zeros(1, size(gt, 1)-1);
for i = 1:size(gt, 1)-1
    vgt(i) = norm(gt(i+1, :) - gt(i, :)) * fps;
end
vest = zeros(1, size(est, 1)-1);
for i = 1:size(est, 1)-1
    vest(i) = norm(est(i+1, :) - est(i, :)) * fps;
end
subplot(122);
plot(vgt, 'b-')
hold on
plot(vest, 'm-')
hold off
grid on
legend({'GT' 'EST'});
title('velocity');
xlabel('frames');
ylabel('v (m/s)');

end