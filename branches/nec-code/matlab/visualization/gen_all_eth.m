clear
basedir = '/home/wgchoi/codes/eth_dataset/';
%%
seq = 'seq02';
imlist = [seq '_imlist.txt'];
resbase = '~/codes/ped_tracker_general/standalone_tracker/results/';

sub = '11_inria';
mkdir([seq '.' sub '/']);
draw_sequence(basedir, imlist, [resbase seq '.' sub '/'], [seq '.' sub '/'], 5);
draw_topview(basedir, imlist, [resbase seq '.' sub '/'], [seq '.' sub '/'], 1:5:2000);
%%
seq = 'seq03';
imlist = [seq '_imlist.txt'];
resbase = '~/codes/ped_tracker_general/standalone_tracker/results/';

sub = '12_inria';
mkdir([seq '.' sub '/']);
draw_sequence(basedir, imlist, [resbase seq '.' sub '/'], [seq '.' sub '/'], 5);
draw_topview(basedir, imlist, [resbase seq '.' sub '/'], [seq '.' sub '/'], 1:5:1000);