function normalized_signal = nm_signal( signal, odor_seq )

normalized_signal = signal;

f0_left  = -10;
f0_right = -2;

index = min(find(odor_seq));

left  = max(1, index+f0_left);
right = max(1, index+f0_right);

for k =1:length(signal)
    f0 = mean(signal{k}(left : right));
    normalized_signal{k} = (signal{k}-f0)/f0;
end

end
