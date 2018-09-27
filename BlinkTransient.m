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

		function main20180814( folder )
			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end

			sbj = { 'A034', 'A038', 'A074', 'A082', 'A088' };
			groups = { {1:3, 4:7, 8:11},...
					   {1:2, 3:6},...
					   {1:3, 4:7, 8:10},...
					   {1:3, 4:6, 7:8, 10:11, 12:14, 15:17, 18:20},...
					   {1} };

			set( figure, 'NumberTitle', 'off', 'name', 'BlinkRT', 'color', 'w' );
			nHRT = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

			set( figure, 'NumberTitle', 'off', 'name', 'Fixational saccade amplitude', 'color', 'w' );
			nHAmp = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

		 	set( figure, 'NumberTitle', 'off', 'name', ['Fixational saccade rate aligned to ', 'PlateauOn' ], 'color', 'w' );
			nHRate = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);
			
			for( iSbj = 1 : size(sbj,2) )
				figure(nHRT);
				subplot( 2, 3, iSbj );
				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ], [], true, [], false );
				title(sbj{iSbj});

				figure(nHAmp);
				subplot( 2, 3, iSbj );
				BlinkTransient.FixSacAmp( [ 'F:\BlinkTransient\', sbj{iSbj} ], true, [], [], false );
				title(sbj{iSbj});

				figure(nHRate);
				subplot( 2, 3, iSbj );
				BlinkTransient.SaccadesRate( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'PlateauOn', 'Gaussian', 100, true, false );
				title(sbj{iSbj});
			end

			saveas( figure(nHRT), [ folder, '\BlinkRT.fig' ] );
			saveas( figure(nHRT), [ folder, '\BlinkRT.png' ] );
			pause(1);
			close(figure(nHRT));

			saveas( figure(nHAmp), [ folder, '\FixSacAmp.fig' ] );
			saveas( figure(nHAmp), [ folder, '\FixSacAmp.png' ] );
			pause(1);
			close(figure(nHAmp));

			saveas( figure(nHRate), [ folder, '\FixSacRate. Aligned to PlateauOn.fig' ] );
			saveas( figure(nHRate), [ folder, '\FixSacRate. Aligned to PlateauOn.png' ] );
			pause(1);
			close(figure(nHRate));

			for( iSbj = 1 : size(sbj,2) )
				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. BlinkRT.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. BlinkRT.png' ] );
				pause(1);
				close;

				BlinkTransient.FixSacAmp( [ 'F:\BlinkTransient\', sbj{iSbj} ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. FixSacAmp.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. FixSacAmp.png' ] );
				pause(1);
				close;

				BlinkTransient.SaccadesRate( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'PlateauOn', 'Gaussian', 100 );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. FixSacRate. Aligned to PlateauOn.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. FixSacRate. Aligned to PlateauOn.png' ] );
				pause(1);
				close;

				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 0, 1 );
				title( 'All Sessions' );
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. OverallCurve.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. OverallCurve.png' ] );
				pause(0.5);
				close;

				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 1, 1 );
				title( 'All Sessions' );
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. CompCurves.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. CompCurves.png' ] );
				pause(0.5);
				close;

				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 1 );
				title( 'All Sessions' );
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. CompCurves. withMicrosacs.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. CompCurves. withMicrosacs.png' ] );
				pause(0.5);
				close;

				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 0 );
				title( 'All Sessions' );
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. CompCurves. withAllSacs.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '. CompCurves. withAllSacs.png' ] );
				pause(0.5);
				close;
			end
		end
			

		function main20180923( folder )
			%% remove trials with gabor amplitude less than 0.3 

			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end

			if( exist( folder, 'dir' ) ~= 7 ) mkdir(folder); end

			sbj = { 'A034', 'A038', 'A074', 'A082', 'A088' };
			groups = { {1:3, 4:7, 8:11, 12:15, 16:19, 20:23},...
					   {1:2, 3:6},...
					   {1:3, 4:7, 8:10},...
					   {1:3, 4:6, 7:8, 10:11, 12:14, 15:17, 18:20, 21:22, 23:25, 26:28, 29:32, 33:36, 37:40, 41:44, 45:48},...
					   {1, 2:4, 5:8} };

			set( figure, 'NumberTitle', 'off', 'name', 'BlinkRT' );
			nHRT = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

		 	set( figure, 'NumberTitle', 'off', 'name', 'BlinkAlign2Plateau' );
			nHB2P = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

			set( figure, 'NumberTitle', 'off', 'name', 'Fixational saccade amplitude' );
			nHAmp = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

		 	set( figure, 'NumberTitle', 'off', 'name', ['Fixational saccade rate aligned to ', 'PlateauOn' ] );
			nHRate = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

		 	set( figure, 'NumberTitle', 'off', 'name', 'Compare Fixational saccade rate' );
			nHRateBars = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);
			
			for( iSbj = 1 : size(sbj,2) )
				figure(nHRT);
				subplot( 2, 3, iSbj );
				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ], [], true, [], false );
				title(sbj{iSbj});

				figure(nHB2P);
				subplot( 2, 3, iSbj );
				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'tPlateauOn', true, [], false );
				title(sbj{iSbj});

				figure(nHAmp);
				subplot( 2, 3, iSbj );
				BlinkTransient.FixSacAmp( [ 'F:\BlinkTransient\', sbj{iSbj} ], true, [], [], false );
				title(sbj{iSbj});

				figure(nHRate);
				subplot( 2, 3, iSbj );
				BlinkTransient.CompSaccadesRate( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'PlateauOn', 'Gaussian', 100, true, false );
				title(sbj{iSbj});

				figure(nHRateBars);
				subplot( 2, 3, iSbj );
				BlinkTransient.CompSaccadesRateBars( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'whole', true, false );
				title(sbj{iSbj});
			end

			saveas( figure(nHRT), [ folder, '\BlinkRT.fig' ] );
			saveas( figure(nHRT), [ folder, '\BlinkRT.png' ] );
			saveas( figure(nHRT), [ folder, '\BlinkRT.eps' ], 'psc2' );
			pause(1);
			close(figure(nHRT));

			saveas( figure(nHB2P), [ folder, '\BlinkAlign2Plateau.fig' ] );
			saveas( figure(nHB2P), [ folder, '\BlinkAlign2Plateau.png' ] );
			saveas( figure(nHB2P), [ folder, '\BlinkAlign2Plateau.eps' ], 'psc2' );
			pause(1);
			close(figure(nHB2P));

			saveas( figure(nHAmp), [ folder, '\FixSacAmp.fig' ] );
			saveas( figure(nHAmp), [ folder, '\FixSacAmp.png' ] );
			saveas( figure(nHAmp), [ folder, '\FixSacAmp.eps' ], 'psc2' );
			pause(1);
			close(figure(nHAmp));

			saveas( figure(nHRate), [ folder, '\FixSacRate_Aligned2PlateauOn.fig' ] );
			saveas( figure(nHRate), [ folder, '\FixSacRate_Aligned2PlateauOn.png' ] );
			saveas( figure(nHRate), [ folder, '\FixSacRate_Aligned2PlateauOn.eps' ], 'psc2' );
			pause(1);
			close(figure(nHRate));

			saveas( figure(nHRateBars), [ folder, '\FixSacRate_CompWhole_Bars.fig' ] );
			saveas( figure(nHRateBars), [ folder, '\FixSacRate_CompWhole_Bars.png' ] );
			saveas( figure(nHRateBars), [ folder, '\FixSacRate_CompWhole_Bars.eps' ], 'psc2' );
			pause(1);
			close(figure(nHRateBars));

			for( iSbj = size(sbj,2) : -1 : 1 )
				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkRT.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkRT.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkRT.eps' ], 'psc2' );
				pause(1);
				close;

				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'tPlateauOn' );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkAlign2Plateau.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkAlign2Plateau.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkAlign2Plateau.eps' ], 'psc2' );
				pause(1);
				close;

				BlinkTransient.FixSacAmp( [ 'F:\BlinkTransient\', sbj{iSbj} ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacAmp.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacAmp.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacAmp.eps' ], 'psc2' );
				pause(1);
				close;

				BlinkTransient.CompSaccadesRate( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'PlateauOn', 'Gaussian', 100 );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_Aligned2PlateauOn.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_Aligned2PlateauOn.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_Aligned2PlateauOn.eps' ], 'psc2' );
				pause(1);
				close;

				BlinkTransient.CompSaccadesRateBars( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'whole' );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_CompWhole_Bars.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_CompWhole_Bars.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_CompWhole_Bars.eps' ], 'psc2' );
				pause(1);
				close;

				% continue;

				% BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 0, 1 );
				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { [ groups{iSbj}{:} ] }, 0, 0, 1 );
				h = get( gcf, 'children' );
				index = 1;
				nMax = 0;
				for( i = 1 : size(h,1) )
					if( strcmpi( class(h(i)), 'matlab.graphics.axis.axes' ) )
						nBlocks = sum( h(i).Title.String == '|' ) + 1;
						if( nMax < nBlocks )
							index = i;
							nMax = nBlocks;
						end
						h(i).Title.String = [ h(i).Title.String(1:8), ': ', num2str(nBlocks), ' blocks' ];
					end
				end
				h(index).Title.String = ['All sessions: ', num2str(nMax), ' blocks'];
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_OverallCurve.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_OverallCurve.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_OverallCurve.eps' ], 'psc2' );
				pause(0.5);
				close;

				% BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 1, 1, 0, 0.3 );
				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { [ groups{iSbj}{:} ] }, 1, 1, 0, 0.3 );
				h = get( gcf, 'children' );
				index = 1;
				nMax = 0;
				for( i = 1 : size(h,1) )
					if( strcmpi( class(h(i)), 'matlab.graphics.axis.axes' ) )
						nBlocks = sum( h(i).Title.String == '|' ) + 1;
						if( nMax < nBlocks )
							index = i;
							nMax = nBlocks;
						end
						h(i).Title.String = [ h(i).Title.String(1:8), ': ', num2str(nBlocks), ' blocks' ];
					end
				end
				h(index).Title.String = ['All sessions: ', num2str(nMax), ' blocks'];
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves.eps' ], 'psc2' );
				pause(0.5);
				close;

				% BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 1, 0, 0.3 );
				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { [ groups{iSbj}{:} ] }, 0, 1, 0, 0.3 );
				h = get( gcf, 'children' );
				index = 1;
				nMax = 0;
				for( i = 1 : size(h,1) )
					if( strcmpi( class(h(i)), 'matlab.graphics.axis.axes' ) )
						nBlocks = sum( h(i).Title.String == '|' ) + 1;
						if( nMax < nBlocks )
							index = i;
							nMax = nBlocks;
						end
						h(i).Title.String = [ h(i).Title.String(1:8), ': ', num2str(nBlocks), ' blocks' ];
					end
				end
				h(index).Title.String = ['All sessions: ', num2str(nMax), ' blocks'];
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withMicrosacs.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withMicrosacs.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withMicrosacs.eps' ], 'psc2' );
				pause(0.5);
				close;

				% BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 0, 0, 0.3 );
				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { [ groups{iSbj}{:} ] }, 0, 0, 0, 0.3 );
				h = get( gcf, 'children' );
				index = 1;
				nMax = 0;
				for( i = 1 : size(h,1) )
					if( strcmpi( class(h(i)), 'matlab.graphics.axis.axes' ) )
						nBlocks = sum( h(i).Title.String == '|' ) + 1;
						if( nMax < nBlocks )
							index = i;
							nMax = nBlocks;
						end
						h(i).Title.String = [ h(i).Title.String(1:8), ': ', num2str(nBlocks), ' blocks' ];
					end
				end
				h(index).Title.String = ['All sessions: ', num2str(nMax), ' blocks'];
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withAllSacs.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withAllSacs.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withAllSacs.eps' ], 'psc2' );
				pause(0.5);
				close;

				data = BlinkTransient.GetData4Blinks( [ 'F:\BlinkTransient\', sbj{iSbj} ], 0, 0 );
				trialsWithBlink = [data([groups{iSbj}{:}]).trialsWithBlink];
				trialsWithoutBlink = [data([groups{iSbj}{:}]).trialsWithoutBlink];
				nOverall(iSbj).withBlink = size( [ trialsWithBlink( [trialsWithBlink.gaborAmp] >= 0.3 ) ], 2 );
				nOverall(iSbj).withoutBlink = size( [ trialsWithoutBlink( [trialsWithoutBlink.gaborAmp] >= 0.3 ) ], 2 );
				data = BlinkTransient.GetData4Blinks( [ 'F:\BlinkTransient\', sbj{iSbj} ], 0, 1 );
				trialsWithBlink = [data([groups{iSbj}{:}]).trialsWithBlink];
				trialsWithoutBlink = [data([groups{iSbj}{:}]).trialsWithoutBlink];
				nWithMicrosacs(iSbj).withBlink = size( [ trialsWithBlink( [trialsWithBlink.gaborAmp] >= 0.3 ) ], 2 );
				nWithMicrosacs(iSbj).withoutBlink = size( [ trialsWithoutBlink( [trialsWithoutBlink.gaborAmp] >= 0.3 ) ], 2 );
				data = BlinkTransient.GetData4Blinks( [ 'F:\BlinkTransient\', sbj{iSbj} ], 1, 1 );
				trialsWithBlink = [data([groups{iSbj}{:}]).trialsWithBlink];
				trialsWithoutBlink = [data([groups{iSbj}{:}]).trialsWithoutBlink];
				nDriftOnly(iSbj).withBlink = size( [ trialsWithBlink( [trialsWithBlink.gaborAmp] >= 0.3 ) ], 2 );
				nDriftOnly(iSbj).withoutBlink = size( [ trialsWithoutBlink( [trialsWithoutBlink.gaborAmp] >= 0.3 ) ], 2 );
			end
			% return;

			set( figure, 'NumberTitle', 'off', 'name', 'nTrials Table', 'color', 'w' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);
			uitable( 'units', 'normalized', 'Position',[.1 .1 .8 .8], 'BackgroundColor', [1 1 1], 'FontName', 'TimesNewRoman', 'FontSize', 15, 'ColumnWidth', num2cell(145*ones(1,7)),...
				'Data', [ nOverall.withBlink; nOverall.withoutBlink; nWithMicrosacs.withBlink; nWithMicrosacs.withoutBlink; nDriftOnly.withBlink; nDriftOnly.withoutBlink ]',...
				'RowName', sbj,...
				'ColumnName', { 'Overall.yes', 'Overall.no', 'WithMicrosacs.yes', 'WithMicrosacs.no', 'DriftOnly.yes', 'DriftOnly.no' } );
			title( 'nTrials Table' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);
			saveas( gcf, [ folder, '/nTrials_Table.fig' ] );
			saveas( gcf, [ folder, '/nTrials_Table.png' ] );
			saveas( gcf, [ folder, '/nTrials_Table.eps' ], 'psc2' );
			pause(0.5);
			close;
		end


		function main20180927( folder )
			%% remove trials with gabor amplitude less than 0.3 

			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end

			if( exist( folder, 'dir' ) ~= 7 ) mkdir(folder); end

			sbj = { 'A034', 'A082', 'A088' };
			nRows = 2;
			nCols = 2;
			groups = { {1:3, 4:7, 8:11, 12:15, 16:19, 20:23, 24:28},...
					   {1:3, 4:6, 7:8, 10:11, 12:14, 15:17, 18:20, 21:22, 23:25, 26:28, 29:32, 33:36, 37:40, 41:44, 45:48},...
					   {1, 2:4, 5:8} };

			set( figure, 'NumberTitle', 'off', 'name', 'BlinkRT' );
			nHRT = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

		 	set( figure, 'NumberTitle', 'off', 'name', 'BlinkAlign2Plateau' );
			nHB2P = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

			set( figure, 'NumberTitle', 'off', 'name', 'Fixational saccade amplitude' );
			nHAmp = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

		 	set( figure, 'NumberTitle', 'off', 'name', ['Fixational saccade rate aligned to ', 'PlateauOn' ] );
			nHRate = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);

		 	set( figure, 'NumberTitle', 'off', 'name', 'Compare Fixational saccade rate' );
			nHRateBars = get( gcf, 'number' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);
			
			for( iSbj = 1 : size(sbj,2) )
				figure(nHRT);
				subplot( nRows, nCols, iSbj );
				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ], [], true, [], false );
				title(sbj{iSbj});

				figure(nHB2P);
				subplot( nRows, nCols, iSbj );
				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'tPlateauOn', true, [], false );
				title(sbj{iSbj});

				figure(nHAmp);
				subplot( nRows, nCols, iSbj );
				BlinkTransient.FixSacAmp( [ 'F:\BlinkTransient\', sbj{iSbj} ], true, [], [], false );
				title(sbj{iSbj});

				figure(nHRate);
				subplot( nRows, nCols, iSbj );
				BlinkTransient.CompSaccadesRate( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'PlateauOn', 'Gaussian', 100, true, false );
				title(sbj{iSbj});

				figure(nHRateBars);
				subplot( nRows, nCols, iSbj );
				BlinkTransient.CompSaccadesRateBars( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'whole', true, false );
				title(sbj{iSbj});
			end

			saveas( figure(nHRT), [ folder, '\BlinkRT.fig' ] );
			saveas( figure(nHRT), [ folder, '\BlinkRT.png' ] );
			saveas( figure(nHRT), [ folder, '\BlinkRT.eps' ], 'psc2' );
			pause(1);
			close(figure(nHRT));

			saveas( figure(nHB2P), [ folder, '\BlinkAlign2Plateau.fig' ] );
			saveas( figure(nHB2P), [ folder, '\BlinkAlign2Plateau.png' ] );
			saveas( figure(nHB2P), [ folder, '\BlinkAlign2Plateau.eps' ], 'psc2' );
			pause(1);
			close(figure(nHB2P));

			saveas( figure(nHAmp), [ folder, '\FixSacAmp.fig' ] );
			saveas( figure(nHAmp), [ folder, '\FixSacAmp.png' ] );
			saveas( figure(nHAmp), [ folder, '\FixSacAmp.eps' ], 'psc2' );
			pause(1);
			close(figure(nHAmp));

			saveas( figure(nHRate), [ folder, '\FixSacRate_Aligned2PlateauOn.fig' ] );
			saveas( figure(nHRate), [ folder, '\FixSacRate_Aligned2PlateauOn.png' ] );
			saveas( figure(nHRate), [ folder, '\FixSacRate_Aligned2PlateauOn.eps' ], 'psc2' );
			pause(1);
			close(figure(nHRate));

			saveas( figure(nHRateBars), [ folder, '\FixSacRate_CompWhole_Bars.fig' ] );
			saveas( figure(nHRateBars), [ folder, '\FixSacRate_CompWhole_Bars.png' ] );
			saveas( figure(nHRateBars), [ folder, '\FixSacRate_CompWhole_Bars.eps' ], 'psc2' );
			pause(1);
			close(figure(nHRateBars));

			for( iSbj = size(sbj,2) : -1 : 1 )
				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkRT.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkRT.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkRT.eps' ], 'psc2' );
				pause(1);
				close;

				BlinkTransient.BlinkRT( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'tPlateauOn' );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkAlign2Plateau.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkAlign2Plateau.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_BlinkAlign2Plateau.eps' ], 'psc2' );
				pause(1);
				close;

				BlinkTransient.FixSacAmp( [ 'F:\BlinkTransient\', sbj{iSbj} ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacAmp.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacAmp.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacAmp.eps' ], 'psc2' );
				pause(1);
				close;

				BlinkTransient.CompSaccadesRate( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'PlateauOn', 'Gaussian', 100 );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_Aligned2PlateauOn.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_Aligned2PlateauOn.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_Aligned2PlateauOn.eps' ], 'psc2' );
				pause(1);
				close;

				BlinkTransient.CompSaccadesRateBars( [ 'F:\BlinkTransient\', sbj{iSbj} ], 'whole' );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_CompWhole_Bars.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_CompWhole_Bars.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_FixSacRate_CompWhole_Bars.eps' ], 'psc2' );
				pause(1);
				close;

				continue;

				% BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 0, 1 );
				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { [ groups{iSbj}{:} ] }, 0, 0, 1 );
				h = get( gcf, 'children' );
				index = 1;
				nMax = 0;
				for( i = 1 : size(h,1) )
					if( strcmpi( class(h(i)), 'matlab.graphics.axis.axes' ) )
						nBlocks = sum( h(i).Title.String == '|' ) + 1;
						if( nMax < nBlocks )
							index = i;
							nMax = nBlocks;
						end
						h(i).Title.String = [ h(i).Title.String(1:8), ': ', num2str(nBlocks), ' blocks' ];
					end
				end
				h(index).Title.String = ['All sessions: ', num2str(nMax), ' blocks'];
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_OverallCurve.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_OverallCurve.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_OverallCurve.eps' ], 'psc2' );
				pause(0.5);
				close;

				% BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 1, 1, 0, 0.3 );
				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { [ groups{iSbj}{:} ] }, 1, 1, 0, 0.3 );
				h = get( gcf, 'children' );
				index = 1;
				nMax = 0;
				for( i = 1 : size(h,1) )
					if( strcmpi( class(h(i)), 'matlab.graphics.axis.axes' ) )
						nBlocks = sum( h(i).Title.String == '|' ) + 1;
						if( nMax < nBlocks )
							index = i;
							nMax = nBlocks;
						end
						h(i).Title.String = [ h(i).Title.String(1:8), ': ', num2str(nBlocks), ' blocks' ];
					end
				end
				h(index).Title.String = ['All sessions: ', num2str(nMax), ' blocks'];
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves.eps' ], 'psc2' );
				pause(0.5);
				close;

				% BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 1, 0, 0.3 );
				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { [ groups{iSbj}{:} ] }, 0, 1, 0, 0.3 );
				h = get( gcf, 'children' );
				index = 1;
				nMax = 0;
				for( i = 1 : size(h,1) )
					if( strcmpi( class(h(i)), 'matlab.graphics.axis.axes' ) )
						nBlocks = sum( h(i).Title.String == '|' ) + 1;
						if( nMax < nBlocks )
							index = i;
							nMax = nBlocks;
						end
						h(i).Title.String = [ h(i).Title.String(1:8), ': ', num2str(nBlocks), ' blocks' ];
					end
				end
				h(index).Title.String = ['All sessions: ', num2str(nMax), ' blocks'];
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withMicrosacs.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withMicrosacs.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withMicrosacs.eps' ], 'psc2' );
				pause(0.5);
				close;

				% BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { groups{iSbj}{:}, [ groups{iSbj}{:} ] }, 0, 0, 0, 0.3 );
				BlinkTransient.BlinkEffect( [ 'F:\BlinkTransient\', sbj{iSbj} ], { [ groups{iSbj}{:} ] }, 0, 0, 0, 0.3 );
				h = get( gcf, 'children' );
				index = 1;
				nMax = 0;
				for( i = 1 : size(h,1) )
					if( strcmpi( class(h(i)), 'matlab.graphics.axis.axes' ) )
						nBlocks = sum( h(i).Title.String == '|' ) + 1;
						if( nMax < nBlocks )
							index = i;
							nMax = nBlocks;
						end
						h(i).Title.String = [ h(i).Title.String(1:8), ': ', num2str(nBlocks), ' blocks' ];
					end
				end
				h(index).Title.String = ['All sessions: ', num2str(nMax), ' blocks'];
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
			 	jf.setMaximized(1);
			 	pause(0.5);
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withAllSacs.fig' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withAllSacs.png' ] );
				saveas( gcf, [ folder, '\', sbj{iSbj}, '_CompCurves_withAllSacs.eps' ], 'psc2' );
				pause(0.5);
				close;

				data = BlinkTransient.GetData4Blinks( [ 'F:\BlinkTransient\', sbj{iSbj} ], 0, 0 );
				trialsWithBlink = [data([groups{iSbj}{:}]).trialsWithBlink];
				trialsWithoutBlink = [data([groups{iSbj}{:}]).trialsWithoutBlink];
				nOverall(iSbj).withBlink = size( [ trialsWithBlink( [trialsWithBlink.gaborAmp] >= 0.3 ) ], 2 );
				nOverall(iSbj).withoutBlink = size( [ trialsWithoutBlink( [trialsWithoutBlink.gaborAmp] >= 0.3 ) ], 2 );
				data = BlinkTransient.GetData4Blinks( [ 'F:\BlinkTransient\', sbj{iSbj} ], 0, 1 );
				trialsWithBlink = [data([groups{iSbj}{:}]).trialsWithBlink];
				trialsWithoutBlink = [data([groups{iSbj}{:}]).trialsWithoutBlink];
				nWithMicrosacs(iSbj).withBlink = size( [ trialsWithBlink( [trialsWithBlink.gaborAmp] >= 0.3 ) ], 2 );
				nWithMicrosacs(iSbj).withoutBlink = size( [ trialsWithoutBlink( [trialsWithoutBlink.gaborAmp] >= 0.3 ) ], 2 );
				data = BlinkTransient.GetData4Blinks( [ 'F:\BlinkTransient\', sbj{iSbj} ], 1, 1 );
				trialsWithBlink = [data([groups{iSbj}{:}]).trialsWithBlink];
				trialsWithoutBlink = [data([groups{iSbj}{:}]).trialsWithoutBlink];
				nDriftOnly(iSbj).withBlink = size( [ trialsWithBlink( [trialsWithBlink.gaborAmp] >= 0.3 ) ], 2 );
				nDriftOnly(iSbj).withoutBlink = size( [ trialsWithoutBlink( [trialsWithoutBlink.gaborAmp] >= 0.3 ) ], 2 );
			end
			return;

			set( figure, 'NumberTitle', 'off', 'name', 'nTrials Table', 'color', 'w' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);
			uitable( 'units', 'normalized', 'Position',[.1 .1 .8 .8], 'BackgroundColor', [1 1 1], 'FontName', 'TimesNewRoman', 'FontSize', 15, 'ColumnWidth', num2cell(145*ones(1,7)),...
				'Data', [ nOverall.withBlink; nOverall.withoutBlink; nWithMicrosacs.withBlink; nWithMicrosacs.withoutBlink; nDriftOnly.withBlink; nDriftOnly.withoutBlink ]',...
				'RowName', sbj,...
				'ColumnName', { 'Overall.yes', 'Overall.no', 'WithMicrosacs.yes', 'WithMicrosacs.no', 'DriftOnly.yes', 'DriftOnly.no' } );
			title( 'nTrials Table' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
		 	jf.setMaximized(1);
		 	pause(0.5);
			saveas( gcf, [ folder, '/nTrials_Table.fig' ] );
			saveas( gcf, [ folder, '/nTrials_Table.png' ] );
			saveas( gcf, [ folder, '/nTrials_Table.eps' ], 'psc2' );
			pause(0.5);
			close;
		end


		function rates = CompSaccadesRate( sbjFolder, alignment, smooth, window, isPlot, isNewFigure )
			%% alignment:					event to align the rates; by default, aligned to the time point of the first recorded eye position
			%  window:						sliding window size (ms)
			%  smooth:						'gaussian', 'square', 'raw'
			%  rates:						1x3 structure array for "microsaccades" and "saccades" rate distributions
			%    rates.rate.microsaccades:	rate for microsaccades (Hz)
			%	 rates.rate.saccades:		rate for large saccades (Hz)
			%    rates.tTicks:				timeline for rates.rate (ms)
			%    rates.nTrials: 			number of trials used

			if( nargin() < 2 || isempty(alignment) ) alignment = 'startTrial'; end
			if( nargin() < 3 || isempty(smooth) ) smooth = 'raw'; end
			if( nargin() < 4 || isempty(window) ) window = 10; end
            if( nargin() < 5 || isempty(isPlot) ) isPlot = true; end
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end

			if( sbjFolder(end) == '/' || sbjFolder(end) == '\' ) sbjFolder(end) = []; end

			for( i = 3:-1:1 )
				rates(i).rate = [];
				rates(i).tTicks = [];
				rates(i).nTrials = 0;
			end

			list = dir(sbjFolder);
			for( i = 1 : size(list,1) )
				if( list(i).isdir() )
					if( strcmp( list(i).name, '.' ) || strcmp( list(i).name, '..' ) || strcmpi( list(i).name(1:4), 'demo' ) || strcmpi( list(i).name(1:3), 'X. ' ) || strcmpi( list(i).name, 'calibration') )
						continue;
					elseif( str2num(list(i).name(1:8)) < 20180816 )	% fix dot not visible during stimulus
						rates(1) = BlinkTransient.SaccadesRateAdd( rates(1), BlinkTransient.SaccadesRate( fullfile(sbjFolder, list(i).name), alignment, smooth, window, 0 ) );
					elseif( str2num(list(i).name(1:8)) < 20180920 )		% fix dot visible during stimulus
						rates(2) = BlinkTransient.SaccadesRateAdd( rates(2), BlinkTransient.SaccadesRate( fullfile(sbjFolder, list(i).name), alignment, smooth, window, 0 ) );
					else 	% fix dot visible during stimulus, and fix window visible as 4 arcs
						rates(3) = BlinkTransient.SaccadesRateAdd( rates(3), BlinkTransient.SaccadesRate( fullfile(sbjFolder, list(i).name), alignment, smooth, window, 0 ) );
					end
				end
			end

			if(isPlot)
				if(isNewFigure)
					set( figure, 'NumberTitle', 'off', 'name', [sbjFolder(end-3:end), ' | Compare SaccadesRate'], 'color', 'w' );
				end
				hold on;
				LineStyles = {'-','--',':'};
				names = { 'NoFixDot', 'WithFixDot', 'With4Arcs' };
				for( i = 3 : -1 : 1 )
					if( rates(i).nTrials > 0 )
						h(i*3) = plot( rates(i).tTicks, rates(i).rate.microsaccades + rates(i).rate.saccades, 'k', 'LineStyle', LineStyles{i}, 'LineWidth', 2, 'DisplayName', 'overall' );
						h(i*3-2) = plot( rates(i).tTicks, rates(i).rate.microsaccades, 'r', 'LineStyle', LineStyles{i}, 'LineWidth', 2, 'DisplayName', ['Microsaccades ', names{i}] );
						h(i*3-1) = plot( rates(i).tTicks, rates(i).rate.saccades, 'b', 'LineStyle', LineStyles{i}, 'LineWidth', 2, 'DisplayName', ['Saccades ', names{i}] );
					end
				end
				legend( [ h(1:3:end), h(2:3:end), h(3:3:end) ] );
				set( gca, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				xlabel( 'Time (ms)' );
				ylabel( 'Rates (Hz)' );
				title( [ sbjFolder(end-3:end), ' | Aligned to ', alignment ] );
			end
		end


		function rates = CompSaccadesRateBars( sbjFolder, period, isPlot, isNewFigure )
			%% period:						which period to analyze: ramp, plateau, whole (stimulus)
			%  rates:						1x3 structure array for "microsaccades" and "saccades" rate samples (one sample from each block)
			%    rates.microsaccades:		rate for microsaccades (Hz)
			%	 rates.saccades:			rate for large saccades (Hz)

			if( nargin() < 2 || isempty(period) ) period = 'whole'; end
            if( nargin() < 3 || isempty(isPlot) ) isPlot = true; end
			if( nargin() < 4 || isempty(isNewFigure) ) isNewFigure = true; end

			if( sbjFolder(end) == '/' || sbjFolder(end) == '\' ) sbjFolder(end) = []; end

			for( i = 5:-1:1 )
				rates(i).microsaccades = [];
				rates(i).saccades = [];
			end

			list = dir(sbjFolder);
			for( i = 1 : size(list,1) )
				if( list(i).isdir() )
					if( strcmp( list(i).name, '.' ) || strcmp( list(i).name, '..' ) || strcmpi( list(i).name(1:4), 'demo' ) || strcmpi( list(i).name(1:3), 'X. ' ) || strcmpi( list(i).name, 'calibration') )
						continue;

					else
						load( fullfile(sbjFolder, list(i).name, 'Trials.mat'), 'Trials' );
						Trials( [Trials.trialType] ~= 'c' & [Trials.trialType] ~= 'e' ) = [];
						microsaccades = [Trials.microsaccades];
						saccades = [Trials.saccades];

						for( iTrial = 1 : size(Trials,2) )
							switch(lower(period))
								case 'ramp'
									microsaccades(iTrial).start( microsaccades(iTrial).start < Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart | Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart < microsaccades(iTrial).start ) = [];
									saccades(iTrial).start( saccades(iTrial).start < Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart | Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart < saccades(iTrial).start ) = [];
								case 'plateau'
									microsaccades(iTrial).start( microsaccades(iTrial).start < Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart | Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart < microsaccades(iTrial).start ) = [];
									saccades(iTrial).start( saccades(iTrial).start < Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart | Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart < saccades(iTrial).start ) = [];
								otherwise
									microsaccades(iTrial).start( microsaccades(iTrial).start < Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart | Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart < microsaccades(iTrial).start ) = [];
									saccades(iTrial).start( saccades(iTrial).start < Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart | Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart < saccades(iTrial).start ) = [];
							end
						end
						
						switch(period)
							case 'ramp'
								duration = (Trials(1).tPlateauOn - Trials(1).tRampOn) / 1000;
							case 'plateau'
								duration = (Trials(1).tMaskOn - Trials(1).tPlateauOn) / 1000;
							otherwise
								duration = (Trials(1).tMaskOn - Trials(1).tRampOn) / 1000;
						end

						microsaccades = size( [microsaccades.start], 2 ) / duration / size(Trials,2);
						saccades = size( [saccades.start], 2 ) / duration / size(Trials,2);

						if( str2num(list(i).name(1:8)) < 20180816 )	% fix dot not visible during stimulus
							rates(1).microsaccades(end+1) = microsaccades;
							rates(1).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) < 20180920 )		% fix dot visible during stimulus
							rates(2).microsaccades(end+1) = microsaccades;
							rates(2).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) < 20180926 ) 	% fix dot visible during stimulus, and fix window visible as 4 arcs
							rates(3).microsaccades(end+1) = microsaccades;
							rates(3).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) < 20180927 ) 	% tiny fix dot (0.05 deg) visible during fixation, instructed to hold eyes still
							rates(4).microsaccades(end+1) = microsaccades;
							rates(4).saccades(end+1) = saccades;
						else 	% fix dot invisible during stimulus, fix window visible as 4 arcs, instructed to hold eyes still
							rates(5).microsaccades(end+1) = microsaccades;
							rates(5).saccades(end+1) = saccades;
						end
						
					end
				end
			end

			if(isPlot)
				if(isNewFigure)
					set( figure, 'NumberTitle', 'off', 'name', [sbjFolder(end-3:end), ' | Compare SaccadesRate (Bars)'], 'color', 'w' );
				end
				hold on;
				colors = {'r','y','b','m','c'};
				names = { 'Nothing', 'WithFixDot', 'Dot&4Arcs', 'HoldFixDot', 'Hold4Arcs' };
				nConds = 0;
				for( i = 1 : size(names,2) )
					if( isempty(rates(i).microsaccades) ) continue; end
					nConds = nConds + 1;
					data = [rates(i).microsaccades; rates(i).saccades];
					data(3,:) = data(1,:) + data(2,:);
					w = size(names,2);
					h(i) = bar( (0:2)*w + nConds, mean(data,2)', 0.95/w, colors{i}, 'LineStyle', 'none', 'DisplayName', names{i}, 'FaceAlpha', 1 );
					plot( reshape( [ repmat( (0:2)*w+nConds, 2, 1 ); ones(1,3)*NaN ], 1, [] ), reshape( [std(data,0,2)*[-1,1] + repmat(mean(data,2),1,2), ones(3,1)*NaN]', 1, [] ), 'k', 'LineWidth', 2 );
				end
				set( legend(h), 'location', 'NorthWest', 'FontSize', 16 );
				set( gca, 'XLim', [0 2*w+nConds+1], 'XTick', (0:2)*w+nConds/2+0.5, 'XTickLabel', {'microsac', 'sac', 'overall'}, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				ylabel( 'Rates (Hz)' );
				title( [ sbjFolder(end-3:end), ' (', period, ')' ] );
			end
		end


		function EIS2Mat( folder )
			if( folder(end) == '\' || folder(end) == '/' ) folder(end) = []; end
			fprintf('%s\n', folder);
			if( size(folder,2) > 10 && strcmpi( folder(end-10:end), 'calibration' ) ) return; end
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

		function Data4Blinks = GetData4Blinks( folder, discardMicrosaccades, discardSaccades )
			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			if( nargin() < 2 ) discardMicrosaccades = true; end 		% by default, we discard trials with microsaccades (<30 arc mins) during stimulus
			if( nargin() < 3 ) discardSaccades = true; end 		% by default, we discard trials with saccades (>30 arc mins) during stimulus

			Data4Blinks = [];
			if( exist( [folder,'/Data4Blinks.mat'], 'file' ) == 2 )	delete( [folder,'/Data4Blinks.mat'] ); end
			if( exist( [folder,'/Data4Blinks.mat'], 'file' ) == 2 )
				load( [folder,'/Data4Blinks.mat'], 'Data4Blinks' );
				needSave = false;
				if( ~isfield( Data4Blinks, 'discardMicrosaccades' ) )
					needSave = true;
					for( i = 1 : size(Data4Blinks,2) )
						Data4Blinks(i).discardMicrosaccades = true;
					end
				end
				if( ~isfield( Data4Blinks, 'discardSaccades' ) )
					needSave = true;
					for( i = 1 : size(Data4Blinks,2) )
						Data4Blinks(i).discardSaccades = true;
					end
				end
				if( Data4Blinks(1).discardMicrosaccades == discardMicrosaccades && Data4Blinks(1).discardSaccades == discardSaccades )
					if(needSave)
						save( [folder,'/Data4Blinks.mat'], 'Data4Blinks' );
					end
					return;
				end
			end
			subfolders = ToolKit.ListFolders(folder);
			index =  false( size(subfolders,1), 1 ) ;
			for( iFolder = 1 : size(subfolders,1) )
				if( strcmp( subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + (1:3) ), 'X. ' ) ) index(iFolder) = 1; end
			end
			subfolders(index,:) = [];

			for( iFolder = size(subfolders,1) : -1 : 1 )
				load( [ ToolKit.RMEndSpaces(subfolders(iFolder,:)), '/Trials.mat' ], 'Trials' );
				VT = Trials( [Trials.trialType] == 'c' | [Trials.trialType] == 'e' );

				tAlignEvent = 'tRampOn';
				tAlignEvent = 'tPlateauOn';
				tStart = 0;%-1500;	% start time relative to tAlignEvent

				% tirals only with drifts
				Data4Blinks(iFolder).sessionName = subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end );
				Data4Blinks(iFolder).trialsWithoutBlink = VT;
				index = false(size(VT));
				for( i = 1 : size(VT,2) )
					if( ~isempty( VT(i).blinks.start ) &&  any( VT(i).tRampOn - VT(i).tTrialStart <= VT(i).blinks.start + VT(i).blinks.duration & VT(i).blinks.start <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						...%~isempty( VT(i).notracks.start ) &&  any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= VT(i).notracks.start + VT(i).notracks.duration & VT(i).notracks.start <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						discardSaccades && ~isempty( VT(i).saccades.start ) && any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= VT(i).saccades.start + VT(i).saccades.duration & VT(i).saccades.start <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						discardMicrosaccades && ~isempty( VT(i).microsaccades.start ) && any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= VT(i).microsaccades.start + VT(i).microsaccades.duration & VT(i).microsaccades.start <= VT(i).tMaskOn - VT(i).tTrialStart ) )
						index(i) = 1;
					end
				end
				Data4Blinks(iFolder).trialsWithoutBlink(index) = [];

				% trials only with blinks
				Data4Blinks(iFolder).trialsWithBlink = VT;
				index = false(size(VT));
				for( i = 1 : size(VT,2) )
					if( isempty( VT(i).blinks.start ) ||...
						all( VT(i).tPlateauOn + tStart - VT(i).tTrialStart > VT(i).blinks.start + VT(i).blinks.duration | VT(i).blinks.start > VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						...%~isempty( VT(i).notracks.start ) &&  any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= VT(i).notracks.start + VT(i).notracks.duration & VT(i).notracks.start <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						discardSaccades && ~isempty( VT(i).saccades.start ) && any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= VT(i).saccades.start + VT(i).saccades.duration & VT(i).saccades.start <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						discardMicrosaccades && ~isempty( VT(i).microsaccades.start ) && any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= VT(i).microsaccades.start + VT(i).microsaccades.duration & VT(i).microsaccades.start <= VT(i).tMaskOn - VT(i).tTrialStart ) )
						index(i) = 1;
					end
				end
				Data4Blinks(iFolder).trialsWithBlink(index) = [];
				Data4Blinks(iFolder).discardMicrosaccades = discardMicrosaccades;
				Data4Blinks(iFolder).discardSaccades = discardSaccades;
			end
			save( [folder,'/Data4Blinks.mat'], 'Data4Blinks' );
		end

		function Data4Blinks = GetData4Blinks_Beep( folder, anything )
			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			Data4Blinks = [];
			% if( exist( [folder,'/Data4Blinks.mat'], 'file' ) == 2 )	delete( [folder,'/Data4Blinks.mat'] ); end
			if( exist( [folder,'/Data4Blinks.mat'], 'file' ) == 2 )
				load( [folder,'/Data4Blinks.mat'], 'Data4Blinks' );
			else
				subfolders = ToolKit.ListFolders(folder);
				index =  false( size(subfolders,1), 1 ) ;
				for( iFolder = 1 : size(subfolders,1) )
					if( sum( subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end ) == '-' ) ~= 2 ) index(iFolder) = 1; end
				end
				% subfolders(index,:) = [];

				for( iFolder = size(subfolders,1) : -1 : 1 )
					load( [ ToolKit.RMEndSpaces(subfolders(iFolder,:)), '/Trials.mat' ], 'Trials' );
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

		function BlinkEffect( folder, groups, discardMicrosaccades, discardSaccades, noCompare, lowestAmp )
			%% groups:					cell array, each element defines the indices of one data group
			%  discardMicrosaccades:	whether discard microsaccades (<30 arc mins); true by default
			%  discardSaccades:			whether discard saccades (>30 arc mins); true by default
			%  noCompare:				pool two conditions together to form a single curve; false by default
			%  lowestAmp:				lowest gabor amplitude to include in analysis  

			if( nargin() < 3 ) discardMicrosaccades = true; end
			if( nargin() < 4 ) discardSaccades = true; end
			if( nargin() < 5 ) noCompare = false; end
			if( nargin() < 6 ) lowestAmp = 0; end

			Data4Blinks = BlinkTransient.GetData4Blinks( folder, discardMicrosaccades, discardSaccades );
			if( isempty(Data4Blinks) ) return; end
			if( nargin() < 2 ) groups = mat2cell( 1:size(Data4Blinks,2), 1, ones(size(Data4Blinks)) ); end

			for( iGroup = size(groups,2) : -1 : 1 )
				data(iGroup).sessionName = sprintf( '%s | ', Data4Blinks(groups{iGroup}).sessionName );
				data(iGroup).sessionName(end-2:end) = [];
				data(iGroup).trialsWithBlink = [Data4Blinks(groups{iGroup}).trialsWithBlink];
				data(iGroup).trialsWithoutBlink = [Data4Blinks(groups{iGroup}).trialsWithoutBlink];
			end

			set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Blink VS No Blink', folder( min( find( folder == '\' | folder == '/', 2, 'last' ) ) + 1 : end ) ), 'color', 'w' );
			nCols = ceil( sqrt( size(data,2) ) );
			nRows = ceil( size(data,2) / nCols );
			for( iGroup = 1 : size(data,2) )
				trials{2} = data(iGroup).trialsWithoutBlink;	% tirals only with drifts
				trials{2}( [trials{2}.gaborAmp] < lowestAmp ) = [];
				trials{1} = data(iGroup).trialsWithBlink;		% trials only with blinks
				trials{1}( [trials{1}.gaborAmp] < lowestAmp ) = [];
				if( isempty(trials{1}) || isempty(trials{2}) ) continue; end

				bgnLuminance = double(trials{1}(1).bgnLuminance);

				subplot( nRows, nCols, iGroup );
				hold on;
				colors = {'r', 'b'};
				names = {'b', 'nb'};%{ 'blink', 'no blink' };
				hAligns = { 'left', 'right' };	% horizontal alignments

				if(noCompare)
					trials = {[trials{:}]};
					names = {''};
					hAligns = {'center'};
				end
				for( j = size(trials,2):-1:1 )
					if( isempty(trials{j}) )
						h(j) = [];
						continue;
					end
					% amplitudes = [trials{j}.gaborAmp];
					contrasts = [trials{j}.gaborAmp];
					contrasts = BlinkTransient.Intensity2Luminance( [trials{j}.gaborAmp] + bgnLuminance ) / BlinkTransient.Intensity2Luminance(bgnLuminance) - 1;
					uniConts = unique(contrasts);
					crctRate(j).rates = zeros(size(trials{j}));
					crctRate(j).contrasts = zeros(size(trials{j}));
					crctRate(j).nRates = size(uniConts,2);
					conWin = 0;%0.0005;%0.3;
					for( iUni = crctRate(j).nRates : -1 : 1 )
						index = uniConts(iUni) - conWin/2 <= contrasts & contrasts <= uniConts(iUni) + conWin/2;
						crctRate(j).rates(iUni) = sum( [trials{j}(index).trialType] == 'c' ) / sum(index);
						crctRate(j).contrasts(iUni) = uniConts(iUni);
						text( crctRate(j).contrasts(iUni), crctRate(j).rates(iUni), sprintf('%d', sum(index)), 'HorizontalAlignment', hAligns{j}, 'VerticalAlignment', 'top', 'FontSize', 12, 'color', colors{j} );
					end
					h(j) = plot( crctRate(j).contrasts(1:crctRate(j).nRates), crctRate(j).rates(1:crctRate(j).nRates), 'o', 'LineStyle', 'none', 'LineWidth', 2, 'color', colors{j}, 'DisplayName', sprintf( '%s %d', names{j}, size(trials{j},2) ) );

					% [thresh, par] = psyfit( contrasts, [trials{j}.trialType] == 'c', 'Thresh', 0.75, 'Chance', 0.5, 'Lapses', 0, 'Log', 'Extra', 'PlotOff' );
					[~, ~, nThresh(j,:), nPar, g(j), chisq(j)] = psyfit( contrasts, [trials{j}.trialType] == 'c', 'Thresh', 0.75, 'Chance', 0.5, 'Lapses', 0, 'Log', 'Extra', 'PlotOff', 'Boots', 10 );
					par = mean(nPar,2);
					semPar(2) = std(nPar(2,:)) / sqrt(size(nPar,2));
					semPar(1) = std(nPar(1,:)) / sqrt(size(nPar,2));
					thresh = mean(nThresh(j,:));
					semThresh = std(nThresh(j,:)) / sqrt(size(nThresh,2));
					x = linspace( 0, max(uniConts)*1.1, 10000 );
					y = psyfun( x, par(1), par(2), 0.5, 0, false, true, 'normal' );
					yLow = psyfun( x, par(1) - semPar(1), par(2) - semPar(2), 0.5, 0, false, true, 'normal' );
					yUp = psyfun( x, par(1) + semPar(1), par(2) + semPar(2), 0.5, 0, false, true, 'normal' );
					plot( x, y, '-', 'LineWidth', 2, 'color', colors{j}, 'DisplayName', sprintf( '%s (n=%d)', names{j}, size(trials{j},2) ) );
					set( fill( [x x(end:-1:1)], [yLow yUp(end:-1:1)], colors{j} ), 'LineStyle', 'none', 'FaceAlpha', 0.5 );
					plot( [1, 1] * thresh, [0, 0.75], '--', 'color', colors{j} );
					set( fill( [-1, 1, 1, -1]*semThresh + thresh, [0, 0, 0.75, 0.75], colors{j} ), 'LineStyle', 'none', 'FaceAlpha', 0.5 );
				end
				set( legend(h), 'location', 'NorthWest', 'FontSize', 12 );
				xlabel('Contrast');
				ylabel('Correct rate');
				set( gca, 'XLim', [0, 0.008], 'YLim', [0 1], 'FontSize', 20 );
				% set( gca, 'XLim', [0, 1], 'YLim', [0 1], 'FontSize', 20 );
				x = get( gca, 'XLim' );
				for( j = size(trials,2) : -1 : 1 )
					if( ~isempty(names{j}) ) names{j} = [names{j}, ': ']; end
					text( x(2), 0.1*j, sprintf( '%sgof = %.3f, chisq = %.3f', names{j}, g(j), chisq(j) ), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 20 );
				end
				if( ~noCompare )
					text( x(2), 0, sprintf( 'p = %.3f', ranksum( nThresh(1,:), nThresh(2,:), 'tail', 'both' ) ), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 20 );
				end
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


		function RT = BlinkRT( folder, alignEvt, isPlot, tStep, isNewFigure )
			%% RT:	in ms

			if( nargin() < 2 || isempty(alignEvt) ) alignEvt = 'tBlinkBeepOn'; end
			if( nargin() < 3 ) isPlot = true; end
			if( nargin() < 4 || isempty(tStep) ) tStep = 5; end 	% by default, 5 ms
			if( nargin() < 5 ) isNewFigure = true; end

			RT = [];
			list = dir(folder);
			for( i = 1 : size(list,1) )
				if( list(i).isdir() )
					if( strcmp( list(i).name, '.' ) || strcmp( list(i).name, '..' ) || strcmpi( list(i).name(1:4), 'demo' ) || strcmpi( list(i).name(1:3), 'X. ' ) || strcmpi( list(i).name, 'calibration') )
						continue;
					else
					 	RT = [ RT, BlinkTransient.BlinkRT( fullfile(folder, list(i).name), alignEvt, 0 ) ];
					end
				else
					if( strcmp( list(i).name, 'Trials.mat' ) )
						load( fullfile(folder, list(i).name), 'Trials' );

						tmpRT = zeros(size(Trials));
						for( iTrial = size(Trials,2) : -1 : 1 )
							starts = [Trials(iTrial).blinks.start];
							starts( starts <= Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart ) = [];
							if( isempty(starts) )
								tmpRT(iTrial) = NaN;
								continue;
							end

							tmpRT(iTrial) = starts(1) - (Trials(iTrial).(alignEvt) - Trials(iTrial).tTrialStart);
						end

						RT = [RT tmpRT];
					end
				end
			end

			% RT(RT < 0) = [];
			RT(isnan(RT)) = [];
			
			if( isPlot )
				if( isNewFigure )
					name = 'Blink';
					if( strcmpi( alignEvt, 'tblinkbeepon' ) ) name = [name,'RT'];
					else name = [name, 'Aligned2', alignEvt]; end
					set( figure, 'NumberTitle', 'off', 'name', name, 'color', 'w' );
				end
				ToolKit.Hist( RT, min(RT) - tStep/2 : tStep : max(RT) + tStep/2 );
				switch alignEvt
					case 'tBlinkBeepOn'
						x = [0 2000];
					case 'tPlateauOn'
						x = [-2500 2000];
					case 'tFpOn'
						x = [0 4500];
					case 'tRampOn'
						x = [-1000 3500];
					otherwise
						x = [0 2000];
				end
				set( gca, 'XLim', x, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				xlabel( sprintf( 'Time aligned to %s (ms)', alignEvt ) );
				ylabel( 'Number of trials' );
			end
		end


		function amplitudes = FixSacAmp( folder, isPlot, ampStep, cutAmp, isNewFigure )
			%% amplitudes:
			%    amplitudes.microsaccades:	for recorded "microsaccades"; in arc mins
			%    amplitudes.saccades:		for recorded "saccades"; in arc mins
			%  input:
			%	 cutAmp:					amplitude threshold for microsaccades and saccades, 30 arc mins by default

			if( nargin() < 2 ) isPlot = true; end
			if( nargin() < 3 || isempty(ampStep) ) ampStep = 3; end 	% by default, 3 arc mins
			if( nargin() < 4 || isempty(cutAmp) ) cutAmp = 30; end
			if( nargin() < 5 ) isNewFigure = true; end

			amplitudes.microsaccades = [];
			amplitudes.saccades = [];
			amplitudes.nTrials = 0;

			list = dir(folder);
			for( i = 1 : size(list,1) )
				if( list(i).isdir() )
					if( strcmp( list(i).name, '.' ) || strcmp( list(i).name, '..' ) || strcmpi( list(i).name(1:4), 'demo' ) || strcmpi( list(i).name(1:3), 'X. ' ) || strcmpi( list(i).name, 'calibration') )
						continue;
					else
						tmpAmp = BlinkTransient.FixSacAmp( fullfile(folder, list(i).name), 0, ampStep, cutAmp );
						amplitudes.microsaccades = [amplitudes.microsaccades, tmpAmp.microsaccades];
						amplitudes.saccades = [amplitudes.saccades, tmpAmp.saccades];
						amplitudes.nTrials = amplitudes.nTrials + tmpAmp.nTrials;
					end
				else
					if( strcmp( list(i).name, 'Trials.mat' ) )
						load( fullfile(folder, list(i).name), 'Trials' );
						microsaccades = [Trials.microsaccades];
						tmpAmp.microsaccades = [microsaccades.amplitude];
						saccades = [Trials.saccades];
						tmpAmp.saccades = [saccades.amplitude];

						amplitudes.microsaccades = [amplitudes.microsaccades, microsaccades.amplitude];
						amplitudes.saccades = [amplitudes.saccades, saccades.amplitude];
						amplitudes.nTrials = amplitudes.nTrials + size(Trials,2);
					end
				end
			end

			if( isPlot )
				if( isNewFigure )
					set( figure, 'NumberTitle', 'off', 'name', 'Fixational saccade amplitude', 'color', 'w' );
				end
				% edges = min(amplitudes.microsaccades) - ampStep/2 : ampStep : max(amplitudes.microsaccades) + ampStep/2;
				edges = 0 : ampStep : cutAmp;
				h(2) = bar( (edges(1:end-1) + edges(2:end)) / 2, ToolKit.Hist( amplitudes.microsaccades, edges, false ) / amplitudes.nTrials, 0.9, 'r', 'LineStyle', 'none', 'DisplayName', 'microsaccades', 'FaceAlpha', 0.6 );
				hold on;
				% edges = min(amplitudes.saccades) - ampStep/2 : ampStep : min( [max(amplitudes.saccades), 300] ) + ampStep/2;
				edges = cutAmp : ampStep : min( [max(amplitudes.saccades), 300] );
				h(1) = bar( (edges(1:end-1) + edges(2:end)) / 2, ToolKit.Hist( amplitudes.saccades, edges, false ) / amplitudes.nTrials, 0.9, 'b', 'LineStyle', 'none', 'DisplayName', 'saccades', 'FaceAlpha', 0.6 );
				legend(h);
				title( sprintf( 'nTrials: %d', amplitudes.nTrials ) );
				set( gca, 'XLim', [0 180], 'XTick', 0:30:180, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				xlabel( 'Amplitude (arc min)' );
				ylabel( 'Number of (micro)saccades' );
			end
		end


		function rates = SaccadesRate( folder, alignment, smooth, window, isPlot, isNewFigure )
			%% alignment:					event to align the rates; by default, aligned to the time point of the first recorded eye position
			%  window:						sliding window size (ms)
			%  smooth:						'gaussian', 'square', 'raw'
			%  rates:						structure array for "microsaccades" and "saccades" rate distributions
			%    rates.rate.microsaccades:	rate for microsaccades (Hz)
			%	 rates.rate.saccades:		rate for large saccades (Hz)
			%    rates.tTicks:				timeline for rates.rate (ms)
			%    rates.nTrials: 			number of trials used

			if( nargin() < 2 || isempty(alignment) ) alignment = 'startTrial'; end
			if( nargin() < 3 || isempty(smooth) ) smooth = 'raw'; end
			if( nargin() < 4 || isempty(window) ) window = 10; end
			if( nargin() < 5 || isempty(isPlot) ) isPlot = true; end
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end

			rates.rate = [];
			rates.tTicks = [];
			rates.nTrials = 0;

			list = dir(folder);
			for( i = 1 : size(list,1) )
				if( list(i).isdir() )
					if( strcmp( list(i).name, '.' ) || strcmp( list(i).name, '..' ) || strcmpi( list(i).name(1:4), 'demo' ) || strcmpi( list(i).name(1:3), 'X. ' ) || strcmpi( list(i).name, 'calibration') )
						continue;
					else
						rates = Add( rates, BlinkTransient.SaccadesRate( fullfile(folder, list(i).name), alignment, smooth, window, 0 ) );
					end
				else
					if( strcmp( list(i).name, 'Trials.mat' ) )
						load( fullfile(folder, list(i).name), 'Trials' );
						microsaccades = [Trials.microsaccades];
						saccades = [Trials.saccades];
						switch(lower(alignment))
							case 'fpon'
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start - ( Trials(iTrial).tFpOn - Trials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start - ( Trials(iTrial).tFpOn - Trials(iTrial).tTrialStart );
								end
							case 'rampon'
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start - ( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start - ( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart );
								end
							case 'plateauon'
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start - ( Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start - ( Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart );
								end
							case 'maskon'
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start - ( Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start - ( Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart );
								end
							case 'blink'	% first blink after beep for blink
								index = false(size(Trials));
								for( iTrial = 1 : size(Trials,2) )
									t = Trials(iTrial).blinks.start( find( Trials(iTrial).blinks.start > Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart, 1, 'first' ) );
									if(isempty(t))
										index(iTrial) = true;
									else
										microsaccades(iTrial).start = microsaccades(iTrial).start - t;
										saccades(iTrial).start = saccades(iTrial).start - t;
									end
								end
								microsaccades(index) = [];
								saccades(index) = [];
							case 'response'
								tmpTrials = Trials( [Trials.tResponse] > 0 );
								microsaccades = [tmpTrials.microsaccades];
								saccades = [tmpTrials.saccades];
								for( iTrial = 1 : size(tmpTrials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start - ( tmpTrials(iTrial).tResponse - tmpTrials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start - ( tmpTrials(iTrial).tResponse - tmpTrials(iTrial).tTrialStart );
								end
						end
						tMicrosaccades = round( [microsaccades.start] );
						tSaccades = round( [saccades.start] );
						tmpRates.nTrials = size(microsaccades,2);
						tmpRates.tTicks = min( [ tMicrosaccades, tSaccades ] ) : max( [ tMicrosaccades, tSaccades ] );
						tmpRates.rate.microsaccades = ToolKit.Hist( tMicrosaccades, [ tmpRates.tTicks - 0.5, tmpRates.tTicks(end) + 0.5 ], false ) / tmpRates.nTrials / 0.001;
						tmpRates.rate.saccades = ToolKit.Hist( tSaccades, [ tmpRates.tTicks - 0.5, tmpRates.tTicks(end) + 0.5 ], false ) / tmpRates.nTrials / 0.001;
						switch( lower(smooth) )
							case 'gaussian'
								SIGMA = window/2;
				        		tmpRates.rate.microsaccades = conv( tmpRates.rate.microsaccades, normpdf( -4*SIGMA : 4*SIGMA, 0, SIGMA ), 'same' );
				        		tmpRates.rate.saccades = conv( tmpRates.rate.saccades, normpdf( -4*SIGMA : 4*SIGMA, 0, SIGMA ), 'same' );
							case 'square'
								tmpRates.rate.microsaccades = conv( tmpRates.rate.microsaccades, ones(1,window)/window, 'same' );
				        		tmpRates.rate.saccades = conv( tmpRates.rate.saccades, ones(1,window)/window, 'same' );
						end

						rates = Add( rates, tmpRates );

					end
				end
			end

			if( isPlot )
				if( isNewFigure )
					set( figure, 'NumberTitle', 'off', 'name', 'Fixational saccades rate', 'color', 'w' );
				end
				h(3) = plot( rates.tTicks, rates.rate.microsaccades + rates.rate.saccades, 'k', 'LineWidth', 2, 'DisplayName', 'overall' ); hold on;
				h(2) = plot( rates.tTicks, rates.rate.microsaccades, 'r', 'LineWidth', 2, 'DisplayName', 'microsaccades' );
				h(1) = plot( rates.tTicks, rates.rate.saccades, 'b', 'LineWidth', 2, 'DisplayName', 'saccades' );
				legend(h);
				set( gca, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				xlabel( 'Time (ms)' );
				ylabel( 'Rates (Hz)' );
				title( ['Aligned to ' alignment] );
			end

			function curRates = Add( curRates, newRates )
				%% add newRates into curRates
				if( curRates.nTrials == 0 )
					curRates = newRates;
				else
					minTime = min( [ curRates.tTicks(1), newRates.tTicks(1) ] );
					maxTime = max( [ curRates.tTicks(end), newRates.tTicks(end) ] );
					curRates.rate.microsaccades = [ zeros( 1, curRates.tTicks(1) - minTime ), curRates.rate.microsaccades, zeros( 1, maxTime - curRates.tTicks(end) ) ];	% padding zeros
					curRates.rate.saccades = [ zeros( 1, curRates.tTicks(1) - minTime ), curRates.rate.saccades, zeros( 1, maxTime - curRates.tTicks(end) ) ];	% padding zeros
					newRates.rate.microsaccades = [ zeros( 1, newRates.tTicks(1) - minTime ), newRates.rate.microsaccades, zeros( 1, maxTime - newRates.tTicks(end) ) ];	% padding zeros
					newRates.rate.saccades = [ zeros( 1, newRates.tTicks(1) - minTime ), newRates.rate.saccades, zeros( 1, maxTime - newRates.tTicks(end) ) ];	% padding zeros
					curRates.rate.microsaccades = ( curRates.rate.microsaccades * curRates.nTrials + newRates.rate.microsaccades * newRates.nTrials ) / ( curRates.nTrials + newRates.nTrials );
					curRates.rate.saccades = ( curRates.rate.saccades * curRates.nTrials + newRates.rate.saccades * newRates.nTrials ) / ( curRates.nTrials + newRates.nTrials );
					curRates.tTicks = minTime : maxTime;
					curRates.nTrials = curRates.nTrials + newRates.nTrials;
				end
			end
		end

		function curRates = SaccadesRateAdd( curRates, newRates )
			%% add newRates into curRates
			if( curRates.nTrials == 0 )
				curRates = newRates;
			else
				minTime = min( [ curRates.tTicks(1), newRates.tTicks(1) ] );
				maxTime = max( [ curRates.tTicks(end), newRates.tTicks(end) ] );
				curRates.rate.microsaccades = [ zeros( 1, curRates.tTicks(1) - minTime ), curRates.rate.microsaccades, zeros( 1, maxTime - curRates.tTicks(end) ) ];	% padding zeros
				curRates.rate.saccades = [ zeros( 1, curRates.tTicks(1) - minTime ), curRates.rate.saccades, zeros( 1, maxTime - curRates.tTicks(end) ) ];	% padding zeros
				newRates.rate.microsaccades = [ zeros( 1, newRates.tTicks(1) - minTime ), newRates.rate.microsaccades, zeros( 1, maxTime - newRates.tTicks(end) ) ];	% padding zeros
				newRates.rate.saccades = [ zeros( 1, newRates.tTicks(1) - minTime ), newRates.rate.saccades, zeros( 1, maxTime - newRates.tTicks(end) ) ];	% padding zeros
				curRates.rate.microsaccades = ( curRates.rate.microsaccades * curRates.nTrials + newRates.rate.microsaccades * newRates.nTrials ) / ( curRates.nTrials + newRates.nTrials );
				curRates.rate.saccades = ( curRates.rate.saccades * curRates.nTrials + newRates.rate.saccades * newRates.nTrials ) / ( curRates.nTrials + newRates.nTrials );
				curRates.tTicks = minTime : maxTime;
				curRates.nTrials = curRates.nTrials + newRates.nTrials;
			end
		end


		function [PS, sHFreqs, sVFreqs, tFreqs, img] = PowerSpectrumAna( dataFileName, version, varargin )
			%%
			% version:	covering; simulating a blink as upper eye lid covers the visual input image from top to bottom then back to top (padding input image with dark area)
			% PS:		1st dimension: horizontal space; 2nd dimension: vertical space; 3rd dimension: time space
			% sHFreqs:	spatial horizontal frequncies for PS
			% sVFreqs:  spatial vertical frequencies for PS
			% tFreqs:	temporal frequencies for PS

			if( nargin() >= 3 )
				for( i = 1 : 2 : size(varargin,2) )
					switch( lower(varargin{i}) )
						case 'spatialfrequency'
							sf = varargin{i+1};
						case 'orientation'
							orientation = varargin{i+1};
						case 'modulator'
							modulator = lower(varargin{i+1});
						otherwise
							varargin{i+1}
					end
				end
			end

			if( ~exist( 'modulator', 'var' ) ) modulator = 'blink'; end

			load( dataFileName );

			swPix = 2560;	% screen width in pixels
			swMm = 600;		% screen width in mm
			shPix = 1440;	% screen height in pixels
			shMm = 335;		% screen height in mm
			sDist = 1605;%1190;	% distance from screen to subject's eye in mm
			gwPix = 720;	% width of gabor patch in pixels; half of the screen height

			Win = 1;	% e.g., Hanning Window
			U = 1;	% scale factor for Win
			PSX = floor(gwPix);
			PSY = floor(gwPix);
			PSZ = 1024;
			NSamples = PSX * PSY * PSZ;
			PS = zeros( PSX/2+1, PSY/2+1, PSZ/2+1, 'single' );
			sHFreqs = (0 : size(PS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
			sVFreqs = (0 : size(PS,2)-1) / (atand( PSX/shPix*shMm/2 / sDist ) * 2);
			sFreqs = (0 : size(PS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
			tFreqs = (0 : size(PS,3)-1) / (PSZ/1000);
			mov = zeros( PSX, PSY, PSZ, 'single' );

			sigma = 180;%120;
			if( ~exist( 'orientation', 'var' ) ) orientation = 0; end
			phase = 0;
			bgnLuminance = BlinkTransient.Intensity2Luminance(128);
			gbAmp = BlinkTransient.Intensity2Luminance(128+8) - bgnLuminance;
			img = zeros( swPix, shPix );	% 1st dimension: horizontal (width); 2nd dimension: vertical (height)
			gabor = zeros( gwPix, gwPix );
			sf = 0 : 0.1 : 10000;
			wlPix = gwPix ./ ( atand( gwPix/shPix*shMm/2 / sDist ) * 2 * sf );
			% for( wl = wlPix )
			% 	% gabor = gabor + ToolKit.Gabor( wl, orientation, phase, gwPix, 'grating', sigma );
			% 	gabor = gabor + ToolKit.Gabor( wl, 0, phase, gwPix, 'gabor', sigma );
			% end
			gabor = zeros(PSY,PSX);
			gabor(:,PSX/2) = 1;
			img( (swPix-gwPix)/2 + (1:gwPix), (shPix-gwPix)/2 + (1:gwPix) ) = gabor' * gbAmp / bgnLuminance;
			
			FontSize = 24;
			LineWidth = 2;

			nValidTrials = size(Trials,2);
			for( iTrial = 1: size(Trials,2) )
				if( strcmp( modulator, 'blink' ) )
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

					% rotate by -orientation
					xx = x * cosd(orientation) + y * sind(orientation);
					yy = y * cosd(orientation) - x * sind(orientation);

					% convert to pixels
					x = round( sDist * tand(x/60) / swMm * swPix );
					y = round( sDist * tand(y/60) / shMm * shPix );
				end

				if( strcmpi( version, 'covering' ) )

					% blink trace simulated as covering input image from top to bottom and then back to top
					[bx, by] = meshgrid( 1:PSX, 1:PSY );
					bx = bx';
					by = by';
					a = sind(-orientation);
					b = cosd(-orientation);
					dc = max( a * bx(:) - b * by(:) ) - min( a * bx(:) - b * by(:) ) + 1;
					bTrace = ones(1,PSZ) * min( a * bx(:) - b * by(:) ) - 1;
					
					if( ~strcmp( modulator, 'drift' ) )
						d = randi(501) - 251;
						bTrace( (1:300) + (end-300)/2 + d ) = max( a * bx(:) - b * by(:) );		% 300 ms of complete covering
						dur = round(dc/PSX*20);	% move by PSX in 20 ms
						bTrace( (1-dur:0) + (end-300)/2 + d ) = min( a * bx(:) - b * by(:) ) - 1 + round( (1:dur)/dur * dc );
						bTrace( (dur:-1:1) + 300 + (end-300)/2 + d ) = min( a * bx(:) - b * by(:) ) - 1 + round( (1:dur)/dur * dc );
						
						% freeze eye trace during blink
						iStart = find( bTrace > min( a * bx(:) - b * by(:) ) - 1, 1, 'first' );	% start of blink
						iEnd = find( bTrace > min( a * bx(:) - b * by(:) ) - 1, 1, 'last' );		% end of blink
						if( ~isempty(iStart) && ~isempty(iEnd) )
							x(iStart:iEnd) = x(iStart-1);
							x(iEnd+1:end) = x(iEnd+1:end) - ( x(iEnd+1) - x(iStart-1) );
							y(iStart:iEnd) = y(iStart-1);
							y(iEnd+1:end) = y(iEnd+1:end) - ( y(iEnd+1) - y(iStart-1) );
						end

						subplot(2,2,2); hold off;
						plot( 1:PSZ, bTrace, 'LineWidth', LineWidth );
						set( gca, 'XLim', [0 PSZ], 'YLim', [min(bTrace) max(bTrace)] * 1.05, 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
						xlabel( 'Time (ms)' );
						ylabel( 'Front edge (pixel)' );
						title( 'Blink simulated as covering visual field' );
					end

					% power spectrum
					nOverlaps = 1;
					for( t = 1 : PSZ )
						tmpMov = img( (0:PSX-1) + round( ( size(img,1) - PSX ) / 2 ) + x(t), (0:PSY-1) + round( ( size(img,2) - PSY ) / 2 ) + y(t) );
                        tmpMov( a * bx - b * by <= bTrace(t) ) = 0;
						mov( :, :, t ) = tmpMov;
						% imshow( mov(350:370,:,t), [] );
					end
					mov = ( mov - mean(mov(:)) ) .* Win;
					tPS = fftn(mov);
					PS = PS + abs( tPS( 1:size(PS,1), 1:size(PS,2), 1:size(PS,3) ) ).^2;	% discard negative frequency part
						% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)
				else
					% power spectrum
					nOverlaps = 9;
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
							tPS = fftn(mov);
							PS = PS + abs( tPS( 1:size(PS,1), 1:size(PS,2), 1:size(PS,3) ) ).^2;	% discard negative frequency part
								% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)
						end
					end
				end
			end
			PS(2:end-1, 2:end-1, 2:end-1) = 2^3 * PS(2:end-1, 2:end-1, 2:end-1);	% convert to single sided
			PS = PS / ( PSX * (PSX/(atand(PSX/swPix*swMm/2/sDist)*2)) * PSY * (PSY/(atand(PSY/shPix*shMm/2/sDist)*2)) * PSZ * 1000 * U ) / nOverlaps / size(nValidTrials,2);	% average over 9 overlapped windows and all eye traces
			% save( 'Drift_PS_theory.mat', 'PS' );

			if( strcmp( modulator, 'drift' ) )
				subplot(2,2,1);
			elseif( strcmp( modulator, 'blink' ) )
				subplot(2,2,4);
			else
				subplot(2,2,3);
			end
			colormap('hot');
			contour( sHFreqs(2:end), tFreqs(2:50), reshape( sum(PS(2:end,:,2:50),2), size(PS,1)-1, [] )', 1000, 'LineStyle', 'none', 'fill', 'on' );
			caxis( [ 0, max(max( reshape( sum(PS(2:end,:,2:50),2), size(PS,1)-1, [] ) )) ] );
			colorbar;
			xlabel( 'Spatial frequency (cpd)' );
			ylabel( 'Temporal frequency (Hz)' );
			title( [ upper(modulator(1)), modulator(2:end) ] );
			position = get( gca, 'position' );
			% position(2) = position(2) + 0.05;	% move up by 0.05 (position: [ left bottom, width, height ])
			% position(4) = position(4) - 0.1;
			set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [0.5 60], 'YLim', tFreqs([2 50]), 'XTick', [1 5 10 20 40], 'YTick', [1 5 10 20 40 80], 'position', position );

		end



		function [PS, sFreqs, tFreqs] = QRadPowerSpectrumAna( dataFileName, modulator )
			%% modulator:		drift, blink, or drift+blink
			
			modulator = lower(modulator);

			load( dataFileName, 'Trials' );

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
			gabor = ToolKit.Gabor( wlPix, orientation, phase, gwPix, 'grating', sigma )' * gbAmp;
			% gabor = zeros(gwPix,gwPix);
			% for( f = sFreqs )
			% 	gabor = gabor + ToolKit.Gabor( gwPix / ( atand( gwPix/shPix*shMm/2 / sDist ) * 2 * f ), orientation, phase, gwPix, 'grating', sigma )';
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
					title( 'Blink simulated as gain modulation' );
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


		function PlotPSDSummary( version )

			global PSD_Covering;
			global PSD_Gain;

			if( strcmpi( version, 'covering' ) )
				if( isempty(PSD_Covering) )
					figure;
					pause(0.1);
					jf = get(handle(gcf),'javaframe');
					jf.setMaximized(1);
					pause(0.5);
					[PS_B, sFreqs_B, ~, tFreqs_B] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\A082\20180731_noPEST_03 (sf1)\Trials.mat','covering','modulator','blink');
					[PS_D, sFreqs_D, ~, tFreqs_D] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\A082\20180731_noPEST_03 (sf1)\Trials.mat','covering','modulator','drift');
					[PS_DB, sFreqs_DB, ~, tFreqs_DB] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\A082\20180731_noPEST_03 (sf1)\Trials.mat','covering','modulator','Drift+blink');
					PS_B = reshape( sum( PS_B, 2 ), size(PS_B,1), [] );
					PS_D = reshape( sum( PS_D, 2 ), size(PS_D,1), [] );
					PS_DB = reshape( sum( PS_DB, 2 ), size(PS_DB,1), [] );
					
					PSD_Covering.PS_B = PS_B;
					PSD_Covering.sFreqs_B = sFreqs_B;
					PSD_Covering.tFreqs_B = tFreqs_B;
					PSD_Covering.PS_D = PS_D;
					PSD_Covering.sFreqs_D = sFreqs_D;
					PSD_Covering.tFreqs_D = tFreqs_D;
					PSD_Covering.PS_DB = PS_DB;
					PSD_Covering.sFreqs_DB = sFreqs_DB;
					PSD_Covering.tFreqs_DB = tFreqs_DB;
				else
					PS_B = PSD_Covering.PS_B;
					sFreqs_B = PSD_Covering.sFreqs_B;
					tFreqs_B = PSD_Covering.tFreqs_B;
					PS_D = PSD_Covering.PS_D;
					sFreqs_D = PSD_Covering.sFreqs_D;
					tFreqs_D = PSD_Covering.tFreqs_D;
					PS_DB = PSD_Covering.PS_DB;
					sFreqs_DB = PSD_Covering.sFreqs_DB;
					tFreqs_DB = PSD_Covering.tFreqs_DB;
				end
			elseif( strcmpi( version, 'gain' ) )
				if( isempty(PSD_Gain) )
					figure;
					pause(0.1);
					jf = get(handle(gcf),'javaframe');
					jf.setMaximized(1);
					pause(0.5);
					[PS_D, sFreqs_D, tFreqs_D] = BlinkTransient.QRadPowerSpectrumAna('F:\BlinkTransient\A082\20180731_noPEST_03 (sf1)\Trials.mat','drift');
					[PS_B, sFreqs_B, tFreqs_B] = BlinkTransient.QRadPowerSpectrumAna('F:\BlinkTransient\A082\20180731_noPEST_03 (sf1)\Trials.mat','blink');
					[PS_DB, sFreqs_DB, tFreqs_DB] = BlinkTransient.QRadPowerSpectrumAna('F:\BlinkTransient\A082\20180731_noPEST_03 (sf1)\Trials.mat','drift+blink');

					PSD_Gain.PS_B = PS_B;
					PSD_Gain.sFreqs_B = sFreqs_B;
					PSD_Gain.tFreqs_B = tFreqs_B;
					PSD_Gain.PS_D = PS_D;
					PSD_Gain.sFreqs_D = sFreqs_D;
					PSD_Gain.tFreqs_D = tFreqs_D;
					PSD_Gain.PS_DB = PS_DB;
					PSD_Gain.sFreqs_DB = sFreqs_DB;
					PSD_Gain.tFreqs_DB = tFreqs_DB;
				else
					PS_B = PSD_Gain.PS_B;
					sFreqs_B = PSD_Gain.sFreqs_B;
					tFreqs_B = PSD_Gain.tFreqs_B;
					PS_D = PSD_Gain.PS_D;
					sFreqs_D = PSD_Gain.sFreqs_D;
					tFreqs_D = PSD_Gain.tFreqs_D;
					PS_DB = PSD_Gain.PS_DB;
					sFreqs_DB = PSD_Gain.sFreqs_DB;
					tFreqs_DB = PSD_Gain.tFreqs_DB;
				end
			else
				return;
			end

			set( figure, 'NumberTitle', 'off', 'name', [ 'PSDSummary.' version ] );
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
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [sFreqs_D(2), 20], 'XTick', [1 10], 'XTickLabel', [1 10] );
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
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 60], 'XTick', [1 10 40], 'XTickLabel', [1 10 40] );
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
				data(i) = load(sprintf('F:/BlinkTransient/Monitor Calibration/ASUS278_Contrast_0_Brightness_0_Test_Dist_162_BS_BW_Repeat%d.mat',i));
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