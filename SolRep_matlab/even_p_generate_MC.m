% ref_p.m 
%
% This function generate N uniformly distributed points on the utopia plane
%
% Syntax: [ p ] = even_p_generate_MC( y_up, N)
%
% Input Parameters:
%
%       y_up  -  The anchor points that form the utopia plane
%
% Output Parameters:
%
%       p     -  Reference points on the utopia plane
%
% Author: Yiyi Sha
% Date:	11-Jan-2017
function [ p ] = even_p_generate_MC( y_up , N)
    %% Generate an initial point
    No = size(y_up,1);                % Calculate number of objectives
    ini = rand(1,No);
    ini = ini/sum(ini);
    X0 = ini*y_up;                    % get an initial point on utopia plane

    p = X0;                           % put X0 into p
    
    %% Find the vectors
    V = zeros(1,No);
    for i=1:(No-1)
        Vi = y_up(No,:)-y_up(i,:);
        if norm(Vi) ~=0
            Vi = Vi/norm(Vi);
        end;
        V = [V;Vi];
    end
    V = V(2:No,:);
    

    %% Finding other N-1 points 
    for i=1:(N-1)
        mult = rand(1, No-1);           % uniformly distributed multiplier
        mult = mult/norm(mult);
        D = mult*V;                     % a random direction on utopia plane
        
        %% Finding the limit of lambda
        lambda_l=0;
        lambda_u=0;
        load webPortal_rand2_input
        %load mosql_3obj
        % [X,Y,lambda]
        Nv = size(A,2);
        A = [A,zeros(size(A,1),No+1)];
        Aeq = [Aeq,zeros(size(Aeq,1),No+1)];
        Aeq1 = [f,-eye(No),zeros(No,1)];
        Aeq2 = [zeros(No,Nv),eye(No),-D'];
        Aeq = [Aeq;Aeq1;Aeq2];
        beq = [beq;zeros(No,1);X0'];
        ff = [zeros(1,Nv+No),1];
        intcon = [];
        lb = [zeros(1,Nv),-Inf*ones(1,No),-Inf];
        ub = [ones(1,Nv),Inf*ones(1,No),Inf];
        [X_l,FVAL_l,exitflag_l] = intlinprog(ff,intcon,A,b,Aeq,beq,lb,ub);
        [X_u,FVAL_u,exitflag_u] = intlinprog(-ff,intcon,A,b,Aeq,beq,lb,ub);
        if exitflag_l==1
            lambda_l = FVAL_l;
        end
        if exitflag_u==1
            lambda_u = -FVAL_u;
        end
        
        
        %% randomly choose a new point
        lambda = unifrnd(lambda_l,lambda_u);        
        X0 = X0+lambda*D;
        p = [p;X0];
    end


end

