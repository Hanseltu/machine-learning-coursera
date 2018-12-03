% NCGOP.m 
%
% This function performs the Normal Constraint Generic Optimization Problem
% for Point P_k
%
% Syntax: [y] = NCGOP(f,A,Aeq,b,beq,y_up,p_k,y_ub,y_lb)
%
% Input Parameters:
%
%       f     -   The objective functions
%       A     -   The linear inequality constraint matrix
%       b     -   The linear inequality constraint vector
%       Aeq   -   The linear equality constraint matrix 
%       beq   -   The linear equality constraint vector
%       p_k   -   The reference point on Utopia Plane
%       y_up  -   The anchor points
%       y_ub  -   The upper bound of objectives
%       y_lb  -   The lower bound of objectives
%
% Output Parameters:
%
%       
%
% Author: Yiyi Sha
% Date:	11-Jan-2017


function [ y,x,fCWMOIP] = NCGOP( f,A,Aeq,b,beq,y_up,p_k,y_ub,y_lb )

No = size(f,1);                                        % Calculate the number of objectives
Nv = size(A,2);                                        % Calculate the number of variables

AA = [A;f(1:No-1,:)];                                        % add constraints
bb = [b;p_k(1:No-1,:)];

lb = zeros(1,Nv);                                      % Lower and upper bound of variables
ub = ones(1,Nv) ;
intcon = 1: Nv;


% calculate new objective function with CWMOIP

ff = f(No,:);
for i=1:(No-1)
    i = No-i;
    w = 1/(y_ub(i,1)-y_lb(i,1)+1);
    ff = ff + w*f(i,:);
end


[X,FVAL,Exitflag] = intlinprog (ff,intcon,AA,bb,Aeq,beq,lb,ub);
y = zeros(1,No);
x = zeros(1,Nv);
if Exitflag==1
    X = round(X);
    y = [y;(f*X)'];
    x = [x;X'];
    fCWMOIP = FVAL;
end

end

