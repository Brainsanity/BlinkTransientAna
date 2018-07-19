classdef BlinkTransientNMV2 < handle
	
	methods ( Access = private )
		function obj = BlinkTransientNMV2();
		end
	end

	methods ( Static )
		function sc = main( folder, task )
			sbjs = {'CB','KS','MH','NM','SB'};
			for i = 1 : 5
				BlinkTransientNMV2.GetData4Blinks(['F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\', sbjs{i}]);
				BlinkTransientNMV2.GetData4Blinks(['F:\MsacCS_VisRes16\Matlab codes and data\Data\HSF(10)\', sbjs{i}]);
				BlinkTransientNMV2.BlinkEffect(['F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\', sbjs{i}]);
				BlinkTransientNMV2.BlinkEffect(['F:\MsacCS_VisRes16\Matlab codes and data\Data\HSF(10)\', sbjs{i}]);
				BlinkTransientNMV2.ShowTimeCourses(['F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\', sbjs{i}]);
				BlinkTransientNMV2.ShowTimeCourses(['F:\MsacCS_VisRes16\Matlab codes and data\Data\HSF(10)\', sbjs{i}]);
			end
			subfolders = {'CV - LSF', 'KS - LSF(1.5)', 'Ks- LSF', 'MH- LSF', 'NM-LSF(1.5)', 'SB- LSF'};
			for( i = 1 : size(subfolders,2) )
				BlinkTransientNMV2.GetData4Blinks(['F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-discarded\', subfolders{i}]);
				BlinkTransientNMV2.BlinkEffect(['F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-discarded\', subfolders{i}]);
				BlinkTransientNMV2.ShowTimeCourses(['F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-discarded\', subfolders{i}]);
			end
			BlinkTransientNMV2.GetData4Blinks('F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-debug\subfolder');
			BlinkTransientNMV2.BlinkEffect('F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-debug\subfolder');
			BlinkTransientNMV2.ShowTimeCourses('F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-debug\subfolder');
		end

		function EIS2Mat( folder )
			if( folder(end) == '\' || folder(end) == '/' ) folder(end) = []; end
			fprintf('%s\n', folder);
			eisFNs = dir( [folder, '/*.eis'] );
			% if( exist( [folder,'/Trials.mat'], 'file' ) == 2 ) delete( [folder,'/Trials.mat'] ); end
			if( exist( [folder,'/Data4Blinks.mat'], 'file' ) == 2 ) delete( [folder,'/Data4Blinks.mat'] ); end
			if( ~isempty(eisFNs) && exist( [folder,'/Trials.mat'], 'file' ) ~= 2 )
				list = eis_readData([], 'x');
				list = eis_readData(list, 'y');
				list = eis_readData(list, 'stream', 0, 'double');
				list = eis_readData(list, 'stream', 1, 'double');
				list = eis_readData(list, 'stream', 2, 'double');
				list = eis_readData(list, 'stream', 3, 'double');
				list = eis_readData(list, 'trigger', 'blink');
				list = eis_readData(list, 'trigger', 'notrack');
				usrVars = { 'sbj',...
							'BkGdLuminance',...
							'screenw',...
							'screenh',...
							'screenr',...
							'corrX',...
							'corrY',...
							'resptime',...
							'plateautime',...
							'fixtime',...
							'trialNo',...
							'imgNo',...
							'trialid',...
							'imggratsize',...
							'dist',...
							'fixArea',...
							'imggrat',...
							'rt',...
							'key',...
							'tilt',...
							'spfreq',...
							'contrast',...
							'TrialStart',...
							'FixStart',...
							'BlinkBeepOn',...
							'RampUpOn',...
							'PlateauOn',...
							'StimulusOff',...
							'quit' };
				for( i = 1 : size(usrVars,2) )
					list = eis_readData(list, 'uservar', usrVars{i} );
				end
				data = eis_eisdir2mat(folder,list);

				for( iTrial = size(data.user,1) : -1 : 1 )
					trial = createTrial( iTrial, data.x{iTrial}, data.y{iTrial}, data.triggers{iTrial}.blink, data.triggers{iTrial}.notrack, ones(1,size(data.x{iTrial},2)) );
					trial = findSaccades( trial, 'minvel', 180, 'minsa', 30 );	% min arc
					trial = findMicrosaccades( trial, 'minvel', 180, 'minmsa', 3, 'maxmsa', 30 );	% min arc
			    	trial = findDrifts(trial);

			    	trial.evntRenderTimes = data.stream00{iTrial};
			    	trial.evntRenderIFrames = data.stream01{iTrial};
			    	trial.postSwapTimes = data.stream02{iTrial};
			    	trial.postSwapIFrames = data.stream03{iTrial};

			    	varNames = fieldnames(data.user{iTrial});
				    for i = 1 : size(varNames,1)
				        trial.(varNames{i}) = data.user{iTrial}.(varNames{i});
				    end

				    Trials(iTrial) = trial;
				end 

				save( [ folder, '/', 'Trials.mat' ], 'Trials' );
				% delete( [ folder, '/', folder( find( folder == '/' | folder == '\', 1, 'last' ) + 1 : end ), '.mat' ] );
			end

			subfolders = ToolKit.ListFolders(folder);
			for( iFolder = 1 : size(subfolders,1) )
				BlinkTransientNMV2.EIS2Mat( ToolKit.RMEndSpaces( subfolders(iFolder,:) ) );
			end
		end

		function Data4Blinks = GetData4Blinks( folder )
			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			Data4Blinks = [];
			% if( exist( [folder,'/Data4Blinks.mat'], 'file' ) == 2 )	delete( [folder,'/Data4Blinks.mat'] ); end
			if( exist( [folder,'/Data4Blinks.mat'], 'file' ) == 2 )
				load( [folder,'/Data4Blinks.mat'] );
			else
				subfolders = ToolKit.ListFolders(folder);
				index = logical( zeros( size(subfolders,1), 1 ) );
				for( iFolder = 1 : size(subfolders,1) )
					if( sum( subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end ) == '-' ) ~= 2 ) index(iFolder) = 1; end
				end
				subfolders(index,:) = [];

				for( iFolder = size(subfolders,1) : -1 : 1 )
					load( [ ToolKit.RMEndSpaces(subfolders(iFolder,:)), '/Trials.mat' ] );
					VT = Trials;

					% tirals only with drifts
					Data4Blinks(iFolder).sessionName = subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end );
					Data4Blinks(iFolder).trialsWithoutBlink = VT;
					index = logical(zeros(size(VT)));
					for( i = 1 : size(VT,2) )
						if( ~isempty( VT(i).blinks.start ) &&  any( VT(i).RampUpOn <= VT(i).blinks.start + VT(i).blinks.duration & VT(i).blinks.start <= VT(i).StimulusOff ) ||...
							~isempty( VT(i).notracks.start ) &&  any( VT(i).RampUpOn <= VT(i).notracks.start + VT(i).notracks.duration & VT(i).notracks.start <= VT(i).StimulusOff ) ||...
							~isempty( VT(i).saccades.start ) && any( VT(i).RampUpOn <= VT(i).saccades.start + VT(i).saccades.duration & VT(i).saccades.start <= VT(i).StimulusOff ) ||...
							~isempty( VT(i).microsaccades.start ) && any( VT(i).RampUpOn <= VT(i).microsaccades.start + VT(i).microsaccades.duration & VT(i).microsaccades.start <= VT(i).StimulusOff ) )
							index(i) = 1;
						end
					end
					Data4Blinks(iFolder).trialsWithoutBlink(index) = [];

					% trials only with blinks
					Data4Blinks(iFolder).trialsWithBlink = VT;
					index = logical(zeros(size(VT)));
					for( i = 1 : size(VT,2) )
						if( isempty( VT(i).blinks.start ) ||...
							all( VT(i).RampUpOn > VT(i).blinks.start + VT(i).blinks.duration | VT(i).blinks.start > VT(i).StimulusOff ) ||...
							~isempty( VT(i).saccades.start ) && any( VT(i).RampUpOn <= VT(i).saccades.start + VT(i).saccades.duration & VT(i).saccades.start <= VT(i).StimulusOff ) ||...
							~isempty( VT(i).microsaccades.start ) && any( VT(i).RampUpOn <= VT(i).microsaccades.start + VT(i).microsaccades.duration & VT(i).microsaccades.start <= VT(i).StimulusOff ) )
							index(i) = 1;
						end
					end
					Data4Blinks(iFolder).trialsWithBlink(index) = [];
				end
				save( [folder,'/Data4Blinks.mat'], 'Data4Blinks' );
			end
		end

		function ShowTimeCourses( folder )
			Data4Blinks = BlinkTransientNMV2.GetData4Blinks(folder);
			if( isempty(Data4Blinks) ) return; end

			% trialsWithoutBlink = [Data4Blinks.trialsWithoutBlink];
			trialsWithBlink = [Data4Blinks.trialsWithBlink];
			set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Time Courses of Blink Trials', folder( min( find( folder == '\' | folder == '/', 2, 'last' ) ) + 1 : end ) ), 'color', 'w' );
			nCols = 2;
			nRows = max( [ceil( size(trialsWithBlink,2) / nCols ), 3 ] );
			for( iTrial = 1 : size(trialsWithBlink,2) )
				subplot(nRows,nCols,iTrial);
				plot( [ trialsWithBlink(iTrial).FixStart, trialsWithBlink(iTrial).RampUpOn, trialsWithBlink(iTrial).PlateauOn, trialsWithBlink(iTrial).StimulusOff, trialsWithBlink(iTrial).StimulusOff, trialsWithBlink(iTrial).resptime ], [0, 0, 1, 1, 0, 0], 'k', 'LineWidth', 2 );
				hold on;
				blinksOn = trialsWithBlink(iTrial).blinks.start;
				blinksOff = trialsWithBlink(iTrial).blinks.start + trialsWithBlink(iTrial).blinks.duration;
				clear x;
				x(2:3,:) = repmat( blinksOn, 2, 1 );
				x(1,:) = NaN;
				plot( x(:), reshape( repmat( [NaN;0;1], 1, size(x,2) ), 1, [] ), 'b:', 'LineWidth', 1 );
				clear x;
				x(2:3,:) = repmat( blinksOff, 2, 1 );
				x(1,:) = NaN;
				plot( x(:), reshape( repmat( [NaN;0;1], 1, size(x,2) ), 1, [] ), 'r:', 'LineWidth', 1 );
				title( sprintf( 'Cont: %.2f', trialsWithBlink(iTrial).contrast ) );
				set( gca, 'xlim', [800 2200], 'FontSize', 10 );
			end
		end

		function BlinkEffect( folder, oneByone )
			if( nargin() < 2 ) oneByone = false; end
			Data4Blinks = BlinkTransientNMV2.GetData4Blinks(folder);
			if( isempty(Data4Blinks) ) return; end

			if( ~oneByone )
				trialsWithoutBlink = [Data4Blinks.trialsWithoutBlink];
				trialsWithBlink = [Data4Blinks.trialsWithBlink];
				Data4Blinks = Data4Blinks(1);
				Data4Blinks.trialsWithoutBlink = trialsWithoutBlink;
				Data4Blinks.trialsWithBlink = trialsWithBlink;
			end
			set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Blink+Drift VS Drift', folder( min( find( folder == '\' | folder == '/', 2, 'last' ) ) + 1 : end ) ), 'color', 'w' );
			nCols = ceil( sqrt( size(Data4Blinks,2) ) );
			nRows = ceil( size(Data4Blinks,2) / nCols );
			for( iSession = 1 : size(Data4Blinks,2) )
				% tirals only with drifts
				trials{2} = Data4Blinks(iSession).trialsWithoutBlink;

				% trials only with blinks
				trials{1} = Data4Blinks(iSession).trialsWithBlink;
				if( isempty(trials{1}) ) continue; end

				subplot( nRows, nCols, iSession );
				hold on;
				colors = {'b', 'r'};
				names = { 'blink+drift', 'drift' };
				for( j = 2:-1:1 )
					contrasts = [trials{j}.contrast];
					crctRate(j).rates = zeros(size(trials{j}));
					crctRate(j).contrasts = zeros(size(trials{j}));
					crctRate(j).nRates = 0;
					conWin = 2;
					for( cont = unique(contrasts) )
						index = cont - conWin/2 <= contrasts & contrasts <= cont + conWin/2;
						if( any(index) )
							crctRate(j).nRates = crctRate(j).nRates+1;
							crctRate(j).rates(crctRate(j).nRates) = sum( [trials{j}(index).key] == [trials{j}(index).tilt] ) / sum(index);
							crctRate(j).contrasts(crctRate(j).nRates) = cont;
						end
					end

					h(j) = plot( crctRate(j).contrasts(1:crctRate(j).nRates), crctRate(j).rates(1:crctRate(j).nRates), '*', 'LineStyle', '-', 'color', colors{j}, 'DisplayName', sprintf( '%s (n=%d)', names{j}, size(trials{j},2) ) );
				end
				legend(h);
				xlabel('Contrast');
				ylabel('Correct rate');
				set( gca, 'FontSize', 20 );
			end
		end
	end
end