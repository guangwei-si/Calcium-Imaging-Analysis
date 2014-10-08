function curve_plot(signal, image_times, odor_seq)

global odor_map    neuron_list;

colorset = varycolor(length(signal));

%% input the neuron name
% if ~exist('neuron_list','var')   
    neuron_list = cell(1,2);
    
    for i =1:length(signal)
        neuron_list{i}=input(['Please enter the name of neurons #', num2str(i), ':'],'s');
    end
% end


%% plot curves
figure
for i =1:length(signal)
%     smooth_signal = smooth(signal{i},30);
%     plot(image_times, smooth_signal,'Color', colorset(i,:));
    plot(image_times, signal{i},'Color', colorset(i,:));
    hold on
end
hold off

axis tight
ax = axis;
axis([0 ax(2) ax(3) ax(4)])
% axis([0 ax(2) ax(3) ceil(ax(4))])
ax= axis;
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);


%% calculate X Y and C for patch.
X(1,1) = image_times(1);
C = odor_seq(1);
j = 1; 

for i = 2:1: length(odor_seq)
    if odor_seq(i) ~= C(j)
        X(2,j) = image_times(i-1);
        j =j+1;
        C(j)  = odor_seq(i);    X(1,j) = image_times(i-1); 
    end
    if i == length(odor_seq)
        X(2,j) = image_times(i);
    end
end

X(3,:) = X(2,:);    X(4,:) = X(1,:);

Y = X;
Y(1, :) = ax(3);    Y(2, :) = ax(3);    Y(3, :) = ax(4);    Y(4, :) = ax(4);
     
%% XX YY and CC_color
cm = lines(64);     %colormap for patch
cm(1,:) = [1 1 1];  %set 0('water') as blank.

CC = unique(odor_seq);
XX = cell(1,length(CC));
YY = XX;

for i =1: length(CC)
    temp = find(C==CC(i));
    XX{i}= X(:,temp);
    YY{i}= Y(:,temp);
end

CC_color = zeros(length(CC) ,3);
for i =1:length(CC)
    CC_color(i,:) = cm(CC(i)+1,:);
end


%% patch
p = zeros(length(CC), 1);
for i =1:length(CC)
    p(i) = patch(XX{i}, YY{i}, CC_color(i,:), ...
        'FaceAlpha', 0.5);
end

%% label, legand and position
text_size = 10;
xlabel('Time(s)', 'FontSize',text_size);  ylabel('\delta F/F', 'FontSize',text_size);
% title([fname, '-', neuron_type],'FontSize',text_size);

% legend_text = cell(1, length(normalized_signal)+length(CC));
% for i = 1:length(normalized_signal)
%     legend_text(i) = neuron_list(i);
% end
% for j = 1:1:length(CC)
%     legend_text(j+i) = odor_seq_list(CC(j)+1);
% end

dim = size(signal);
legend_text = cell(1, dim(2)+length(CC));
for i = 1:dim(2)
    legend_text(i) = neuron_list(i);
end
for j = 1:1:length(CC)
    index_temp = strcmp(num2str(CC(j)), odor_map);
    index = find(index_temp == 1);
    legend_text(j+dim(2)) = odor_map(index-length(odor_map));
end

legend(legend_text, 'Location','NorthEastOutside', 'FontSize', text_size);

post = get(gcf, 'Position');
set(gcf, 'Position', [post(1), post(2), 960, 250])

% %% save figure
% saveas(gcf,[pathname, filename, '-', neuron_type,'.fig']);
end
