% Homework Program 1
%
% Name:     Mukherjee, Ishan
% Date:     09/29/2023

% Get user input for value of N and d
N = input("Hyperlink matrix size: ");
d = input("Damping factor: ");

% Returns an N x N array containing random integers between 0 and 1, both
% inclusize (so, either 0 or 1)
A = randi([0 1],N,N);
% Counting from left to right and top to bottom, replaces every (N+1)th
% element with 0 (making every element in the main diagonal 0)
A(1:N+1:end) = 0;
% Divide each column by the sum of its entries, or if the column is all
% zeros then keep it all zeros by dividing by 1
H = A./max(1,sum(A,1));

% Create an identity matrix of the proper size
I = eye(N);
% Create a vector of ones of the proper size
one = ones(N,1);

% Solve the PageRank problem and store the results in a vector r
r = (I-d*H)\((1-d)*one);

% Create a vector containing the number of incoming links to each page 
links_incoming = sum(H>0,2);
% *** Create a vector containing the number of outgoing links from each page ***
links_outgoing = sum(H>0,1);

% Create a results matrix with the following columns:
%   1: page numbers
%   2: ranks
%   3: number of outgoing links
%   4: number of incoming links
results = [[1:N]', r, links_outgoing', links_incoming];

% Sort the rows of the results matrix by the ranks in descending order.  
% Look at the documentation of the "sortrows" function.
results_sorted = sortrows(results, 2, "descend"); 

% Print the results to the screen.
fprintf('The rank of page %i is %.2f, with %i outgoing links and %i incoming links\n',results_sorted')

% Plot the number of outgoing and incoming links on a single plot, vs
% the rank of the corresponding page (i.e. the ranks should be on the 
% x-axis, and the number of links should be on the y-axis.  Use
% the sorted results matrix, so you can see if there is a correlation
% between the rank and either of the metrics.
plot(results_sorted(:,2), results_sorted(:,3), results_sorted(:,2), results_sorted(:,4));

% Label the axes. 
xlabel("Rank");
ylabel("Outgoing and incoming links");


% Create a legend.
legend("outgoing links", "incoming links")


% Answers:
% 3(a): No. The rank of a page is unaffected by the number of outgoing
% links from that page.
% 3(b): Yes. The rank of a page tends to increase with the number of
% incoming links to that page.
%
% 4(a): 2
% 4(b): 1
% 4(c): 0.7874
