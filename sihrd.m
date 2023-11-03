function s = sihrd(steps, s_init, param, deter)
%sihrd Returns a matrix of state vectors and plots states of the SIHRD
%model over time.
% s = sihrd(steps, s_init, param, deter) returns the matrix of (steps-1) 
% state vectors generated by updating the state vector represented by 
% s_init, using the transition probabilities in param, while taking account
% of deterrence strategy represented by deter.

% Input validators
arguments
    steps (1,1) {mustBePositive, mustBeInteger}
    s_init (5,1) {mustBeNonnegative}
    param (1,:) {mustBeInRange(param, 0, 1), mustHaveLength(param, 6)}
    deter (1,:) {mustBeInRange(deter,0,1), mustHaveLength(deter,steps)} = ones(1, steps)
end

% Naming p(susceptible -> infected), p(infected -> hospitalized), etc from
% the parameters array.
p_SI = param(1)*deter(1);
p_IH = param(2);
p_IR = param(3);
p_HR = param(4);
p_RS = param(5);
p_HD = param(6);

% Displaying parameters
param_str = ["p_SI", "p_IH", "p_IR", "p_HR", "p_RS", "p_HD"];
fprintf("The parameters are:\n");
fprintf("%s: %.4f\n", [param_str; param]);

% Displaying initial state probabilities
state_str = ["S", "I", "H", "R", "D"];
fprintf("The initial state probabilites are:\n");
fprintf("%s: %.4f\n", [state_str; s_init']);

% Preallocating s
s = zeros(length(s_init), steps);

% Filling first column of s with s_init values
s(:, 1) = s_init;

% Initializing transition matrix according to values given in problem
% statement
P = [1-p_SI*s_init(2), p_SI*s_init(2), 0, 0, 0;
    0, 1-p_IR-p_IH, p_IH, p_IR, 0;
    0, 0, 1-p_HR-p_HD, p_HR, p_HD;
    p_RS, 0, 0, 1-p_RS, 0;
    0, 0, 0, 0, 1];

% Filling s with (steps-1) state vectors
for ii = 2:steps
    % Updating ii-th column on the basis of (ii-1)-th column
    s(:, ii) = P' * s(:, ii-1);
    
    % Updating transition matrix to account for updated state vector
    P(1, [1 2]) = [1-p_SI*deter(ii)*s(2, ii), p_SI*deter(ii)*s(2, ii)];
end

% First subplot showing infected, hospitalized and deceased over time
subplot(2,1,1);
plot((1:steps)', s([2 3 5], :)');
xlabel("Time");
ylabel("Probability");
legend("Infected", "Hospitalized", "Deceased");

% Second subplot showing susceptible and recovered over time
subplot(2,1,2);
plot((1:steps)', s([1 4], :)');
xlabel("Time");
ylabel("Probability");
legend("Susceptible", "Recovered");

% Title for figure
sgtitle("Markov Chains");

end

% Custom validating function provided in the problem statement.
function mustHaveLength(x,L)
if length(x) ~= L
    eid = 'Size:badLength';
    msg = 'The input length is \%u but it should be \%u.';
    error(eid,msg,length(x),L);
end
end

% Answers to text questions
% Q: What is the maximum percentage of the population that is hospitalized? 
% A: About 1.2% for this specific example.
%
% Q: Why do the infection and hospitalized states have hump-shaped
% trajectories?
% A: The number of infected and hospitalized people initially increases 
% rapidly (seen as the steep, first part of the hump), since the rate of 
% infection (which leads to hospitalization) depends on the number of 
% infected people, causing a positive feedback loop.  
% However, the system exits from infection into recovery (an absorbing state
% for the given parameters) or into hospitalization, which leads to
% recovery or death (another absorbing state). As the probability of being
% in an absorbing state increases over time, the probability of being in
% infected or hospitalized states reduces, leading to the tapering off,
% latter part of the hump.
%
% Q: Why is s_D always increasing?
% A: D is an absorbing state, since the only state the system can exit to 
% from D is D itself.
%
% Q: Change p_SI to 0.1 and rerun the example. Why does the percentage of 
% the population that remain susceptible (that is, never get the disease) 
% decrease?
% A: If the probability of getting infected increases, the probability that
% the average member of the population never gets the disease decreases.
% Consequently, the fraction of the population that is lucky enough never
% to get the disease also decreases.
%
% Q: Does the model show that deterrence measures always help?
% A: No, prolonging M (ie, days of strong deterrence) cannot prevent a
% second wave, only delay it. The number of deaths also remains unaffected.
%
% Q: What may help to mitigate the second wave shown that is not captured 
% in the model?
% A: Vaccinations can permanently reduce p_SI, unlike the deterrence
% measures modeled in this assignment that lower p_SI for only a few days.
% This can be seen by executing sihrd() with
% deter = [ones(1, time_to_develop_vaccc),
% vacc_efficacy * ones(1, steps-time_to_develop_vacc)], which results in a
% consistent reduction in infections (no second wave).
% During the time bought before a second wave by deterrence measures,
% vaccinations may be done to prevent a second wave.