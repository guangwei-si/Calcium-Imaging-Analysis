%This function calculate the mean intensity of the fluorescence
function mean_F = calculate_intensity(F,n)

if nargin==1
    n=20;
end

F_sorted=sort(F,'descend');
baseline_F=mean(F_sorted(end-10:end));
mean_F=mean(F_sorted(1:n))-baseline_F; % average over the first n brightest pixels
end
