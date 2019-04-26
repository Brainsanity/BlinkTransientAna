function test(source, dest)
	if( exist( fullfile(source, 'Trials.mat'), 'file' ) == 2 )
		if( exist( dest, 'dir' ) ~= 7 )
			mkdir(dest);
		end
		copyfile( fullfile(source, 'Trials.mat'), fullfile(dest, 'Trials.mat') );
	end
	folders = dir(source);
	for( i = 3 : size(folders,1) )
		if( folders(i).isdir )
			test( fullfile(source, folders(i).name), fullfile(dest, folders(i).name) );
		end
	end
end