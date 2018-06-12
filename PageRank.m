
%% PageRank Algorithm to Rank Websites

% This example shows how to use a PageRank algorithm to rank a collection
% of websites. Although the PageRank algorithm was originally designed to
% rank search engine results, it also can be more broadly applied to the
% nodes in many different types of graphs. The PageRank score gives an
% idea of the relative importance of each graph node based on how it is
% connected to the other nodes.
%
 
 

%%  Step 1 load the adjacent matrix; 
load('webpages.mat', 'A','U') ;
spy(A)
val = full(A);
%  normalize this matrix

adjMat=zeros(100,100);
for i=1:100
    for j=1:100
        if val(i,j)~=0
            adjMat(i,j)=1/sum(val(i,:));
        else
            adjMat(i,j)=0;
        end
    end
end
A=adjMat;
% visualize the graph 
% Create a directed graph with the sparse adjacency matrix, |A|, using the
% URLs contained in |U| as node names.
G = digraph(A,U);
% Plot the graph using the force layout.
plot(G,'NodeLabel',{},'NodeColor',[0.93 0.78 0],'Layout','force');
title('Entire network of Websites'); 

%% step 2: Compute the PageRank scores for the graph, |G|, using 200 iterations and
% a damping factor of |0.85|. 
pr=ones(length(U),1); % initial ranks 

% update ranks according to adjacent matrix; 
e=ones(length(U),1);
for iter=1:200
    
    pr=(1-0.85)*e+0.85*A'*pr; 
end

% you might compare your results with this line: pr = centrality(G,'pagerank','MaxIterations',200,'FollowProbability',0.85);
 
%% step 3: visualize the webaites with higher rank. 

% Extract and plot a subgraph containing all nodes whose score is greater
% than half of the maximal rank value. Color the graph nodes based on their PageRank score.
H = subgraph(G,find(pr > 0.5*max(pr(:))));
figure, plot(H,'NodeLabel',{},'Layout','force');
title('high-ranked Websites')
colorbar



