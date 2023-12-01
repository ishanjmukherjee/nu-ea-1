%% FUNCTION Approximates signal
function [coeffs, sig_approx, approx_error] = approx_pulse(sig, n, f0)
%approx_pulse Approximates a given pulse train using cosine terms

arguments
    sig (:,1)
    n (1,1) {mustBePositive, mustBeInteger}
    f0
end

% Make design matrix
T = length(sig);
F = zeros(T, n+1);
for row = 1:T
    for col = 1:(n+1)
        F(row, col) = cos(2*pi*f0*(col-1)*row);
    end
end

% Solve least-squares
coeffs = (F' * F) \ (F' * sig);

% Find approximate signal
sig_approx = F * coeffs;

% Find approximation error
approx_error = sum((sig-sig_approx).^2);

% Display results
fprintf("Approximate signal = %.2f", coeffs(1));
for ii = 1:n
    fprintf(" + %.2f cos (2 * pi * %i * f0 * k)", coeffs(ii+1), ii)
end
fprintf("\n\n");
fprintf("The approximation error is %.6f\n", approx_error);

end

%% FUNCTION Generates pulse train
function [pulse_train, f0] = gen_pulse_train(off, on, cycles)
%gen_pulse_train Generates an on/off pulse train
% One pulse is off many zeros, on many ones, then off many zeros.
% The pulse train is one pulse repeated cycles many times.

arguments
    off (1,1) {mustBePositive, mustBeInteger}
    on (1,1) {mustBePositive, mustBeInteger}
    cycles (1,1) {mustBePositive, mustBeInteger}
end

one_pulse = [zeros(1,off) ones(1,on) zeros(1,off)];
pulse_train = repmat(one_pulse, 1, cycles);
f0 = 1/length(one_pulse);

end

%% SCRIPT to compute approximation error for n = 1:30
% Storing upper limit of terms to try
n = 30;

% Generating square pulse train
[pulse_train,f0] = gen_pulse_train(80,40,4);

% Preallocating approximate signal and error vectors
sig_approx = zeros(n,length(pulse_train));
over_err = zeros(n,1);
under_err = zeros(n,1);
app_err = zeros(n,1);

% Iterating for j terms, j = 1, ..., n
for ii = 1:n
    [~,app,err] = approx_pulse(pulse_train,ii,f0);
    sig_approx(ii,:) = app;
    app_err(ii) = err;
    over_err(ii) = max(sig_approx(ii,:)-1);
    under_err(ii) = max(-sig_approx(ii,:));
end

% Plotting to find maximum overshoot
terms = 5;
figure;
hold on;
plot(1:length(pulse_train),pulse_train);
plot(1:length(sig_approx(terms,:)),sig_approx(terms,:));

% Displaying the three errors as column vectors
fprintf(" Least Squares Error         Overshoot Error         Undershoot Error\n");
for ii = 1:n
    fprintf("%10.6f                  %10.6f              %10.6f\n", app_err(ii), over_err(ii), under_err(ii));
end

%% TEXT ANSWERS
% Omitting terms
% Every fifth term can be ommitted since its leading coefficient is zero, 
% making the entire term zero. We can also verify by looking at the errors 
% table below that every fifth approximation has the same error as the one 
% before it (ie, no increase in accuracy).

% Where does the maximum overshoot occur for n = 5?
% Middle of each narrow pulse

% Where does the maximum overshoot occur for increasing n?
% The maximum overshoot occurs closer and closer to the edge for increasing
% n.

%% ERRORS
%  Least Squares Error         Overshoot Error          Undershoot Error
%  72.000240                   -0.425835                0.174165
%  35.366009                   -0.123204                0.160457
%  19.097525                    0.078467                0.120844
%  15.606173                    0.171893                0.063496
%  15.606173                    0.171893                0.063496
%  14.059574                    0.109712                0.102093
%  11.091146                    0.039716                0.117439
%   8.824082                    0.078851                0.101152
%   8.141807                    0.118130                0.072197
%   8.141807                    0.118130                0.072197
%   7.688109                    0.086100                0.095421
%   6.693855                    0.062662                0.106716
%   5.850221                    0.081688                0.095133
%   5.573629                    0.103891                0.074872
%   5.573629                    0.103891                0.074872
%   5.363999                    0.081952                0.090749
%   4.880563                    0.069154                0.099395
%   4.451916                    0.081420                0.090475
%   4.305896                    0.098444                0.076965
%   4.305896                    0.098444                0.076965
%   4.188003                    0.083148                0.089104
%   3.908868                    0.067620                0.089256
%   3.655477                    0.080608                0.087675
%   3.567318                    0.093617                0.076853
%   3.567318                    0.093617                0.076853
%   3.493520                    0.081714                0.086755
%   3.316050                    0.070428                0.088077
%   3.152657                    0.070672                0.075561
%   3.095074                    0.082381                0.069454
%   3.095074                    0.082381                0.069454
