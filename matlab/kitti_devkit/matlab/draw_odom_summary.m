function draw_odom_summary(gt, est)
%%
subplot(121);
plot(gt(:, 1), gt(:, 2), 'b.-')
hold on
plot(est(:, 1), est(:, 2), 'm.-');
hold off
grid on
h=legend({'GT' 'EST'});
set(h, 'fontsize', 20);
h=title('x-z location');
set(h, 'fontsize', 20);
h=xlabel('x');
set(h, 'fontsize', 15);
h=ylabel('z');
set(h, 'fontsize', 15);
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
h=legend({'GT' 'EST'});
set(h, 'fontsize', 20);
h=title('velocity');
set(h, 'fontsize', 20);
h=xlabel('frames');
set(h, 'fontsize', 15);
h=ylabel('v (m/s)');
set(h, 'fontsize', 15);

end