function G = Gconstant(iter,max_iter)
%p41重力公式參數
alpha = 20;
G0 = 100;
G=G0*exp(-alpha*iter/max_iter);