clear

resbase =  '../standalone_tracker/results/';
dirs = dir('../standalone_tracker/results/seq02*');
names = {};
for i = 1:length(dirs)
	if(dirs(i).isdir)
		names{end+1} = dirs(i).name;
	end
end
% names = {'seq02.30' 'seq02.31' 'seq02,32' 'seq02.33'};
matlabpool open 8
parfor i = 1:length(names)
	disp(['read ' names{i}]);
	idl{i} = tracks2idl(fullfile(resbase, [names{i} '/']));
end
matlabpool close
save results/track02_all idl names
