classdef Index
    
properties
    keys
    name = []
end

methods
    function [index] = Index(type,vals)
        switch type
            case 'default'
                index.keys = 1 : vals;
            case 'numeric'
                index.keys = vals;
            case 'char'
                index.keys = vals;
        end
    end
    
    function [tf] = isnumeric(obj)
        tf = isnumeric(obj.keys);
    end
    
    function [n] = length(obj)
        n = length(obj.keys);
    end
    
    function [loc] = idxof(obj,key)
        [~,loc] = ismember(key,obj.keys);
    end
    
    function [str] = disp_key(obj,key)
        if isnumeric(obj)
            str = num2str(key);
        else
            str = key;
        end
    end
end

end
