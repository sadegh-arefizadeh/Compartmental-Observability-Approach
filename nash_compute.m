function [ nash ] = nash_compute( W,B,F)
  n=length(W);
  MM=eye(n)-(eye(n)-W)*F;
  qq=-1*B;
  nash=LCP(MM,qq);

end

