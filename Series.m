classdef Series < handle

properties
    index
end

properties (Access = private)
    data
end

properties (Dependent, SetAccess = private)
    keys
end

methods

    function [series] = Series(data,varargin)
        [index,default] = set_opt_args(varargin, ...
                                       'index',[], ...
                                       'default',NaN);
        N = length(data);
        if isempty(index)
            series.index = Index('default',N);
        elseif isnumeric(index)
            series.index = Index('numeric',index);
        else
            series.index = Index('char',index);
        end
        
        indexN = length(series.index);
        
        if isempty(data)
            if isnumeric(default)
                series.data = repmat(default,indexN,1);
            else
                series.data = cell(indexN,1);
                for i = 1 : indexN
                    series.data{i} = default;
                end
            end
        else
            series.data = data;
        end

    end
    
    function [tf] = isnumeric(obj)
        tf = isnumeric(obj.data);
    end
    
    function [ks] = get.keys(obj)
        ks = obj.index.keys;
    end
    
%     function [val] = subsref(obj,S)
%         switch S.type
%             case '()'
%                 idx = obj.index.idxof(S.subs);
%                 if isnumeric(obj)
%                     val = obj.data(idx);
%                 else
%                     val = obj.data{idx};
%                 end
%             case '.'
%                 val = obj.(S.subs);
%         end
%     end

    function [val] = get(obj,key)
        idx = obj.index.idxof(key);
        if isnumeric(obj)
            val = obj.data(idx);
        else
            val = obj.data{idx};
        end
    end

    function disp(obj)
        for i = 1 : length(obj.keys)
            key = obj.keys{i};
            disp_key = obj.index.disp_key(key);
            if isnumeric(obj)
                disp_val = num2str(obj.get(key));
            else
                disp_val = obj.get(key);
            end
            fprintf('    %s  %s\n',disp_key,disp_val);
        end
        fprintf('\n');
    end
    
    function [val] = subsref(obj,varargin)
        varargin{:}
        val = [];
    end
    
end

end
    
