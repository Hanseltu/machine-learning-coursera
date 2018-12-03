clear all

tic
%% 1. Parameters Setting
No = 4;    % Number of objective functions
Nv = 43;   % Number of variables

%% 2. Initialization
load webPortal_rand2_input
%% parameters in  webPortal_rand2_input
%       f  -   The objective functions, f[1] is cost coefficient, f[2] is feature diversity coefficient, f[3] is feature used-before coefficient, f[4] is defect coefficient 
%       A  -   The the linear inequality constraint matrix converted from
%       the TCs and CTCs
%       b  -   The the linear inequality constraint vector converted from
%       the TCs and CTCs
%       Aeq  -   The the linear equality constraint matrix converted from
%       the TCs and CTCs
%       beq  -   The the linear equality constraint vector converted from
%       the TCs and CTCs






%% 3. Calculate the Utopia Plane
[x_up,y_up,y_ub,y_lb] = utopia_plane(f,A,Aeq,b,beq);


%% 4. Generate a set of evenly distributed points on the utopia plane
% Monte Carlo method to generate N reference points on utopia plane
N = 1000;                              % Generate N reference points 
[ p ] = even_p_generate_MC( y_up , N );

% original NC method, without enlarging utopia plane
m = 6;
%[ p ] = even_p_generate1( y_up,m);


%% 5. Generate nondominated solutions for each reference point p
sols = zeros(1,No);
p = p(:,1:No);
for i=1:size(p,1)
    p_k = p(i,:);
    [ y,x ] = SolRep(f,A,Aeq,b,beq,y_up,p_k',y_ub,y_lb);
    if size(y,1)>1
        %sol = [y(2:size(y,1),:),p_k];
        %sols = [sols;sol];
        sols = [sols;y];
        sols = unique(sols,'rows');
    end
end

sols=sols(2:size(sols,1),:);

%% 6. Time
time=toc;
