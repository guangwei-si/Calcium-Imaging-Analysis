global neuron_list;

if length(questdlg('Save this data? '))==3
    
    clear data;
    clear imagelist;
    clear img_stack;
    [fn, savepathname]= uiputfile('*.mat', 'choose file to save', strcat(fname, '_',num2str(istart),'-',num2str(iend),'-', neuron_list{1},'.mat'));
    if length(fn) > 1
        fnamemat = strcat(savepathname,fn);
        save(fnamemat);
    end
    
    saveas(gcf,[pathname, filename, '-', neuron_list{1} ,'.fig']);
end
