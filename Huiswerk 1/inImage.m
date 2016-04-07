function bool = inImage(sizeImage, x, y)
    if (sizeImage(1) >= x && sizeImage(2) >= y && x > 1 && y > 1)
        bool = true;
        return;
    else
        bool = false;
        return;
    end
end
