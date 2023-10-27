% EA 1, Homework program assignment 3
%
% Name:     Mukherjee, Ishan
% Date:     10/12/2023
% Grade:    100%

% Data hygiene
clear; clc;

% Loop keeps prompting the user for budget input until internally broken.
while true
    budget = input("Intial budget (>1): ");
    % If inputted budget is at least 1, break out of the loop.
    if budget >= 1
        break
    end
    % If the above condition isn't satisfied, print error message and
    % restart the loop to prompt the user again.
    warning("Budget must be at least 1");
end

% Initialize values.
num_racers = 4;
budget_cap = 2*budget;

% Initialize bet and budget record (to be displayed after the game).
bet_record = [];
budget_record = [];

% Loop controlling the betting cycle is internally broken if budget drops
% below the minimum or above the cap, or if player terminates the game.
while true
    % Create an array of randomly generated mean times.
    mean_times = rand(1,num_racers) .* 2 + 1;

    % Create an array containing odds for each contestant.
    inv_time = 1 ./ mean_times; % Equivalent to inv_time = ones(1, num_racers) ./ mean_times
    prob_win = inv_time ./ sum(inv_time);
    odds =  1./ prob_win;

    % Display odds.
    fprintf("Contestant odds:\n");
    disp(odds);

    % Get bets input.
    % Loop keeps prompting the user for bets input until internally broken.
    while true
        bets = input("Input bets:\n");

        % Determine if the number of bets equals the number of contestants.
        % First, check if the inputted bets matrix has only 2 dimensions. Next,
        % check if it has only 1 row and as many columns as there are
        % contestants.
        if size(size(bets), 2) == 2 & size(bets, 1) == 1 & size(bets, 2) == num_racers
            % If the inputted bets are within budget and are each nonzero,
            % break out of the loop.
            if sum(bets) < budget && min(bets) >= 0 % While these conditions could be in the parent if, I've put them here for readability
                break;
            end
        end
        % If not, print an error message and restart the loop.
        warning("Bets are invalid. Try again...");
    end

    % Display user-entered bets
    fprintf("The bets are:\n");
    disp(bets);

    % Calculate contestant times.
    times = - mean_times .* log(rand(1, num_racers));

    % Display contestant times.
    fprintf("The times are:\n");
    disp(times);

    % Determine winner.
    [~, winner] = min(times);

    % Display winner.
    fprintf("The winner is contestant number %i\n", winner);

    % Update and display the budget.
    budget = budget + odds(winner) * bets(winner) - sum(bets);
    fprintf("Your budget is now $%.2f\n",budget);
    
    % Update bet and budget record.
    bet_record(end+1) = sum(bets);
    budget_record(end+1) = budget;
    
    % Stop the betting if the budget is too low or too high.
    if budget < 1
        fprintf("Your budget is less than the minimum bet.\n");
        break;
    elseif budget >= budget_cap
        fprintf("Congratulations, you exceeded your cap!\n");
        break;
    
    % If not, ask the user if betting is to be continued.
    else
        % Continue prompting the user until they input 1 or 0.
        while true
            cont = input("Continue? (1=y, 0=n) ");
            if cont == 1 | cont == 0
                break;
            end
            warning("Enter 1 or 0.");
        end
        
        % If player chooses to terminate the game, break out of the loop.
        if cont == 0
            break;
        end
    end
end

% Print summary of the game (ie, bet and budget after each race).
for ii = 1:length(bet_record)
    fprintf("Race %i: bet $%.2f, budget $%.2f\n", ii, bet_record(ii), budget_record(ii))
end

% Output for outcome 1: budget drops below one
% Intial budget (>1): 10
% Contestant odds:
%     3.0930    7.4534    2.5728    6.5000
% 
% Input bets:
% [0 9.99 0 0]
% The bets are:
%          0    9.9900         0         0
% 
% The times are:
%     0.2448    0.4116    2.4947    2.3378
% 
% The winner is contestant number 1
% Your budget is now $0.01
% Your budget is less than the minimum bet.
% Race 1: bet $9.99, budget $0.01

% Output for outcome 2: cap exceeded
% Intial budget (>1): 10
% Contestant odds:
%     4.5474    4.7178    2.9180    4.4359
% 
% Input bets:
% [2 2 1 2]
% The bets are:
%      2     2     1     2
% 
% The times are:
%     1.0231    4.5580    3.3038    1.6431
% 
% The winner is contestant number 1
% Your budget is now $12.09
% Continue? (1=y, 0=n) 1
% Contestant odds:
%     6.0988    3.5111    4.5342    3.0241
% 
% Input bets:
% [0.5 2.25 1 2.75]
% The bets are:
%     0.5000    2.2500    1.0000    2.7500
% 
% The times are:
%     0.8350    2.2961    1.4788    0.5182
% 
% The winner is contestant number 4
% Your budget is now $13.91
% Continue? (1=y, 0=n) 1
% Contestant odds:
%     5.4593    5.7277    4.1103    2.5066
% 
% Input bets:
% [1 1 1.75 2.5]
% The bets are:
%     1.0000    1.0000    1.7500    2.5000
% 
% The times are:
%     5.2905    3.9597    0.3634    1.7490
% 
% The winner is contestant number 3
% Your budget is now $14.85
% Continue? (1=y, 0=n) 1
% Contestant odds:
%     5.2334    2.9607    5.6913    3.3846
% 
% Input bets:
% [1 2.75 1 2.25]
% The bets are:
%     1.0000    2.7500    1.0000    2.2500
% 
% The times are:
%     4.2757    2.0551    1.3848    1.2717
% 
% The winner is contestant number 4
% Your budget is now $15.47
% Continue? (1=y, 0=n) 1
% Contestant odds:
%     3.2360    5.0567    4.1236    3.9886
% 
% Input bets:
% [3.33 0.5 2.33 2.33]
% The bets are:
%     3.3300    0.5000    2.3300    2.3300
% 
% The times are:
%     0.1472    3.3333    0.6037    0.5936
% 
% The winner is contestant number 1
% Your budget is now $17.76
% Continue? (1=y, 0=n) 1
% Contestant odds:
%     4.9429    5.9948    3.2329    3.1099
% 
% Input bets:
% [2.25 1.25 3.25 3.25]
% The bets are:
%     2.2500    1.2500    3.2500    3.2500
% 
% The times are:
%     1.1153    0.5329    0.0786    2.2612
% 
% The winner is contestant number 3
% Your budget is now $18.26
% Continue? (1=y, 0=n) 1
% Contestant odds:
%     5.4673    4.9587    2.6185    4.2821
% 
% Input bets:
% [0.25 2 4.25 2.5]
% The bets are:
%     0.2500    2.0000    4.2500    2.5000
% 
% The times are:
%     3.8885    0.4465    1.1951    1.0676
% 
% The winner is contestant number 2
% Your budget is now $19.18
% Continue? (1=y, 0=n) 1
% Contestant odds:
%     3.0533    5.0547    3.4997    5.2937
% 
% Input bets:
% [3.75 1.5 3.25 1.5]
% The bets are:
%     3.7500    1.5000    3.2500    1.5000
% 
% The times are:
%     0.4955    0.6395    1.2166    5.7221
% 
% The winner is contestant number 1
% Your budget is now $20.63
% Congratulations, you exceeded your cap!
% Race 1: bet $7.00, budget $12.09
% Race 2: bet $6.50, budget $13.91
% Race 3: bet $6.25, budget $14.85
% Race 4: bet $7.00, budget $15.47
% Race 5: bet $8.49, budget $17.76
% Race 6: bet $10.00, budget $18.26
% Race 7: bet $9.00, budget $19.18
% Race 8: bet $10.00, budget $20.63

% Output for outcome 3: program is terminated, first vector of bets is
% entered incorrectly
% Intial budget (>1): 10
% Contestant odds:
%     2.9390    5.0283    3.6025    5.4560
% 
% Input bets:
% [10 10 10 10]
% Warning: Bets are invalid. Try again... 
% Input bets:
% [1 1 1 1]
% The bets are:
%      1     1     1     1
% 
% The times are:
%     2.5905    3.4648    3.5902    5.6273
% 
% The winner is contestant number 1
% Your budget is now $8.94
% Continue? (1=y, 0=n) 0
% Race 1: bet $4.00, budget $8.94
