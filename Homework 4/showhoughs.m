function showhoughs()

    boxC = imread('attachments/box.png');
    box = im2double(rgb2gray(boxC));

    billC = imread('attachments/billboard.png');
    bill = im2double(rgb2gray(billC));
    
    shapeC = imread('attachments/shapes.png');
    shape = im2double(rgb2gray(shapeC));

    subplot(2,3,1);
    imshow(shapeC)
    title('Shapes')
    h = hough(shape, 0.5, 700, 700);
    houghlines(shape,h,.2, 'dilation');
    subplot(2,3,4);    
    imshow(h)
    colormap(hot);
    title('Shapes Hough transform')

    subplot(2,3,2);
    imshow(boxC)
    title('Box')
    h = hough(box, 0.5, 700, 700);
    houghlines(box,h,.4, 'dilation');
    subplot(2,3,5);
    imshow(h)
    colormap(hot);
    title('Box Hough transform')

    subplot(2,3,3);
    imshow(billC)
    title('Billboard')
    h = hough(bill, 0.5, 700, 700);
    houghlines(bill,h,.45, 'dilation');
    subplot(2,3,6);
    imshow(h)
    colormap(hot);
    title('Billboard Hough transform');
end

