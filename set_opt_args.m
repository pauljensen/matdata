function [varargout] = set_opt_args(options,varargin)

p = inputParser;
for i = 1 : 2 : length(varargin)
    p.addParamValue(varargin{i},varargin{i+1});
end
p.parse(options{:});
varargout = cell(1,length(varargin)/2);
count = 1;
for i = 1 : 2 : length(varargin)
    varargout{count} = p.Results.(varargin{i});
    count = count + 1;
end
