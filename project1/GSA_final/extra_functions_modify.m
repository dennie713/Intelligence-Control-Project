function fit=extra_functions_modify(x1,x3,A,dt,F_index,~)
% dim = 2;
% if F_index==00
%     fit = 4.*x.^2-2.1.*x.^4+1/3.*x.^6+x.*y-4.*y.^2+4.*y.^4;
%     disp(fit);
% end
if F_index==100
    y = x1;
    x1 = x1_0 + dx1*dt;
    dx1 = x2;
    dx2 = B*(x1*x4^2-G*sin(x3));
    dx3 = x4;
    dx4 = u;
    yd = A*cos((pi*t)/5);
    fit = y - yd;
end