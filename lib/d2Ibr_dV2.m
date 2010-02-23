function [Gaa, Gav, Gva, Gvv] = d2Ibr_dV2(Ybr, V, lam)
%D2IBR_DV2   Computes 2nd derivatives of complex branch current w.r.t. voltage.
%   [Gaa, Gav, Gva, Gvv] = d2Ibr_dV2(Cbr, Ybr, V, lam) returns 4 matrices
%   containing the partial derivatives w.r.t. voltage angle and magnitude
%   of the product of a vector lam with the 1st partial derivatives of the
%   complex branch currents. Takes sparse branch admittance matrix Ybr,
%   voltage vector V and nl x 1 vector lam. Output matrices are sparse.
%
%   e.g [Ybus, Yf, Yt] = makeYbus(baseMVA, bus, branch);
%       Ybr = Yf;
%
%   Gaa = (d/dVa (dIbr_dVa.')) * lam
%   Gav = (d/dVm (dIbr_dVa.')) * lam
%   Gva = (d/dVa (dIbr_dVm.')) * lam
%   Gvv = (d/dVm (dIbr_dVm.')) * lam

%   MATPOWER
%   $Id$
%   by Ray Zimmerman, PSERC Cornell
%   Copyright (c) 2008 by Power System Engineering Research Center (PSERC)
%   See http://www.pserc.cornell.edu/matpower/ for more info.

%% define
nb = length(V);

diaginvVm = sparse(1:nb, 1:nb, ones(nb, 1)./abs(V), nb, nb);

Gaa = sparse(1:nb, 1:nb, -(Ybr.' * lam) .* V, nb, nb);
Gva = -1j * Gaa * diaginvVm;
Gav = Gva;
Gvv = sparse(nb, nb);