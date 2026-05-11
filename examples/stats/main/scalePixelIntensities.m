function x = scalePixelIntensities(imdat)
%SCALEPIXELINTENSITIES Scales image pixel intensities
%   SCALEPIXELINTENSITIES scales the pixel intensities of the image such
%   that the result x is a row vector of values in the interval [0,1].
imdat = rgb2gray(imdat);

minimdat = min(min(imdat));
maximdat = max(max(imdat));
x = (imdat - minimdat)/(maximdat - minimdat);
end

