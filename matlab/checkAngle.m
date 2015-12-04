function [ inRange ] = checkAngle(angle)
    if(angle>80*pi/180 )
        inRange = true;
    else
        inRange = false;
    end
end

