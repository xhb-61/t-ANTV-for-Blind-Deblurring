function x = firm_threshold(x, value_low, value_high)
x(abs(x) <= value_low) = 0;
idx = find(value_low < abs(x) & abs(x) <= value_high);
x(idx) = x(idx) .* value_high .* (1 - value_low ./ x(idx)) ./ (value_high- value_low);
end