function [down_x,down_y,up_x,up_y,dim]=extra_functions_range_modify(F_index)
dim = 2;
if F_index==00
    down_x = -1;up_x = 0.75;
    down_y = -1;up_y = 1;
end