%apma3100_proj3_part5
%bilge batsukh
clc;clear;
%step 1 - prepare 550 estimates of a sample mean for samples n = 5, 10, 15
%and 30
%note - use a uniform random variable for this, because why not

%step 2 - for each sample size, calculate mean and variance, transform into
%standardized z scores and do estimations

%step 1 start
agg_sample_size = 200000;
initGlobSeed(1000);
aggregate_sample = zeros(agg_sample_size, 1);
for i = 1:agg_sample_size
    aggregate_sample(i) = randNum();
end
all_sample_means = zeros(4, 550);
sample_mean = 0;
for i = 1:550
    sample_mean = 0;
    n1 = randperm(agg_sample_size, 5);
    for j = 1:5
        sample_mean = sample_mean + aggregate_sample(n1(j));
    end
    sample_mean = sample_mean/5;
    all_sample_means(1,i) = sample_mean;
    sample_mean = 0;
    n2 = randperm(agg_sample_size, 10);
    for j = 1:10
        sample_mean = sample_mean + aggregate_sample(n2(j));
    end
    sample_mean = sample_mean/10;
    all_sample_means(2,i) = sample_mean;
    sample_mean = 0;
    n3 = randperm(agg_sample_size, 15);
    for j = 1:15
        sample_mean = sample_mean + aggregate_sample(n3(j));
    end
    sample_mean = sample_mean/15;
    all_sample_means(3,i) = sample_mean;
    sample_mean = 0;
    n4 = randperm(agg_sample_size, 30);
    for j = 1:30
        sample_mean = sample_mean + aggregate_sample(n4(j));
    end
    sample_mean = sample_mean/30;
    all_sample_means(4,i) = sample_mean;
end


%step 2 
%mean and variance of each sample set (n=5,10,15,30)
means(1) = mean(all_sample_means(1,:));
means(2) = mean(all_sample_means(2,:));
means(3) = mean(all_sample_means(3,:));
means(4) = mean(all_sample_means(4,:));

variances(1) = var(all_sample_means(1,:));
variances(2) = var(all_sample_means(2,:));
variances(3) = var(all_sample_means(3,:));
variances(4) = var(all_sample_means(4,:));

%transform a given sample into standardized sample Z_n
z_samples = zeros(size(all_sample_means));

for i = 1:size(z_samples,1)
    for j = 1:size(z_samples,2)
        z_samples(i,j) = transform(all_sample_means(i,j), means(i), variances(i));
    end
end


%step 3 - estimate P[Z_n <= z_j] where j = 1:7 

z_j = [-1.4, -1, -0.5, 0, 0.5, 1, 1.4];
in_range_zs = zeros(4, 7);
for i = 1:size(all_sample_means, 1)
    count_z_1 = nnz(z_samples(i,:) < z_j(1));
    count_z_2 = nnz(z_samples(i,:) < z_j(2));
    count_z_3 = nnz(z_samples(i,:) < z_j(3));
    count_z_4 = nnz(z_samples(i,:) < z_j(4));
    count_z_5 = nnz(z_samples(i,:) < z_j(5));
    count_z_6 = nnz(z_samples(i,:) < z_j(6));
    count_z_7 = nnz(z_samples(i,:) < z_j(7));
    in_range_zs(i,:) = [count_z_1 count_z_2 count_z_3 count_z_4 count_z_5 count_z_6 count_z_7];
end



%turns a set of sample means into a set of z-scores based on a sample
%average and variance
function z_n = transform(m_n, mu, sigma)
    z_n = zeros(length(m_n));
    for i = 1:length(m_n)
        z_n(i) = (m_n(i) - mu)/sqrt(sigma);
    end
end

function rng = randNum() % report a uniform random number in range (0,1)
    global x_0_a;
    global x_n_minus_1_a;
    random = mod((24693*x_0_a + 3967),2^18);
    x_n_minus_1_a = x_0_a;
    x_0_a = random;
    rng = random/(2^18);
end 

function globSeed = initGlobSeed(x)
    global x_0_a
    x_0_a = x; %initialize the seed as 1000;
    globSeed = x_0_a;
end

