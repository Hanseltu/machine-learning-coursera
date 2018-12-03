% utopia_plane.m 
%
% This function calculate the utopia plane of the original problem
%
% Syntax: [x_up,y_up, y_ub] = utopia_plane(f,A,Aeq,b,beq)
%
% Input Parameters:
%
%       f     -   The objective functions
%       A     -   The linear inequality constraint matrix
%       b     -   The linear inequality constraint vector
%       Aeq   -   The linear equality constraint matrix 
%       beq   -   The linear equality constraint vector 
%
% Output Parameters:
%
%       x_up  -   The variables for anchor points
%       y_up  -   The anchor points
%
% Author: Yiyi Sha
% Date:	11-Jan-2017

function [ x_up,y_up, y_ub, y_lb ] = utopia_plane( f,A,Aeq,b,beq )

No = size(f,1);                                        % Calculate the number of objectives
Nv = size(A,2);                                        % Calculate the number of variables
lb = zeros(1,Nv);                                      % Lower and upper bound of variables
ub = ones(1,Nv) ;
intcon = 1: Nv;
for i=1:No
    ff = f(i,:);
    X = intlinprog (ff,intcon,A,b,Aeq,beq,lb,ub);
    X2 = intlinprog (-ff,intcon,A,b,Aeq,beq,lb,ub);
    X = round(X);
    X2 = round(X2);
    y = (f*X)';
    y1 = ff*X;
    y2 = ff*X2;
    if i==1
        x_up = X';
        y_up = y;
        y_lb = y1;
        y_ub = y2;
    else
        x_up = [x_up;X'];
        y_up = [y_up;y];
        y_lb = [y_lb;y1];
        y_ub = [y_ub;y2];
    end
end        


end

