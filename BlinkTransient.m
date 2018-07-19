classdef BlinkTransient < handle
	
	methods ( Access = private )
		function obj = BlinkTransient();
		end
	end

	methods ( Static )
		function sc = main( folder, task )
			sbjs = {'CB','KS','MH','NM','SB'};
			for i = 1 : 5
				BlinkTransient.GetData4Blinks(['F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\', sbjs{i}]);
				BlinkTransient.GetData4Blinks(['F:\MsacCS_VisRes16\Matlab codes and data\Data\HSF(10)\', sbjs{i}]);
				BlinkTransient.BlinkEffect(['F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\', sbjs{i}]);
				BlinkTransient.BlinkEffect(['F:\MsacCS_VisRes16\Matlab codes and data\Data\HSF(10)\', sbjs{i}]);
				BlinkTransient.ShowTimeCourses(['F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\', sbjs{i}]);
				BlinkTransient.ShowTimeCourses(['F:\MsacCS_VisRes16\Matlab codes and data\Data\HSF(10)\', sbjs{i}]);
			end
			subfolders = {'CV - LSF', 'KS - LSF(1.5)', 'Ks- LSF', 'MH- LSF', 'NM-LSF(1.5)', 'SB- LSF'};
			for( i = 1 : size(subfolders,2) )
				BlinkTransient.GetData4Blinks(['F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-discarded\', subfolders{i}]);
				BlinkTransient.BlinkEffect(['F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-discarded\', subfolders{i}]);
				BlinkTransient.ShowTimeCourses(['F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-discarded\', subfolders{i}]);
			end
			BlinkTransient.GetData4Blinks('F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-debug\subfolder');
			BlinkTransient.BlinkEffect('F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-debug\subfolder');
			BlinkTransient.ShowTimeCourses('F:\MsacCS_VisRes16\Matlab codes and data\Data\SRC-debug\subfolder');
		end

		function EIS2Mat( folder )
			if( folder(end) == '\' || folder(end) == '/' ) folder(end) = []; end
			fprintf('%s\n', folder);
			if( size(folder,2) > 10 && strcmp( folder(end-10:end), lower('calibration') ) ) return; end
			eisFNs = dir( [folder, '/*.eis'] );
			% if( exist( [folder,'/Trials.mat'], 'file' ) == 2 ) delete( [folder,'/Trials.mat'] ); end
			if( ~isempty(eisFNs) && exist( [folder,'/Trials.mat'], 'file' ) ~= 2 )
                list = [];
				list = eis_readData([], 'x');
				list = eis_readData(list, 'y');
				list = eis_readData(list, 'stream', 0, 'double');
				list = eis_readData(list, 'stream', 1, 'double');
				list = eis_readData(list, 'trigger', 'blink');
				list = eis_readData(list, 'trigger', 'notrack');
				usrVars = { 'trialType',...
							'tTrialStart',...
							'tFpOn',...
							'tRampOn',...
							'tPlateauOn',...
							'tMaskOn',...
							'tMaskOff',...
							'tResponse',...
							'response',...
							'tBlinkBeepOn',...
							'gaborSpFreq',...
							'gaborOri',...
							'gaborStdPix',...
							'gaborWPix',...
							'gaborAmp',...
							'expName',...
							'sbjName',...
							'screenR',...
							'screenWPix',...
							'screenHPix',...
							'screenWmm',...
							'screenHmm',...
							'screenDmm',...
							'bgnLuminance' };
				for( i = 1 : size(usrVars,2) )
					list = eis_readData(list, 'uservar', usrVars{i} );
				end
				data = eis_eisdir2mat(folder,list);

				for( iTrial = size(data.user,1) : -1 : 1 )
					trial = createTrial( iTrial, data.x{iTrial}, data.y{iTrial}, data.triggers{iTrial}.blink, data.triggers{iTrial}.notrack, ones(1,size(data.x{iTrial},2)) );
					% trial = createTrial( iTrial, [], [], [], [], 0 );
					trial = findSaccades( trial, 'minvel', 180, 'minsa', 30 );	% min arc
					trial = findMicrosaccades( trial, 'minvel', 180, 'minmsa', 3, 'maxmsa', 30 );	% min arc
			  		trial = findDrifts(trial);

			    	trial.evntRenderTimes = data.stream00{iTrial};
			    	trial.evntRenderIFrames = data.stream01{iTrial};
			    	% trial.postSwapTimes = data.stream02{iTrial};
			    	% trial.postSwapIFrames = data.stream03{iTrial};

			    	varNames = fieldnames(data.user{iTrial});
				    for i = 1 : size(varNames,1)
				        trial.(varNames{i}) = data.user{iTrial}.(varNames{i});
				    end

				    trial.trialType = char(trial.trialType);

				    Trials(iTrial) = trial;
				end 

				save( [ folder, '/', 'Trials.mat' ], 'Trials' );
				% delete( [ folder, '/', folder( find( folder == '/' | folder == '\', 1, 'last' ) + 1 : end ), '.mat' ] );
			end

			subfolders = ToolKit.ListFolders(folder);
			for( iFolder = 1 : size(subfolders,1) )
				BlinkTransient.EIS2Mat( ToolKit.RMEndSpaces( subfolders(iFolder,:) ) );
			end
		end

		function Data4Blinks = GetData4Blinks( folder, discardMicrosaccades )
			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			if( nargin() < 2 ) discardMicrosaccades = true; end 		% by default, we discard trials with microsaccades during stimulus

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
				% subfolders(index,:) = [];

				for( iFolder = size(subfolders,1) : -1 : 1 )
					load( [ ToolKit.RMEndSpaces(subfolders(iFolder,:)), '/Trials.mat' ] );
					VT = Trials;

					% tirals only with drifts
					Data4Blinks(iFolder).sessionName = subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end );
					Data4Blinks(iFolder).trialsWithoutBlink = VT;
					index = logical(zeros(size(VT)));
					for( i = 1 : size(VT,2) )
						if( ~isempty( VT(i).blinks.start ) &&  any( VT(i).tRampOn <= VT(i).blinks.start + VT(i).blinks.duration & VT(i).blinks.start <= VT(i).tMaskOn ) ||...
							~isempty( VT(i).notracks.start ) &&  any( VT(i).tRampOn <= VT(i).notracks.start + VT(i).notracks.duration & VT(i).notracks.start <= VT(i).tMaskOn ) ||...
							~isempty( VT(i).saccades.start ) && any( VT(i).tRampOn <= VT(i).saccades.start + VT(i).saccades.duration & VT(i).saccades.start <= VT(i).tMaskOn ) ||...
							discardMicrosaccades && ~isempty( VT(i).microsaccades.start ) && any( VT(i).tRampOn <= VT(i).microsaccades.start + VT(i).microsaccades.duration & VT(i).microsaccades.start <= VT(i).tMaskOn ) )
							index(i) = 1;
						end
					end
					Data4Blinks(iFolder).trialsWithoutBlink(index) = [];

					% trials only with blinks
					Data4Blinks(iFolder).trialsWithBlink = VT;
					index = logical(zeros(size(VT)));
					for( i = 1 : size(VT,2) )
						if( isempty( VT(i).blinks.start ) ||...
							all( VT(i).tRampOn > VT(i).blinks.start + VT(i).blinks.duration | VT(i).blinks.start > VT(i).tMaskOn ) ||...
							~isempty( VT(i).saccades.start ) && any( VT(i).tRampOn <= VT(i).saccades.start + VT(i).saccades.duration & VT(i).saccades.start <= VT(i).tMaskOn ) ||...
							discardMicrosaccades && ~isempty( VT(i).microsaccades.start ) && any( VT(i).tRampOn <= VT(i).microsaccades.start + VT(i).microsaccades.duration & VT(i).microsaccades.start <= VT(i).tMaskOn ) )
							index(i) = 1;
						end
					end
					Data4Blinks(iFolder).trialsWithBlink(index) = [];
				end
				save( [folder,'/Data4Blinks.mat'], 'Data4Blinks' );
			end
		end

		function Data4Blinks = GetData4Blinks_Beep( folder, anything )
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
				% subfolders(index,:) = [];

				for( iFolder = size(subfolders,1) : -1 : 1 )
					load( [ ToolKit.RMEndSpaces(subfolders(iFolder,:)), '/Trials.mat' ] );
					VT = Trials( [Trials.trialType] == 'c' | [Trials.trialType] == 'e' );
					VT( [VT.tFpOn] < 0 | [VT.tBlinkBeepOn] < 0 | [VT.tRampOn] < 0 | [VT.tPlateauOn] < 0 | [VT.tResponse] < 0 ) = [];

					% tirals blink beep during fixation
					Data4Blinks(iFolder).sessionName = subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end );
					Data4Blinks(iFolder).trialsWithoutBlink = VT( [VT.tBlinkBeepOn] < [VT.tRampOn] );

					% trials only with blinks
					Data4Blinks(iFolder).trialsWithBlink = VT( [VT.tBlinkBeepOn] > [VT.tRampOn] );
				end
				save( [folder,'/Data4Blinks.mat'], 'Data4Blinks' );
			end
		end

		function ShowTimeCourses( folder )	% for old data from APLab
			Data4Blinks = BlinkTransient.GetData4Blinks(folder);
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

		function BlinkEffect( folder, groups )
			%% groups:			cell array, each element defines the indices of one data group

			Data4Blinks = BlinkTransient.GetData4Blinks(folder);
			if( isempty(Data4Blinks) ) return; end
			if( nargin() < 2 ) groups = mat2cell( 1:size(Data4Blinks,2), 1, ones(size(Data4Blinks)) ); end

			for( iGroup = size(groups,2) : -1 : 1 )
				data(iGroup).sessionName = sprintf( '%s | ', Data4Blinks(groups{iGroup}).sessionName );
				data(iGroup).sessionName(end-2:end) = [];
				data(iGroup).trialsWithBlink = [Data4Blinks(groups{iGroup}).trialsWithBlink];
				data(iGroup).trialsWithoutBlink = [Data4Blinks(groups{iGroup}).trialsWithoutBlink];
			end
			bgnLuminance = double(data(iGroup).trialsWithBlink(1).bgnLuminance);

			set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Blink VS No Blink', folder( min( find( folder == '\' | folder == '/', 2, 'last' ) ) + 1 : end ) ), 'color', 'w' );
			nCols = ceil( sqrt( size(data,2) ) );
			nRows = ceil( size(data,2) / nCols );
			for( iGroup = 1 : size(data,2) )
				% tirals only with drifts
				trials{2} = data(iGroup).trialsWithoutBlink;

				% trials only with blinks
				trials{1} = data(iGroup).trialsWithBlink;
				if( isempty(trials{1}) ) continue; end

				subplot( nRows, nCols, iGroup );
				hold on;
				colors = {'r', 'b'};
				names = { 'blink', 'no blink' };
				for( j = 2:-1:1 )
					% amplitudes = [trials{j}.gaborAmp];
					contrasts = BlinkTransient.Intensity2Luminance( [trials{j}.gaborAmp] + bgnLuminance ) / BlinkTransient.Intensity2Luminance(bgnLuminance) - 1;
					uniConts = unique(contrasts);
					crctRate(j).rates = zeros(size(trials{j}));
					crctRate(j).contrasts = zeros(size(trials{j}));
					crctRate(j).nRates = size(uniConts,2);
					conWin = 0;%0.3;
					for( iUni = crctRate(j).nRates : -1 : 1 )
						index = uniConts(iUni) - conWin/2 <= contrasts & contrasts <= uniConts(iUni) + conWin/2;
						crctRate(j).rates(iUni) = sum( [trials{j}(index).trialType] == 'c' ) / sum(index);
						crctRate(j).contrasts(iUni) = uniConts(iUni);
						text( crctRate(j).contrasts(iUni), crctRate(j).rates(iUni), sprintf('%d', sum(index)), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 12, 'color', colors{j} );
					end
					h(j) = plot( crctRate(j).contrasts(1:crctRate(j).nRates), crctRate(j).rates(1:crctRate(j).nRates), 'o', 'LineStyle', 'none', 'LineWidth', 2, 'color', colors{j}, 'DisplayName', sprintf( '%s (n=%d)', names{j}, size(trials{j},2) ) );

					[thresh, par] = psyfit( contrasts, [trials{j}.trialType] == 'c', 'Thresh', 0.75, 'Chance', 0.5, 'Lapses', 0, 'Log', 'Extra', 'PlotOff' );
					x = 0 : 0.001 : max(uniConts)+1;
					y = psyfun( x, par(1), par(2), 0.5, 0, false, true, 'normal' );
					plot( x, y, '-', 'LineWidth', 2, 'color', colors{j}, 'DisplayName', sprintf( '%s (n=%d)', names{j}, size(trials{j},2) ) );
					plot( [1, 1] * thresh, [0, 0.75], '--', 'color', colors{j} );
				end
				set( legend(h), 'location', 'SouthEast' );
				xlabel('Contrast');
				ylabel('Correct rate');
				set( gca, 'XLim', [0, 1], 'FontSize', 20 );
				title( data(iGroup).sessionName, 'FontSize', 12, 'Interpreter', 'none' );
			end
		end


		function CheckEyeTrace( dataFileName )
			Trials = load(dataFileName);
			Trials = Trials.Trials;
			set( figure, 'NumberTitle', 'off', 'name', 'CheckEyeTrace | iTrial: 1', 'WindowKeyReleaseFcn', @plotEyeTrace );
			hold on;
			iTrial = 2;
			plotEyeTrace( gcf, struct('Key', 'leftarrow') );

			function plotEyeTrace( hFig, evnt )
				switch evnt.Key
					case 'leftarrow'
						iTrial = mod( iTrial-1 - 1, size(Trials,2) ) + 1;
					
					case 'downarrow'
						iTrial = mod( iTrial-1 - 10, size(Trials,2) ) + 1;
					
					case 'rightarrow'
						iTrial = mod( iTrial-1 + 1, size(Trials,2) ) + 1;

					case 'uparrow'
						iTrial = mod( iTrial-1 + 10, size(Trials,2) ) + 1;
					
					case { 'return' }
						iTrial = sscanf( input( 'iTrial: ', 's' ), '%d' );
						if( iTrial < 1 ) iTrial = 1;
						elseif( iTrial > size(Trials,2) ) iTrial = size(Trials,2); end
				end
				
				cla;
				set( hFig, 'name', sprintf( 'CheckEyeTrace | iTrial: %d', iTrial ) );
				title( sprintf( 'iTrial: %d', iTrial ) );
				set( gca, 'FontSize', 24 );
				xlabel( 'Time (ms)' );
				ylabel( 'Eye position (degrees)' );
				
				% eye trace
				h(1:2) = plot( [Trials(iTrial).x.position; Trials(iTrial).y.position]'/60 );
				set( h(1), 'DisplayName', 'Eye X' );
				set( h(2), 'DisplayName', 'Eye Y' );
				YLim = get( gca, 'YLim' );

				% saccades
				saccades = Trials(iTrial).saccades;
				for( iSac = 1 : size( saccades.start, 2 ) )
					plot( (0:saccades.duration(iSac)-1) + saccades.start(iSac), Trials(iTrial).x.position( (0:saccades.duration(iSac)-1) + saccades.start(iSac) )/60, 'color', 'k', 'LineWidth', 2 );
					plot( (0:saccades.duration(iSac)-1) + saccades.start(iSac), Trials(iTrial).y.position( (0:saccades.duration(iSac)-1) + saccades.start(iSac) )/60, 'color', 'k', 'LineWidth', 2 );
				end

				% microsaccades
				microsaccades = Trials(iTrial).microsaccades;
				for( iSac = 1 : size( Trials(iTrial).microsaccades.start, 2 ) )
					plot( (0:microsaccades.duration(iSac)-1) + microsaccades.start(iSac), Trials(iTrial).x.position( (0:microsaccades.duration(iSac)-1) + microsaccades.start(iSac) )/60, 'color', 'r', 'LineWidth', 2 );
					plot( (0:microsaccades.duration(iSac)-1) + microsaccades.start(iSac), Trials(iTrial).y.position( (0:microsaccades.duration(iSac)-1) + microsaccades.start(iSac) )/60, 'color', 'r', 'LineWidth', 2 );
				end


				% fp on
				h(3) = plot( [1 1] * (Trials(iTrial).tFpOn - Trials(iTrial).tTrialStart), YLim, 'b', 'DisplayName', 'Fp On' );

				% beep on
				h(4) = plot( [1 1] * (Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart), YLim, 'r', 'DisplayName', 'Beep On' );

				% response
				h(5) = plot( [1 1] * (Trials(iTrial).tResponse - Trials(iTrial).tTrialStart), YLim, 'g', 'DisplayName', 'Response' );

				% ramp
				h(6) = fill( [ [1 1] * Trials(iTrial).tRampOn, [1 1] * Trials(iTrial).tPlateauOn ] - Trials(iTrial).tTrialStart, YLim([1 2 2 1]),...
							 [0 0 0], 'LineStyle', 'none', 'FaceColor', 'c', 'FaceAlpha', 0.25, 'DisplayName', 'Ramp' );

				% plateau
				h(7) = fill( [ [1 1] * Trials(iTrial).tPlateauOn, [1 1] * Trials(iTrial).tMaskOn ] - Trials(iTrial).tTrialStart, YLim([1 2 2 1]),...
							 [0 0 0], 'LineStyle', 'none', 'FaceColor', 'g', 'FaceAlpha', 0.5, 'DisplayName', 'Plateau' );

				% blinks
				starts = [Trials(iTrial).blinks.start];
				ends = starts + [Trials(iTrial).blinks.duration];
				if( ~isempty( starts ) )
					% h(1) = plot( [starts; starts], YLim, 'k:', 'DisplayName', 'Blink On' );
					% h(2) = plot( [ends; ends], YLim, 'k-', 'DisplayName', 'Blink Off' );
					h(8) = fill( reshape( [starts; ends; ends; starts; starts], 1, [] ), reshape( repmat( YLim([1 1 2 2 1])', 1, size(starts,2) ), 1, [] ),...
								 [0 0 0], 'LineStyle', 'none', 'FaceColor', 'k', 'FaceAlpha', 0.9, 'DisplayName', 'Blink' );
				else
					title( sprintf( 'iTrial: %d | NO BLINK DETECTED!!!', iTrial ) );
				end

				set( legend(h), 'location', 'EastOutside' );
			end
		end


		function CheckEyeDrift( dataFileName )
			Trials = load(dataFileName);
			Trials = Trials.Trials;
			set( figure, 'NumberTitle', 'off', 'name', 'CheckEyeDrift | iTrial: 1', 'WindowKeyReleaseFcn', @plotDrift );
			hold on;
			iTrial = 2;
			plotDrift( gcf, struct('Key', 'leftarrow') );

			function plotDrift( hFig, evnt )
				switch evnt.Key
					case 'leftarrow'
						iTrial = mod( iTrial-1 - 1, size(Trials,2) ) + 1;
					
					case 'downarrow'
						iTrial = mod( iTrial-1 - 10, size(Trials,2) ) + 1;
					
					case 'rightarrow'
						iTrial = mod( iTrial-1 + 1, size(Trials,2) ) + 1;

					case 'uparrow'
						iTrial = mod( iTrial-1 + 10, size(Trials,2) ) + 1;
					
					case { 'return' }
						iTrial = sscanf( input( 'iTrial: ', 's' ), '%d' );
						if( iTrial < 1 ) iTrial = 1;
						elseif( iTrial > size(Trials,2) ) iTrial = size(Trials,2); end
				end
				
				cla;
				set( hFig, 'name', sprintf( 'CheckEyeDrift | iTrial: %d', iTrial ) );
				title( sprintf( 'iTrial: %d', iTrial ) );
				set( gca, 'FontSize', 24 );
				xlabel( 'Time (ms)' );
				ylabel( 'Eye position (degrees)' );
				
				% eye trace
				x = zeros( 1, sum([Trials(iTrial).drifts.duration]) );
				y = zeros(size(x));
				index = 0;
				for( i = 1 : size( Trials(iTrial).drifts.start, 2 ) )
					if( any( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration ) || any( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start ) )
						continue;
					end
					x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).x.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
					y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).y.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
					if( index > 0 )
						x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = x( (1 : Trials(iTrial).drifts.duration(i)) + index ) - x(index+1) + x(index);
						y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = y( (1 : Trials(iTrial).drifts.duration(i)) + index ) - y(index+1) + y(index);
					end
					index = index + Trials(iTrial).drifts.duration(i);
				end
				x( index+1 : end ) = [];
				y( index+1 : end ) = [];
				h = plot( [x; y]'/1 );
				if( isempty(h) ) return; end
				set( h(1), 'DisplayName', 'Eye X' );
				set( h(2), 'DisplayName', 'Eye Y' );
				set( legend(h), 'location', 'EastOutside' );
			end
		end


		function RT = BlinkRT( dataFileName )
			load(dataFileName);
			set( figure, 'NumberTitle', 'off', 'name', 'BlinkRT' );

			RT = ones(size(Trials)) * -1;
			for( iTrial = size(Trials,2) : -1 : 1 )
				starts = [Trials(iTrial).blinks.start];
				ends = starts + [Trials(iTrial).blinks.duration];
				starts( starts <= Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart ) = [];
				ends( ends <= Trials(iTrial).tBlinkBeepOn ) = [];
				if( isempty(starts) ) continue; end

				RT(iTrial) = starts(1) - (Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart);
			end
			RT(RT < 0) = [];
			hist( RT, 0:10:1000 );
		end


		function [driftPS, img] = PowerSpectrumAna( dataFileName )
			load( dataFileName );

			swPix = 2560;	% screen width in pixels
			swMm = 600;		% screen width in mm
			shPix = 1440;	% screen height in pixels
			shMm = 335;		% screen height in mm
			sDist = 1620;%1190;	% distance from screen to subject's eye in mm
			gwPix = 720;	% width of gabor patch in pixels; half of the screen height
			sigma = 180;%120;
			sf = 10;
			wlPix = gwPix / ( atand( gwPix/shPix*shMm/2 / sDist ) * 2 * sf );
			orientation = 0;
			phase = 0;
			bgnLuminance = BlinkTransient.Intensity2Luminance(128);
			gbAmp = BlinkTransient.Intensity2Luminance(128+8) - bgnLuminance;
			img = zeros( swPix, shPix );	% 1st dimension: horizontal (width); 2nd dimension: vertical (height)
			gabor = ToolKit.Gabor( wlPix, orientation, phase, sigma, gwPix, 'grating' )' * gbAmp;
			img( (swPix-gwPix)/2 + (1:gwPix), (shPix-gwPix)/2 + (1:gwPix) ) = gabor / bgnLuminance;
			figure;
			FontSize = 24;
		 	pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);
			subplot(2,2,1);
			set( gca, 'FontSize', FontSize );
			imshow( img, BlinkTransient.Intensity2Luminance([0 255]) / bgnLuminance - 1 );
			set( gca, 'XDir', 'normal' );

			Win = 1;	% e.g., Hanning Window
			U = 1;	% scale factor for Win
			PSX = floor(gwPix);
			PSY = floor(gwPix);
			PSZ = 1024;
			NSamples = PSX * PSY * PSZ;
			driftPS = zeros( PSX/2+1, 50, 'single');
			sFreqs = (0 : size(driftPS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
			tFreqs = (0 : size(driftPS,2)-1) / (PSZ/1000);
			mov = zeros( PSX, PSY, PSZ, 'single' );

			nValidTrials = size(Trials,2);
			for( iTrial = 1: size(Trials,2) )
				% get eye drift
				x = zeros( 1, sum([Trials(iTrial).drifts.duration]) );
				y = zeros(size(x));
				index = 0;
				for( i = 1 : size( Trials(iTrial).drifts.start, 2 ) )
					if( any( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration ) || any( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start ) )
						continue;
					end
					x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).x.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
					y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).y.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
					if( index > 0 )
						x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = x( (1 : Trials(iTrial).drifts.duration(i)) + index ) - x(index+1) + x(index);
						y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = y( (1 : Trials(iTrial).drifts.duration(i)) + index ) - y(index+1) + y(index);
					end
					index = index + Trials(iTrial).drifts.duration(i);
				end
				x( index+1 : end ) = [];
				y( index+1 : end ) = [];
				if( size(x,2) < PSZ )
					nValidTrials = nValidTrials - 1;
					continue;
				end
				x = x(1:PSZ);
				y = y(1:PSZ);
				subplot(2,2,3);
				set( gca, 'FontSize', FontSize );
				hold on;
				% plot( [x;y]' );

				% rotate by -orientation
				orientation = 45;
				xx = x * cosd(orientation) + y * sind(orientation);
				yy = y * cosd(orientation) - x * sind(orientation);
				x = round(xx);
				y = round(yy);
				% plot( [x;y]' );

				% convert to pixels
				x = round( sDist * tand(x/60) / swMm * swPix );
				y = round( sDist * tand(y/60) / shMm * shPix );
				plot( [x;y]' );

				% power spectrum
				startXmin = max([0,-min(x)]) + 1;
				startXmax = ( size(img,1) - max([0,max(x)]) ) - (PSX-1);
				startYmin = max([0,-min(y)]) + 1;
				startYmax = ( size(img,2) - max([0,max(y)]) ) - (PSY-1);
				for( startX = [startXmin, round((startXmin+startXmax)/2), startXmax] )
					for( startY = [startYmin, round((startYmin+startYmax)/2), startYmax] )
						for( t = 1 : PSZ )
							mov(:,:,t) = img( (0:PSX-1)+startX+x(t), (0:PSY-1)+startY+y(t) );
						end
						mov = ( mov - mean(mov(:)) ) .* Win;
						tPS = reshape( sum(fftn(mov),2), PSX, [] );
						driftPS = driftPS + abs( tPS( 1:size(driftPS,1), 1:size(driftPS,2) ) ).^2;	% discard negative frequency part
							% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)
					end
				end
			end
			if( size(driftPS,2) < PSZ )
				driftPS(2:end-1, 2:end) = 2^2 * driftPS(2:end-1, 2:end);	% convert to single sided
			else
				driftPS(2:end-1, 2:end-1) = 2^2 * driftPS(2:end-1, 2:end-1);	% convert to single sided
			end
			driftPS = driftPS / ( PSX * (PSX/(atand(PSX/swPix*swMm/2/sDist)*2)) * PSY * (PSY/(atand(PSY/shPix*shMm/2/sDist)*2)) * PSZ * 1000 * U ) / 9 / size(nValidTrials,2);	% average over 9 overlapped windows and all eye traces
			save( 'Drift_PS_theory.mat', 'driftPS' );

			subplot(2,2,[2 4]);
			colormap('hot');
			set( pcolor( sFreqs, tFreqs, driftPS' ), 'LineStyle', 'none' );
			caxis( [0 max(driftPS(:))] );
			colorbar;
			set( gca, 'FontSize', FontSize );
		end


		function [PS, sFreqs, tFreqs] = QRadPowerSpectrumAna( dataFileName, modulator )
			%% modulator:		drift, blink, or drift+blink
			
			modulator = lower(modulator);

			load( dataFileName );

			swPix = 2560;	% screen width in pixels
			swMm = 600;		% screen width in mm
			shPix = 1440;	% screen height in pixels
			shMm = 335;		% screen height in mm
			sDist = 1620;%1190;	% distance from screen to subject's eye in mm
			gwPix = 720;	% width of gabor patch in pixels; half of the screen height
			sigma = 180;%120;
			sf = 10;
			wlPix = gwPix / ( atand( gwPix/shPix*shMm/2 / sDist ) * 2 * sf );
			orientation = 0;
			phase = 0;
			bgnLuminance = BlinkTransient.Intensity2Luminance(128);
			gbAmp = BlinkTransient.Intensity2Luminance(128+8) - bgnLuminance;
			img = zeros( swPix, shPix );	% 1st dimension: horizontal (width); 2nd dimension: vertical (height)

			Win = 1;	% e.g., Hanning Window
			U = 1;	% scale factor for Win
			PSX = floor(gwPix);
			PSY = floor(gwPix);
			PSZ = 1024;
			NSamples = PSX * PSY * PSZ;
			PS = zeros( PSX/2+1, 50, 'single');
			sFreqs = (0 : size(PS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
			tFreqs = (0 : size(PS,2)-1) / (PSZ/1000);
			mov = zeros( PSX, PSY, PSZ, 'single' );

			% set( figure, 'NumberTitle', 'off', 'name', dataFileName );
			% pause(0.1);
			% jf = get(handle(gcf),'javaframe');
			% jf.setMaximized(1);
			% pause(0.5);
			FontSize = 20;
			LineWidth = 1.5;
			
			%% gabor patch
			gabor = ToolKit.Gabor( wlPix, orientation, phase, sigma, gwPix, 'grating' )' * gbAmp;
			% gabor = zeros(gwPix,gwPix);
			% for( f = sFreqs )
			% 	gabor = gabor + ToolKit.Gabor( gwPix / ( atand( gwPix/shPix*shMm/2 / sDist ) * 2 * f ), orientation, phase, sigma, gwPix, 'grating' )';
			% end
			% gabor = gabor * gbAmp;
			img( (swPix-gwPix)/2 + (1:gwPix), (shPix-gwPix)/2 + (1:gwPix) ) = gabor / bgnLuminance;
			% subplot(2,2,1);
			% hold on;
			% imshow( img, BlinkTransient.Intensity2Luminance([0 255]) / bgnLuminance - 1 );
			% set( gca, 'XDir', 'normal' );


			%% power spectrum of the image
			% PSImg = zeros( PSX/2+1, PSY/2+1, 'single' );
			% for( startX = floor((size(img,1)-PSX) * [0 0.5 1] + 1) )
			% 	for( startY = floor((size(img,2)-PSY) * [0 0.5 1] + 1) )
			% 		tPS = fft2( img( startX + (0:PSX-1), startY + (0:PSY-1) ) );
			% 		PSImg = PSImg + abs( tPS( 1:size(PSImg,1), 1:size(PSImg,2) ) ).^2;
			% 	end
			% end
			% PSImg( :, 2:end-1 ) = PSImg( :, 2:end-1 ) * 2;
			% PSImg( 2:end-1, : ) = PSImg( 2:end-1, : ) * 2;
			% PSImg = 35 * PSImg / ( PSX * (PSX/(atand(PSX/swPix*swMm/2/sDist)*2)) * PSY * (PSY/(atand(PSY/shPix*shMm/2/sDist)*2)) ) / 9;		% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)
			% subplot(2,2,1);
			% colormap('hot');
			% set( pcolor( sFreqs, sFreqs, PSImg' ), 'LineStyle', 'none' );
			% caxis( [0 max(PSImg(:))] );
			% colorbar;
			% set( gca, 'FontSize', FontSize );

			%% power spectrum of e^( -i*2*pi*sFreq*Eye(t）), where Eye(t) is eye trace
			Win = ones(1,PSZ);
			nValidTrials = size(Trials,2);
			for( iTrial = 1:size(Trials,2) )
				if( strcmp( modulator, 'blink' ) )	% blink only
					x = zeros(1,PSZ);
					y = zeros(1,PSZ);
				else
					% get eye drift
					x = zeros( 1, sum([Trials(iTrial).drifts.duration]) );
					y = zeros(size(x));
					index = 0;
					for( i = 1 : size( Trials(iTrial).drifts.start, 2 ) )
						if( any( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration ) || any( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start ) )
							continue;
						end
						x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).x.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
						y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).y.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
						if( index > 0 )
							x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = x( (1 : Trials(iTrial).drifts.duration(i)) + index ) - x(index+1) + x(index);
							y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = y( (1 : Trials(iTrial).drifts.duration(i)) + index ) - y(index+1) + y(index);
						end
						index = index + Trials(iTrial).drifts.duration(i);
					end
					x( index+1 : end ) = [];
					y( index+1 : end ) = [];
					if( size(x,2) < PSZ )
						nValidTrials = nValidTrials - 1;
						continue;
					end
					x = x(1:PSZ);
					y = y(1:PSZ);
					% subplot(2,2,3);
					% set( gca, 'FontSize', FontSize );
					% hold on;
					% plot( [x;y]' );

					% rotate by -orientation
					orientation = 45;
					xx = x * cosd(orientation) + y * sind(orientation);
					yy = y * cosd(orientation) - x * sind(orientation);
					% plot( [x;y]' );
				end

				if( strcmp( modulator, 'drift' ) )		% drift only
					Gt = 1;
					Gt = (0:PSZ-1)/(PSZ-1);		% ramping
				else
					% consider that blink decreases the luminance (not contrast) to a proportion of p;
					%   contrast does not change!!! ((gbAmp + bgnLuminance) * p - bgnLuminance*p) / (bgnLuminance*p) == ( (gbAmp + bgnLuminance) - bgnLuminance ) / bgnLuminance;
					p = 0;
					Gt = ones(1,PSZ);
					d = randi(501) - 251;
					Gt( (1:350) + (end-350)/2 + d ) = 0;
					Gt( (1:20) + (end-350)/2 + d ) = 1 - (1:20)/20;
					Gt( (350:-1:331) + (end-350)/2 + d ) = 1 - (1:20)/20;

					% Gt = (0:PSZ-1)/(PSZ-1);
					% Gt( (1:350) + (end-350)/2 + d ) = 0;
					% Gt( (1:20) + (end-350)/2 + d ) = ( 1 - (1:20)/20 ) * Gt((end-350)/2 + d + 1);
					% Gt( (350:-1:331) + (end-350)/2 + d ) = ( 1 - (1:20)/20 ) * Gt((end-350)/2 + d + 350);

					subplot(2,2,2); hold off;
					plot( 1:PSZ, Gt*100, 'LineWidth', 2 );
					set( gca, 'XLim', [0 PSZ], 'YLim', [0 101], 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
					xlabel( 'Time (ms)' );
					ylabel( 'Contrast gain (%)' );
					title( 'Blink simulation' );
				end

				% tPS = repmat( sum(PSImg,2), 1, size(x,2) ) .* QRad_fft2_SingleTrace(sFreqs, size(x,2), 0, x, y, Win)';
				if( strcmp( modulator, 'drift' ) )		% drift only
					tPS = QRad_Welch_SingleTrace(sFreqs, PSZ/2, 0, x, y, Win(1:PSZ/2), 1000)' * 1000 * PSZ;
					tFreqs = (0 : size(PS,2)-1) / (PSZ/2/1000);
					% tPS = QRad_fft2_SingleTrace(sFreqs, size(x,2), 0, x, y, Win)';
				else
					tPS = QRad_fft2_SingleTrace(sFreqs, size(x,2), 0, x, y, Win, Gt)';
				end
				PS = PS + tPS(:,1:size(PS,2));
			end
			if( size(PS,2) < PSZ )
				PS( :, 2:end ) = 2 * PS( :, 2:end );	% convert to single sided
			else
				PS( :, 2:end-1 ) = 2 * PS( :, 2:end-1 );	% convert to single sided
			end
			PS = PS / (PSZ*1000) / size(nValidTrials,2);	% fft^2 / (N*Fs); and average over all eye traces
			save( 'PS_QRad.mat', 'PS' );

			if( strcmp( modulator, 'drift' ) )
				subplot(2,2,1);
			elseif( strcmp( modulator, 'blink' ) )
				subplot(2,2,4);
			else
				subplot(2,2,3);
			end
			colormap('hot');
			contour( sFreqs(2:end), tFreqs(2:end), PS(2:end,2:end)', 1000, 'LineStyle', 'none', 'fill', 'on' );
			caxis( [0 max(max(PS(2:end,2:end)))] );
			colorbar;
			xlabel( 'Spatial frequency (cpd)' );
			ylabel( 'Temporal frequency (Hz)' );
			title( [ upper(modulator(1)), modulator(2:end) ] );
			position = get( gca, 'position' );
			% position(2) = position(2) + 0.05;	% move up by 0.05 (position: [ left bottom, width, height ])
			% position(4) = position(4) - 0.1;
			set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [0.5 60], 'YLim', [tFreqs(2), (size(PS,2)-1) / (PSZ/1000)], 'XTick', [1 5 10 20 40], 'YTick', [1 5 10 20 40 80], 'position', position );
		end


		function PlotPSDSummary()

			global PS_D;
			global sFreqs_D;
			global tFreqs_D;
			global  PS_B;
			global sFreqs_B;
			global  tFreqs_B;
			global PS_DB;
			global sFreqs_DB;
			global tFreqs_DB;

			% figure;
			% pause(0.1);
			% jf = get(handle(gcf),'javaframe');
			% jf.setMaximized(1);
			% pause(0.5);
			% [PS_D, sFreqs_D, tFreqs_D] = BlinkTransient.QRadPowerSpectrumAna('F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\MH\3-11-13\Trials.mat','drift');
			% [PS_B, sFreqs_B, tFreqs_B] = BlinkTransient.QRadPowerSpectrumAna('F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\MH\3-11-13\Trials.mat','blink');
			% [PS_DB, sFreqs_DB, tFreqs_DB] = BlinkTransient.QRadPowerSpectrumAna('F:\MsacCS_VisRes16\Matlab codes and data\Data\LSF(0.8cpd)\MH\3-11-13\Trials.mat','drift+blink');

			set( figure, 'NumberTitle', 'off', 'name', 'PSDSummary' );
			FontSize = 24;
			LineWidth = 2;
			subplot(1,2,1);
			hold on;
			colors = {'m', 'b', 'c', 'k'};
			f = [5 10 20];
			h = [];
			for( iF = 1:3 )
				y = zeros(size(sFreqs_D));
				for( i = 1 : size(sFreqs_D,2) )
					y(i) = interp1( tFreqs_D, PS_D(i,:), f(iF), 'linear' );
				end
				plot( sFreqs_D, y, '--', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift', f(iF) ) );

				y = zeros(size(sFreqs_B));
				for( i = 1 : size(sFreqs_B,2) )
					y(i) = interp1( tFreqs_B, PS_B(i,:), f(iF), 'linear' );
				end
				plot( sFreqs_B, y, ':', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Blink', f(iF) ) );

				y = zeros(size(sFreqs_DB));
				for( i = 1 : size(sFreqs_DB,2) )
					y(i) = interp1( tFreqs_DB, PS_DB(i,:), f(iF), 'linear' );
				end
				plot( sFreqs_DB, y, '-', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift+blink', f(iF) ) );
			end
			plot( sFreqs_D, sum( PS_D(:,2:end), 2 ) * (tFreqs_D(2) - tFreqs_D(1)), '--', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift' );
			plot( sFreqs_B, sum( PS_B(:,2:end), 2 ) * (tFreqs_B(2) - tFreqs_B(1)), ':', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Blink' );
			plot( sFreqs_DB, sum( PS_DB(:,2:end), 2 ) * (tFreqs_DB(2) - tFreqs_DB(1)), '-', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift+blink' );
			
			names = { '5', '10', '20', 'NonZero' };
			for( i = 1 : 4 )
				h(end+1) = plot( -1, -1, 'LineStyle', 'none', 'Marker', 'Square', 'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i}, 'DisplayName', [names{i} ' Hz'] );
			end
			h(end+1) = plot( -1, -1, 'k--', 'LineWidth', LineWidth, 'DisplayName', 'Drift' );
			h(end+1) = plot( -1, -1, 'k:', 'LineWidth', LineWidth, 'DisplayName', 'Blink' );
			h(end+1) = plot( -1, -1, 'k', 'LineWidth', LineWidth, 'DisplayName', 'Drift+blink' );
			set( legend(h), 'location', 'Southeast' );
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [sFreqs_D(2), 20], 'XTick', [1 10], 'XTickLabel', [1 10], 'YLim', [0.0001 300], 'YTick', [0.01 1 100], 'YTickLabel', [0.01 1 100] );
			xlabel('Spatial frequency (cpd)');
			ylabel('Power spectral density');

			subplot(1,2,2);
			hold on;
			k = [1 10];
			colors = {'m', 'b'};
			h = [];
			for( iK = 1:2 )
				y = zeros(size(tFreqs_D));
				for( i = 1 : size(tFreqs_D,2) )
					y(i) = interp1( sFreqs_D, PS_D(:,i), k(iK), 'linear' );
				end
				h(end+1) = plot( tFreqs_D, y, '--', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Drift', k(iK) ) );

				y = zeros(size(tFreqs_B));
				for( i = 1 : size(tFreqs_B,2) )
					y(i) = interp1( sFreqs_B, PS_B(:,i), k(iK), 'linear' );
				end
				h(end+1) = plot( tFreqs_B, y, ':', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Blink', k(iK) ) );

				y = zeros(size(tFreqs_DB));
				for( i = 1 : size(tFreqs_DB,2) )
					y(i) = interp1( sFreqs_DB, PS_DB(:,i), k(iK), 'linear' );
				end
				h(end+1) = plot( tFreqs_DB, y, '-', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Drift+blink', k(iK) ) );
			end
			set( legend(h), 'location', 'Southeast' );
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 60], 'XTick', [1 10 40], 'XTickLabel', [1 10 40], 'YLim', [0.0001 300], 'YTick', [0.01 1 100], 'YTickLabel', [0.01 1 100] );
			xlabel('Temporal frequency (Hz)');
			ylabel('Power spectral density');

		end


		function ShowParadigm()
			set( figure, 'NumberTitle', 'off', 'name', 'BlinkTransient.Paradigm', 'color', 'w' );
			axis([0 100 0 100]);
			set( gca, 'position', [0 0 1 1], 'visible', 'off' );
		end


		function luminances = Intensity2Luminance( intensities )
			nMeasureData = 3;
			for( i = nMeasureData : -1 : 1 )
				data(i) = load( sprintf( 'F:/BlinkTransient/Monitor Calibration/ASUS278_Contrast_0_Brightness_0_Test_Dist_162_BS_BW_Repeat%d.mat', i+4 ) );

				% measured bit steeling intensities
				bitSteelingSteps = data(i).calResult.bitSteelingSteps;
				lums(i,:) = data(i).calResult.inputValuesBitSteeling(4,:);

				% for non-measured bit steeling intensities
				% ratio = ( data(i).calResult.inputValuesBitWise(:,1:end-1) - repmat( data(i).calResult.inputValues(4,1:end-1), 7, 1 ) );
				% ratio = ratio ./ repmat( ratio(end,:), 7, 1 );
				% meanRatio(i,:) = [0, mean(ratio, 2)'];
				% use slopes of three color guns to calculate meanRatio
				Y = reshape( data(i).calResult.inputValues', [], 1 );
				X = zeros( size(Y,1), 5 );
				X(:,1) = 1;
				for( ii = 2 : 5 )
					X( (1:length(data(i).calResult.ramp)) + (ii-2) * length(data(i).calResult.ramp), ii ) = data(i).calResult.ramp;
				end
				betas = regress(Y,X);
				meanRatio(i,:) = betas(2:4)' * [0,0,0; 0,0,1; 0,1,0; 0,1,1; 1,0,0; 1,0,1; 1,1,0; 1,1,1]' / sum(betas(2:4));
			end
			lums = mean(lums,1);

			decLUT =  [ 0,0,0; 0,0,1; 0,1,0; 1,0,0; 0,1,1; 1,0,1; 1,1,0; 1,1,1 ];	% for data collected before monitor calibration
			decLUT =  [ 0,0,0; 0,0,1; 1,0,0; 1,0,1; 0,1,0; 0,1,1; 1,1,0; 1,1,1 ];

			luminances = zeros(size(intensities));
			for( iIntensity = 1 : size(intensities,2) )
				if( false && any( abs(bitSteelingSteps - intensities(iIntensity)) < 1e-6 ) )	% the measured the luminances became unreliable after the Colorimeter worked for a long time 
					luminances(iIntensity) = lums( abs(bitSteelingSteps - intensities(iIntensity)) < 1e-6 );
				else
					for( i = nMeasureData : -1 : 1 )
						%% power or linear fitting (Not used, because they produce systematic errors compared to measured luminances, so I stick to linear interpolation)
						% if( any( intensities(iIntensity) == data(i).calResult.ramp ) )
						% 	lum(i) = data(i).calResult.inputValues( 4, intensities(iIntensity) == data(i).calResult.ramp );
						% else
						% 	% power fitting
						% 	lum(i) = power( intensities(iIntensity)/255, data(i).calResult.displayGamma(4) ) * data(i).calResult.displayRange(4) + data(i).calResult.displayBaseline(4);

						% 	% linear fitting
						% 	Y = reshape( data(i).calResult.inputValues', [], 1 );
						% 	X = zeros( size(Y,1), 5 );
						% 	X(:,1) = 1;
						% 	for( ii = 2 : 5 )
						% 		X( (1:length(data(i).calResult.ramp)) + (ii-2) * length(data(i).calResult.ramp), ii ) = data(i).calResult.ramp;
						% 	end
						% 	betas = regress(Y,X);
						% 	lum(i) = betas(1) + betas(5) * intensities(iIntensity);
						% end

						%% linear interpolation (Both linear fitting and power fitting produce systematic errors compared to measured luminances, so I stick to linear interpolation)
						if( intensities(iIntensity) == floor(intensities(iIntensity)) )
							lum(i) = interp1( data(i).calResult.ramp, data(i).calResult.inputValues(4,:), intensities(iIntensity), 'linear' );

						else 	% using bit stealing for non-integer intensities
							decimal = ( intensities(iIntensity) - floor( intensities(iIntensity) ) ) * 7;
							tmpLums = interp1( data(i).calResult.ramp, data(i).calResult.inputValues(4,:), [0 1] + floor(intensities(iIntensity)), 'linear' );
							lum(i) =  tmpLums(1) + (tmpLums(2) - tmpLums(1)) * ( meanRatio( i, decLUT( floor(decimal)+1, : ) * [4 2 1]' + 1 ) .* (1 - (decimal - floor(decimal))) + meanRatio( i, decLUT( floor(decimal)+2, : ) * [4 2 1]' + 1 ) .* (decimal - floor(decimal)) );
						end
					end
					luminances(iIntensity) = mean(lum);
				end
			end
		end

		function lumins = MeasureLuminance( intensities, varargin )
			%% intensities:		1-row array specifying float gray level intensities at range of [0,255]

			decLUT =  [ 0,0,0; 0,0,1; 0,1,0; 1,0,0; 0,1,1; 1,0,1; 1,1,0; 1,1,1 ];		% for data collected before monitor calibration
			% decLUT = [ 0, 0, 0; 0, 0, 1; 1, 0, 0; 1, 0, 1; 0, 1, 0; 0, 1, 1, 1, 1, 0; 1, 1, 1 ]; % look up table for decimal part of the intensity
			lumins = zeros(size(intensities));
			for( iIntensity = 1 : size(intensities,2) )
				decimal = intensities(iIntensity) - floor(intensities(iIntensity)) * 7;
				lumins(iIntensity) = intensity2Luminance( [1 1 1] * floor(intensities(iIntensity)) + decLUT(floor(decimal)+1,:) ) * (1 - (decimal - floor(decimal))) +...
									 intensity2Luminance( [1 1 1] * floor(intensities(iIntensity)) + decLUT(floor(decimal)+2,:) ) * (decimal - floor(decimal));
			end

			function luminance = intensity2Luminance(intensity)
				%% intensity:	integer vector of RGB intensity at range of [0,255]
				luminance = intensity;
				if( any( intensity - min(intensity) ) )	% look up gray table for min(intensity), then look up tables for individual color guns to add extra luminance
					;
				else	% look up the table for gray level
					;
				end
			end
		end

		function VerifyBS()
			n = 7;
			for( i = n : -1 : 1 )
				% data(i) = load(sprintf('D:/0 Research/3 Blink/BlinkTransientExp/BlinkTransient/BlinkTransient/data/yb/Monitor Calibration/ASUS278_Contrast_50_Brightness_50_Measure_Dist_122_BS_BW_Repeat%d.mat',i));
				data(i) = load(sprintf('D:/0 Research/3 Blink/BlinkTransientExp/BlinkTransient-DPI/BlinkTransient/data/yb/Monitor Calibration/ASUS278_Contrast_0_Brightness_0_Test_Dist_162_BS_BW_Repeat%d.mat',i));
			end
			decLUT =  [ 0,0,0; 0,0,1; 0,1,0; 1,0,0; 0,1,1; 1,0,1; 1,1,0; 1,1,1 ];	% for data collected before monitor calibration
			decLUT =  [ 0,0,0; 0,0,1; 1,0,0; 1,0,1; 0,1,0; 0,1,1; 1,1,0; 1,1,1 ];
			colors = {'r','g','b','k','m','c','y',[0.5 0.5 0.5]};
			figure;
			subplot(2,2,1); cla; hold on;
			subplot(2,2,2); cla; hold on;
			for( i = 1 : n )
				subplot(2,2,1);
				plot( data(i).calResult.bitSteelingSteps, data(i).calResult.inputValuesBitSteeling(4,:), '-o', 'color', colors{i} );
				
				ratio = ( data(i).calResult.inputValuesBitWise(:,1:end-1) - repmat( data(i).calResult.inputValues(4,1:end-1), 7, 1 ) );
				ratio = ratio ./ repmat( ratio(end,:), 7, 1 );
				meanRatio = [0, mean(ratio, 2)'];
				decimal = ( data(i).calResult.bitSteelingSteps - floor( data(i).calResult.bitSteelingSteps ) ) * 7;

				% linear fitting, only for test data
				Y = reshape( data(i).calResult.inputValues', [], 1 );
				X = zeros( size(Y,1), 5 );
				X(:,1) = 1;
				for( ii = 2 : 5 )
					X( (1:length(data(i).calResult.ramp)) + (ii-2) * length(data(i).calResult.ramp), ii ) = data(i).calResult.ramp;
				end
				betas = regress(Y,X);
				% luminance = betas(1) + betas(5) .* ( floor(data(i).calResult.bitSteelingSteps) + meanRatio( decLUT( floor(decimal)+1, : ) * [4 2 1]' + 1 ) .* (1 - (decimal - floor(decimal))) + meanRatio( decLUT( floor(decimal)+2, : ) * [4 2 1]' + 1 ) .* (decimal - floor(decimal)) );
				
				% gamma function
				normLum = power( [ floor(data(i).calResult.bitSteelingSteps); floor(data(i).calResult.bitSteelingSteps)+1 ] / 255, data(i).calResult.displayGamma(4) );
				luminance = data(i).calResult.displayBaseline(4) + data(i).calResult.displayRange(4) * ( normLum(1,:) + ( normLum(2,:) - normLum(1,:) ) .* ( meanRatio( decLUT( floor(decimal)+1, : ) * [4 2 1]' + 1 ) .* (1 - (decimal - floor(decimal))) + meanRatio( decLUT( floor(decimal)+2, : ) * [4 2 1]' + 1 ) .* (decimal - floor(decimal)) ) );
				
				plot( data(i).calResult.bitSteelingSteps, luminance, '--^', 'color', colors{i} );

				Ratio(:,:,i) = ratio;

				subplot(2,2,2);
				intensity = repmat( data(i).calResult.ramp, 8, 1 ) + repmat( (0:7)/7, 17, 1 )';
				intensity(:,end) = [intensity(2:8,end) - 1; intensity(1,end)];
				luminance = [ data(i).calResult.inputValues(4,:); data(i).calResult.inputValuesBitWise ];
				luminance(:,end) = luminance([2:8,1],end);
				plot( intensity(:), luminance(:), '-o', 'color', colors{i} );

				normLum = power( [data(i).calResult.ramp(1:end-1); data(i).calResult.ramp(1:end-1) + 1] / 255, data(i).calResult.displayGamma(4) );
				normLum = repmat( normLum(2,:) - normLum(1,:), 7, 1 ) .* ratio + repmat( normLum(1,:), 7, 1 );
				luminance = normLum * data(i).calResult.displayRange(4) + data(i).calResult.displayBaseline(4);
				intensity = repmat( data(i).calResult.ramp(1:end-1), 7, 1 ) + repmat( (1:7)/7, 16, 1 )';
				plot( intensity(:), luminance(:), ':^', 'color', colors{i} );
				plot( data(i).calResult.ramp, data(i).calResult.displayBaseline(4) + power( data(i).calResult.rampNorm, data(i).calResult.displayGamma(4) ) * data(i).calResult.displayRange(4), '--^', 'color', colors{i} );
				% plot( data(i).calResult.ramp, data(i).calResult.ramp * betas(5) + betas(1), '--^', 'color', colors{i} );
			end
			subplot(2,2,3); hold on;
			seq = decLUT(2:8,:) * [4 2 1]';
			for(i = 1 : size(Ratio,1))
				plot( [data(1).calResult.ramp(1:end-1) 250], [mean( Ratio(seq(i),:,:), 3 ), mean(mean( Ratio(seq(i),:,:), 3 ))], '^', 'color', colors{i} );
				% plot( data(1).calResult.ramp(1:end-1), data(1).calResult.inputValuesBitWise(seq(i),1:end-1) - data(1).calResult.inputValues(4,1:end-1), '^', 'color', colors{i} );
			end
		end
	end
end