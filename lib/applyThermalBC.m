function [M,b] = applyThermalBC(M,b,k,H_BC,G_base,T_atm,T_m,...
                                north,south,east,west,m,n,nT,dy,dz)
%Applies boundary conditions to the ice stream thermal model

%North (fixed-value)
BCn = [north,...
       T_atm*ones(length(north),1)];
%BCd: [[node numbers], [nodal values]]
[M,b] = applyDirichlet(M,b,BCn);

%South (Robin/Neumann)
if (n == nT) %w/o till
    BCs = [south,...
           (1./k(1:m)).*(1-H_BC) + 1e-100,...
           k(south),...
           H_BC,...
           (T_m+0.01 - G_base(1:m)./k(1:m)).*H_BC + G_base(1:m)./k(1:m)];
    %BCr: [[node numbers], [a], [mu], [b], [c]]
    [M,b] = applyRobin(M,b,BCs,m,dz);
elseif (n~= nT) %w/ till
    BCs = [south,...
           ones(m,1),...
           k(south),...
           zeros(m,1),...
           H_BC.*G_base];
    %BCr: [[node numbers], [a], [mu], [b], [c]]
    [M,b] = applyRobin(M,b,BCs,m,dz);
end

%East (symmetry)
BCe = [east,...
       ones(length(east),1),...
       k(east),...
       sparse(length(east),1),...
       sparse(length(east),1)];
%BCr: [[node numbers], [a], [mu], [b], [c]]
[M,b] = applyRobin(M,b,BCe,-1,dy);

%West (symmetry)
BCw = [west,...
       ones(length(west),1),...
       k(west),...
       sparse(length(west),1),...
       sparse(length(west),1)];
%BCr: [[node numbers], [a], [mu], [b], [c]]
[M,b] = applyRobin(M,b,BCw,1,dy);

end

