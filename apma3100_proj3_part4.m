%apma 3100 project 3 on part 4
%a = 24693;
%c = 3967;
%K = 2^18;
clear;clc;
x = linspace(0,250,1000);
f_ = f(x);
F_ = F(x);
run_4_2_2 = 1; %1 if you need to run 4.2.2's "as many as needed independent realizations of x"
run_4_2_3 = 1; %1 if you need to run 4.2.3's sampling protocols, 0 otherwise
generate_later_values = 0; %1 if you need u_51 and beyond, 0 if you don't
global x_n_minus_1;
aggregate_sample = [0, 0, 0]; %placeholder value to just initialize vector
initGlobSeed(1000); %initial seed x_0 is 1000



if generate_later_values == 1
    for i = 1:55 % report random values for i = 51, 52, and 53
        if ( i == 51 || i == 52 || i == 53)
            fprintf("Iteration: " + i + " Random Number: " + randNum() + "\n")
        end
    end
end

if run_4_2_2 == 1
    aggregate_sample_size = 100000; %number of the supersample size
    for j = 1:(aggregate_sample_size)
        aggregate_sample(j) = invF(randNum);
    end
end

if run_4_2_3 == 1
   all_sample_means = zeros(7, 110);
   sample_mean = 0;
   for i = 1:110
       %select random sample - n = 10, 30, 50, 100, 250, 500, 1000
       %fill all_sample_means with sample means based on selections
       sample_mean = 0;
       n1 = randperm(100000, 10);
       for j = 1:10
          sample_mean = sample_mean + aggregate_sample(n1(j));
       end
       sample_mean = sample_mean/10;
       all_sample_means(1,i) = sample_mean;
       sample_mean = 0;
       n2 = randperm(100000, 30);
       for j = 1:30
          sample_mean = sample_mean + aggregate_sample(n2(j));
       end
       sample_mean = sample_mean/30;
       all_sample_means(2,i) = sample_mean;
       sample_mean = 0;
       n3 = randperm(100000, 50);
       for j = 1:50
          sample_mean = sample_mean + aggregate_sample(n3(j));
       end
       sample_mean = sample_mean/50;
       all_sample_means(3,i) = sample_mean;
       sample_mean = 0;
       n4 = randperm(100000, 100);
       for j = 1:100
          sample_mean = sample_mean + aggregate_sample(n4(j));
       end
       sample_mean = sample_mean/100;
       all_sample_means(4,i) = sample_mean;
       sample_mean = 0;
       n5 = randperm(100000, 250);
       for j = 1:250
          sample_mean = sample_mean + aggregate_sample(n5(j));
       end
       sample_mean = sample_mean/250;
       all_sample_means(5,i) = sample_mean;
       sample_mean = 0;
       n6 = randperm(100000, 500);
       for j = 1:500
          sample_mean = sample_mean + aggregate_sample(n6(j));
       end
       sample_mean = sample_mean/500;
       all_sample_means(6,i) = sample_mean;
       sample_mean = 0;
       n7 = randperm(100000, 1000);
       for j = 1:1000
          sample_mean = sample_mean + aggregate_sample(n7(j));
       end
       sample_mean = sample_mean/1000;
       all_sample_means(7,i) = sample_mean;
   end
end
% at this point, all_sample_means is ready for graphing with the number of
% samples (those j values from above) on the x-axis and the means on the y
% axis

function oldSeed = reportLastSeed()
    global x_n_minus_1
    oldSeed = x_n_minus_1;
end
function globSeed = initGlobSeed(x)
    global x_0 
    x_0 = x; %initialize the seed as 1000;
    globSeed = x_0;
end
function rng = randNum() % report a uniform random number in range (0,1)
    global x_0;
    global x_n_minus_1;
    random = mod((24693*x_0 + 3967),2^18);
    x_n_minus_1 = x_0;
    x_0 = random;
    rng = random/(2^18);
end 
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