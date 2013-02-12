clear 

addpath ./eval
addpath ./IDL

imgformat = '%010d.png';
basenum = 0 - 1;

seqname = '0104';


% datadir = '/home/wgchoi/datasets/necdata/0104/2011_09_26_drive_0104/image_02/dets/';
% resdir = '/home/wgchoi/Codes/ped_tracker_release/nec-code/standalone_tracker/results/0104.car.nec/';
% datadir = '/home/wgchoi/Dataset/KITTI/NEC/0104/';
% annofile = '/home/wgchoi/Dataset/KITTI/gtbbox/0104_image02.idl';

% resdir = '/home/wgchoi/codes/ped_tracker_google/trunk/standalone_tracker/results/0093.car.org/';
datadir = ['/home/wgchoi/Dataset/KITTI/voc/' seqname '/'];
annofile = ['/home/wgchoi/Dataset/KITTI/gtbbox/' seqname '_image02.idl'];

%datadir = '/home/wgchoi/Dataset/KITTI/0056/2011_09_26_drive_0056/image_02/dets/';
% datadir = '/home/wgchoi/Dataset/KITTI/NEC/0056/';
% annofile = '/home/wgchoi/Dataset/KITTI/gtbbox/0056_image02.idl';
%%
% read annotations in idl format 
anno = readIDL(annofile);
% corret the order of x1, x2, y1, y2 (increasing)
anno = correctIDL(anno);

% read detection results and convert it into IDL format
detidl = confs2idl(datadir, '');
%%
% compute fppi/recall
figure;
resdirs = {['/home/wgchoi/Codes/ped_tracker_release/nec-code/standalone_tracker/results/' seqname '.car.voc0.5/'] ...
    ['/home/wgchoi/Codes/ped_tracker_release/nec-code/standalone_tracker/results/' seqname '.car.voc0.75/'] ...
    ['/home/wgchoi/Codes/ped_tracker_release/nec-code/standalone_tracker/results/' seqname '.car.voc/'] ...
    ['/home/wgchoi/Codes/ped_tracker_release/nec-code/standalone_tracker/results/' seqname '.car.voc1.5/']};
cols = 'rgbk';
names = {'track 0.5' 'track 0.75' 'track 1' 'track 1.5'};

hold on;
for i = 1:length(resdirs)
    trackidl  = tracks2idl(resdirs{i}, imgformat, basenum); 
    [ FPPI{i}, recall{i}] = recallfppi_idls( anno , trackidl, 1, 1);
    draw_fppimr(recall{i}, FPPI{i}, cols(i), '.-')
    drawnow;
end
[ FPPI{end+1}, recall{end+1}, thlist ] = recallfppi_idls( anno , detidl, 1, 1);
draw_fppimr(recall{end}, FPPI{end}, 'c', '--')
drawnow;
hold off;
names{end+1} = 'voc';
legend(names);

save(['./summary_weights_' seqname '_voc'], 'FPPI', 'recall', 'names');