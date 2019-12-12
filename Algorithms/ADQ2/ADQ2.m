function M = ADQ2(I)
    c1 = 1;
    c2 = 15;
    M = getJmap(I, 1, c1, c2);
    M = adaptMap(M, I.image_width, I.image_height, 0.6);
end

