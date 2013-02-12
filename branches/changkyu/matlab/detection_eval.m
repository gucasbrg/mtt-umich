clear 

addpath ./eval
addpath ./IDL

imgformat = '%010d.png';
basenum = 0 - 1;

seqnames = {'0056' '0093' '0104'};
seqnames = {'0004' '0047'};

addpath ~/Codes/plottingTools/savefig

for s = 1:length(seqnames)
    seqname = seqnames{s};
    
    dpmdir = ['/home/wgchoi/Dataset/KITTI/voc/' seqname '/'];
    necdir = ['/home/wgchoi/Dataset/KITTI/NEC/' seqname '/'];
    annofile = ['/home/wgchoi/Dataset/KITTI/gtbbox/' seqname '_image02.idl'];
    resdirs = ['/home/wgchoi/Codes/ped_tracker_release/nec-code/standalone_tracker/results/' seqname '.car.voc/'];

    % read annotations in idl format 
    anno = readIDL(annofile);
    % corret the order of x1, x2, y1, y2 (increasing)
    anno = correctIDL(anno);
    % read detection results and convert it into IDL format
    dpmidl = confs2idl(dpmdir, '');
    % read detection results and convert it into IDL format
    necidl = confs2idl(necdir, '');
    %%
    % compute fppi/recall

    figure;
    hold on;
    
    FPPI = {};
    recall = {};
    names = {};
    
    trackidl  = tracks2idl(resdirs, imgformat, basenum); 
    
    [ FPPI{1}, recall{1}] = recallfppi_idls( anno , trackidl, 1, 1);
    draw_fppimr(recall{1}, FPPI{1}, 'r', '.-')
    names{1} = 'tracking';
    [ FPPI{2}, recall{2} ] = recallfppi_idls( anno , dpmidl, 1, 1);
    draw_fppimr(recall{2}, FPPI{2}, 'g', '--')
    names{2} = 'dpm';
    [ FPPI{3}, recall{3} ] = recallfppi_idls( anno , necidl, 1, 1);
    draw_fppimr(recall{3}, FPPI{3}, 'b', '--')
    names{3} = 'nec';
    drawnow;
    
    hold off;
    legend(names);
    savefig([seqname '_det'], 'png')
    close
end
%%
addpath ./kitti_devkit/matlab/

seqnames = {'0004' '0047' '0056' '0093' '0104'};

for i = 1:length(seqnames)
    seqname = seqnames{i};
    basedir=['/home/wgchoi/Dataset/KITTI/' seqname '/'];
    traj = loadCamTrajectory(basedir, 1:2000);
    
    camera = load(['~/Codes/ped_tracker_release/nec-code/standalone_tracker/results/' seqname '.car.voc/camera.txt']);
    draw_odom_summary(traj, camera(:, [4 6]))
    
    savefig([seqname '_traj'], 'png')
end
