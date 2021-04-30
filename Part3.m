clear;clc;

x = linspace(0,250,1000);

f_ = f(x);
F_ = F(x);

figure(1)
plot(x,f_);
title("PDF")
xlabel("Distance from T (in)")
ylabel("Probability")
grid on
figure(2)
plot(x,F_);
title("CDF")
xlabel("Distance from T (in)")
ylabel("Cumulative Probability")
grid on

p = [0.5 0.7 0.9];

x_ = invF(p);

figure(3)
title("Drop Zones")
hold on

scatter(0,0,'k*');

for i = x_
    theta= linspace(0,2*pi);
    x = i*cos(theta);
    y = i*sin(theta);
    plot(x,y)
end

xlabel("\Delta inches")
ylabel("\Delta inches")

legend(["Target","50%", "70%", "90%"]);

axis equal
axis([-200 200 -200 200])
grid on
hold off

figure(4)
[X,Y] = meshgrid(-200:1:200,-200:1:200);
Z = F(sqrt((X).^2 + (Y.^2)));
plt = surf(X,Y,Z,Z);
set(plt,'LineStyle','none')
colorbar
%view(0, 90)
grid on

function y = f(x)
    tau = 57;
    a = 1/tau;
    y = a^2 * x.* exp(-0.5* a^2 * x.^2);
end

function y = F(x)
    tau = 57;
    a = 1/tau;
    y = 1 - exp(-0.5* a^2 * x.^2);
end

function x = invF(p)
    tau = 57;
    a = 1/tau;
    x = sqrt((-2*log(1-p)) / a^2);
end
