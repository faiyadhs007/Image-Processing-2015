%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function [CMYK_final,error] = nearest_vertex(CMY_vector,type)

%% Necessary Parameters
C = CMY_vector(1,1,1); M = CMY_vector(1,1,2); Y = CMY_vector(1,1,3);
error = zeros(1,1,3); value = 1/2;
CMYK_final = zeros(1,1,3);

%% 6 cases to considered
switch (type)
    case 'CMYW'
        if (C <= value)
        if (M <= value)
            if (Y <= value)
                % W
                CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 0;
            elseif (Y > value)
                % Y
                CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 1;
            end
        elseif (M > value)
            % M
                CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 0;
        end
        elseif(C > value)
        % C
            CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 0;
        end
    case 'MYGC'
        if (M <= value)
        if (Y > value)
            if (C <=value)
                % Y
                CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 1;
            elseif (C > 0.5)
                % G
                CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 1;
            end
        elseif (Y <= value)
            % C
            CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 0;
        end
    elseif (M > value)
        % M
        CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 0;
        end
    case 'RGMY'
        if(Y <= value)
        % M
        CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 0;
    elseif(Y > value)
        if (M > value)
            % R
            CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 1;
        elseif (M <= value)
            if (C <= value)
                % Y
                CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 1;
            elseif (C > value)
                % G
                CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 1;
            end
        end
        end
    case 'KRGB'
        if (C > value)
        if (M > value)
            if (Y > value)
                % K
                CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 1;
            elseif (Y <= value)
                % B
                CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 0;
            end
        elseif (M <= value)
            % G
            CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 1;
        end
    elseif (C <= value)
        % R
        CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 1;
        end
    case 'RGBM'
        if (M <= value)
        % G
        CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 1;
        
    elseif (M > value)
        if (C <= value)
            if (Y > value)
                % R
                CMYK_final(1,1,1) = 0; CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 1;
            elseif (Y <= value)
                % M
                CMYK_final(1,1,1) = 0;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 0;
            end
        elseif (C > value)
            % B
            CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 0;
        end
        end
    case 'CMGB'
        if (C > value)
        if (Y <= value)
            if (M <= value)
                % C
                CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 0;
            elseif (M > value)
                % B
                CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 0;
            end
        elseif (Y >= value)
            % G
            CMYK_final(1,1,1) = 1;CMYK_final(1,1,2) = 0;CMYK_final(1,1,3) = 1;
        end
    elseif(C <= value)
        % M
        CMYK_final(1,1,1) = 0; CMYK_final(1,1,2) = 1;CMYK_final(1,1,3) = 0;
    end
end
error(1,1,1) = C - CMYK_final(1,1,1); 
error(1,1,2) = M - CMYK_final(1,1,2); 
error(1,1,3) = Y - CMYK_final(1,1,3);
end