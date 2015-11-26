function [ output ] = get( object )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

MatlabStruct=rino.load(object);
output=MatlabStruct.data;

end

