function [ inRange ] = checkColorRange( y, cb, cr )
    if(cr>150)
        inRange = true;
    else
        inRange = false;
    end
end

