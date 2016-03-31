function [ RGB_out ] = combineRGB(BytesPerPixel,R,G,B )
RGB_out = cat(BytesPerPixel,R,G,B);
end

