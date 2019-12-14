function M = ADQ2(I)
    c1 = 1;
    c2 = 10;
    M = getJmap(I, 1, c1, c2);
    M = adaptMap(M, 0.6);
end

