%% REGULAR LATTICE
n = 100;
k = 5;
RG = regular_network(n,k);
GR = graph(RG);

figure;
plot(GR);
title("Regular network")

p1 = 0.6;
p2 = 0.8;
p3 = 0.9;
p = numedges(GR)*2/(n*(n-1));
%% CASE 1
% Rewiring with p = 0.6

WS1 = watts_strogatz(RG, n, k, p1);
G1 = graph(WS1);
figure;
plot(G1);
title("Watts-Strogatz network with p=0.6")
[C1, l1] = graph_parameters (G1);

%% CASE 2
% Rewiring with p = 0.8 

WS2 = watts_strogatz(RG, n, k, p2);
G2 = graph(WS2);
figure;
plot(G2);
title("Watts-Strogatz network with p=0.8")
[C2, l2] = graph_parameters (G2);

%% CASE 3
% Rewiring with p =0.9

WS3 = watts_strogatz(RG, n, k, p3);
G3 = graph(WS3);    
figure;
plot(G3);
title("Watts-Strogatz network with p=0.9")
[C3, l3] = graph_parameters (G3);

%% ER NETWORK COMPARISON

ER = er_network(n,p);
x = 1:100;

avgCer = mean(ER(:,1));
y1C = C1 * ones(size(x));
y2C = C2 * ones(size(x));
y3C = C3 * ones(size(x));
yavgCer = avgCer * ones(size(x));

figure
scatter(x, ER(:,1));

hold on
line(x, yavgCer);
line(x, y1C);
line(x, y2C);
line(x, y3C);
legend("ER points", "ER avg","p=0.6","p=0.8","p=0.9");
title("Average Clustering coeffecient comparison");
hold off

avgler = mean(ER(:,2));
y1l = l1 * ones(size(x));
y2l = l2 * ones(size(x));
y3l = l3 * ones(size(x));
yavgler = avgler * ones(size(x));

figure
scatter(x, ER(:,2));
hold on
line(x, yavgler);
line(x, y1l);
line(x, y2l);
line(x, y3l);
legend("ER points", "ER avg","p=0.6","p=0.8","p=0.9");
title("Characteristic path length comparison");
hold off

%% REGULAR LATTICE
% Generates adjacency matrix of regular graph with n nodes and 2k
% neighbours for each node

function adj = regular_network(n,k)
    adj = zeros(n);
    for i= 1:n
        for j = 1:n
            if i~=j
                if abs(j-i)<= k
                    adj(i,j) = 1;
                end
                if i<=k
                    if j>=abs(n+i-k)
                        adj(i,j)=1;
                    end
                end
                if i>(n-k)
                    if j<=abs(n-i-k)
                        adj(i,j)=1;
                    end
                end
            end
        end
    end
end

%% WATTS-STROGATZ NETWORK
% Takes in adjanceny matrix of a regular network and rewires it with a
% probability of p

function reg = watts_strogatz(reg, n, k, p)
    for j = 1:k/2
        for i = 1:n
            p_ = rand();
            if p_ < p

                %cutting edge with one of the nearest neighbour
                reg(i, mod(i+j-1,n)+1) = 0; 
                reg(mod(i+j-1,n)+1, i) = 0;

                %assigning new neighbour until you find one which is not
                %already a neighbour
                newneigh = mod(randi(n - 2*k - 1),n)+1;
                while reg(i, newneigh) == 1 || reg(newneigh, i) == 1
                    newneigh = mod(randi(n - 2*k - 1),n)+1;
                end

                %adding new edge
                reg(i, newneigh) = 1;
                reg(newneigh, i) = 1;
            end
        end
    end
end

%% NETWORK PARAMETERS
% Calculates average clustering coeffecient and characteristic path length
% of a given graph

function [C, l] = graph_parameters (G)
    n = numnodes(G);
    A = adjacency(G);
    C = mean(clustering_coefficients(A));
    l = sum(all_shortest_paths(A),"all")/(n*(n-1));
end

%% ER NETWORK 
% Generates 100 ER networks and calculates average clustering
% coeffecient and characteristic path lengths

function ER = er_network(n,p)
    ER = zeros(100,2);
    for i = 1:100
        Ger = graph(erdos_reyni(n, p));
        [ER(i,1), ER(i,2)] = graph_parameters(Ger);
    end
end