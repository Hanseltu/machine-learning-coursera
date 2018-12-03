% the original normal onstraint method, without enlarging the utopia plane
function [ d ] = even_p_generate1( y_up,m )
d = zeros(1,4);
for i1=0:m  
    for i2=0:m        
        for i3=0:m         
            for i4=0:m 
                if i1+i2+i3+i4 == m
                    dd = 1/m*[i1,i2,i3,i4]*y_up;
                    d = [d;dd];
                end
            end
        end
    end
end


end

