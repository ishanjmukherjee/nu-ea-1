% Homework Program 3
%
% Name: Mukherjee, Ishan
% Date: 10/6/2023

% Get inputs:
d = input("d: ");
s = input("s: ");
n = input("n: ");

% Create matrix rolls:
rolls = randi(s,n,d);

% Calculate dice_sums:
dice_sums = sum(rolls, 2);

% Calculate tally and sums:
[tally, sums] = hist(dice_sums, d:s*d);

% Find desired probabilities:
probs = tally ./ n;

% Plot bar graph of results:
% Open a new figure window
figure;
% Create a bar graph with sums in the x-axis and probs in the y-axis
bar(sums, probs);

% Create  nice title
title(sprintf("%i Dice, %i Sides, %i Trials", d, s, n));

% Label the axes
xlabel("Sum");
ylabel("Probability");

% Create a results matrix:
% Transpose sums and probs so that results is a n x 2 matrix
results = [sums', probs'];

% Answer to step 10: 
% results =
%  3.0000    0.0010
%  4.0000    0.0050
%  5.0000    0.0070
%  6.0000    0.0090
%  7.0000    0.0160
%  8.0000    0.0230
%  9.0000    0.0220
% 10.0000    0.0460
% 11.0000    0.0390
% 12.0000    0.0460
% 13.0000    0.0590
% 14.0000    0.0740
% 15.0000    0.0650
% 16.0000    0.0810
% 17.0000    0.0720
% 18.0000    0.0670
% 19.0000    0.0780
% 20.0000    0.0750
% 21.0000    0.0500
% 22.0000    0.0420
% 23.0000    0.0350
% 24.0000    0.0350
% 25.0000    0.0240
% 26.0000    0.0170
% 27.0000    0.0060
% 28.0000    0.0030
% 29.0000    0.0020
% 30.0000    0.0010 

% Answer to step 11:
% results =
%
%     4.0000    0.0008
%     5.0000    0.0031
%     6.0000    0.0076
%     7.0000    0.0156
%     8.0000    0.0271
%     9.0000    0.0431
%    10.0000    0.0616
%    11.0000    0.0803
%    12.0000    0.0965
%    13.0000    0.1084
%    14.0000    0.1123
%    15.0000    0.1084
%    16.0000    0.0965
%    17.0000    0.0799
%    18.0000    0.0614
%    19.0000    0.0433
%    20.0000    0.0270
%    21.0000    0.0155
%    22.0000    0.0078
%    23.0000    0.0031
%    24.0000    0.0008

% Answer to step 12: 
% As the number of trials increases, the shape of the histogram "smoothens"
% to more closely resemble the "bell curve" of the binomial distribution.
% 
% This happens because with a small number of trials, a few deviations from
% the expected distribution can look significant. For example, it is not
% unlikely for the 3 out of 10 trials to result in one of the two extreme 
% possible values of the sum, making the probability distribution generated 
% differ significantly from expected (imagine tall spikes at the two 
% extreme ends of what we would expect to be a smooth bell curve). 
% However, it much more unlikely for 30,000 of 100,000 trials to result in 
% extreme-valued sums. In general, with a large number of trials, we can 
% expect the distribution generated to more closely resemble the 
% mathematically accurate distribution.
