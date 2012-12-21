clear

basedir='/home/wgchoi/Dataset/KITTI/';

fstep = 1;
seqs = {'0047' '0093' '0104' '0004' '0056'};

for i = 1:length(seqs)
    seqname = seqs{i}; % '0056';
    draw_sequence(basedir, [seqname '_imlist.txt'], ['~/Codes/ped_tracker_release/nec-code/standalone_tracker/results/' seqname '.car.voc/'], ['visualization/' seqname '/'], fstep);
    draw_topview(basedir, [seqname '_imlist.txt'], ['~/Codes/ped_tracker_release/nec-code/standalone_tracker/results/' seqname '.car.voc/'], ['visualization/' seqname '/']);
    merge_images(['visualization/' seqname '/']);
    
    unix(['ffmpeg -sameq -f image2 -r 10 -i ./visualization/' seqname '/merged%05d.png ./visualization/' seqname '_new.avi; rm -rf ./visualization/' seqname]);
end