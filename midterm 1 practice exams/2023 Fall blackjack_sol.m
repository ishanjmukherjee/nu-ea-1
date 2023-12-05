% This program simulates a simple version of the game of Blackjack.
% Aces count as one and the dealer deals from an infinite deck.


clear;

% Dealer's initial hand
card = min(randi(13), 10);
fprintf('The dealer shows %d (and hides one card)\n', card);
dealerTotal = card + min(randi(13), 10);

% Player's initial hand
card1 = min(randi(13), 10);
card2 = min(randi(13), 10);
fprintf('You show %d and hide %d, totaling %d\n', card1, card2, card1+card2);
playerTotal = card1 + card2;

hit = 1;
bust = 0;
while hit && ~bust
    % Player chooses whether or not to hit
    playerHit = input('Hit (1) or stand (0)? ');
    
    % Player hits
    if playerHit ~= 0
        card = min(randi(13), 10);
        playerTotal = playerTotal + card;
        fprintf('You drew a %d, totaling %d\n', card, playerTotal);
        
        % Player busts
        if playerTotal > 21
            bust = 1;
            fprintf('You bust!\n');
            fprintf('Sorry, you lose.\n');
        end
    end
    
    % Dealer's turn if player did not bust
    dealerHit = 0;
    if bust == 0
        % Dealer draws a card if total < 17
        if dealerTotal < 17
            dealerHit = 1;
            card = min(randi(13), 10);
            fprintf('Dealer hits, draws %d\n', card);
            dealerTotal = dealerTotal + card;

            % Dealer busts
            if dealerTotal > 21
                bust = 1;
                fprintf('Dealer total is %d, a bust!\n',dealerTotal);
                fprintf('You win! Hooray!\n');
            end

        % Dealer stands
        else
            dealerHit = 0;
            fprintf('Dealer stands\n');
        end
    end
    
    % Set hit flag to determine whether or not to exit while loop
    hit = playerHit | dealerHit;
end

% Check if both player and dealer stand; if so, compare values
if ~bust
    fprintf('Dealer has %d, you have %d\n', dealerTotal, playerTotal);
    if playerTotal > dealerTotal
        fprintf('You win! Hooray!\n');
    elseif playerTotal < dealerTotal
        fprintf('Sorry, you lose.\n');
    else
        fprintf('You tied!\n');
    end
end
