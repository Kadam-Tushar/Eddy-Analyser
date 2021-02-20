function [M] = nbrOperation(M,fil)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
M = (filter2(fil,M) > 0);
end

