function showhoughs()
szel = imread('attachments/szeliski.png');
szel = im2double(rgb2gray(szel));

box = imread('attachments/box.png');
box = im2double(rgb2gray(box));

bill = imread('attachments/billboard.png');
bill = im2double(rgb2gray(bill));

subplot(2,3,1);
imshow(szel)
title('Szeliski')
subplot(2,3,4);
imshow(hough(szel, 0.5, 700, 700))
title('Szeliski Hough transform')

subplot(2,3,2);
imshow(box)
title('Box')
subplot(2,3,5);
imshow(hough(box, 0.5, 700, 700))
title('Box Hough transform')

subplot(2,3,3);
imshow(bill)
title('Billboard')
subplot(2,3,6);
imshow(hough(bill, 0.5, 700, 700))
title('Billboard Hough transform')
end

