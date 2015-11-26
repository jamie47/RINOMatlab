function startup(varargin)
%STARTUP Initialize runtime environment.
%
% SYNOPSIS
%
%   json.startup(optionName, optionValue, ...)
%
% The function internally adds dynamic java class path. This process clears
% any matlab internal states, such as global/persistent variables or mex
% functions. To avoid unexpected state reset, execute this function once before
% using other json API functions.
% 
% OPTIONS
%
% The function takes a following option.
%
%   'WarnOnAddPath'   Warn when javaaddpath is internally called. Default false.
%
% EXAMPLE
%
%   >> json.startup
%
% See also javaaddpath javaclasspath



  jar_file = fullfile(fileparts(mfilename('fullpath')), 'java', 'json.jar');
  if ~any(strcmp(jar_file, javaclasspath))
    javaaddpath(jar_file);
  end
end