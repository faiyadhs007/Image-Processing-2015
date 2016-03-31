%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function type = mvbq(CMY_vector)

% This code is inspired from the following paper:
% D.Shaked, N. Arad, A.Fitzhugh, I. Sobel, ?Color Diffusion: Error-Diffusion 
% for Color Halftones?,HP Labs Technical Report, HPL-96-128R1, 1996.

C = CMY_vector(1,1,1); M = CMY_vector(1,1,2); Y = CMY_vector(1,1,3);

x = C+M; y = M+Y; z = C+M+Y;

if (x < 1)
    if (y < 1)
        if ((z) < 2)
            type = 'CMYW';
        else
            type = 'MYGC';
        end
    else
            type = 'RGMY';
    end
    
else
    if (~(y < 1))
        if (~(z < 1))
            type = 'KRGB';
        else
            type = 'RGBM';
        end
    else
            type = 'CMGB';
    end
end

end
