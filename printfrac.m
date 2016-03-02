%%printfrac outputs a PNG file of the current image given a colormap. 
%% map is your chosen colormap

% map=pmkmp(256,'Edge');
% map=copper
% map=createcolormap;
map = bone;
%%
% Calculate min and max.
m_minValue = min(m(:));
m_maxValue = max(m(:));
% Scale to 0-255;
m = 255.0 * (m - m_minValue) / (m_maxValue - m_minValue);
% Convert to 8 bit integer.
m8 = uint8(m);
% Display monochrome image.
subplot(1,2,1);
imshow(m8, []);
% Maximize figure.
set(gcf, 'Position', get(0,'Screensize'));
% Convert to rgb.
rgbImage = ind2rgb(m8, map);
% Display rgb image.
subplot(1,2,2);
imshow(rgbImage);
% Save the RGB image to disk.
imwrite(rgbImage, 'image.png');