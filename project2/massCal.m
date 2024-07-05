function [M]=massCal(fit,min_flag)
Fmax=max(fit); Fmin=min(fit); Fmean=mean(fit); 
N = size(fit,1);
if Fmax==Fmin
    M=ones(N,1);
else 
   if min_flag==1 %for minimization eq. 19¡B20
      best=Fmin;worst=Fmax; 
   else %for maximization
      best=Fmax;worst=Fmin; 
   end
   M=(fit-worst)./(best-worst); %eq.15,
end
M=M./sum(M); %eq. 16.