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


		function Ana20181029()
			%% column 1: duration distribution of blinks happen during Plateau
			%% column 2: blink onset distribution aligned to Plateau on
			%% column 3: amplitude distribution of fixational saccades
			%% column 4: performance comparison for 3 types of trials: drift only, drift + microsaccades, drift + saccades
			sbjs = { 'A017', 'A082', 'Bin' };
			folders = { 'F:\BlinkTransient\A017',...
						'F:\BlinkTransient\A082\2 FixedLevels',...
						'F:\BlinkTransient\Bin\2.5s+1.5s' };
			folderIndices = { 1:20,...
							  1:9,...
							  1:21 };

			set( figure, 'NumberTitle', 'off', 'name', 'Explore Blink Effect', 'color', 'w' );

			for( iSbj = 1 : 3 )

				%% blink duration
				subplot( 3, 4, 4*(iSbj-1) + 1 );
				BlinkTransient.BlinkDuration( sbjs{iSbj}, folders{iSbj}, folderIndices{iSbj}, [], true, [], false );
				title('Blink Duration');
				if(iSbj ~= 1)
					title([]);
				end
				if(iSbj ~= 3)
					set( gca, 'XTickLabel', [] );
					xlabel([]);
				end


				%% blink raster
				subplot( 3, 4, 4*(iSbj-1) + 2 );
				BlinkTransient.BlinkRaster( sbjs{iSbj}, folders{iSbj}, folderIndices{iSbj}, false );
				title('Blink Raster');
				if( iSbj ~= 1 )
					title([]);
				end
				if( iSbj ~= 3 )
					set( gca, 'XTickLabel', [] );
					xlabel([]);
				end


				%% saccade amplitude
				subplot( 3, 4, 4*(iSbj-1) + 3 );
				data = BlinkTransient.GetData4Blinks( folders{iSbj}, false, false );
				data = data(folderIndices{iSbj});
				trials = [data.trialsWithBlink, data.trialsWithoutBlink];
				% for( iTrial = 1 : size(trials,2) )
				% 	trials(iTrial).microsaccades.amplitude( ( trials(iTrial).microsaccades.start + trials(iTrial).microsaccades.duration - 2 ) / trials(iTrial).sRate * 1000 >= trials(iTrial).tMaskOn - trials(iTrial).tTrialStart ) = [];
				% 	trials(iTrial).saccades.amplitude( ( trials(iTrial).saccades.start + trials(iTrial).saccades.duration - 2 ) / trials(iTrial).sRate * 1000 >= trials(iTrial).tMaskOn - trials(iTrial).tTrialStart ) = [];
				% end
				microsaccades = [trials.microsaccades];
				amplitudes.microsaccades = [microsaccades.amplitude];
				saccades = [trials.saccades];
				amplitudes.saccades = [saccades.amplitude];
				amplitudes.nTrials = size(trials,2);

				ampStep = 3;
				cutAmp = 30;
				edges = 0 : ampStep : cutAmp;
				h(2) = bar( (edges(1:end-1) + edges(2:end)) / 2, ToolKit.Hist( amplitudes.microsaccades, edges, false ) / amplitudes.nTrials, 0.9, 'm', 'LineStyle', 'none', 'DisplayName', 'microsaccades', 'FaceAlpha', 0.6 );
				hold on;
				edges = cutAmp : ampStep : min( [max(amplitudes.saccades), 300] );
				h(1) = bar( (edges(1:end-1) + edges(2:end)) / 2, ToolKit.Hist( amplitudes.saccades, edges, false ) / amplitudes.nTrials, 0.9, 'g', 'LineStyle', 'none', 'DisplayName', 'saccades', 'FaceAlpha', 0.6 );
				
				set( gca, 'XLim', [0 180], 'XTick', 0:30:180, 'box', 'off', 'LineWidth', 1, 'FontSize', 20 );
				if( iSbj ~= 3 )
					set( gca, 'XTickLabel', [] );
				end
				ylabel( 'Number of sacs' );
				if( iSbj == 3 )
					xlabel( 'Amplitude (arc min)' );
					legend(h);
				end
				if( iSbj == 1 )
					title('Saccade Amplitude');
				end


				%% performance
				subplot( 3, 4, 4*(iSbj-1) + 4 );
				BlinkTransient.FixLevelMultiComp( sbjs{iSbj}, folders{iSbj}, folderIndices{iSbj}, 'tPlateauOn', 0, false );
				if( iSbj ~= 3 ) set( gca, 'XTickLabel', [] ); end
				if( iSbj ~= 1 )
					title([]);
					legend('off');
				end
				if( iSbj ~= 3 )
					set( gca, 'XTickLabel', [] );
				end
			end

			subplot(3,4,1);
			pos1 = get( gca, 'position' );
			y1 = pos1(2) + pos1(4)/2;
			subplot(3,4,5);
			pos2 = get( gca, 'position' );
			y2 = pos2(2) + pos2(4)/2;
			subplot(3,4,9);
			pos3 = get( gca, 'position' );
			y3 = pos3(2) + pos3(4)/2;

			h(1) = ToolKit.BorderText( 'FigureLeftTop', 'A017', 'FontSize', 20, 'FontWeight', 'Bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top' );
			set( h(1), 'position', [0.05, y1, 0] );
			h(2) = ToolKit.BorderText( 'FigureLeft', 'A082', 'FontSize', 20, 'FontWeight', 'Bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top' );
			set( h(2), 'position', [0.05, y2, 0] );
			h(3) = ToolKit.BorderText( 'FigureLeftBottom', 'Bin', 'FontSize', 20, 'FontWeight', 'Bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top' );
			set( h(3), 'position', [0.05, y3, 0] );
		end


		function FreeReport20181108( tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones )
			%% tLBEvent4Blink:		hasBlink is true only if a blink happens after tLBEvent4Blink
			%  tLBOffset4Blink:		offset regarding tLBEvent4Blink
			%  tUBOffset4Blink:		offset regarding upper bound for hasBlink
			%  reverse2Tones:		assign true for the paradigm where lower tone signaling later report and higher tone signaling immediate report

			if( nargin() < 1 || isempty(tAlignEvent) ) tAlignEvent = 'tRampOn'; end 	% start event for microsaccades/saccades control analysis
			if( nargin() < 2 || isempty(tStart) ) tStart = 0; end 						% start time for microsaccades/saccades control analysis (relative to tAlignEvent)
			if( nargin() < 3 || isempty(tLBEvent4Blink) ) tLBEvent4Blink = 'tRampOn'; end
			if( nargin() < 4 || isempty(tLBOffset4Blink) ) tLBOffset4Blink = 0; end
			if( nargin() < 5 || isempty(tUBOffset4Blink) ) tUBOffset4Blink = 0; end
			if( nargin() < 6 || isempty(reverse2Tones) ) reverse2Tones = false; end

			sbjs = { 'A017', 'A017', 'A082', 'A082', 'A017', 'A017', 'Nikunj', 'Bin', 'MAC', 'Bin', 'A043', 'A017', 'Janis' };
			folders = { 'F:\BlinkTransient\A017\3 FreeReport',...
						'F:\BlinkTransient\A017\3 FreeReport',...
						'F:\BlinkTransient\A082\3 FreeReport',...
						'F:\BlinkTransient\A082\3 FreeReport',...
						'F:\BlinkTransient\A017\3 FreeReport',...
						'F:\BlinkTransient\A017\3 FreeReport',...
						'F:\BlinkTransient\Nikunj',...
						'F:\BlinkTransient\Bin\1.5s+0.75_1.25s',...
						'F:\BlinkTransient\MAC',...
						'F:\BlinkTransient\Bin\1.5s+0s',...
						'F:\BlinkTransient\A043',...
						'F:\BlinkTransient\A017\3 FreeReport',...
						'F:\BlinkTransient\Janis' };
			blockIndices = { 2:5, 6:10, 1:6, 7:10, 12:15, 17:20, 4:7, 1:13, 2:10, 1:13, 2:5, 21:25, 2:6 };

			iSbj = 7;
			data = BlinkTransient.GetLabeledTrials4Blinks( folders{iSbj}, tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink );
			% for( i = 1 : size(data,2) )
			% 	trials = data(i).trials;
			% 	if( isfield(trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
			% 		beepFreq = [trials.beepFreq];
			% 		beepFreq = beepFreq - mean( unique(beepFreq) );
			% 		if( size( unique(beepFreq), 2 ) == 2 )
			% 			trials( beepFreq < 0 & [trials.hasBlink] | beepFreq > 0 & ~[trials.hasBlink] ) = [];
			% 		else
			% 			trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
			% 		end	
			% 	else
			% 		trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
			% 	end
			% 	data(i).trials = trials;
			% end
			Trials = [data(blockIndices{iSbj}).trials];
			if( isfield(Trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
				beepFreq = [Trials.beepFreq];
				beepFreq = beepFreq - mean( unique(beepFreq) );
				if( size( unique(beepFreq), 2 ) == 2 )
					Trials( beepFreq < 0 & [Trials.hasBlink] | beepFreq > 0 & ~[Trials.hasBlink] ) = [];
				else
					Trials( [Trials.tBlinkBeepOn] - [Trials.tRampOn] > -600 & ~[Trials.hasBlink] | [Trials.tBlinkBeepOn] - [Trials.tRampOn] < -600 & [Trials.hasBlink] ) = [];
				end	
			else
				Trials( [Trials.tBlinkBeepOn] - [Trials.tRampOn] > -600 & ~[Trials.hasBlink] | [Trials.tBlinkBeepOn] - [Trials.tRampOn] < -600 & [Trials.hasBlink] ) = [];
			end

			set( figure, 'NumberTitle', 'off', 'name', [ sbjs{iSbj}, ': FreeReport' ], 'color', 'w' );

			%% overall response time
			subplot(3,4,1); hold on;
			trials = Trials;
			tResponse = [trials.tResponse] - [trials.tMaskOn];
			tStep = 100;
			edges = min(tResponse) - tStep/2 : tStep : max(tResponse) + tStep/2;
			hData = ToolKit.Hist( tResponse, edges, false );
			bar( (edges(1:end-1) + edges(2:end)) / 2, hData, 0.9, 'k', 'LineStyle', 'none', 'DisplayName', 'saccades', 'FaceAlpha', 0.8 );

			% early responses
			tResponse = [trials.tResponse] - [trials.tMaskOn];
			edg = edges( edges < -250 + tStep/2 );
			if( ~isempty(edg) )
				data = ToolKit.Hist( tResponse( tResponse < edg(end) & [trials.trialType] == 'c' ), edg, false );
				bar( (edg(1:end-1) + edg(2:end)) / 2, data, 0.9, 'g', 'LineStyle', 'none', 'DisplayName', 'saccades', 'FaceAlpha', 0.6 );
				n1 = sum( tResponse < edg(end) );
				p1 = sum( tResponse < edg(end) & [trials.trialType] == 'c' ) / n1;
				text( mean(tResponse(tResponse<edg(end))), max(hData)*0.05, sprintf( '$\\mathbf{n_1=%d}$\n$\\mathbf{p_1=%.1f\\%%}$', n1, p1*100 ), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'color', 'r', 'Interpreter', 'LaTex' );
			end

			% late responses
			edg = edges( edges > 250 - tStep/2 );
			if( ~isempty(edg) )
				data = ToolKit.Hist( tResponse( tResponse >= edg(1) & [trials.trialType] == 'c' ), edg, false );
				bar( (edg(1:end-1) + edg(2:end)) / 2, data, 0.9, 'g', 'LineStyle', 'none', 'DisplayName', 'saccades', 'FaceAlpha', 0.6 );
				n2 = sum( tResponse >= edg(1) );
				p2 = sum( tResponse >= edg(1) & [trials.trialType] == 'c' ) / n2;
				text( mean(tResponse(tResponse>=edg(1))), max(hData)*0.025, sprintf( '$\\mathbf{n_2=%d}$\n$\\mathbf{p_2=%.1f\\%%}$', n2, p2*100 ), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'color', 'r', 'Interpreter', 'LaTex' );
			end

			% z-test
			if( ~isempty( edges( edges < -250 + tStep/2 ) ) && ~isempty( edges( edges > 250 - tStep/2 ) ) )
				if(p1<p2)
					p1 = p1 + 0.5/n1;
					p2 = p2 - 0.5/n2;
				elseif(p1>p2)
					p1 = p1 - 0.5/n1;
					p2 = p2 + 0.5/n2;
				end
				p = ( n1*p1 + n2*p2 ) / (n1 + n2);
				sd = sqrt( p*(1-p) * ( 1/n1 + 1/n2 ) );
				pVal = ( 1 - normcdf( abs(p1-p2), 0, sd ) ) * 2;
				text( edges(3), max(hData)*1.175, sprintf( '$\\mathbf{p=%.3f}$', pVal ), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 18, 'color', 'k', 'Interpreter', 'LaTex' );
			end


			plot( [0 0], [0 max(hData)*1.2], 'k--', 'LineWidth', 1 );	% mask on time
			plot( [-1 -1]*1000, [0 max(hData)*1.2], 'k--', 'LineWidth', 1 );	% plateau on time

			set( gca, 'XLim', edges([1 end]), 'YLim', [0 max(hData)*1.2], 'LineWidth', 1, 'box', 'off', 'FontSize', 20 );
			set( xlabel('Time aligned to Mask onset (ms)'), 'FontSize', 20 );
			set( ylabel('Number of trials'), 'FontSize', 20 );
			set( title('RT'), 'FontSize', 20 );

			
			%% rasters; and tEnd VS tResponse
			subplot(1,2,2); hold on;
			hFlags = false(1,6);
			h(6) = gca;
			xlim1 = mean( [Trials.tFpOn] - [Trials.tPlateauOn] ) - 150;
			xlim2 = mean( [Trials.tMaskOn] - [Trials.tPlateauOn] ) + 1100;
			txtTags = { 'b', 'nb', 'drift', 'msac', 'sac' };
			txtColors = {'r', 'b'};
			blinkFlags = [true, false];
			sacFlags = [ false, false; true, false; false, true ];
			nTrials = 0;
			for( j = 1:3 )
				for( i = 1:2 )
					trials = Trials( [Trials.hasBlink] == blinkFlags(i) & [Trials.hasMicrosac] == sacFlags(j,1) & [Trials.hasSac] == sacFlags(j,2) );
					% if(j==2) trials = Trials( [Trials.hasBlink] == blinkFlags(i) & ( [Trials.hasMicrosac] | [Trials.hasSac] ) ); end
					if( isempty(trials) ) continue; end
					tSort = -Inf * ones(size(trials));
					for( iTrial = size(trials,2) : -1 : 1 )
						sRate = trials(iTrial).sRate;
						if( blinkFlags(i) )
							blinks = [trials(iTrial).microsaccades, trials(iTrial).saccades, trials(iTrial).blinks];
							blinks = [trials(iTrial).blinks];
							tEnd = sort( ( [blinks.start] + [blinks.duration] - 2 ) / sRate * 1000 );
							index = find( tEnd < min( trials(iTrial).tResponse, trials(iTrial).tMaskOn ) - trials(iTrial).tTrialStart, 1, 'last' );
							if( ~isempty(index) )
								tSort(iTrial) = tEnd(index) - ( trials(iTrial).tPlateauOn - trials(iTrial).tTrialStart );
							end
						else
							sacs = [trials(iTrial).microsaccades, trials(iTrial).saccades, trials(iTrial).blinks];
							% sacs = [trials(iTrial).blinks];
							tEnd = sort( ( [sacs.start] + [sacs.duration] - 2 ) / sRate * 1000 );
							index = find( tEnd < min( trials(iTrial).tResponse, trials(iTrial).tMaskOn ) - trials(iTrial).tTrialStart, 1, 'last' );
							if( ~isempty(index) )
								tSort(iTrial) = tEnd(index) - ( trials(iTrial).tPlateauOn - trials(iTrial).tTrialStart );
							end
							% tSort(iTrial) = trials(iTrial).tBlinkBeepOn - trials(iTrial).tPlateauOn;
						end
					end
					[tSort, index] = sort(tSort);
					trials = trials(index);

					x = []; y = [];
					x{size(trials,2),3} = [];
					y{size(trials,2),3} = [];
					evnts = {'blinks', 'microsaccades', 'saccades'};
					for( iTrial = size(trials,2) : -1 : 1 )
						sRate = trials(iTrial).sRate;
						for( iEvnt = 1 : 3 )
							index = trials(iTrial).tFpOn - trials(iTrial).tTrialStart <= ( trials(iTrial).(evnts{iEvnt}).start -1 ) / sRate * 1000 & (trials(iTrial).(evnts{iEvnt}).start + trials(iTrial).(evnts{iEvnt}).duration - 2)/sRate*1000 <= min( trials(iTrial).tMaskOn, trials(iTrial).tResponse ) - trials(iTrial).tTrialStart;
							if( sum(index) == 0 ) continue; end
							x{iTrial,iEvnt}(3,:) = ones(1,sum(index)) * NaN;
							x{iTrial,iEvnt}(1,:) = trials(iTrial).(evnts{iEvnt}).start(index);
							x{iTrial,iEvnt}(2,:) = trials(iTrial).(evnts{iEvnt}).start(index) + trials(iTrial).(evnts{iEvnt}).duration(index) - 1;
							x{iTrial,iEvnt} = reshape( ( x{iTrial,iEvnt} - 1 ) / sRate * 1000 - (trials(iTrial).tPlateauOn - trials(iTrial).tTrialStart), 1, [] );
							y{iTrial,iEvnt} = repmat( [iTrial, iTrial, NaN], 1, sum(index) );
						end
					end

					subplot(1,2,2);
					% plot blinks/sacs/msacs
					colors = {'k', [0.3 0.3 0.3], [0.4 0.4 0.4]};
					for( iEvnt = 1 : 3 )
						xx = [x{:,iEvnt}];
						yy = [y{:,iEvnt}] + nTrials;
						if( isempty(xx) ) continue; end
						h(iEvnt) = plot( xx, yy, 'color', colors{iEvnt}, 'LineWidth', 2, 'DisplayName', evnts{iEvnt} );
						hFlags(iEvnt) = true;
					end

					% plot response
					tResponse = [trials.tResponse] - [trials.tPlateauOn];
					y = (1 : size(trials,2)) + nTrials;
					if( any( [trials.trialType] == 'c' ) )
						h(3) = plot( tResponse( [trials.trialType] == 'c' ), y( [trials.trialType] == 'c' ), '.', 'color', [0 0.5 0], 'MarkerSize', 10, 'DisplayName', 'crct rpt' );
						hFlags(3) = true;
					end
					if( any(  [trials.trialType] == 'e') )
						h(4) = plot( tResponse( [trials.trialType] == 'e' ), y( [trials.trialType] == 'e' ), '.', 'color', 'r', 'MarkerSize', 10, 'DisplayName', 'error rpt' );
						hFlags(4) = true;
					end

					% plot beep
					tBeep = [trials.tBlinkBeepOn] - [trials.tPlateauOn];
					if( ~isempty(tBeep) )
						h(5) = plot( tBeep, y, '.', 'color', 'c', 'MarkerSize', 10, 'DisplayName', 'tBeep' );
						hFlags(5) = true;
					end

					% plot fp on
					tFpOn = [trials.tFpOn] - [trials.tPlateauOn];
					if( ~isempty(tFpOn) )
						h(6) = plot( tFpOn, y, '.', 'color', 'y', 'MarkerSize', 10, 'DisplayName', 'tFp' );
						hFlags(6) = true;
					end

					nTrials = nTrials + size(trials,2) + 5;
					plot( [xlim1 xlim2], [1 1] * (nTrials-2), 'k:', 'LineWidth', 1 );
					text( xlim2, nTrials-2, [txtTags{j+2} ' ' txtTags{i} ], 'color', txtColors{i}, 'FontSize', 14, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle' );


					%% tEnd VS tResponse
					% subplot( 9, 8, ([1 2]+j*2)*8 + i ); hold on;
					subplot( 3, 6, i*6+j ); hold on;
					tOffset = mean([Trials.tMaskOn]-[Trials.tTrialStart]);
					tSort = tSort + [trials.tPlateauOn] - [trials.tTrialStart];
					tResponse = tResponse + [trials.tPlateauOn] - [trials.tTrialStart];
					tResponse(tSort == -Inf) = [];
					trials(tSort == -Inf) = [];
					tSort(tSort == -Inf) = [];
					plot( tSort( [trials.trialType] == 'c' ), tResponse( [trials.trialType] == 'c' ), '.', 'color', [0 0.5 0], 'MarkerSize', 10 );
					plot( tSort( [trials.trialType] == 'e' ), tResponse( [trials.trialType] == 'e' ), '.', 'color', [1 0 0], 'MarkerSize', 10 );
					p = polyfit( tSort, tResponse, 1);
					[r pval] = corrcoef( tSort, tResponse );
	                if( size(r,2) == 1 ) r(2) = r(1); end
	                if( size(pval,2) == 1) pval(2) = pval(1); end
					plot( [-2600, 100] + tOffset, polyval( p, [-2600, 100] + tOffset ), 'k', 'LineWidth', 1 );
					if( p(2) >= 0 )
						text( 100+tOffset, -1700+tOffset, sprintf( '$y=%.1fx+%.1f$\n$\\mathbf{r=%.3f}$\n$\\mathbf{p=%.3f}$', p, r(2), pval(2) ), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'color', 'k', 'Interpreter', 'LaTex' );
					else
						text( 100+tOffset, -1700+tOffset, sprintf( '$y=%.1fx%.1f$\n$\\mathbf{r=%.3f}$\n$\\mathbf{p=%.3f}$', p, r(2), pval(2) ), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'color', 'k', 'Interpreter', 'LaTex' );
					end
					
					set( gca, 'xlim', [-2600 100] + tOffset, 'ylim', [-1900 1300] + tOffset, 'LineWidth', 1, 'box', 'off', 'FontSize', 20 );
					% axis equal;
					if( i == 1 ) 
						set( gca, 'XTickLabel', [] );
						set( title( [ upper(txtTags{j+2}(1)) txtTags{j+2}(2:end) ]), 'FontSize', 20 );
					end
					if( j ~= 1 )
						set( gca, 'YTickLabel', [] );
					else
						pos = get( gca, 'position' );
						y(i) = pos(2) + pos(4)/2;
					end
				end
			end

			% Rasters
			subplot(1,2,2);
			if( hFlags(2) ) h(2).DisplayName = 'm/sac'; end
			h = h(hFlags);
			plot( [1 1] * mean( [Trials.tRampOn] - [Trials.tPlateauOn] ), [0 nTrials], 'k--', 'LineWidth', 1 );	% ramp on
			plot( [0 0], [0 nTrials], 'k--', 'LineWidth', 1 );	% ramp off / plateau on
			plot( [1 1] * mean( [Trials.tMaskOn] - [Trials.tPlateauOn] ), [0 nTrials], 'k--', 'LineWidth', 1 );	% mask on
			% plot( -[1 1]*350, [0 nTrials], 'k:', 'LineWidth', 1 );
			set( gca, 'XLim', [xlim1 xlim2], 'YLim', [0 nTrials], 'LineWidth', 1, 'box', 'off', 'FontSize', 20 );
			set( xlabel('Time aligned to Ramp offset (ms)'), 'FontSize', 20);
			set( ylabel('Trial #'), 'FontSize', 20 );
			set( title('Rasters'), 'FontSize', 20 );
			set( legend(h), 'location', 'NorthEastOutside', 'FontSize', 14 );

			
			%% performance
			subplot(3,4,2);
			[~, ~, pVal] = BlinkTransient.FixLevelMultiComp( sbjs{iSbj}, folders{iSbj}, blockIndices{iSbj}, tAlignEvent, tStart, false, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink )
			set( get(gca,'title'), 'FontSize', 20 );


			%% tEnd VS tResponse
			subplot(3,6,8);
			set( xlabel('tEnd of last blink (ms)'), 'FontSize', 20 );
			subplot(3,6,14);
			set( xlabel('tEnd of last blink/m/sac (ms)'), 'FontSize', 20 );
			subplot(3,6,7);
			pos1 = get( gca, 'position' );
			y1 = pos1(2) + pos1(4)/2 - 0.05;
			subplot(3,6,13);
			pos2 = get( gca, 'position' );
			y2 = pos2(2) + pos2(4)/2;
			for(i = 7:9)
				subplot(3,6,i);
				hA = gca;
				hA.Position(2) = hA.Position(2) - 0.035;
			end
			hBlink = ToolKit.BorderText( 'FigureLeftTop', 'Blink', 'FontSize', 20, 'FontWeight', 'Bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top' );
			set( hBlink, 'position', [0.05, y1, 0], 'FontSize', 20 );
			hNBlink = ToolKit.BorderText( 'FigureLeft', 'No Blink', 'FontSize', 20, 'FontWeight', 'Bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top' );
			set( hNBlink, 'position', [0.05, y2, 0], 'FontSize', 20 );
			hYLabel = ToolKit.BorderText( 'FigureLeftBottom', 'Report time (ms)', 'FontSize', 20, 'FontWeight', 'Bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top' );
			set( hYLabel, 'position', [0.0734, (y1+y2)/2, 0], 'FontWeight', 'normal', 'FontSize', 20 );


			%% Panel labels
			set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
			text( 0.1, 0.97, 'A', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );
			text( 0.3035, 0.97, 'B', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );
			text( 0.5508, 0.97, 'C', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );
			text( 0.0675, 0.6151, 'D', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );

			h = findall(gcf,'type','axes');
			uistack( h(2:end), 'top' );
			set( h(1), 'layer', 'bottom' );
		end


		function main20181126()
			sbjs = { 'A017', 'A082', 'MAC', 'Bin', 'Nikunj', 'Janis' };
			folders = { 'F:\BlinkTransient\A017\3 FreeReport',...
						'F:\BlinkTransient\A082\3 FreeReport',...
						'F:\BlinkTransient\MAC',...
						'F:\BlinkTransient\Bin\1.5s+0s',...
						'F:\BlinkTransient\Nikunj',...
						'F:\BlinkTransient\Janis' };
			blockIndices = { [2:5, 6:10, 12:15, 17:20, 21:25], [1:6, 7:10] , 2:10, 1:13, 4:7, 2:6 };
			reverse2Tones = [false, false, true, true];
			
			sbjs = sbjs(1:3);
			folders = folders(1:3);
			blockIndices = blockIndices(1:3);

			n = size(sbjs,2);

			set(figure, 'numbertitle', 'off', 'name','Pooled: Multiple Comparisons @ FixedLevel | RT', 'color', 'w');
			for( i = 1 : n )
				subplot( 4, n, i );cla;
				BlinkTransient.FixLevelMultiComp_RT( sbjs{i}, folders{i}, blockIndices{i}, 'tRampOn', 0, false, 'tRampOn', 0, 0, reverse2Tones(i), false, false );
				if(i~=1) legend off; end
				title(sbjs{i});
				ylabel('RT (ms)')
				% continue;

				subplot( 4, n, i+n ); cla;
				% FixLevelMultiComp_RT( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones, cutBlinks, noLateReport );
				BlinkTransient.FixLevelMultiComp_RT( sbjs{i}, folders{i}, blockIndices{i}, 'tRampOn', 0, false, 'tRampOn', 0, 0, reverse2Tones(i), true, false );
				legend off;
				title('');
				ylabel('RT (ms)')

				subplot( 4, n, i+n*2 ); cla;
				% FixLevelMultiComp_RT( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones, cutBlinks, noLateReport );
				BlinkTransient.FixLevelMultiComp_RT( sbjs{i}, folders{i}, blockIndices{i}, 'tRampOn', 0, false, 'tRampOn', 0, 0, reverse2Tones(i), false, true );
				legend off;
				title('');
				ylabel('RT (ms)')

				subplot( 4, n, i+n*3 ); cla;
				% FixLevelMultiComp_RT( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones, cutBlinks, noLateReport );
				BlinkTransient.FixLevelMultiComp_RT( sbjs{i}, folders{i}, blockIndices{i}, 'tRampOn', 0, false, 'tRampOn', 0, 0, reverse2Tones(i), true, true );
				legend off;
				title('');
				ylabel('RT (ms)')
			end
			subplot( 4, n, 1 );
			pos1 = get( gca, 'position' );
			subplot( 4, n, n + 1 );
			pos2 = get( gca, 'position' );
			subplot( 4, n, n*2 + 1 );
			pos3 = get( gca, 'position' );
			subplot( 4, n, n*3 + 1 );
			pos4 = get( gca, 'position' );
			set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
			text( pos1(1)/3, pos1(2) + pos1(4)/2, 'RT', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			text( pos2(1)/3, pos2(2) + pos2(4)/2, 'Fixed RT', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			text( pos3(1)/3, pos3(2) + pos3(4)/2, 'Early RT', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			text( pos4(1)/3, pos4(2) + pos4(4)/2, 'Early Fixed RT', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			h = findall(gcf,'type','axes');
			uistack( h(2:end), 'top' );
			set( h(1), 'layer', 'bottom' );
			% return;


			set(figure, 'numbertitle', 'off', 'name','Pooled: Multiple Comparisons @ FixedLevel | Performance', 'color', 'w');
			for( i = 1 : n )
				subplot( 3, n, i );
				% FixLevelMultiComp( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones );
				BlinkTransient.FixLevelMultiComp( sbjs{i}, folders{i}, blockIndices{i}, 'tRampOn', 0, false, 'tRampOn', 0, 0, reverse2Tones(i));
				if(i~=1) legend off; end
				title(sbjs{i});

				subplot( 3, n, i+n );
				% FixLevelMultiComp_RT( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones, cutBlinks, noLateReport );
				BlinkTransient.FixLevelMultiComp( sbjs{i}, folders{i}, blockIndices{i}, 'tRampOn', 0, false, 'tRampOn', 0, 0, reverse2Tones(i), 'late' );
				legend off;
				title('');

				subplot( 3, n, i+n*2 );
				% FixLevelMultiComp_RT( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones, cutBlinks, noLateReport );
				BlinkTransient.FixLevelMultiComp( sbjs{i}, folders{i}, blockIndices{i}, 'tRampOn', 0, false, 'tRampOn', 0, 0, reverse2Tones(i), 'early' );
				legend off;
				title('');
			end
			subplot( 3, n, 1 );
			pos1 = get( gca, 'position' );
			subplot( 3, n, n + 1 );
			pos2 = get( gca, 'position' );
			subplot( 3, n, n*2 + 1 );
			pos3 = get( gca, 'position' );
			set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
			text( pos1(1)/3, pos1(2) + pos1(4)/2, 'All', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			text( pos2(1)/3, pos2(2) + pos2(4)/2, 'Late', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			text( pos3(1)/3, pos3(2) + pos3(4)/2, 'Early', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			h = findall(gcf,'type','axes');
			uistack( h(2:end), 'top' );
			set( h(1), 'layer', 'bottom' );
		end


		function [data, n, p, pVals] = DriftOnly_VaryDur()
			%% fixed report data collected from Bin, with 0.1cpd | 1.5s ramp | vary plateau; 3cpd | 1.5s ramp | vary plateau

			i = 1;
			data(i).dur = 0.25 * 1000;
			data(i).n = 207;
			data(i).condition = 'b';	% blink condition
			data(i).p = 0.7536;
			data(i).ramp = false;	% blink during ramp
			data(i).experiment = 1;
			data(i).sf = 0.1;

			i = 2;
			data(i).dur = 1.25 * 1000;
			data(i).n = 184;
			data(i).condition = 'b';
			data(i).p = 0.8859;
			data(i).ramp = false;
			data(i).experiment = 1;
			data(i).sf = 0.1;

			i = 3;
			data(i).dur = 0.25 * 1000;
			data(i).n = 219;
			data(i).condition = 'n';	% no blink condition
			data(i).p = 0.7671;
			data(i).ramp = false;
			data(i).experiment = 1;
			data(i).sf = 0.1;

			i = 4;
			data(i).dur = 1.25 * 1000;
			data(i).n = 177;
			data(i).condition = 'n';
			data(i).p = 0.7684;
			data(i).ramp = false;
			data(i).experiment = 1;
			data(i).sf = 0.1;

			i = 5;
			data(i).dur = 0.75 * 1000;
			data(i).n = 188;
			data(i).condition = 'b';
			data(i).p = 0.8245;
			data(i).ramp = false;
			data(i).experiment = 1;
			data(i).sf = 0.1;

			i = 6;
			data(i).dur = 0.75 * 1000;
			data(i).n = 195;
			data(i).condition = 'n';
			data(i).p = 0.7846;
			data(i).ramp = false;
			data(i).experiment = 1;
			data(i).sf = 0.1;

			i = 7;
			data(i).dur = 0 * 1000;
			data(i).n = 196;
			data(i).condition = 'b';
			data(i).p = 0.6276;
			data(i).ramp = true;
			data(i).experiment = 2;
			data(i).sf = 0.1;

			i = 8;
			data(i).dur = 0.5 * 1000;
			data(i).n = 160;
			data(i).condition = 'b';
			data(i).p = 0.8;
			data(i).ramp = true;
			data(i).experiment = 2;
			data(i).sf = 0.1;

			i = 9;
			data(i).dur = 0 * 1000;
			data(i).n = 205;
			data(i).condition = 'n';
			data(i).p = 0.6878;
			data(i).ramp = true;
			data(i).experiment = 2;
			data(i).sf = 0.1;

			i = 10;
			data(i).dur = 0.5 * 1000;
			data(i).n = 171;
			data(i).condition = 'n';
			data(i).p = 0.7953;
			data(i).ramp = true;
			data(i).experiment = 2;
			data(i).sf = 0.1;

			i = 11;
			data(i).dur = 0.5 * 1000;
			data(i).n = 120;
			data(i).condition = 'b';
			data(i).p = 0.7;
			data(i).ramp = false;
			data(i).experiment = 3;
			data(i).sf = 0.1;

			i = 12;
			data(i).dur = 0.7 * 1000;
			data(i).n = 119;
			data(i).condition = 'b';
			data(i).p = 0.7647;
			data(i).ramp = false;
			data(i).experiment = 3;
			data(i).sf = 0.1;

			i = 13;
			data(i).dur = 0.5 * 1000;
			data(i).n = 130;
			data(i).condition = 'n';
			data(i).p = 0.7846;
			data(i).ramp = false;
			data(i).experiment = 3;
			data(i).sf = 0.1;

			i = 14;
			data(i).dur = 0.7 * 1000;
			data(i).n = 125;
			data(i).condition = 'n';
			data(i).p = 0.784;
			data(i).ramp = false;
			data(i).experiment = 3;
			data(i).sf = 0.1;

			i = 15;
			data(i).dur = 0.75 * 1000;
			data(i).n = 216;
			data(i).condition = 'b';
			data(i).p = 0.7176;
			data(i).ramp = false;
			data(i).experiment = 4;
			data(i).sf = 0.1;

			i = 16;
			data(i).dur = 1.25 * 1000;
			data(i).n = 202;
			data(i).condition = 'b';
			data(i).p = 0.7772;
			data(i).ramp = false;
			data(i).experiment = 4;
			data(i).sf = 0.1;

			i = 17;
			data(i).dur = 0.75 * 1000;
			data(i).n = 212;
			data(i).condition = 'n';
			data(i).p = 0.7547;
			data(i).ramp = false;
			data(i).experiment = 4;
			data(i).sf = 0.1;

			i = 18;
			data(i).dur = 1.25 * 1000;
			data(i).n = 171;
			data(i).condition = 'n';
			data(i).p = 0.7719;
			data(i).ramp = false;
			data(i).experiment = 4;
			data(i).sf = 0.1;


			%% sf 3
			i = 19;
			data(i).dur = 0 * 1000;
			data(i).n = 299;
			data(i).condition = 'b';
			data(i).p = 0.5217;
			data(i).ramp = true;
			data(i).experiment = 5;
			data(i).sf = 3;

			i = 20;
			data(i).dur = 0.5 * 1000;
			data(i).n = 286;
			data(i).condition = 'b';
			data(i).p = 0.8601;
			data(i).ramp = true;
			data(i).experiment = 5;
			data(i).sf = 3;

			i = 21;
			data(i).dur = 0 * 1000;
			data(i).n = 305;
			data(i).condition = 'n';
			data(i).p = 0.5377;
			data(i).ramp = true;
			data(i).experiment = 5;
			data(i).sf = 3;

			i = 22;
			data(i).dur = 0.5 * 1000;
			data(i).n = 278;
			data(i).condition = 'n';
			data(i).p = 0.7878;
			data(i).ramp = true;
			data(i).experiment = 5;
			data(i).sf = 3;


			[data.sd] = deal( sqrt( [data.p] .* (1-[data.p]) ./ [data.n] ) );


			set( figure, 'NumberTitle', 'off', 'name', 'Psych Curves Along Time', 'color', 'w' ); hold on;
			vAlign = {'top', 'bottom'};
			sf = 0.1;
			dur = [ data( [data.sf] == sf ).dur ];
			uniDurs = unique(dur);
			for( i = size(uniDurs,2) : -1 : 1 )
				index = [data.dur] == uniDurs(i) & [data.sf] == sf & [data.condition] == 'b';
				n(1,i) = sum( [ data(index).n ] );
				p(1,i) = [ data(index).n ] * [ data(index).p ]' / n(1,i);
				index = [data.dur] == uniDurs(i) & [data.sf] == sf & [data.condition] == 'n';
				n(2,i) = sum( [ data(index).n ] );
				p(2,i) = [ data(index).n ] * [ data(index).p ]' / n(2,i);

				text( uniDurs(i), p(1,i) + 0.05 * ( (p(1,i) > p(2,i)) * 2 - 1 ), num2str(n(1,i)), 'color', 'r', 'HorizontalAlignment', 'center', 'VerticalAlignment', vAlign{ ( p(1,i) > p(2,i) ) + 1 }, 'FontSize', 14 );
				text( uniDurs(i), p(2,i) + 0.05 * ( (p(2,i) > p(1,i)) * 2 - 1 ), num2str(n(2,i)), 'color', 'b', 'HorizontalAlignment', 'center', 'VerticalAlignment', vAlign{ ( p(2,i) > p(1,i) ) + 1 }, 'FontSize', 14 );
			end
			sd = sqrt( p .* (1-p) ./ n );
			h(1) = plot( uniDurs, p(1,:), 'rs--', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'BC' ); hold on;
			plot( reshape( [uniDurs+1; uniDurs+1; ones(size(uniDurs))*NaN], 1, [] ), reshape( [p(1,:)-sd(1,:); p(1,:)+sd(1,:); ones(size(uniDurs))*NaN], 1, [] ), 'r', 'LineWidth', 2 );
			h(2) = plot( uniDurs, p(2,:), 'bs--', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'NBC' );
			plot( reshape( [uniDurs-1; uniDurs-1; ones(size(uniDurs))*NaN], 1, [] ), reshape( [p(2,:)-sd(2,:); p(2,:)+sd(2,:); ones(size(uniDurs))*NaN], 1, [] ), 'b', 'LineWidth', 2 );
			set( gca, 'xlim', [-0.3 1.4]*1000, 'ylim', [0.4 1], 'FontSize', 20 );
			xlabel( 'Plateau duration (ms)' );
			ylabel( 'Performance' );
			set( legend(h), 'location', 'NorthEastOutside' );

			n1 = [n(1,:) n(1,1:end-1) n(2,1:end-1)];
			p1 = [p(1,:) p(1,1:end-1) p(2,1:end-1)];
			n2 = [n(2,:) n(1,2:end) n(2,2:end)];
			p2 = [p(2,:) p(1,2:end) p(2,2:end)];
			index = p1 < p2;
			p1(index) = p1(index) + 0.5./n1(index);
			p2(index) = p2(index) - 0.5./n2(index); 
			index = p1 > p2;
			p1(index) = p1(index) - 0.5./n1(index);
			p2(index) = p2(index) + 0.5./n2(index);
			pp = ( n1.*p1 + n2.*p2 ) ./ ( n1 + n2 );
			sd = sqrt( pp .* (1-pp) .* (1./n1 + 1./n2) );
			pVals = normcdf( -abs(p1-p2), 0, sd );

			height = [0.5 0.9];
			colors = {'r', 'b'};
			for( i = 7 : size(n1,2)-1 )
				if( pVals(i) < 0.1 )
					isShowValue = true;
					if( pVals(i) < 0.05 ) isShowValue = false; end
					ToolKit.ShowSignificance( [uniDurs( mod(i-7,5) + 1 ), height( (i>=12)+1 )], [ uniDurs( mod(i-7,5) + 2 ), height( (i>=12)+1 ) ], pVals(i), 0.02, isShowValue, 'FontSize', 14, 'color', colors{ (i>=12)+1 } );
				end
			end

			[r1 pVal1] = corrcoef( uniDurs, p(1,:) )
			polyfit( uniDurs, p(1,:), 1 )*1000
			[r2 pVal2] = corrcoef( uniDurs, p(2,:) )
			polyfit( uniDurs, p(2,:), 1 )*1000


			% figure;
			% index = [data.sf] == 0.1;
			% n = [ data(index).n ];
			% condition = [ data(index).condition ];
			% p = [ data(index).p ];
			% dur = [ data(index).dur ];
			% plot( dur(condition=='b'), p(condition=='b'), 'r^', 'MarkerSize', 8, 'LineWidth', 2 ); hold on;
			% plot( dur(condition=='n'), p(condition=='n'), 'bv', 'MarkerSize', 8, 'LineWidth', 2 ); 
			% set( gca, 'xlim', [-0.3 1.4], 'ylim', [0.4 1] );

			% plot( get(gca,'xlim'), polyval( polyfit( dur(condition=='b'), p(condition=='b'), 1 ), get(gca,'xlim') ), 'r' );
			% [r1 pVal1] = corrcoef( dur(condition=='b'), p(condition=='b') )
			% plot( get(gca,'xlim'), polyval( polyfit( dur(condition=='n'), p(condition=='n'), 1 ), get(gca,'xlim') ), 'b' );
			% [r2 pVal2] = corrcoef( dur(condition=='n'), p(condition=='n') )


			% [~, ~, nThresh(1,:), nPar, g(1), chisq(1)] = psyfit( uniDurs, n1.*p1, n1, 'Chance', 0.5, 'Extra', 'Boots', 20, 'plotHandle', figure );
			% [~, ~, nThresh(2,:), nPar, g(2), chisq(2)] = psyfit( uniDurs, n2.*p2, n2, 'Chance', 0.5, 'Extra', 'Boots', 20, 'plotHandle', figure );


			return;
		end


		function Extract_1s_SF3()
			sbjs 	= { 'Bin',	'A058',	'A082',	'A088', 'A043' };
			folders = { 'F:\BlinkTransient\Bin\1.5s+0_0.5s (sf3)',...	% 0.5s
						'F:\BlinkTransient\A058\0.5_1s',...
						'F:\BlinkTransient\A082\2 FixedLevels\0.25_1s',...
						'F:\BlinkTransient\A088\mix_1s',...
						'F:\BlinkTransient\A043\0.5_1s' };
			indices = { 8:36,...
						10:42,...
						4:32,...
						1:22,...
						5:23 };

			for( iSbj = 1 : size(sbjs,2) )
				if( strcmpi( sbjs{iSbj}, 'bin' ) )
					targetFolder = [ folders{iSbj}( 1 : find( folders{iSbj} == '\' | folders{iSbj} == '/', 1, 'last' ) ), 'Extracted_0.5s_sf3\' ];
				else
					targetFolder = [ folders{iSbj}( 1 : find( folders{iSbj} == '\' | folders{iSbj} == '/', 1, 'last' ) ), 'Extracted_1s_sf3\' ];
				end
				fprintf( 'Target folder: "%s"', targetFolder );
				if( exist( targetFolder, 'dir' ) == 7 )
					fprintf(' already exsits\n');
				else
					mkdir(targetFolder);
					fprintf(' created\n');
				end

				fprintf( 'Creating readme.txt' );
				f = fopen( [targetFolder, 'readme.txt'], 'w' );
				fprintf( f, 'Data extracted from: %s\nIndices: ', folders{iSbj} );
				fprintf( f, '%3d', indices{iSbj} );
				fclose(f);

				subfolders = ToolKit.ListFolders(folders{iSbj});
				index =  false( size(subfolders,1), 1 ) ;
				for( iFolder = 1 : size(subfolders,1) )
					if( strcmp( subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + (1:3) ), 'X. ' ) ) index(iFolder) = 1; end
				end
				subfolders(index,:) = [];

				for( iFolder = 1 : size(subfolders,1) )
					if( all( iFolder ~= indices{iSbj} ) ) continue; end
					clear Trials;
					load( [ ToolKit.RMEndSpaces(subfolders(iFolder,:)), '/Trials.mat' ], 'Trials' );
					if( strcmpi( sbjs{iSbj}, 'bin' ) )
						plateau = 500;
					else
						plateau = 1000;
					end
					win = 50;
					Trials = Trials( abs( [Trials.tMaskOn] - [Trials.tPlateauOn] - plateau ) < win );
					trialsFolder = [ targetFolder, ToolKit.RMEndSpaces( subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end ) ) ];
					if( exist( trialsFolder, 'dir' ) ~= 7 )
						mkdir( trialsFolder );
					end
					fprintf( '\tSaving %s...\n', [ trialsFolder, '\Trials.mat' ] );
					save( [ trialsFolder, '\Trials.mat' ], 'Trials' );
				end
			end
		end


		function BlinkRetinaImageDemo()
			load('BlinkRetinaImageDemo.mat');
			
			SF = 3;
			swPix = 1366*2;%2560;	% screen width in pixels
			swMm = 600*2;		% screen width in mm
			w = 300;
			sDist = 1605;%1190;	% distance from screen to subject's eye in mm
			wlPix = swPix ./ ( atand( swMm/2 / sDist ) * 2 * SF );	% wave length for 3 cpd
			gabor = ToolKit.Gabor( wlPix, 45, 0, swPix, swPix, 'grating' ) * 0.25 + 0.5;		% contrast of 0.5
			figure; imshow(gabor);

			x = round( sDist * tand(x/60) / swMm * swPix );
			y = round( sDist * tand(y/60) / swMm * swPix );
			x = x - x(1);
			y = y - y(1);
			x(tEye(1):tEye(2)) = x(tEye(1)-1);
			y(tEye(1):tEye(2)) = y(tEye(1)-1);
			x(tEye(2)+1:end) = x(tEye(2)+1:end) - ( x(tEye(2)+1) - x(tEye(1)-1) );
			y(tEye(2)+1:end) = y(tEye(2)+1:end) - ( y(tEye(2)+1) - y(tEye(1)-1) );
			figure;
			plot( [x;y]' )

			center = (swPix+1)/2;
			lidEdge = zeros(size(x));
			lidEdge( 1 : tLid(2) ) = round( (0:tLid(2)-1) / (tLid(2)-1) * w );
			lidEdge( tLid(2) : tLid(3) ) = w;
			lidEdge( tLid(3) : tLid(4) ) = round( (tLid(4)-tLid(3) : -1 : 0) / (tLid(4)-tLid(3)) * w );
			figure; plot( tLid(1):tLid(4), lidEdge );
			set( figure, 'color', 'w' );

			retina = zeros(w,w,tLid(4));
			frameRate = 1000;
			luminances = zeros(1,tLid(4));
			radius = round(wlPix/2);
			[ix,iy] = meshgrid( (1:w)-w/2-3, (1:w)-w/2-3 );
			index = sqrt(ix.^2+iy.^2) < radius;
			for( t = 1 : 1 : tLid(4) )
				tmp = gabor( round( center+x(t)-w/2 ) : round( center+x(t)+w/2-1 ), round( center+y(t)-w/2 ) : round( center+y(t)+w/2-1 ) );
				tmp( (1:end) <= lidEdge(t), : ) = 0;
				retina(:,:,t) = tmp;
				luminances(t) = sum(sum(tmp(index)));
				if( t > tLid(2) + 5 && t <= tLid(3) - 5 || mod(t,2) == 0 ) continue; end
				imshow(retina(:,:,t));pause
				[img, map] = rgb2ind( frame2im( getframe(gcf) ), 20 );
				if( t == 1 )
					imwrite( img, map, ['BlinkRetinaImageDemo', '.gif'], 'gif', 'LoopCount', inf, 'DelayTime', 1/frameRate );
				elseif( t <= tLid(2) + 5 || t >= tLid(3) - 5 )
					imwrite( img, map, ['BlinkRetinaImageDemo', '.gif'], 'gif', 'WriteMode', 'append', 'DelayTime', 1/frameRate );
				end
			end
			for( i = 1 : 20 )
				imwrite( img, map, ['BlinkRetinaImageDemo', '.gif'], 'gif', 'WriteMode', 'append', 'DelayTime', 1/frameRate );
			end

			set( figure, 'color', 'w' );
			hold on;
			h(1) = plot( [1 tLid(4)], [1 1]*luminances(1), 'k', 'LineWidth', 2, 'DisplayName', 'Static' );
			h(2) = plot( 1:tLid(4), luminances, 'r', 'LineWidth', 2, 'DisplayName', 'Blink' );
			set( gca, 'xlim', [1 tLid(4)+4], 'ylim', [-50 250], 'LineWidth', 2, 'FontSize', 24, 'box', 'off' )
			xlabel( 'Time (ms)' );
			ylabel( 'Intensity' );
			set( legend(h), 'location', 'NorthEast', 'FontSize', 18 );
		end


		function StoreBlinkSamples()
			sbjs 	= { 'Bin',	'A058',	'A082',	'A088', 'A002', 'A050' };
			folders = { 'F:\BlinkTransient\Bin\Extracted_0.5s_sf3',...	% 0.5s
						'F:\BlinkTransient\A058\Extracted_1s_sf3',...
						'F:\BlinkTransient\A082\2 FixedLevels\Extracted_1s_sf3',...
						'F:\BlinkTransient\A088\Extracted_1s_sf3',...
						'F:\BlinkTransient\A002',...
						'F:\BlinkTransient\A050' };
			indices = { 1:29,...
						1:33,...
						1:29,...
						1:19,...
						4:57,...
						3:53 };

			sbjs 	= { 'Bin',	'A058',	'A082',	'A088', 'A002', 'A050', 'A098', 'A092', 'A029' };
			folders = { 'F:\BlinkTransient\Bin\Extracted_0.5s_sf3',...	% 0.5s
						'F:\BlinkTransient\A058\Extracted_1s_sf3',...
						'F:\BlinkTransient\A082\2 FixedLevels\Extracted_1s_sf3',...
						'F:\BlinkTransient\A088\Extracted_1s_sf3',...
						'F:\BlinkTransient\A002',...
						'F:\BlinkTransient\A050',...
						'F:\BlinkTransient\A098',...
						'F:\BlinkTransient\A092',...
						'F:\BlinkTransient\A029' };
			indices = { 1:29,...	% Bin
						1:33,...	% A058
						1:29,...	% A082
						1:19,...	% A088
						4:57,...	% A002
						3:53,...	% A050
						5:29,...	% A098
						4:20,...	% A092
						4:28,...	% A029
						};

			for( iSbj = 1 : size(sbjs,2) )
				fprintf( 'Processing data for %s...\n', sbjs{iSbj} );
				data = BlinkTransient.GetLabeledTrials4Blinks( folders{iSbj}, [], [], 'tRampOn', 0, 0 );
				data = data(indices{iSbj});
				for( i = 1 : size(data,2) )
					data(i).trials( [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] > -600 & ~[data(i).trials.hasBlink] | [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] < -600 & [data(i).trials.hasBlink] ) = [];
				end
				trials = [data.trials];
				trials = trials( ~[trials.hasMicrosac] & ~[trials.hasSac] );
				sRate = trials(1).sRate;
				bTrials = trials( [trials.hasBlink] );		% blink trials
				index = false(size(bTrials));
				for( iTrial = 1 : size(bTrials,2) )
					blinks = bTrials(iTrial).blinks;
					iBlink = find( (blinks.start-1) / bTrials(iTrial).sRate * 1000 > bTrials(iTrial).tRampOn - bTrials(iTrial).tTrialStart, 1, 'first' );
					if( ( blinks.start(iBlink) -1 ) / bTrials(iTrial).sRate * 1000 > bTrials(iTrial).tPlateauOn - bTrials(iTrial).tTrialStart ||...
						  blinks.duration(iBlink) / bTrials(iTrial).sRate * 1000 > 350 )
						index(iTrial) = true;
					end
				end
				bTrials(index) = [];
				% nbTrials = trials( ~[trials.hasBlink] );	% no blink trials
				[ tTriggers, tLid, tEye, x, y ] = BlinkTransient.BlinkParams(bTrials);

				f = fopen( sprintf( 'F:/BlinkTransient/BlinkSamples/%s_BlinkSamples.txt', sbjs{iSbj} ), 'w' );
				fprintf( f, 'nTrials: %d\n', size(tTriggers,1) );
				for( iTrial = 1 : size(tTriggers,1) )
					fprintf( f, 'iTrial: %d\n', iTrial );
					fprintf( f, 'tTriggers: %d %d\n', tTriggers(iTrial,:) );
					fprintf( f, 'tLid: %d %d %d %d\n', tLid(iTrial,:) );
					fprintf( f, 'tEye: %d %d\n', tEye(iTrial,:) );
					fprintf( f, 'nSamples: %d\n', size(x{iTrial},2) );
					fprintf( f, '%.2f ', x{iTrial} );
					fprintf( f, '\n' );
					fprintf( f, '%.2f ', y{iTrial} );
					fprintf( f, '\n' );
				end
				fclose(f);


			end
		end


		function Supplementals20190527( flags )
			if( nargin() < 1 || isempty(flags) ) flags = 2^8-1; end
			sbjs 	= { 'Bin',	'A058',	'A082',	'A088', 'A002', 'A050', 'A098', 'A092', 'A029', 'A037', 'A043', 'A025' };
			folders = { 'F:\BlinkTransient\Bin\Extracted_0.5s_sf3',...	% 0.5s
						'F:\BlinkTransient\A058\Extracted_1s_sf3',...
						'F:\BlinkTransient\A082\2 FixedLevels\Extracted_1s_sf3',...
						'F:\BlinkTransient\A088\Extracted_1s_sf3',...
						'F:\BlinkTransient\A002',...
						'F:\BlinkTransient\A050',...
						'F:\BlinkTransient\A098',...
						'F:\BlinkTransient\A092',...
						'F:\BlinkTransient\A029',...
						'F:\BlinkTransient\A037',...
						'F:\BlinkTransient\A043\Extracted_1s_sf3',...
						'F:\BlinkTransient\A025' };
			folderIndices = { 1:29,...	% Bin
						1:33,...	% A058
						1:29,...	% A082
						1:19,...	% A088
						4:57,...	% A002
						3:53,...	% A050
						5:29,...	% A098
						4:20,...	% A092
						4:28,...	% A029
						[4:36,41:45],...	% A037
						1:19,...	% A043
						8:32,...	% A025
						};

			n = size(sbjs,2);
			nRows = floor( sqrt( size(sbjs,2) ) );
			nCols = ceil( size(sbjs,2) / nRows );
			figure;
			subplot( nRows, nCols, 1 );
			pos1 = get( gca, 'position' );
			subplot( nRows, nCols, size(sbjs,2) );
			pos2 = get( gca, 'position' );
			close(gcf);

			%% SaccadesRate
			if( bitget(flags,1) )
				set( figure, 'numbertitle', 'off', 'name', 'Pooled: SaccadesRate aligned to RampOn', 'color', 'w' );
				for( iSbj = 1 : size(sbjs,2) )
					subplot( nRows, nCols, iSbj ); hold on;
					fill( [0 1500 1500 0], [0 0 4 4], [0 0 0], 'LineStyle', 'none', 'FaceColor', 'c', 'FaceAlpha', 0.25, 'DisplayName', 'Ramp' );
					if( strcmpi( sbjs{iSbj}, 'bin' ) )
						fill( [1500 2000 2000 1500], [0 0 4 4], [0 0 0], 'LineStyle', 'none', 'FaceColor', 'g', 'FaceAlpha', 0.25, 'DisplayName', 'Plateau' );
					else
						fill( [1500 2500 2500 1500], [0 0 4 4], [0 0 0], 'LineStyle', 'none', 'FaceColor', 'g', 'FaceAlpha', 0.25, 'DisplayName', 'Plateau' );
					end
					rates = BlinkTransient.SaccadesRate( folders{iSbj}, folderIndices{iSbj}, 'RampOn', 'gaussian', 100, true, false );
					title( [sbjs{iSbj}, ' | n=', num2str(rates.nTrials)]);
					set( gca, 'YMinorTick', 'on' );
					xlabel([]);
					ylabel([]);
					set( gca, 'XLim', [-1000 4000], 'YLim', [0 4] );
					if( iSbj ~= size(sbjs,2) ) legend off; end
					if( mod( iSbj-1, nCols ) )
						set( gca, 'YTickLabel', [] );
					end
					if( (iSbj-1) / nCols < nRows-1 )
						set( gca, 'XTickLabel', [] );
					end
				end
				set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
				text( pos1(1)/3*2, 0.5, 'Saccades rate (Hz)', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
				text( 0.5, pos2(2)/3, 'Time aligned to ramp onset (s)', 'FontWeight', 'bold', 'FontSize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
				h = findall(gcf,'type','axes');
				uistack( h(2:end), 'top' );
				set( h(1), 'layer', 'bottom' );
			end

			%% BlinkRT
			if( bitget( flags, 2 ) )
				set( figure, 'numbertitle', 'off', 'name', 'Pooled: BlinkRT aligned to RampOn', 'color', 'w' );
				for( iSbj = 1 : size(sbjs,2) )
					subplot( nRows, nCols, iSbj ); hold on;
					yTop = 0.3;
					h(2) = fill( [0 1500 1500 0], [0 0 yTop yTop], [0 0 0], 'LineStyle', 'none', 'FaceColor', 'c', 'FaceAlpha', 0.25, 'DisplayName', 'Ramp' );
					if( strcmpi( sbjs{iSbj}, 'bin' ) )
						h(1) = fill( [1500 2000 2000 1500], [0 0 yTop yTop], [0 0 0], 'LineStyle', 'none', 'FaceColor', 'g', 'FaceAlpha', 0.25, 'DisplayName', 'Plateau' );
					else
						h(1) = fill( [1500 2500 2500 1500], [0 0 yTop yTop], [0 0 0], 'LineStyle', 'none', 'FaceColor', 'g', 'FaceAlpha', 0.25, 'DisplayName', 'Plateau' );
					end
					RT = BlinkTransient.BlinkRT( sbjs{iSbj}, folders{iSbj}, folderIndices{iSbj}, 'tRampOn', [], true, 50, false );
					title( [sbjs{iSbj}, ' | n=', num2str(size(RT,2))] );
					set( gca, 'YMinorTick', 'on', 'YLim', [0 yTop] );
					xlabel([]);
					ylabel([]);
					if( iSbj ~= size(sbjs,2) ) legend off; end
					if( mod( iSbj-1, nCols ) )
						set( gca, 'YTickLabel', [] );
					end
					if( (iSbj-1) / nCols < nRows-1 )
						set( gca, 'XTickLabel', [] );
					end
				end
				legend( h([2 1]), 'location', 'NorthEast' );
				set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
				text( pos1(1)/3*2, 0.5, 'Proportion of trials', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
				text( 0.5, pos2(2)/3, 'Time aligned to ramp onset (s)', 'FontWeight', 'bold', 'FontSize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
				h = findall(gcf,'type','axes');
				uistack( h(2:end), 'top' );
				set( h(1), 'layer', 'bottom' );
			end

			%% BlinkDuration
			if( bitget( flags, 3 ) )
				set( figure, 'numbertitle', 'off', 'name', 'Pooled: BlinkDuration of Blink Trials', 'color', 'w' );
				for( iSbj = 1 : size(sbjs,2) )
					subplot( nRows, nCols, iSbj ); hold on;
					[~, trials] = BlinkTransient.BlinkDuration( sbjs{iSbj}, folders{iSbj}, folderIndices{iSbj}, [], true, 10, false );
					title( [sbjs{iSbj}, ' | n=', num2str(size(trials,2))] );
					set( gca, 'YMinorTick', 'on', 'YLim', [0 0.3] );
					xlabel([]);
					ylabel([]);
					if( mod( iSbj-1, nCols ) )
						set( gca, 'YTickLabel', [] );
					end
					if( (iSbj-1) / nCols < nRows-1 )
						set( gca, 'XTickLabel', [] );
					end
				end
				set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
				text( pos1(1)/3*2, 0.5, 'Proportion of trials', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
				text( 0.5, pos2(2)/3, 'Blink duration (ms)', 'FontWeight', 'bold', 'FontSize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
				h = findall(gcf,'type','axes');
				uistack( h(2:end), 'top' );
				set( h(1), 'layer', 'bottom' );
			end

			%% Drift proportion VS performance
			if( bitget( flags, 4 ) )
				set( figure, 'numbertitle', 'off', 'name', 'Drift prop VS performance', 'color', 'w' );
				load('F:\BlinkTransient\Reports\2019.06.10\Population_spl.mat');
				indices = [1,2,3,4,7,8,9,11,12];
				colors = { [0.5 0.5 1], [0.5 1 1], [0.5 1 0.5], [1 0.5 1], [1 0.5 0.5], [1 1 0.5], [1 0.8 0.6], [1 0.6 0.8], [0.8 1 0.6], [0.8 0.6 1], [0.6 1 0.8], [0.6 0.8 1] };

				subplot(2,2,1); hold on;
				h = [];
				for( iSbj = indices )
					plot( Population.drift.nTrials.blink(iSbj) ./ Population.all.nTrials.blink(iSbj), Population.all.performance.blink(iSbj), '^', 'color', 'r', 'markersize', 10, 'linewidth', 2 );
					plot( Population.drift.nTrials.noBlink(iSbj) ./ Population.all.nTrials.noBlink(iSbj), Population.all.performance.noBlink(iSbj), 's', 'color', 'b', 'markersize', 15, 'linewidth', 2.5 );
					h(end+1) = plot( [Population.drift.nTrials.blink(iSbj) ./ Population.all.nTrials.blink(iSbj), Population.drift.nTrials.noBlink(iSbj) ./ Population.all.nTrials.noBlink(iSbj)], [Population.all.performance.blink(iSbj), Population.all.performance.noBlink(iSbj)], '--', 'color', colors{iSbj}, 'linewidth', 2, 'displayname', Population.sbj{iSbj} );
				end
				h(end+1) = plot( -10, -10, 'r^', 'markersize', 10, 'linewidth', 2, 'displayname', 'Blink' );
				h(end+1) = plot( -10, -10, 'bs', 'markersize', 15, 'linewidth', 2.5, 'displayname', 'No Blink' );
				legend(h);
				set( gca, 'linewidth', 2, 'fontsize', 24, 'box', 'off', 'ylim', [0.65 1], 'xlim', [-0.05 1] );
				xlabel('Proportion of drift only trials');
				ylabel('Performance');

				subplot(2,2,2); hold on;
				h = [];
				prop = (Population.drift.nTrials.blink + Population.drift.nTrials.noBlink) ./ (Population.all.nTrials.blink + Population.all.nTrials.noBlink);
				dif = Population.all.performance.blink - Population.all.performance.noBlink;
				prop = prop(indices);
				dif = dif(indices);
				for( iSbj = 1:size(prop,2) )
					h(end+1) = plot( prop(iSbj), dif(iSbj), '^', 'color', colors{indices(iSbj)}, 'markersize', 10, 'LineWidth', 2, 'DisplayName', Population.sbj{indices(iSbj)} );
				end
				set( gca, 'linewidth', 2, 'fontsize', 24, 'box', 'off', 'ylim', [0 0.15], 'xlim', [-0.05 1] );
				xlabel('Proportion of drift only trials');	% average across Blink and No Blink
				ylabel('Diff in performance');

				p = polyfit( prop([1,3:4,6:end]), dif([1,3:4,6:end]), 1);
				residuals = dif - polyval( p, prop );
				% [outliers, L, U, C] = isoutlier( residuals, 'mean' );		% outliers beyond 3*std
				outliers = abs(residuals) > 2 * std(residuals);
				h(end+1) = plot( prop(outliers), dif(outliers), 'ro', 'MarkerSize', 12, 'LineWidth', 1.5, 'DisplayName', 'Outliers' );

				p = polyfit( prop(~outliers), dif(~outliers), 1 );
				[r pval] = corrcoef( prop(~outliers), dif(~outliers) );
                if( size(r,2) == 1 ) r(2) = r(1); end
                if( size(pval,2) == 1) pval(2) = pval(1); end
				plot( get(gca,'XLim'), polyval( p, get(gca,'XLim') ), 'k', 'LineWidth', 1.5 );
				text( 0, 0.15, sprintf( 'k = %6.3f; r = %6.3f; p = %6.3f', p(1), r(2), pval(2) ), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 20 );
				legend(h);

				
				subplot(2,2,3); hold on;
				h = [];
				for( iSbj = indices )
					h(end+1) = plot( Population.drift.nTrials.blink(iSbj) / Population.all.nTrials.blink(iSbj) - Population.drift.nTrials.noBlink(iSbj) / Population.all.nTrials.noBlink(iSbj), Population.all.performance.blink(iSbj) - Population.all.performance.noBlink(iSbj), '^', 'color', colors{iSbj}, 'markersize', 10, 'LineWidth', 2, 'DisplayName', Population.sbj{iSbj} );
				end
				legend(h);
				set( gca, 'linewidth', 2, 'fontsize', 24, 'box', 'off', 'ylim', [0 0.15], 'xlim', [-0.45 0.1] );
				xlabel('Diff in proportion of drift only trials');	% average across Blink and No Blink
				ylabel('Diff in performance');


				% drift characteristics VS performance (drift only trials)
				subplot(2,2,4); hold on;
				for( iSbj = 1 : 9 )
					data = BlinkTransient.GetLabeledTrials4Blinks( folders{iSbj}, [], [], 'tRampOn', 0, 0 );
					data = data(folderIndices{iSbj});
					for( i = 1 : size(data,2) )
						data(i).trials( [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] > -600 & ~[data(i).trials.hasBlink] | [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] < -600 & [data(i).trials.hasBlink] ) = [];
					end
					trials = BlinkTransient.ETScreen([data.trials]);
					condsTrials{1} = trials([trials.hasBlink]);
					condsTrials{2} = trials(~[trials.hasBlink]);
					for( iCond = 2 : -1 : 1 )
						for( iTrial = size(condsTrials{iCond},2) : -1 : 1 )
							starts = (condsTrials{iCond}(iTrial).drifts.start - 1) / condsTrials{iCond}(iTrial).sRate * 1000 + condsTrials{iCond}(iTrial).tTrialStart;
							ends = (condsTrials{iCond}(iTrial).drifts.start + condsTrials{iCond}(iTrial).drifts.duration - 2) / condsTrials{iCond}(iTrial).sRate * 1000 + condsTrials{iCond}(iTrial).tTrialStart;
							index = ( condsTrials{iCond}(iTrial).tRampOn < starts & starts < condsTrials{iCond}(iTrial).tMaskOn ) | ( condsTrials{iCond}(iTrial).tRampOn < ends & ends < condsTrials{iCond}(iTrial).tMaskOn ) | ( starts < condsTrials{iCond}(iTrial).tRampOn & ends > condsTrials{iCond}(iTrial).tMaskOn );
							for( iX = find(index) )
								condsTrials{iCond}(iTrial).drifts.duration(iX) = round( ( min( ends(iX), condsTrials{iCond}(iTrial).tMaskOn ) - condsTrials{iCond}(iTrial).tTrialStart ) / 1000 * condsTrials{iCond}(iTrial).sRate ) + 2 - condsTrials{iCond}(iTrial).drifts.start(iX);
								condsTrials{iCond}(iTrial).drifts.start(iX) = max( condsTrials{iCond}(iTrial).drifts.start(iX), round( (condsTrials{iCond}(iTrial).tRampOn - condsTrials{iCond}(iTrial).tTrialStart) / 1000 * condsTrials{iCond}(iTrial).sRate ) );

							end
							drifts{iSbj,iCond}(iTrial).start = condsTrials{iCond}(iTrial).drifts.start(index);
							drifts{iSbj,iCond}(iTrial).duration = condsTrials{iCond}(iTrial).drifts.duration(index);
							drifts{iSbj,iCond}(iTrial).amplitude = condsTrials{iCond}(iTrial).drifts.amplitude(index);
							drifts{iSbj,iCond}(iTrial).angle = condsTrials{iCond}(iTrial).drifts.angle(index);
							drifts{iSbj,iCond}(iTrial).xPos = [];
							drifts{iSbj,iCond}(iTrial).xVel = [];
							drifts{iSbj,iCond}(iTrial).yPos = [];
							drifts{iSbj,iCond}(iTrial).yVel = [];
							for( iDrift = sum(index) : -1 : 1 )
								drifts{iSbj,iCond}(iTrial).xPos{iDrift} = condsTrials{iCond}(iTrial).x.position( (0 : drifts{iSbj,iCond}(iTrial).duration(iDrift)-1) + drifts{iSbj,iCond}(iTrial).start(iDrift) );
								drifts{iSbj,iCond}(iTrial).xVel{iDrift} = condsTrials{iCond}(iTrial).x.velocity( (0 : drifts{iSbj,iCond}(iTrial).duration(iDrift)-1) + drifts{iSbj,iCond}(iTrial).start(iDrift) );
								drifts{iSbj,iCond}(iTrial).yPos{iDrift} = condsTrials{iCond}(iTrial).y.position( (0 : drifts{iSbj,iCond}(iTrial).duration(iDrift)-1) + drifts{iSbj,iCond}(iTrial).start(iDrift) );
								drifts{iSbj,iCond}(iTrial).yVel{iDrift} = condsTrials{iCond}(iTrial).y.velocity( (0 : drifts{iSbj,iCond}(iTrial).duration(iDrift)-1) + drifts{iSbj,iCond}(iTrial).start(iDrift) );
								drifts{iSbj,iCond}(iTrial).velocity{iDrift} = condsTrials{iCond}(iTrial).velocity( (0 : drifts{iSbj,iCond}(iTrial).duration(iDrift)-1) + drifts{iSbj,iCond}(iTrial).start(iDrift) );

								smoothing = 41;
								cutseg = 50;
								maxSpeed = 300;
								if( size( drifts{iSbj,iCond}(iTrial).xPos{iDrift}, 2 ) < smoothing ) continue; end
								[drifts{iSbj,iCond}(iTrial).span(iDrift), drifts{iSbj,iCond}(iTrial).mSpeed(iDrift), drifts{iSbj,iCond}(iTrial).mCurvature(iDrift), drifts{iSbj,iCond}(iTrial).varX(iDrift), drifts{iSbj,iCond}(iTrial).varY(iDrift)]...
									= getDriftChar( drifts{iSbj,iCond}(iTrial).xPos{iDrift}, drifts{iSbj,iCond}(iTrial).yPos{iDrift}, smoothing, cutseg, maxSpeed);
							end
							drifts{iSbj,iCond}(iTrial).span = drifts{iSbj,iCond}(iTrial).span( ~isnan(drifts{iSbj,iCond}(iTrial).mSpeed) );
							drifts{iSbj,iCond}(iTrial).mCurvature = drifts{iSbj,iCond}(iTrial).mCurvature( ~isnan(drifts{iSbj,iCond}(iTrial).mSpeed) );
							drifts{iSbj,iCond}(iTrial).varX = drifts{iSbj,iCond}(iTrial).varX( ~isnan(drifts{iSbj,iCond}(iTrial).mSpeed) );
							drifts{iSbj,iCond}(iTrial).varY = drifts{iSbj,iCond}(iTrial).varY( ~isnan(drifts{iSbj,iCond}(iTrial).mSpeed) );
							drifts{iSbj,iCond}(iTrial).mSpeed = drifts{iSbj,iCond}(iTrial).mSpeed( ~isnan(drifts{iSbj,iCond}(iTrial).mSpeed) );
						end
					end
				end
				h = [];
				for( iSbj = 1:9 )
					% plot( mean([drifts{iSbj,1}.mSpeed]), Population.drift.performance.blink(iSbj), '^', 'color', 'r', 'markersize', 10, 'linewidth', 2 );
					% plot( mean([drifts{iSbj,2}.mSpeed]), Population.drift.performance.noBlink(iSbj), 's', 'color', 'b', 'markersize', 15, 'linewidth', 2.5 );
					% h(end+1) = plot( [ mean([drifts{iSbj,1}.mSpeed]), mean([drifts{iSbj,2}.mSpeed]) ], [ Population.drift.performance.blink(iSbj), Population.drift.performance.noBlink(iSbj) ], '--', 'color', colors{iSbj}, 'linewidth', 2, 'displayname', Population.sbj{iSbj} );
					h(end+1) = plot( mean([drifts{iSbj,1}.mSpeed, drifts{iSbj,2}.mSpeed]), Population.drift.performance.blink(iSbj) - Population.drift.performance.noBlink(iSbj), '^', 'color', colors{iSbj}, 'LineWidth', 2, 'MarkerSize', 10, 'DisplayName', Population.sbj{iSbj} );
				end
				set( gca, 'linewidth', 2, 'fontsize', 24, 'box', 'off', 'ylim', get(gca, 'ylim'), 'xlim', get(gca, 'xlim') );
				% h(end+1) = plot( -10, -10, 'r^', 'markersize', 10, 'linewidth', 2, 'displayname', 'Blink' );
				% h(end+1) = plot( -10, -10, 'bs', 'markersize', 15, 'linewidth', 2.5, 'displayname', 'No Blink' );
				legend(h);
				xlabel('Drift mSpeed');
				ylabel('Performance diff of drift only trials');

				
			end

			%% drift VS m/sacs
			if( bitget( flags, 5 ) )
				set( figure, 'numbertitle', 'off', 'name', 'Drift VS M/Sac', 'color', 'w' );
				load('F:\BlinkTransient\Reports\2019.06.20\Population.mat');
				colors = { [0.5 0.5 1], [0.5 1 1], [0.5 1 0.5], [1 0.5 1], [1 0.5 0.5], [1 1 0.5], [1 0.8 0.6], [1 0.6 0.8], [0.8 1 0.6], [0.8 0.6 1], [0.6 1 0.8], [0.6 0.8 1] };
				indices = 1 : size(Population.drift.performance.blink,2);

				subplot(2,2,1); hold on;
				h = [];
				for( iSbj = indices )
					plot( Population.drift.performance.blink(iSbj), Population.m_sac.performance.blink(iSbj), '^', 'color', 'r', 'markersize', 10, 'linewidth', 2 );
					plot( Population.drift.performance.noBlink(iSbj), Population.m_sac.performance.noBlink(iSbj), 's', 'color', 'b', 'markersize', 15, 'linewidth', 2.5 );
					h(end+1) = plot( [Population.drift.performance.blink(iSbj), Population.drift.performance.noBlink(iSbj)], [Population.m_sac.performance.blink(iSbj), Population.m_sac.performance.noBlink(iSbj)], '--', 'color', colors{iSbj}, 'linewidth', 2, 'displayname', Population.sbj{iSbj} );
				end
				h(end+1) = plot( -10, -10, 'r^', 'markersize', 10, 'linewidth', 2, 'displayname', 'Blink' );
				h(end+1) = plot( -10, -10, 'bs', 'markersize', 15, 'linewidth', 2.5, 'displayname', 'No Blink' );
				plot( [0 1], [0 1], 'k--', 'LineWidth', 1.5 );
				legend(h);
				set( gca, 'linewidth', 2, 'fontsize', 24, 'box', 'off', 'ylim', [0.5 1], 'xlim', [0.5 1] );
				xlabel('Performance of drift only trials');
				ylabel('Performance of m/sacs trials');

				subplot(2,2,2); hold on;
				h = [];
				for( iSbj = indices )
					h(end+1) = plot( Population.drift.performance.blink(iSbj) - Population.drift.performance.noBlink(iSbj), Population.m_sac.performance.blink(iSbj) - Population.m_sac.performance.noBlink(iSbj), '^', 'color', colors{iSbj}, 'markersize', 10, 'LineWidth', 2, 'DisplayName', Population.sbj{iSbj} );
				end
				set(gca,'linewidth',2,'fontsize',24,'box','off','ylim',[-0.03 0.3],'xlim',[-0.03 0.3]);
				xlabel('Improvement of drift only trials');
				ylabel('Improvement of M/Sac trials');

				x = Population.drift.performance.blink(indices) - Population.drift.performance.noBlink(indices);
				y = Population.m_sac.performance.blink(indices) - Population.m_sac.performance.noBlink(indices);
				p = polyfit( x, y, 1);
				residuals = y - polyval( p, y );
				outliers = abs(residuals) > 2 * std(residuals);
				h(end+1) = plot( x(outliers), y(outliers), 'ro', 'MarkerSize', 12, 'LineWidth', 1.5, 'DisplayName', 'Outliers' );

				p = polyfit( x(~outliers), y(~outliers), 1 );
				[r pval] = corrcoef( x(~outliers), y(~outliers) );
                if( size(r,2) == 1 ) r(2) = r(1); end
                if( size(pval,2) == 1) pval(2) = pval(1); end
				plot( get(gca,'XLim'), polyval( p, get(gca,'XLim') ), 'k', 'LineWidth', 1.5 );
				text( 0, 0.3, sprintf( 'k = %6.3f; r = %6.3f; p = %6.3f', p(1), r(2), pval(2) ), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 20 );
				legend(h);				

				% only 9 subjects analyzed for drift only trials
				subplot(2,2,3); hold on;
				fields = {'m_sac', 'drift', 'all'};
				for( iField = 1 : size(fields,2) )
					m(iField,1) = mean([Population.(fields{iField}).performance.blink(indices)]);
					sd(iField,1) = std([Population.(fields{iField}).performance.blink(indices)]);
					bar( 3*iField-2, m(iField,1), 0.9, 'r', 'FaceColor', 'r', 'LineStyle', 'none' );
					plot( [1 1] * (3*iField-2), m(iField,1) + [-1 1]*sd(iField,1), 'k-', 'LineWidth', 2 );
					
					m(iField,2) = mean([Population.(fields{iField}).performance.noBlink(indices)]);
					sd(iField,2) = std([Population.(fields{iField}).performance.noBlink(indices)]);
					bar( 3*iField-1, m(iField,2), 0.9, 'b', 'FaceColor', 'b', 'LineStyle', 'none' );
					plot( [1 1] * (3*iField-1), m(iField,2) + [-1 1]*sd(iField,2), 'k-', 'LineWidth', 2 );

					[~, pVal, CI] = ttest( [Population.(fields{iField}).performance.noBlink(indices)], [Population.(fields{iField}).performance.blink(indices)], 'alpha', 0.05 );
					ToolKit.ShowSignificance( [3*iField-2, m(iField,1)+sd(iField,1)], [3*iField-1, m(iField,2)+sd(iField,2)], pVal, 0.02, true, 'FontSize', 18 );
				end
				conds = {'blink', 'noBlink'};
				for( iField = [1,2] )
					for( iCond = [1,2] )
						[~, pVal, CI] = ttest( [Population.(fields{iField}).performance.(conds{iCond})(indices)], [Population.(fields{iField+1}).performance.(conds{iCond})(indices)], 'alpha', 0.05 );
						ToolKit.ShowSignificance( [3*iField+iCond-3+0.1, m(iField,iCond)+sd(iField,iCond)], [3*iField+iCond-0.1, m(iField+1,iCond)+sd(iField+1,iCond)], pVal, 0.2 * iCond, true, 'FontSize', 18 );
					end
				end


				set( gca, 'XLim', [-0.5 9.5], 'YLim', [0 1.5], 'XTick', (0:2)*3+1.5, 'XTickLabel', {'M/Sac', 'Drift', 'All'}, 'XTickLabelRotation', 10, 'FontSize', 24, 'LineWidth', 2 );
				ylabel('Performance');
			end

			%%%%%% MainSequence?
			%%%%%% DriftCurvature? DriftDifussionConstant?
			return;
			subplot( 3, n, 1 );
			pos1 = get( gca, 'position' );
			subplot( 3, n, n + 1 );
			pos2 = get( gca, 'position' );
			subplot( 3, n, n*2 + 1 );
			pos3 = get( gca, 'position' );
			set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
			text( pos1(1)/3, pos1(2) + pos1(4)/2, 'All', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			text( pos2(1)/3, pos2(2) + pos2(4)/2, 'Late', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			text( pos3(1)/3, pos3(2) + pos3(4)/2, 'Early', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			h = findall(gcf,'type','axes');
			uistack( h(2:end), 'top' );
			set( h(1), 'layer', 'bottom' );
		end


		function [performance, nTrials, sbjs] = PopulationPerformance( condition )
			%% population comparison of performance with paired t-test
			%	subjects: Bin, A058, A082, A088, A002, A050, A098, A092, A029, A037, A043, A025
			%	sf:	3 cpd
			%	ramp: 1.5s
			%	plateau:	0.5s (Bin); 1s (A058, A082, A088, A002, A050, A098, A092, A029, A037, A043, A025)

			if( nargin() < 1 ) condition = 'drift'; end

			%% all data, contrast level might vary a little bit for each subject in order to achieve an average performance of about 80%
			sbjs 	= { 'Bin',	'A058',	'A082',	'A088', 'A002', 'A050', 'A098', 'A092', 'A029', 'A037', 'A043', 'A025' };
			folders = { 'F:\BlinkTransient\Bin\Extracted_0.5s_sf3',...	% 0.5s
						'F:\BlinkTransient\A058\Extracted_1s_sf3',...
						'F:\BlinkTransient\A082\2 FixedLevels\Extracted_1s_sf3',...
						'F:\BlinkTransient\A088\Extracted_1s_sf3',...
						'F:\BlinkTransient\A002',...
						'F:\BlinkTransient\A050',...
						'F:\BlinkTransient\A098',...
						'F:\BlinkTransient\A092',...
						'F:\BlinkTransient\A029',...
						'F:\BlinkTransient\A037',...
						'F:\BlinkTransient\A043\Extracted_1s_sf3',...
						'F:\BlinkTransient\A025' };
			indices = { 1:29,...	% Bin
						1:33,...	% A058
						1:29,...	% A082
						1:19,...	% A088
						4:57,...	% A002
						3:53,...	% A050
						5:29,...	% A098
						4:20,...	% A092
						4:28,...	% A029
						[4:36,41:45],...	% A037
						1:19,...	% A043
						8:32,...	% A025
						};
			if( strcmpi( condition, 'drift' ) )
				nSbjs = size(sbjs,2) - 3;
			else
				nSbjs = size(sbjs,2);
			end
			% nSbjs = size(sbjs,2);

			for( iSbj = nSbjs : -1 : 1 )
				if( strcmpi( condition, 'all' ) )
					BlinkTransient.FixLevelEffect( sbjs{iSbj}, folders{iSbj}, mat2cell( indices{iSbj}, 1, ones(size(indices{iSbj})) ), [], [], true );
				elseif( strcmpi( condition, 'drift' ) )
					BlinkTransient.FixLevelEffect( sbjs{iSbj}, folders{iSbj}, mat2cell( indices{iSbj}, 1, ones(size(indices{iSbj})) ), false, false, true );
				elseif( strcmpi( condition, 'm/sac' ) )
					BlinkTransient.FixLevelEffect( sbjs{iSbj}, folders{iSbj}, mat2cell( indices{iSbj}, 1, ones(size(indices{iSbj})) ), true, true, true, false, false );
				end
				set( gca, 'YGrid', 'on', 'YMinorGrid', 'on' );
				data = BlinkTransient.GetLabeledTrials4Blinks( folders{iSbj}, [], [], 'tRampOn', 0, 0 );
				data = data(indices{iSbj});
				for( i = 1 : size(data,2) )
					data(i).trials( [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] > -600 & ~[data(i).trials.hasBlink] | [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] < -600 & [data(i).trials.hasBlink] ) = [];
				end
				trials = [data.trials];

				if( strcmpi( condition, 'all' ) )
					index = true(size(trials));
				elseif( strcmpi( condition, 'm/sac' ) )
					index = [trials.hasSac] | [trials.hasMicrosac];
				else
					index = ~[trials.hasSac] & ~[trials.hasMicrosac];
				end

				for( iTrial = 1 : size(trials,2) )
					notracks = trials(iTrial).notracks;
					% notracks.start( notracks.duration / trials(iTrial).sRate * 1000 < 15 ) = [];
					% notracks.duration( notracks.duration / trials(iTrial).sRate * 1000 < 15 ) = [];
					index(iTrial) = index(iTrial) && sum( max( 0, ...
						min( (notracks.start+notracks.duration-1)/trials(iTrial).sRate*1000, trials(iTrial).tMaskOn-trials(iTrial).tTrialStart ) - ...
							max( (notracks.start-1)/trials(iTrial).sRate*1000, trials(iTrial).tRampOn-trials(iTrial).tTrialStart ) ) ) < 15;
				end

				nTrials.blink(iSbj) = sum( [trials.hasBlink] & index & ( [trials.trialType] == 'c' | [trials.trialType] == 'e' ) );
				nTrials.noBlink(iSbj) = sum( ~[trials.hasBlink] & index & ( [trials.trialType] == 'c' | [trials.trialType] == 'e' ) );
				performance.blink(iSbj) = sum( [trials.hasBlink] & index & [trials.trialType] == 'c' ) / nTrials.blink(iSbj);
				performance.noBlink(iSbj) = sum( ~[trials.hasBlink] & index & [trials.trialType] == 'c' ) / nTrials.noBlink(iSbj);
			end


			set( figure, 'NumberTitle', 'off', 'name', sprintf( 'Population_%sTrials: 3cpd | 0.5sX1sbj + 1sX%dsbj', [upper(condition(1)), condition(2:end)], size(performance.blink,2)-1 ), 'color', 'w' );

			[~, pVal, CI] = ttest( performance.noBlink, performance.blink, 'alpha', 0.05 )
			if( pVal < 0.1 && pVal > 0.05 ) isShowValue = true;
			else isShowValue = false; end
			isShowValue = true;

			colors = { [0.5 0.5 1], [0.5 1 1], [0.5 1 0.5], [1 0.5 1], [1 0.5 0.5], [1 1 0.5], [1 0.8 0.6], [1 0.6 0.8], [0.8 1 0.6], [0.8 0.6 1], [0.6 1 0.8], [0.6 0.8 1] };
			
			subplot(1,2,1); hold on;
			for( i = 1 : size(performance.blink,2) )
				plot( [1 3], [ performance.noBlink(i), performance.blink(i) ], '^--', 'MarkerSize', 10, 'LineWidth', 2, 'color', colors{i} );
			end
			plot( [1 3], [ mean(performance.noBlink), mean(performance.blink) ], 's-', 'MarkerSize', 12, 'LineWidth', 2, 'color', 'k' );
			plot( [1 1 NaN 3 3], [ [-1 1] * std(performance.noBlink) + mean(performance.noBlink), NaN, [-1 1] * std(performance.blink) + mean(performance.blink) ], '-', 'LineWidth', 2, 'color', 'k' );
			set( gca, 'XLim', [0 4], 'YLim', [0.6 1.1], 'YTick', 0.6:0.1:1, 'LineWidth', 2, 'XTick', [1 3], 'XTickLabel', {'No Blink', 'Blink'}, 'FontSize', 20 );
			ToolKit.ShowSignificance( [1, 1.05], [3, 1.05], pVal, 0.02, isShowValue, 'FontSize', 24 );
			ylabel('Performance');

			subplot(1,2,2); hold on;
			plot( [0 1], [0 1], 'k--', 'LineWidth', 1 );
			for( i = 1 : size(performance.blink,2) )
				h(i) = plot( performance.noBlink(i), performance.blink(i), '^', 'MarkerSize', 10, 'LineWidth', 2, 'color', colors{i}, 'DisplayName', sbjs{i} );
			end
			plot( mean(performance.noBlink), mean(performance.blink), 's', 'MarkerSize', 12, 'LineWidth', 2, 'color', 'k' );
			plot( [1 1] * mean(performance.noBlink), mean(performance.noBlink) - CI, 'k-', 'LineWidth', 2 );
			set( gca, 'XLim', [0.5 1], 'YLim', [0.5 1], 'XTick', 0.5:0.1:1, 'YTick', 0.5:0.1:1, 'LineWidth', 2, 'FontSize', 20 );
			set( legend(h), 'location', 'NorthEast', 'FontSize', 16 );
			xlabel('No Blink performance');
			ylabel('Blink performance');
		end


		function [performance, nTrials, sbjs] = PopulationPerformanceCtrl( condition )
			%% population comparison of performance with paired t-test; control experiment where blink was simulated with a brief blackout of the screen
			%	subjects: A082, A002, A050, A092
			%	sf:	3 cpd
			%	ramp: 1.5s
			%	plateau: 1s

			if( nargin() < 1 ) condition = 'drift'; end

			%% all data, contrast level might vary a little bit for each subject in order to achieve an average performance of about 80%
			sbjs 	= { 'A050', 'A092', 'A082', 'A002', 'A029' };
			folders = { 'F:\BlinkTransient\0 SimulateBlinks\A050',...
						'F:\BlinkTransient\0 SimulateBlinks\A092',...
						'F:\BlinkTransient\0 SimulateBlinks\A082',...
						'F:\BlinkTransient\0 SimulateBlinks\A002',...
						'F:\BlinkTransient\0 SimulateBlinks\A029',...
						 };
			indices = { 3:31,...	% A050
						1:29,...	% A092
						3:42,...	% A082
						1:25,...	% A002
						1:5,...		% A029
						};
			nSbjs = 2; %size(sbjs,2);
			
			for( iSbj = nSbjs : -1 : 1 )
				if( strcmpi( condition, 'all' ) )
					BlinkTransient.FixLevelEffect( [sbjs{iSbj}, 'Ctrl'], folders{iSbj}, mat2cell( indices{iSbj}, 1, ones(size(indices{iSbj})) ), [], [], true );
				else
					BlinkTransient.FixLevelEffect( [sbjs{iSbj}, 'Ctrl'], folders{iSbj}, mat2cell( indices{iSbj}, 1, ones(size(indices{iSbj})) ), false, false, true );
				end
				set( gca, 'YGrid', 'on', 'YMinorGrid', 'on' );
				data = BlinkTransient.GetLabeledTrials4Blinks( folders{iSbj}, [], [], 'tRampOn', 0, 0 );
				data = data(indices{iSbj});
				for( i = 1 : size(data,2) )
					data(i).trials( [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] > -600 & ~[data(i).trials.hasBlink] | [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] < -600 & [data(i).trials.hasBlink] ) = [];
				end
				trials = [data.trials];

				if( strcmpi( condition, 'all' ) )
					index = true(size(trials));
				else
					index = ~[trials.hasSac] & ~[trials.hasMicrosac];
				end

				for( iTrial = 1 : size(trials,2) )
					notracks = trials(iTrial).notracks;
					% notracks.start( notracks.duration / trials(iTrial).sRate * 1000 < 15 ) = [];
					% notracks.duration( notracks.duration / trials(iTrial).sRate * 1000 < 15 ) = [];
					index(iTrial) = index(iTrial) && sum( max( 0, ...
						min( (notracks.start+notracks.duration-1)/trials(iTrial).sRate*1000, trials(iTrial).tMaskOn-trials(iTrial).tTrialStart ) - ...
							max( (notracks.start-1)/trials(iTrial).sRate*1000, trials(iTrial).tRampOn-trials(iTrial).tTrialStart ) ) ) < 15;
				end

				nTrials.blink(iSbj) = sum( [trials.hasBlink] & index & ( [trials.trialType] == 'c' | [trials.trialType] == 'e' ) );
				nTrials.noBlink(iSbj) = sum( ~[trials.hasBlink] & index & ( [trials.trialType] == 'c' | [trials.trialType] == 'e' ) );
				performance.blink(iSbj) = sum( [trials.hasBlink] & index & [trials.trialType] == 'c' ) / nTrials.blink(iSbj);
				performance.noBlink(iSbj) = sum( ~[trials.hasBlink] & index & [trials.trialType] == 'c' ) / nTrials.noBlink(iSbj);
			end


			set( figure, 'NumberTitle', 'off', 'name', sprintf( 'Population_%sTrials_Ctrl: 3cpd | %dsbj', [upper(condition(1)), condition(2:end)], size(performance.blink,2) ), 'color', 'w' );

			[~, pVal, CI] = ttest( performance.noBlink, performance.blink, 'alpha', 0.05 )
			if( pVal < 0.1 && pVal > 0.05 ) isShowValue = true;
			else isShowValue = false; end
			isShowValue = true;

			colors = { [0.5 0.5 1], [0.5 1 1], [0.5 1 0.5], [1 0.5 1], [1 0.5 0.5], [1 1 0.5], [1 0.8 0.6], [1 0.6 0.8], [0.8 1 0.6], [0.8 0.6 1], [0.6 1 0.8], [0.6 0.8 1] };
			
			subplot(1,2,1); hold on;
			for( i = 1 : size(performance.blink,2) )
				plot( [1 3], [ performance.noBlink(i), performance.blink(i) ], '^--', 'MarkerSize', 10, 'LineWidth', 2, 'color', colors{i}, 'DisplayName', sbjs{i} );
			end
			plot( [1 3], [ mean(performance.noBlink), mean(performance.blink) ], 's-', 'MarkerSize', 12, 'LineWidth', 2, 'color', 'k' );
			plot( [1 1 NaN 3 3], [ [-1 1] * std(performance.noBlink) + mean(performance.noBlink), NaN, [-1 1] * std(performance.blink) + mean(performance.blink) ], '-', 'LineWidth', 2, 'color', 'k' );
			set( gca, 'XLim', [0 4], 'YLim', [0.6 1.1], 'YTick', 0.6:0.1:1, 'LineWidth', 2, 'XTick', [1 3], 'XTickLabel', {'No Blink', 'Blink'}, 'FontSize', 20 );
			ToolKit.ShowSignificance( [1, 1.05], [3, 1.05], pVal, 0.02, isShowValue, 'FontSize', 24 );
			ylabel('Performance');

			subplot(1,2,2); hold on;
			plot( [0 1], [0 1], 'k--', 'LineWidth', 1 );
			for( i = 1 : size(performance.blink,2) )
				h(i) = plot( performance.noBlink(i), performance.blink(i), '^', 'MarkerSize', 10, 'LineWidth', 2, 'color', colors{i}, 'DisplayName', sbjs{i} );
			end
			plot( mean(performance.noBlink), mean(performance.blink), 's', 'MarkerSize', 12, 'LineWidth', 2, 'color', 'k' );
			plot( [1 1] * mean(performance.noBlink), mean(performance.noBlink) - CI, 'k-', 'LineWidth', 2 );
			set( gca, 'XLim', [0.5 1], 'YLim', [0.5 1], 'XTick', 0.5:0.1:1, 'YTick', 0.5:0.1:1, 'LineWidth', 2, 'FontSize', 20 );
			set( legend(h), 'location', 'NorthEast', 'FontSize', 16 );
			xlabel('No Blink performance');
			ylabel('Blink performance');
		end


		function FV_Power( withRamp, destFolder, w, rSlope, gainMin )
			%  w:				total duration of a simulated blink in ms; 200 by default
			%  rSlope:			proportion/ratio of two slopes over total duration for a simulated blink; 0.2 by default
			%  gainMin:			minimal gain during a simulated blink; 0 by default
			
			if( nargin() < 1 || isempty(withRamp) ) withRamp = false; end
			if( nargin() < 2 || isempty(destFolder) ) destFolder = './'; end
			if( nargin() < 3 || isempty(w) ) w = 200; end
			if( nargin() < 4 || isempty(rSlope) ) rSlope = 0.2; end
			if( nargin() < 5 || isempty(gainMin) ) gainMin = 0; end

			sf = 3;
			swPix = 1366;	% screen width in pixels
			swMm = 600;		% screen width in mm
			shPix = 768;	% screen height in pixels
			shMm = 335;		% screen height in mm
			sDist = 1620;%1190;	% distance from screen to subject's eye in mm
			gwPix = 720;	% width of gabor patch in pixels; half of the screen height

    		orientation = 0;
    		phase = 0;
    		wlPix = swPix ./ ( atand(swMm/2/sDist) * 2 * sf );
    		contrast = 1;
    		bgnLuminance = 128;
    		img = ToolKit.Gabor( wlPix, orientation, phase, swPix, shPix, 'grating' )' * contrast;

    		tRamp = 1500; % ms
            tPlateau = 1000;    % ms
    		T = tRamp + tPlateau;	% ms
    		Gt = ones(1,T);
    		if(withRamp)
	    		Gt(1:tRamp) = (0:tRamp-1)/(tRamp-1);
	    	end

	    	% spatial receptive field
    		rfWDeg = 5;%10;
    		rfHDeg = 5;%10;
    		rfWPix = ceil( tand(rfWDeg/2) * 2 * sDist / swMm * swPix );
    		rfHPix = ceil( tand(rfHDeg/2) * 2 * sDist / shMm * shPix );
    		precision = rfWDeg / rfWPix;
    		rfLoc = round( ( [size(img)] - [rfWPix, rfHPix] ) / 2 ) - 1;	% bottom left point [x,y]
    		
			FontSize = 24;
			LineWidth = 2;

			if( exist( [destFolder, '\FV_Power_withRamp', num2str(withRamp), '.mat'], 'file' ) == 2 )
				load( [destFolder, '\FV_Power_withRamp', num2str(withRamp), '.mat'] );
			else
				folders = dir( 'F:\FreeViewingDatabase\*FV.mat' );
				Pop_L_FRs.Blink = ones(size(folders,1),T-100) * NaN;
				Pop_L_FRs.NoBlink = ones(size(folders,1),T-100) * NaN;
		        Pop_LN_FRs.Blink = ones(size(folders,1),T-100) * NaN;
		        Pop_LN_FRs.NoBlink = ones(size(folders,1),T-100) * NaN;
		        Pop_Power.Blink = zeros(1,size(folders,1));
		        Pop_Power.NoBlink = zeros(1,size(folders,1));
				for( iFolder = size(folders,1) : -1 : 1 )
					fprintf( 'Processing %s...\n', folders(iFolder).name );
					vt = load( fullfile( folders(iFolder).folder, folders(iFolder).name ), 'Trials' );
					Trials = vt.Trials;
					
					rfImg = zeros(rfHPix, rfWPix, T);
		    		L_FRs.Blink = ones(size(Trials,2),T) * NaN;
		    		L_FRs.NoBlink = ones(size(Trials,2),T) * NaN;
		            LN_FRs.Blink = ones(size(Trials,2),T) * NaN;
		            LN_FRs.NoBlink = ones(size(Trials,2),T) * NaN;
					for( iTrial = 1:size(Trials,2) )
						% get eye drift
						x = zeros( 1, sum([Trials(iTrial).drifts.duration]) );
						y = zeros(size(x));
						index = 0;
						for( i = 1 : size( Trials(iTrial).drifts.start, 2 ) )						
							idx = find( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration );
							if( ~isempty(idx) )
								st = Trials(iTrial).drifts.start(i) + 250;
								dur = Trials(iTrial).drifts.duration(i) - 250;
								if( dur < 1 )
									continue;
								else
									Trials(iTrial).drifts.start(i) = st;
									Trials(iTrial).drifts.duration(i) = dur;
								end
							end
							idx = find( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start );
							if( ~isempty(idx) )
								dur = Trials(iTrial).drifts.duration(i) - 50;
								if( dur < 1 )
									continue;
								else
									Trials(iTrial).drifts.duration(i) = dur;
								end
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
						if( size(x,2) < T ) continue; end
						x = x(1:T);
						y = y(1:T);

						% rotate by -orientation
						xx = x * cosd(orientation) + y * sind(orientation);
						yy = y * cosd(orientation) - x * sind(orientation);

						% center eye trace
						x = x - mean(x);
						y = y - mean(y);

						% convert to pixels
						x = round( sDist * tand(x/60) / swMm * swPix );
						y = round( sDist * tand(y/60) / shMm * shPix );

						%% NoBlink condition
						Bt = ones(1,T);
						for( t = 1 : T )
							rfImg(:,:,t) = ( img( (1:rfWPix) + rfLoc(1) + x(t), (1:rfHPix) + rfLoc(2) + y(t) )' * Gt(t) + bgnLuminance ) * Bt(t);
						end
						% linearity
						[fRate, fRate_C, fRate_S] = RGC.SpatioLinearModel( rfImg, precision, round(rfWPix/2), round(rfHPix/2), 'm', 25 );
		                L_FRs.NoBlink(iTrial,:) = RGC.TemporalLinearModel( fRate, 'm', 'on' );;
			    		% Non-linearity: sigmoid
			    		K = 30;	% peak firing rate
			    		g = 1;	% gain, which modulates the slope of the S-curve
			    		thresh = 0;%60;%0.2;
			    		% LN_FRs.NoBlink(iTrial,:) = K ./ ( 1 + exp( -g * (L_FRs.NoBlink(iTrial,:) - thresh) ) );
			    		base = 10;	% baseline activity
			    		LN_FRs.NoBlink(iTrial,:) = max( L_FRs.NoBlink(iTrial,:) + base, 0 );

			    		%% Blink condition
			    		Bt = ones(1,T);
						offset = 0;%randi(501) - 251;
						Bt( (1:w) + (end-w)/2 + offset ) = gainMin;
						down = w*rSlope/2;
						Bt( (1:down) + (end-w)/2 + offset ) = 1 - (1:down)/down * (1-gainMin);
						up = w*rSlope/2;
						Bt( ( w : -1 : w-up+1 ) + (end-w)/2 + offset ) = 1 - (1:up)/up * (1-gainMin);
						for( t = 1 : T )
							rfImg(:,:,t) = ( img( (1:rfWPix) + rfLoc(1) + x(t), (1:rfHPix) + rfLoc(2) + y(t) )' * Gt(t) + bgnLuminance ) * Bt(t);
						end
						% linearity
						[fRate, fRate_C, fRate_S] = RGC.SpatioLinearModel( rfImg, precision, round(rfWPix/2), round(rfHPix/2), 'm', 25 );
		                L_FRs.Blink(iTrial,:) = RGC.TemporalLinearModel( fRate, 'm', 'on' );;
			    		% Non-linearity: sigmoid
			    		K = 30;	% peak firing rate
			    		g = 1;	% gain, which modulates the slope of the S-curve
			    		thresh = 0;%60;%0.2;
			    		% LN_FRs.Blink(iTrial,:) = K ./ ( 1 + exp( -g * (L_FRs.Blink(iTrial,:) - thresh) ) );
			    		LN_FRs.Blink(iTrial,:) = max( L_FRs.Blink(iTrial,:) + base, 0 );
			    		LN_FRs.Blink( iTrial, LN_FRs.Blink(iTrial,:) > 300 ) = 300;

					end
					L_FRs.NoBlink( isnan(L_FRs.NoBlink(:,1)), : ) = [];
					LN_FRs.NoBlink( isnan(LN_FRs.NoBlink(:,1)), : ) = [];
					L_FRs.Blink( isnan(L_FRs.Blink(:,1)), : ) = [];
					LN_FRs.Blink( isnan(LN_FRs.Blink(:,1)), : ) = [];
					L_FRs.NoBlink( :, 1:100 ) = [];
					LN_FRs.NoBlink( :, 1:100 ) = [];
					L_FRs.Blink( :, 1:100 ) = [];
					LN_FRs.Blink( :, 1:100 ) = [];

					Power.NoBlink = var( LN_FRs.NoBlink, 0, 2 );
					Power.Blink = var( LN_FRs.Blink, 0, 2 );

					ShowFigure( folders(iFolder).name, L_FRs, LN_FRs, Power );
					saveas( gcf, [ destFolder, '\FV_Power_', folders(iFolder).name(1:end-4), '_withRamp', num2str(withRamp), '.fig' ] );
					saveas( gcf, [ destFolder, '\FV_Power_', folders(iFolder).name(1:end-4), '_withRamp', num2str(withRamp), '.png' ] );
					close(gcf);
					
					Pop_L_FRs.Blink(iFolder,:) = mean( L_FRs.Blink, 1 );
					Pop_L_FRs.NoBlink(iFolder,:) = mean( L_FRs.NoBlink, 1 );
			        Pop_LN_FRs.Blink(iFolder,:) = mean( LN_FRs.Blink, 1 );
					Pop_LN_FRs.NoBlink(iFolder,:) = mean( LN_FRs.NoBlink, 1 );
					Pop_Power.Blink(iFolder) = mean(Power.Blink);
					Pop_Power.NoBlink(iFolder) = mean(Power.NoBlink);

				end
				FV_Power.Pop_L_FRs = Pop_L_FRs;
				FV_Power.Pop_LN_FRs = Pop_LN_FRs;
				FV_Power.Power = Pop_Power;
				save( [destFolder, '\FV_Power_withRamp', num2str(withRamp), '.mat'], 'FV_Power' );
			end
			ShowFigure( 'Population', FV_Power.Pop_L_FRs, FV_Power.Pop_LN_FRs, FV_Power.Power );
			saveas( gcf, [ destFolder, '\FV_Power_Population_withRamp', num2str(withRamp), '.fig' ] );
			saveas( gcf, [ destFolder, '\FV_Power_Population_withRamp', num2str(withRamp), '.png' ] );

			function ShowFigure( name, L_FRs, LN_FRs, Power )
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s | FR & Power Based on FreeViewing Data | withRamp:%d | w:%d | rSlope:%.2f | gainMin:%.2f', name, withRamp, w, rSlope, gainMin ), 'color', 'w' );
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
				jf.setMaximized(1);
				pause(0.5);

				subplot(2,3,1); hold on;
				m = mean( L_FRs.NoBlink, 1 );
				sd = std( L_FRs.NoBlink, 0, 1 );
				plot( 0:T-100-1, m, 'color', 'b', 'LineWidth', LineWidth );
				fill( [ 0:T-100-1, T-100-1:-1:0 ], [m-sd, m(end:-1:1)+sd], 'b', 'LineStyle', 'none', 'FaceColor', 'b', 'FaceAlpha', 0.5 );
				set( gca, 'xLim', [0 T], 'YLim', [-20 20], 'YTick', [-20, 0, 20], 'FontSize', FontSize, 'LineWidth', LineWidth );
				ylabel('Linear Response');
				title('NoBlink Condition');
				
				subplot(2,3,2); hold on;
				m = mean( L_FRs.Blink, 1 );
				sd = std( L_FRs.Blink, 0, 1 );
				plot( 0:T-100-1, m, 'color', 'r', 'LineWidth', LineWidth );
				fill( [ 0:T-100-1, T-100-1:-1:0 ], [m-sd, m(end:-1:1)+sd], 'r', 'LineStyle', 'none', 'FaceColor', 'r', 'FaceAlpha', 0.5 );
				set( gca, 'xLim', [0 T], 'YLim', [-20 20], 'YTick', [-20, 0, 20], 'FontSize', FontSize, 'LineWidth', LineWidth );
				title('Blink Condition')

				subplot(2,3,4); hold on;
				m = mean( LN_FRs.NoBlink, 1 );
				sd = std( LN_FRs.NoBlink, 0, 1 );
				plot( 0:T-100-1, m, 'color', 'b', 'LineWidth', LineWidth );
				fill( [ 0:T-100-1, T-100-1:-1:0 ], [m-sd, m(end:-1:1)+sd], 'b', 'LineStyle', 'none', 'FaceColor', 'b', 'FaceAlpha', 0.5 );
				set( gca, 'xLim', [0 T], 'YLim', [0 50], 'FontSize', FontSize, 'LineWidth', LineWidth );
				xlabel('Time (ms)');
				ylabel('Linear-NonLinear Response');

				subplot(2,3,5); hold on;
				m = mean( LN_FRs.Blink, 1 );
				sd = std( LN_FRs.Blink, 0, 1 );
				plot( 0:T-100-1, m, 'color', 'r', 'LineWidth', LineWidth );
				fill( [ 0:T-100-1, T-100-1:-1:0 ], [m-sd, m(end:-1:1)+sd], 'r', 'LineStyle', 'none', 'FaceColor', 'r', 'FaceAlpha', 0.5 );
				set( gca, 'xLim', [0 T], 'YLim', [0 50], 'FontSize', FontSize, 'LineWidth', LineWidth );
				xlabel('Time (ms)');

				subplot(1,3,3); hold on;
				nb = Power.NoBlink;
				nb_m = mean(nb);
				nb_sd = std(nb);
				bar( 1, nb_m, 0.9, 'b', 'LineStyle', 'none', 'DisplayName', 'NoBlink' );
				plot( [1,1], [-1,1] * nb_sd + nb_m, '-k', 'LineWidth', LineWidth );

				b = Power.Blink;
				b_m = mean(b);
				b_sd = std(b);
				bar( 3, b_m, 0.9, 'r', 'LineStyle', 'none', 'DisplayName', 'Blink' );
				plot( [3,3], [-1,1] * b_sd + b_m, '-k', 'LineWidth', LineWidth );

				[~, pVal, p] = ttest( nb, b, 'alpha', 0.05 );
				ToolKit.ShowSignificance( [1, nb_sd + nb_m], [3, b_sd + b_m], pVal, 10, true, 'FontSize', 24 );

				set( gca, 'XLim', [-1 5], 'XTick', [1, 3], 'XTickLabel', { 'NoBlink', 'Blink' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
				ylabel('Mean power of linear response');
			end
		end


		function FV_PSD_V2( withRamp, destFolder )
			%% PSD analysis using free viewing data
			%  PSD of I_k_0(x,t) = a * sin( 2pi*k_0*x + eye(t) ) * g(t) + b * { g(t) - E[g(t)] }, where g(t) is the blink as a gain function
			if( nargin() < 1 || isempty(withRamp) ) withRamp = true; end
			if( nargin() < 2 || isempty(destFolder) ) destFolder = './'; end

			SF = 0;
			
			FontSize = 22;
			LineWidth = 2;

			if( exist( [destFolder, '\PSD_FV_withRamp', num2str(withRamp), '.mat'], 'file' ) == 2 )
				load( [destFolder, '\PSD_FV_withRamp', num2str(withRamp), '.mat'] );
			else
				folders = dir( 'F:\FreeViewingDatabase\*FV.mat' );
				for( iFolder = size(folders,1) : -1 : 1 )
					fprintf( 'Processing %s...\n', folders(iFolder).name );
					vt = load( fullfile( folders(iFolder).folder, folders(iFolder).name ), 'Trials' );
					Trials = vt.Trials;

					hMain = figure( 'NumberTitle', 'off', 'name', [ folders(iFolder).name, ' | PSD Based on FreeViewing Data | withRamp: ', num2str(withRamp) ], 'color', 'w' );
					pause(0.1);
					jf = get(handle(gcf),'javaframe');
					jf.setMaximized(1);
					pause(0.5);

					swPix = 1366;%2560;	% screen width in pixels
					swMm = 600;		% screen width in mm
					sDist = 1605;%1190;	% distance from screen to subject's eye in mm
					PSX = floor(swPix/2)*2;
					sFreqs = (0 : PSX/2) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);

					tRamp = 1024+512;
					tPlateau = 1024;%+512;
					a = 1;
					b = 128;
					if( withRamp )
						ramp(1:tRamp) = ( 0 : tRamp-1 ) / (tRamp-1) * a;		% ramp of 1024+512 ms + plateau of 1024ms
					end
					PSZ = tRamp + tPlateau;
					tFreqs = (0 : PSZ/2) / (PSZ/1000);

					Win = 1;	% e.g., Hanning Window
					U = 1;	% scale factor for Win
					
					sf = 3;
					orientation = 0;

					PS_D = zeros(PSX/2+1, PSZ/2+1);
					PS_DB = zeros(PSX/2+1, PSZ/2+1);
					for( iCon = 1 : 2 )
						nValidTrials = size(Trials,2);
						for( iTrial = 1 : size(Trials,2) )
				    		% get eye drift
							x = zeros( 1, sum([Trials(iTrial).drifts.duration]) );
							y = zeros(size(x));
							index = 0;
							Trials(iTrial).blinks.start = [Trials(iTrial).blinks.start, Trials(iTrial).notracks.start];
							Trials(iTrial).blinks.duration = [Trials(iTrial).blinks.duration, Trials(iTrial).notracks.duration];
							for( i = 1 : size( Trials(iTrial).drifts.start, 2 ) )
								idx = find( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration );
								if( ~isempty(idx) )
									st = Trials(iTrial).drifts.start(i) + 250;
									dur = Trials(iTrial).drifts.duration(i) - 250;
									if( dur < 1 )
										continue;
									else
										Trials(iTrial).drifts.start(i) = st;
										Trials(iTrial).drifts.duration(i) = dur;
									end
								end
								idx = find( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start );
								if( ~isempty(idx) )
									dur = Trials(iTrial).drifts.duration(i) - 50;
									if( dur < 1 )
										continue;
									else
										Trials(iTrial).drifts.duration(i) = dur;
									end
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

							% center eye trace
							x = x - mean(x);
							y = y - mean(y);

							if( iCon == 1 )		% drift
								tPS = a^2 * QRad_fft2_SingleTrace(sFreqs, size(x,2), 0, x, y, Win)';
								tPS(1,:) = 0;
								PS_D = PS_D + tPS(:,1:size(PS_D,2));
							else 	% drift + blink
								% blink function
								Gt = ones(1,PSZ);
								Gt( (-100:100) + PSZ/2 ) = 0;
								tPS = a^2 * QRad_fft2_SingleTrace(sFreqs, size(x,2), 0, x, y, Win, Gt)';
								tPS(1,:) = b^2 * abs( fft( Gt - mean(Gt) ) ).^2;
								PS_DB = PS_DB + tPS(:,1:size(PS_DB,2));
							end
							
						end
					end
					PS_D( :, 2:end-1 ) = 2 * PS_D( :, 2:end-1 );	% convert to single sided
					PS_D = PS_D / (PSZ*1000) / nValidTrials;	% fft^2 / (N*Fs); and average over all eye traces
					PS_DB( :, 2:end-1 ) = 2 * PS_DB( :, 2:end-1 );	% convert to single sided
					PS_DB = PS_DB / (PSZ*1000) / nValidTrials;	% fft^2 / (N*Fs); and average over all eye traces

					subplot(2,2,1);
					colormap('hot');
					contour( sFreqs(1:end), tFreqs(2:end), PS_D(1:end,2:end)', 1000, 'LineStyle', 'none', 'fill', 'on' );
					caxis( [ 0, max(max( [PS_D(1:end,2:end), PS_DB(1:end,2:end)] )) ] );
					colorbar;
					xlabel( 'Spatial frequency (cpd)' );
					ylabel( 'Temporal frequency (Hz)' );
					title('Drift');
					set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'linear', 'YScale', 'log', 'XLim', [0 30], 'YLim', [tFreqs(2), 60], 'XTick', 0:10:30, 'YTick', [1 5 10 20 40] );

					subplot(2,2,2);
					colormap('hot');
					contour( sFreqs(1:end), tFreqs(2:end), PS_DB(1:end,2:end)', 1000, 'LineStyle', 'none', 'fill', 'on' );
					caxis( [ 0, max(max( [PS_D(1:end,2:end), PS_DB(1:end,2:end)] )) ] );
					colorbar;
					xlabel( 'Spatial frequency (cpd)' );
					ylabel( 'Temporal frequency (Hz)' );
					title('Drift + Blink');
					set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'linear', 'YScale', 'log', 'XLim', [0 30], 'YLim', [tFreqs(2), 60], 'XTick', 0:10:30, 'YTick', [1 5 10 20 40] );

					subplot(2,2,3);
					hold on;
					% colors = {'m', 'b', 'c', 'k'};
					% f = [1 5 10];% [5 10 20];
					h = [];
					% for( iF = 1:size(f,2) )
					% 	y = zeros(size(sFreqs));
					% 	y = interp2( tFreqs, sFreqs, PS_D, f(iF), sFreqs, 'linear' );
					% 	plot( sFreqs, y, '--', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift', f(iF) ) );

					% 	y = zeros(size(sFreqs));
					% 	y = interp2( tFreqs, sFreqs, PS_DB, f(iF), sFreqs, 'linear' );
					% 	plot( sFreqs, y, '-', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift+Blink', f(iF) ) );
					% end
					% cut = 10;%min(tFreqs_D(end),tFreqs_DB(end));
					h(end+1) = plot( sFreqs, sum( PS_D( :, 0 < tFreqs ), 2 ) * (tFreqs(2) - tFreqs(1)), '-', 'LineWidth', LineWidth, 'color', 'b', 'DisplayName', 'Drift Unweighted' );
					h(end+1) = plot( sFreqs, sum( PS_DB( :, 0 < tFreqs ), 2 ) * (tFreqs(2) - tFreqs(1)), '-', 'LineWidth', LineWidth, 'color', 'r', 'DisplayName', 'Drift+Blink Unweighted' );
					pCellGain = RGC.TemporalFreqGainProfile( tFreqs, 'p', 'center' ) - RGC.TemporalFreqGainProfile( tFreqs, 'p', 'surround' );
					mCellGain = RGC.TemporalFreqGainProfile( tFreqs, 'm', 'on' );
					weighted_D.P = ( (tFreqs(2) - tFreqs(1))^2 * PS_D(:, 0<tFreqs) * pCellGain(tFreqs>0)' )';
					weighted_D.M = ( (tFreqs(2) - tFreqs(1))^2 * PS_D(:, 0<tFreqs) * mCellGain(tFreqs>0)' )';
					weighted_DB.P = ( (tFreqs(2) - tFreqs(1))^2 * PS_DB(:, 0<tFreqs) * pCellGain(tFreqs>0)' )';
					weighted_DB.M = ( (tFreqs(2) - tFreqs(1))^2 * PS_DB(:, 0<tFreqs) * mCellGain(tFreqs>0)' )';
					h(end+1) = plot( sFreqs, weighted_D.P, '--', 'LineWidth', LineWidth, 'color', 'b', 'DisplayName', 'Drift P-cell' );
					h(end+1) = plot( sFreqs, weighted_D.M, '-.', 'LineWidth', LineWidth, 'color', 'b', 'DisplayName', 'Drift M-cell' );
					h(end+1) = plot( sFreqs, weighted_DB.P, '--', 'LineWidth', LineWidth, 'color', 'r', 'DisplayName', 'Drift+Blink P-cell' );
					h(end+1) = plot( sFreqs, weighted_DB.M, '-.', 'LineWidth', LineWidth, 'color', 'r', 'DisplayName', 'Drift+Blink M-cell' );
					% names = { num2str(f(1)), num2str(f(2)), num2str(f(3)), 'NonZero' };
					% for( i = 1 : 4 )
					% 	h(end+1) = plot( -1, -1, 'LineStyle', 'none', 'Marker', 'Square', 'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i}, 'DisplayName', [names{i} ' Hz'] );
					% end
					% h(end+1) = plot( -1, -1, 'k--', 'LineWidth', LineWidth, 'DisplayName', 'Drift' );
					% h(end+1) = plot( -1, -1, 'k', 'LineWidth', LineWidth, 'DisplayName', 'Drift+Blink' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'linear', 'YScale', 'log', 'XLim', [sFreqs(1), 30], 'XTick', 0:10:30, 'XTickLabel', 0:10:30 );
					plot( [3 3], get(gca,'YLim'), 'k:' );
					set( legend(h), 'location', 'Southeast' );
					xlabel('Spatial frequency (cpd)');
					ylabel('Power spectral density');
					title('Non-Zero Hz Temporal Power');

					subplot(2,2,4);
					hold on;
					k = [0 3];
					% colors = {'m', 'b'};
					LineStyles = {'-', '--'};
					h = [];
					for( iK = 1:size(k,2) )
						y = zeros(size(tFreqs));
						y = interp2( tFreqs, sFreqs, PS_D, tFreqs, k(iK), 'linear' );
						h(end+1) = plot( tFreqs, y, LineStyles{iK}, 'LineWidth', LineWidth, 'color', 'b', 'DisplayName', sprintf( '%d cpd Drift', k(iK) ) );

						y = zeros(size(tFreqs));
						y = interp2( tFreqs, sFreqs, PS_DB, tFreqs, k(iK), 'linear' );
						h(end+1) = plot( tFreqs, y, LineStyles{iK}, 'LineWidth', LineWidth, 'color', 'r', 'DisplayName', sprintf( '%d cpd Drift+blink', k(iK) ) );
					end
					set( legend(h), 'location', 'Southeast' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs(2), 60], 'XTick', [10 60], 'XTickLabel', [10 60] );
					xlabel('Temporal frequency (Hz)');
					ylabel('Power spectral density');
					pause(10);
					saveas( gcf, [ destFolder, '\FV_', folders(iFolder).name(1:end-4), '_withRamp', num2str(withRamp), '.fig' ] );
					saveas( gcf, [ destFolder, '\FV_', folders(iFolder).name(1:end-4), '_withRamp', num2str(withRamp), '.png' ] );
					close(gcf);

					PSD_FV.PS_D(:,:,iFolder) = PS_D;
					PSD_FV.sFreqs = sFreqs;
					PSD_FV.tFreqs = tFreqs;
					PSD_FV.PS_DB(:,:,iFolder) = PS_DB;
					PSD_FV.weighted_D.P(iFolder,:) = weighted_D.P;
					PSD_FV.weighted_D.M(iFolder,:) = weighted_D.M;
					PSD_FV.weighted_DB.P(iFolder,:) = weighted_DB.P;
					PSD_FV.weighted_DB.M(iFolder,:) = weighted_DB.M;
					PSD_FV.pCellGain = pCellGain;
					PSD_FV.mCellGain = mCellGain;
				end

				save( [destFolder, '\PSD_FV_withRamp', num2str(withRamp), '.mat'], 'PSD_FV' );
			end

			PS_D = PSD_FV.PS_D;
			sFreqs = PSD_FV.sFreqs;
			tFreqs = PSD_FV.tFreqs;
			PS_DB = PSD_FV.PS_DB;
			weighted_D = PSD_FV.weighted_D;
			weighted_DB = PSD_FV.weighted_DB;
			pCellGain = PSD_FV.pCellGain;
			mCellGain = PSD_FV.mCellGain;

			set( figure, 'NumberTitle', 'off', 'name', [ 'Mean of Population | PSD Based on FreeViewing Data | withRamp: ', num2str(withRamp) ], 'color', 'w' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
			jf.setMaximized(1);
			pause(0.5);
			subplot(2,2,1);
			colormap('hot');
			contour( sFreqs(2:end), tFreqs(2:end), mean( PS_D(2:end,2:end,:), 3 )', 1000, 'LineStyle', 'none', 'fill', 'on' );
			caxis( [ 0, max(max( [mean( PS_D(2:end,2:end,:), 3 ) mean( PS_DB(2:end,2:end,:), 3 )] )) ] );
			colorbar;
			xlabel( 'Spatial frequency (cpd)' );
			ylabel( 'Temporal frequency (Hz)' );
			title('Drift');
			set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'linear', 'YScale', 'log', 'XLim', [0 30], 'YLim', [tFreqs(2), 60], 'XTick', 0:10:30, 'YTick', [1 5 10 20 40] );

			subplot(2,2,2);
			colormap('hot');
			contour( sFreqs(2:end), tFreqs(2:end), mean( PS_DB(2:end,2:end,:), 3 )', 1000, 'LineStyle', 'none', 'fill', 'on' );
			caxis( [ 0, max(max( [mean( PS_D(2:end,2:end,:), 3 ) mean( PS_DB(2:end,2:end,:), 3 )] )) ] );
			colorbar;
			xlabel( 'Spatial frequency (cpd)' );
			ylabel( 'Temporal frequency (Hz)' );
			title('Drift + Blink');
			set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [sFreqs(1) 30], 'YLim', [tFreqs(2), 60], 'XTick', 0:10:30, 'YTick', [1 5 10 20 40] );

			subplot(2,2,3);
			hold on;
			h = [];
			h(end+1) = plot( sFreqs, sum( mean( PS_D( :, 0 < tFreqs, : ), 3 ), 2 ) * (tFreqs(2) - tFreqs(1)), '-', 'LineWidth', LineWidth, 'color', 'b', 'DisplayName', 'Drift Unweighted' );
			h(end+1) = plot( sFreqs, sum( mean( PS_DB( :, 0 < tFreqs, : ), 3 ), 2 ) * (tFreqs(2) - tFreqs(1)), '-', 'LineWidth', LineWidth, 'color', 'r', 'DisplayName', 'Drift+Blink Unweighted' );
			h(end+1) = plot( sFreqs, mean( weighted_D.P, 1 ), '--', 'LineWidth', LineWidth, 'color', 'b', 'DisplayName', 'Drift P-cell' );
			h(end+1) = plot( sFreqs, mean( weighted_D.M, 1 ), '-.', 'LineWidth', LineWidth, 'color', 'b', 'DisplayName', 'Drift M-cell' );
			h(end+1) = plot( sFreqs, mean( weighted_DB.P, 1 ), '--', 'LineWidth', LineWidth, 'color', 'r', 'DisplayName', 'Drift+Blink P-cell' );
			h(end+1) = plot( sFreqs, mean( weighted_DB.M, 1 ), '-.', 'LineWidth', LineWidth, 'color', 'r', 'DisplayName', 'Drift+Blink M-cell' );
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'linear', 'YScale', 'log', 'XLim', [sFreqs(1), 30], 'XTick', 0:10:30, 'XTickLabel', 0:10:30 );
			plot( [3 3], get(gca,'YLim'), 'k:' );
			set( legend(h), 'location', 'Southeast' );
			xlabel('Spatial frequency (cpd)');
			ylabel('Power spectral density');
			title('Non-Zero Hz Temporal Power');

			subplot(2,2,4);
			hold on;
			k = [0 3];
			LineStyles = {'-', '--'};
			h = [];
			for( iK = 1:size(k,2) )
				y = zeros(size(tFreqs));
				y = interp2( tFreqs, sFreqs, mean( PS_D, 3 ), tFreqs, k(iK), 'linear' );
				h(end+1) = plot( tFreqs, y, LineStyles{iK}, 'LineWidth', LineWidth, 'color', 'b', 'DisplayName', sprintf( '%d cpd Drift', k(iK) ) );

				y = zeros(size(tFreqs));
				y = interp2( tFreqs, sFreqs, mean( PS_DB, 3 ), tFreqs, k(iK), 'linear' );
				h(end+1) = plot( tFreqs, y, LineStyles{iK}, 'LineWidth', LineWidth, 'color', 'r', 'DisplayName', sprintf( '%d cpd Drift+blink', k(iK) ) );
			end
			set( legend(h), 'location', 'Southeast' );
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'linear', 'YScale', 'log', 'XLim', [tFreqs(1), 60], 'XTick', 0:10:60, 'XTickLabel', 0:10:60 );
			xlabel('Temporal frequency (Hz)');
			ylabel('Power spectral density');
			pause(3);
			saveas( gcf, [ destFolder, '\FV_Population_Mean_withRamp', num2str(withRamp), '.fig' ] );
			saveas( gcf, [ destFolder, '\FV_Population_Mean_withRamp', num2str(withRamp), '.png' ] );


			set( figure, 'NumberTitle', 'off', 'name', [ 'Population | PSD Based on FreeViewing Data | withRamp: ', num2str(withRamp) ], 'color', 'w' );
			pause(0.1);
			jf = get(handle(gcf),'javaframe');
			jf.setMaximized(1);
			pause(0.5);
			
			P.D = interp2( sFreqs, 1:size(PS_D,3), weighted_D.P, 3, 1:size(PS_D,3), 'linear' );
			P.DB_3 = interp2( sFreqs, 1:size(PS_D,3), weighted_DB.P, 3, 1:size(PS_D,3), 'linear' );
			P.DB_0 = weighted_DB.P(:,1);
			M.D = interp2( sFreqs, 1:size(PS_D,3), weighted_D.M, 3, 1:size(PS_D,3), 'linear' );
			M.DB_3 = interp2( sFreqs, 1:size(PS_D,3), weighted_DB.M, 3, 1:size(PS_D,3), 'linear' );
			M.DB_0 = weighted_DB.M(:,1);
			Unweighted.D = interp2( sFreqs, 1:size(PS_D,3), reshape( sum( PS_D(:,2:end,:), 2 ) * (tFreqs(2) - tFreqs(1)), size(PS_D,1), [] )', 3, 1:size(PS_D,3), 'linear' );
			Unweighted.DB_3 = interp2( sFreqs, 1:size(PS_D,3), reshape( sum( PS_DB(:,2:end,:), 2 ) * (tFreqs(2) - tFreqs(1)), size(PS_D,1), [] )', 3, 1:size(PS_D,3), 'linear' );
			Unweighted.DB_0 = reshape( sum( PS_DB(1,2:end,:), 2 ) * (tFreqs(2) - tFreqs(1)), 1, [] )';
			
			[~, pVal.P_DB_3, CI.P] = ttest( P.D, P.DB_3, 'alpha', 0.05 );	% P-cell, D_3 VS DB_3
			[~, pVal.P_DB_0, CI.P] = ttest( P.D, P.DB_0, 'alpha', 0.05 );	% P-cell, D_3 VS DB_0
			[~, pVal.M_DB_3, CI.P] = ttest( M.D, M.DB_3, 'alpha', 0.05 );	% M-cell, D_3 VS DB_3
			[~, pVal.M_DB_0, CI.P] = ttest( M.D, M.DB_0, 'alpha', 0.05 );	% M-cell, D_3 VS DB_0
			[~, pVal.U_DB_3, CI.P] = ttest( Unweighted.D, Unweighted.DB_3, 'alpha', 0.05 );	% Unweighted, D_3 VS DB_3
			[~, pVal.U_DB_0, CI.P] = ttest( Unweighted.D, Unweighted.DB_0, 'alpha', 0.05 )	% Unweighted, D_3 VS DB_0
			hold on; h = [];
			h(1) = bar( 1, mean( P.D ), 0.9, 'b', 'LineStyle', 'none', 'DisplayName', 'Drift' );
			plot( [1,1], [-1,1]*std(P.D)+mean(P.D), '-k', 'LineWidth', LineWidth );
			h(2) = bar( 2, mean(P.DB_3), 0.9, 'r', 'LineStyle', 'none', 'DisplayName', 'Drift+Blink, 3cpd' );
			plot( [2,2], [-1,1]*std(P.DB_3)+mean(P.DB_3), '-k', 'LineWidth', LineWidth );
			h(3) = bar( 3, mean(P.DB_0), 0.9, 'FaceColor', [0.5 0 0], 'LineStyle', 'none', 'DisplayName', 'Drift+Blink, 0cpd' );
			plot( [3,3], [-1,1]*std(P.DB_0)+mean(P.DB_0), '-k', 'LineWidth', LineWidth );
			ToolKit.ShowSignificance( [1, std(P.D)+mean(P.D)], [2, std(P.DB_3)+mean(P.DB_3)], pVal.P_DB_3, 0.02, true, 'FontSize', 24 );
			ToolKit.ShowSignificance( [1, std(P.D)+mean(P.D)], [3, std(P.DB_0)+mean(P.DB_0)], pVal.P_DB_0, 0.02, true, 'FontSize', 24 );

			bar( 5, mean( M.D ), 0.9, 'b', 'LineStyle', 'none', 'DisplayName', 'Drift' );
			plot( [5,5], [-1,1]*std(M.D)+mean(M.D), '-k', 'LineWidth', LineWidth );
			bar( 6, mean(M.DB_3), 0.9, 'r', 'LineStyle', 'none', 'DisplayName', 'Drift+Blink, 3cpd' );
			plot( [6,6], [-1,1]*std(M.DB_3)+mean(M.DB_3), '-k', 'LineWidth', LineWidth );
			bar( 7, mean(M.DB_0), 0.9, 'FaceColor', [0.5 0 0], 'LineStyle', 'none', 'DisplayName', 'Drift+Blink, 0cpd' );
			plot( [7,7], [-1,1]*std(M.DB_0)+mean(M.DB_0), '-k', 'LineWidth', LineWidth );
			ToolKit.ShowSignificance( [5, std(M.D)+mean(M.D)], [6, std(M.DB_3)+mean(M.DB_3)], pVal.M_DB_3, 0.02, true, 'FontSize', 24 );
			ToolKit.ShowSignificance( [5, std(M.D)+mean(M.D)], [7, std(M.DB_0)+mean(M.DB_0)], pVal.M_DB_0, 0.02, true, 'FontSize', 24 );

			bar( 9, mean( Unweighted.D ), 0.9, 'b', 'LineStyle', 'none', 'DisplayName', 'Drift' );
			plot( [9,9], [-1,1]*std(Unweighted.D)+mean(Unweighted.D), '-k', 'LineWidth', LineWidth );
			bar( 10, mean(Unweighted.DB_3), 0.9, 'r', 'LineStyle', 'none', 'DisplayName', 'Drift+Blink, 3cpd' );
			plot( [10,10], [-1,1]*std(Unweighted.DB_3)+mean(Unweighted.DB_3), '-k', 'LineWidth', LineWidth );
			bar( 11, mean(Unweighted.DB_0), 0.9, 'FaceColor', [0.5 0 0], 'LineStyle', 'none', 'DisplayName', 'Drift+Blink, 0cpd' );
			plot( [11,11], [-1,1]*std(Unweighted.DB_0)+mean(Unweighted.DB_0), '-k', 'LineWidth', LineWidth );
			ToolKit.ShowSignificance( [9, std(Unweighted.D)+mean(Unweighted.D)], [10, std(Unweighted.DB_3)+mean(Unweighted.DB_3)], pVal.M_DB_3, 0.02, true, 'FontSize', 24 );
			ToolKit.ShowSignificance( [9, std(Unweighted.D)+mean(Unweighted.D)], [11, std(Unweighted.DB_0)+mean(Unweighted.DB_0)], pVal.M_DB_0, 0.02, true, 'FontSize', 24 );

			set( gca, 'XLim', [-1 13], 'XTick', [2, 6, 10], 'XTickLabel', { 'P Cell', 'M Cell', 'Unweighted' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
			title( 'PSD', 'FontSize', 20 );
			ylabel('PSD');
			set( legend(h), 'location', 'northeastout', 'fontsize', 18 );
			saveas( gcf, [ destFolder, '\FV_Population_withRamp', num2str(withRamp), '.fig' ] );
			saveas( gcf, [ destFolder, '\FV_Population_withRamp', num2str(withRamp), '.png' ] );
		end


		function FV_PSD_old( withRamp, destFolder )
			%% PSD analysis using free viewing data
			if( nargin() < 1 || isempty(withRamp) ) withRamp = true; end
			if( nargin() < 2 || isempty(destFolder) ) destFolder = './'; end

			SF = 3;
			
			FontSize = 24;
			LineWidth = 2;

			if( exist( [destFolder, '\PSD_FV_withRamp', num2str(withRamp), '.mat'], 'file' ) == 2 )
				load( [destFolder, '\PSD_FV_withRamp', num2str(withRamp), '.mat'] );
			else
				folders = dir( 'F:\FreeViewingDatabase\*FV.mat' );
				for( iFolder = size(folders,1) : -1 : 1 )
					fprintf( 'Processing %s...\n', folders(iFolder).name );
					vt = load( fullfile( folders(iFolder).folder, folders(iFolder).name ), 'Trials' );
					Trials = vt.Trials;

					set( figure, 'NumberTitle', 'off', 'name', [ folders(iFolder).name, ' | PSD Based on FreeViewing Data | withRamp: ', num2str(withRamp) ], 'color', 'w' );
					pause(0.1);
					jf = get(handle(gcf),'javaframe');
					jf.setMaximized(1);
					pause(0.5);
					
					[PS_D, sFreqs_D, ~, tFreqs_D] = BlinkTransient.PowerSpectrumAna( Trials, 'covering', 'modulator', 'drift', 'sf', SF, 'withRamp', withRamp );
					[PS_DB, sFreqs_DB, ~, tFreqs_DB] = BlinkTransient.PowerSpectrumAna( Trials, 'covering', 'modulator', 'Drift+blink', 'sf', SF, 'withRamp', withRamp );
					PS_D = reshape( sum( PS_D, 2 ), size(PS_D,1), [] );
					PS_DB = reshape( sum( PS_DB, 2 ), size(PS_DB,1), [] );

					subplot(2,4,7);
					hold on;
					colors = {'m', 'b', 'c', 'k'};
					f = [1 5 10];% [5 10 20];
					h = [];
					for( iF = 1:size(f,2) )
						y = zeros(size(sFreqs_D));
						y = interp2( tFreqs_D, sFreqs_D, PS_D, f(iF), sFreqs_D, 'linear' );
						plot( sFreqs_D, y, '--', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift', f(iF) ) );

						y = zeros(size(sFreqs_DB));
						y = interp2( tFreqs_DB, sFreqs_DB, PS_DB, f(iF), sFreqs_DB, 'linear' );
						plot( sFreqs_DB, y, '-', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift+blink', f(iF) ) );
					end
					cut = 10;%min(tFreqs_D(end),tFreqs_DB(end));
					% plot( sFreqs_D, sum( PS_D(:,2:end), 2 ) * (tFreqs_D(2) - tFreqs_D(1)), '--', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift' );
					plot( sFreqs_D, sum( PS_D( :, 1 < tFreqs_D & tFreqs_D < cut ), 2 ) * (tFreqs_D(2) - tFreqs_D(1)), '--', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift' );
					% plot( sFreqs_B, sum( PS_B(:,2:end), 2 ) * (tFreqs_B(2) - tFreqs_B(1)), ':', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Blink' );
					% plot( sFreqs_DB, sum( PS_DB(:,2:end), 2 ) * (tFreqs_DB(2) - tFreqs_DB(1)), '-', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift+blink' );
					plot( sFreqs_DB, sum( PS_DB( :, 1 < tFreqs_DB & tFreqs_DB < cut ), 2 ) * (tFreqs_DB(2) - tFreqs_DB(1)), '-', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift+blink' );
					
					names = { num2str(f(1)), num2str(f(2)), num2str(f(3)), 'NonZero' };
					for( i = 1 : 4 )
						h(end+1) = plot( -1, -1, 'LineStyle', 'none', 'Marker', 'Square', 'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i}, 'DisplayName', [names{i} ' Hz'] );
					end
					h(end+1) = plot( -1, -1, 'k--', 'LineWidth', LineWidth, 'DisplayName', 'Drift' );
					% h(end+1) = plot( -1, -1, 'k:', 'LineWidth', LineWidth, 'DisplayName', 'Blink' );
					h(end+1) = plot( -1, -1, 'k', 'LineWidth', LineWidth, 'DisplayName', 'Drift+blink' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [sFreqs_D(2), 20], 'XTick', [1 10], 'XTickLabel', [1 10] );
					plot( [3 3], get(gca,'YLim'), 'k:' );
					set( legend(h), 'location', 'Southeast' );
					xlabel('Spatial frequency (cpd)');
					ylabel('Power spectral density');

					subplot(2,4,8);
					hold on;
					k = [3];
					colors = {'m', 'b'};
					h = [];
					for( iK = 1:size(k,2) )
						y = zeros(size(tFreqs_D));
						y = interp2( tFreqs_D, sFreqs_D, PS_D, tFreqs_D, k(iK), 'linear' );
						h(end+1) = plot( tFreqs_D, y, '--', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Drift', k(iK) ) );

						y = zeros(size(tFreqs_DB));
						y = interp2( tFreqs_DB, sFreqs_DB, PS_DB, tFreqs_DB, k(iK), 'linear' );
						h(end+1) = plot( tFreqs_DB, y, '-', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Drift+blink', k(iK) ) );
					end
					set( legend(h), 'location', 'Southeast' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 60], 'XTick', [1 10 40], 'XTickLabel', [1 10 40] );
					xlabel('Temporal frequency (Hz)');
					ylabel('Power spectral density');

					pCellGain = RGC.TemporalFreqGainProfile( tFreqs_D, 'p', 'center' ) - RGC.TemporalFreqGainProfile( tFreqs_D, 'p', 'surround' );
					mCellGain = RGC.TemporalFreqGainProfile( tFreqs_D, 'm', 'on' );
					weighted_D.P = interp2( tFreqs_D, sFreqs_D, PS_D, tFreqs_D(tFreqs_D>0), SF, 'linear' ) * pCellGain(tFreqs_D>0)';
					weighted_D.M = interp2( tFreqs_D, sFreqs_D, PS_D, tFreqs_D(tFreqs_D>0), SF, 'linear' ) * mCellGain(tFreqs_D>0)';
					weighted_DB.P = interp2( tFreqs_DB, sFreqs_DB, PS_DB, tFreqs_DB(tFreqs_DB>0), SF, 'linear' ) * pCellGain(tFreqs_DB>0)';
					weighted_DB.M = interp2( tFreqs_DB, sFreqs_DB, PS_DB, tFreqs_DB(tFreqs_DB>0), SF, 'linear' ) * mCellGain(tFreqs_DB>0)';

					% subplot(2,4,7); hold on;
					% h(2) = plot( tFreqs_D(tFreqs_D>0), pCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', [0.5 0.5 0.5], 'DisplayName', 'P Cell' );
					% h(1) = plot( tFreqs_D(tFreqs_D>0), mCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', 'k', 'DisplayName', 'M Cell' );
					% set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 70], 'XTick', [1 10 40], 'XTickLabel', [1 10 40], 'box', 'off' );
					% title( 'Cell sensitivity', 'FontSize', 20 );
					% xlabel( 'Temporal frequency (Hz)' );
					% ylabel( 'Gain' );
					% set( legend(h), 'location', 'southwest', 'FontSize', 18 );
					
					% subplot(2,4,8); hold on; h = [];
					% h(1) = bar( 1, weighted_D.P, 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
					% h(2) = bar( 2, weighted_DB.P, 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
					% bar( 5, weighted_D.M, 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
					% bar( 6, weighted_DB.M, 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
					% set( gca, 'XLim', [-1 8], 'XTick', [1.5 5.5], 'XTickLabel', { 'P Cell', 'M Cell' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
					% title( 'Weighted PSD', 'FontSize', 20 );
					% ylabel('PSD');
					% set( legend(h), 'location', 'northwest', 'fontsize', 18 );

					PSD_FV.PS_D{iFolder} = PS_D;
					PSD_FV.sFreqs_D = sFreqs_D;
					PSD_FV.tFreqs_D = tFreqs_D;
					PSD_FV.PS_DB{iFolder} = PS_DB;
					PSD_FV.sFreqs_DB = sFreqs_DB;
					PSD_FV.tFreqs_DB = tFreqs_DB;
					PSD_FV.weighted_D(iFolder) = weighted_D;
					PSD_FV.weighted_DB(iFolder) = weighted_DB;
					PSD_FV.pCellGain = pCellGain;
					PSD_FV.mCellGain = mCellGain;

					pause(10);
					saveas( gcf, [ destFolder, '\FV_', folders(iFolder).name(1:end-4), '_withRamp', num2str(withRamp), '.fig' ] );
					saveas( gcf, [ destFolder, '\FV_', folders(iFolder).name(1:end-4), '_withRamp', num2str(withRamp), '.png' ] );
					close(gcf);
				end
				save( [destFolder, '\PSD_FV_withRamp', num2str(withRamp), '.mat'], 'PSD_FV' );
			end

			PS_D = PSD_FV.PS_D;
			sFreqs_D = PSD_FV.sFreqs_D;
			tFreqs_D = PSD_FV.tFreqs_D;
			PS_DB = PSD_FV.PS_DB;
			sFreqs_DB = PSD_FV.sFreqs_DB;
			tFreqs_DB = PSD_FV.tFreqs_DB;
			weighted_D = PSD_FV.weighted_D;
			weighted_DB = PSD_FV.weighted_DB;
			pCellGain = PSD_FV.pCellGain;
			mCellGain = PSD_FV.mCellGain;
			[~, pVal.P, CI.P] = ttest( [weighted_D.P], [weighted_DB.P], 'alpha', 0.05 );
			[~, pVal.M, CI.M] = ttest( [weighted_D.M], [weighted_DB.M], 'alpha', 0.05 )
			if( pVal.P < 0.1 && pVal.P > 0.05 ) isShowValue.P = true;
			else isShowValue.P = false; end
			if( pVal.M < 0.1 && pVal.M > 0.05 ) isShowValue.M = true;
			else isShowValue.M = false; end


			for( weighted = [true false] )

				if(~weighted)
					for( i = 1 : size(PS_D,2) )
						weighted_D(i).P = sum( interp2( tFreqs_D, sFreqs_D, PS_D{i}, tFreqs_D(tFreqs_D>0), SF, 'linear' ) ) * (tFreqs_D(2) - tFreqs_D(1));
						weighted_D(i).M = sum( interp2( tFreqs_D, sFreqs_D, PS_D{i}, tFreqs_D(tFreqs_D>0), SF, 'linear' ) ) * (tFreqs_D(2) - tFreqs_D(1));
						weighted_DB(i).P = sum( interp2( tFreqs_DB, sFreqs_DB, PS_DB{i}, tFreqs_DB(tFreqs_DB>0), SF, 'linear' ) ) * (tFreqs_DB(2) - tFreqs_DB(1));
						weighted_DB(i).M = sum( interp2( tFreqs_DB, sFreqs_DB, PS_DB{i}, tFreqs_DB(tFreqs_DB>0), SF, 'linear' ) ) * (tFreqs_DB(2) - tFreqs_DB(1));
					end
				else
					weighted_D = PSD_FV.weighted_D;
					weighted_DB = PSD_FV.weighted_DB;
				end
				[~, pVal.P, CI.P] = ttest( [weighted_D.P], [weighted_DB.P], 'alpha', 0.05 );
				[~, pVal.M, CI.M] = ttest( [weighted_D.M], [weighted_DB.M], 'alpha', 0.05 )
				if( pVal.P < 0.1 && pVal.P > 0.05 ) isShowValue.P = true;
				else isShowValue.P = false; end
				if( pVal.M < 0.1 && pVal.M > 0.05 ) isShowValue.M = true;
				else isShowValue.M = false; end

				set( figure, 'NumberTitle', 'off', 'name', [ 'Population | PSD Based on FreeViewing Data | withRamp: ', num2str(withRamp), ' | weighted: ', num2str(weighted) ], 'color', 'w' );
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
				jf.setMaximized(1);
				pause(0.5);
				if(weighted)
					subplot(1,2,1); hold on;
					h(2) = plot( tFreqs_D(tFreqs_D>0), pCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', [0.5 0.5 0.5], 'DisplayName', 'P Cell' );
					h(1) = plot( tFreqs_D(tFreqs_D>0), mCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', 'k', 'DisplayName', 'M Cell' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 70], 'XTick', [1 10 40], 'XTickLabel', [1 10 40], 'box', 'off' );
					title( 'Cell sensitivity', 'FontSize', 20 );
					xlabel( 'Temporal frequency (Hz)' );
					ylabel( 'Gain' );
					set( legend(h), 'location', 'southwest', 'FontSize', 18 );
					
					subplot(1,2,2);
				end
				hold on; h = [];
				h(1) = bar( 1, mean( [weighted_D.P] ), 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
				plot( [1,1], [-1,1]*std([weighted_D.P])+mean([weighted_D.P]), '-k', 'LineWidth', LineWidth );
				h(2) = bar( 2, mean( [weighted_DB.P] ), 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
				plot( [2,2], [-1,1]*std([weighted_DB.P])+mean([weighted_DB.P]), '-k', 'LineWidth', LineWidth );
				ToolKit.ShowSignificance( [1, std([weighted_D.P]+mean([weighted_D.P]))], [2, std([weighted_DB.P]+mean([weighted_DB.P]))], pVal.P, 0.02, isShowValue.P, 'FontSize', 24 );

				bar( 5, mean( [weighted_D.M] ), 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
				plot( [5,5], [-1,1]*std([weighted_D.M])+mean([weighted_D.M]), '-k', 'LineWidth', LineWidth );
				bar( 6, mean( [weighted_DB.M] ), 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
				plot( [6,6], [-1,1]*std([weighted_DB.M])+mean([weighted_DB.M]), '-k', 'LineWidth', LineWidth );
				ToolKit.ShowSignificance( [5, std([weighted_D.M]+mean([weighted_D.M]))], [6, std([weighted_DB.M]+mean([weighted_DB.M]))], pVal.M, 0.02, isShowValue.M, 'FontSize', 24 );

				set( gca, 'XLim', [-1 8], 'XTick', [1.5 5.5], 'XTickLabel', { 'P Cell', 'M Cell' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
				title( 'PSD', 'FontSize', 20 );
				ylabel('PSD');
				set( legend(h), 'location', 'northeastout', 'fontsize', 18 );

				saveas( gcf, [ destFolder, '\FV_Population_withRamp', num2str(withRamp), '_weighted', num2str(weighted) '.fig' ] );
				saveas( gcf, [ destFolder, '\FV_Population_withRamp', num2str(withRamp), '_weighted', num2str(weighted) '.png' ] );

			end

			% set( figure, 'NumberTitle', 'off', 'name', [ 'Population | PSD Based on FreeViewing Data | withRamp: ', num2str(withRamp) ], 'color', 'w' );
			% subplot(1,2,1); hold on;
			% h(2) = plot( tFreqs_D(tFreqs_D>0), pCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', [0.5 0.5 0.5], 'DisplayName', 'P Cell' );
			% h(1) = plot( tFreqs_D(tFreqs_D>0), mCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', 'k', 'DisplayName', 'M Cell' );
			% set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 70], 'XTick', [1 10 40], 'XTickLabel', [1 10 40], 'box', 'off' );
			% title( 'Cell sensitivity', 'FontSize', 20 );
			% xlabel( 'Temporal frequency (Hz)' );
			% ylabel( 'Gain' );
			% set( legend(h), 'location', 'southwest', 'FontSize', 18 );
			
			% subplot(1,2,2); hold on; h = [];
			% h(1) = bar( 1, mean( [weighted_D.P] ), 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
			% plot( [1,1], [-1,1]*std([weighted_D.P])+mean([weighted_D.P]), '-k', 'LineWidth', LineWidth );
			% h(2) = bar( 2, mean( [weighted_DB.P] ), 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
			% plot( [2,2], [-1,1]*std([weighted_DB.P])+mean([weighted_DB.P]), '-k', 'LineWidth', LineWidth );
			% ToolKit.ShowSignificance( [1, std([weighted_D.P]+mean([weighted_D.P]))], [2, std([weighted_DB.P]+mean([weighted_DB.P]))], pVal.P, 0.02, isShowValue.P, 'FontSize', 24 );

			% bar( 5, mean( [weighted_D.M] ), 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
			% plot( [5,5], [-1,1]*std([weighted_D.M])+mean([weighted_D.M]), '-k', 'LineWidth', LineWidth );
			% bar( 6, mean( [weighted_DB.M] ), 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
			% plot( [6,6], [-1,1]*std([weighted_DB.M])+mean([weighted_DB.M]), '-k', 'LineWidth', LineWidth );
			% ToolKit.ShowSignificance( [5, std([weighted_D.M]+mean([weighted_D.M]))], [6, std([weighted_DB.M]+mean([weighted_DB.M]))], pVal.M, 0.02, isShowValue.M, 'FontSize', 24 );

			% set( gca, 'XLim', [-1 8], 'XTick', [1.5 5.5], 'XTickLabel', { 'P Cell', 'M Cell' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
			% title( 'Weighted PSD', 'FontSize', 20 );
			% ylabel('PSD');
			% set( legend(h), 'location', 'northwest', 'fontsize', 18 );

			% saveas( gcf, [ destFolder, '\FV_Population_withRamp', num2str(withRamp), '.fig' ] );
			% saveas( gcf, [ destFolder, '\FV_Population_withRamp', num2str(withRamp), '.png' ] );

		end


		function FV_PSD_Test( destFolder, w, rSlope, gainMin )
			%% PSD analysis using free viewing data
			%  destFolder:		folder to save data and figures
			%  w:				total duration of a simulated blink in ms; 200 by default
			%  rSlope:			proportion/ratio of two slopes over total duration for a simulated blink; 0.2 by default
			%  gainMin:			minimal gain during a simulated blink; 0 by default

			if( nargin() < 1 || isempty(destFolder) ) destFolder = './'; end
			if( nargin() < 2 || isempty(w) ) w = 200; end
			if( nargin() < 3 || isempty(rSlope) ) rSlope = 0.2; end
			if( nargin() < 4 || isempty(gainMin) ) gainMin = 0; end

			SF = 3;
			
			FontSize = 24;
			LineWidth = 2;

			destFolder = sprintf( '%s/w%03d_rSlope%.2f_gainMin%.2f', destFolder, w, rSlope, gainMin );
			if( exist( destFolder, 'dir' ) ~= 7 )
				mkdir(destFolder);
			end

			if( exist( [destFolder, '\PSD_FV_Test.mat'], 'file' ) == 2 )
				load( [destFolder, '\PSD_FV_Test.mat'] );
			else
				folders = dir( 'F:\FreeViewingDatabase\*FV.mat' );
				for( iFolder = size(folders,1) : -1 : 1 )
					fprintf( 'Processing %s...\n', folders(iFolder).name );
					set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s | PSD Based on FreeViewing Data | w:%d | rSlope:%.2f | gainMin:%.2f', folders(iFolder).name, w, rSlope, gainMin ), 'color', 'w' );
					pause(0.1);
					jf = get(handle(gcf),'javaframe');
					jf.setMaximized(1);
					pause(0.5);
					
					[PS_D, sFreqs_D, tFreqs_D] = BlinkTransient.QRadPowerSpectrumAna( [ folders(iFolder).folder, '/', folders(iFolder).name ], 'drift', w, rSlope, gainMin );
					[PS_DB, sFreqs_DB, tFreqs_DB] = BlinkTransient.QRadPowerSpectrumAna( [ folders(iFolder).folder, '/', folders(iFolder).name ], 'drift+blink', w, rSlope, gainMin );

					subplot(2,4,7);
					hold on;
					colors = {'m', 'b', 'c', 'k'};
					f = [1 5 10];% [5 10 20];
					h = [];
					for( iF = 1:size(f,2) )
						y = zeros(size(sFreqs_D));
						y = interp2( tFreqs_D, sFreqs_D, PS_D, f(iF), sFreqs_D, 'linear' );
						plot( sFreqs_D, y, '--', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift', f(iF) ) );

						y = zeros(size(sFreqs_DB));
						y = interp2( tFreqs_DB, sFreqs_DB, PS_DB, f(iF), sFreqs_DB, 'linear' );
						plot( sFreqs_DB, y, '-', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift+blink', f(iF) ) );
					end
					cut = 10;%min(tFreqs_D(end),tFreqs_DB(end));
					% plot( sFreqs_D, sum( PS_D(:,2:end), 2 ) * (tFreqs_D(2) - tFreqs_D(1)), '--', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift' );
					plot( sFreqs_D, sum( PS_D( :, 1 < tFreqs_D & tFreqs_D < cut ), 2 ) * (tFreqs_D(2) - tFreqs_D(1)), '--', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift' );
					% plot( sFreqs_B, sum( PS_B(:,2:end), 2 ) * (tFreqs_B(2) - tFreqs_B(1)), ':', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Blink' );
					% plot( sFreqs_DB, sum( PS_DB(:,2:end), 2 ) * (tFreqs_DB(2) - tFreqs_DB(1)), '-', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift+blink' );
					plot( sFreqs_DB, sum( PS_DB( :, 1 < tFreqs_DB & tFreqs_DB < cut ), 2 ) * (tFreqs_DB(2) - tFreqs_DB(1)), '-', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift+blink' );
					
					names = { num2str(f(1)), num2str(f(2)), num2str(f(3)), 'NonZero' };
					for( i = 1 : 4 )
						h(end+1) = plot( -1, -1, 'LineStyle', 'none', 'Marker', 'Square', 'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i}, 'DisplayName', [names{i} ' Hz'] );
					end
					h(end+1) = plot( -1, -1, 'k--', 'LineWidth', LineWidth, 'DisplayName', 'Drift' );
					% h(end+1) = plot( -1, -1, 'k:', 'LineWidth', LineWidth, 'DisplayName', 'Blink' );
					h(end+1) = plot( -1, -1, 'k', 'LineWidth', LineWidth, 'DisplayName', 'Drift+blink' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [sFreqs_D(2), 20], 'XTick', [1 10], 'XTickLabel', [1 10] );
					plot( [3 3], get(gca,'YLim'), 'k:' );
					set( legend(h), 'location', 'Southeast' );
					xlabel('Spatial frequency (cpd)');
					ylabel('Power spectral density');

					subplot(2,4,8);
					hold on;
					k = [3];
					colors = {'m', 'b'};
					h = [];
					for( iK = 1:size(k,2) )
						y = zeros(size(tFreqs_D));
						y = interp2( tFreqs_D, sFreqs_D, PS_D, tFreqs_D, k(iK), 'linear' );
						h(end+1) = plot( tFreqs_D, y, '--', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Drift', k(iK) ) );

						y = zeros(size(tFreqs_DB));
						y = interp2( tFreqs_DB, sFreqs_DB, PS_DB, tFreqs_DB, k(iK), 'linear' );
						h(end+1) = plot( tFreqs_DB, y, '-', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Drift+blink', k(iK) ) );
					end
					set( legend(h), 'location', 'Southeast' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 60], 'XTick', [1 10 40], 'XTickLabel', [1 10 40] );
					xlabel('Temporal frequency (Hz)');
					ylabel('Power spectral density');


					pCellGain = RGC.TemporalFreqGainProfile( tFreqs_D, 'p', 'center' ) - RGC.TemporalFreqGainProfile( tFreqs_D, 'p', 'surround' );
					mCellGain = RGC.TemporalFreqGainProfile( tFreqs_D, 'm', 'on' );
					weighted_D.P = interp2( tFreqs_D, sFreqs_D, PS_D, tFreqs_D(tFreqs_D>0), SF, 'linear' ) * pCellGain(tFreqs_D>0)';
					weighted_D.M = interp2( tFreqs_D, sFreqs_D, PS_D, tFreqs_D(tFreqs_D>0), SF, 'linear' ) * mCellGain(tFreqs_D>0)';
					weighted_DB.P = interp2( tFreqs_DB, sFreqs_DB, PS_DB, tFreqs_DB(tFreqs_DB>0), SF, 'linear' ) * pCellGain(tFreqs_DB>0)';
					weighted_DB.M = interp2( tFreqs_DB, sFreqs_DB, PS_DB, tFreqs_DB(tFreqs_DB>0), SF, 'linear' ) * mCellGain(tFreqs_DB>0)';

					% subplot(2,4,7); hold on;
					% h(2) = plot( tFreqs_D(tFreqs_D>0), pCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', [0.5 0.5 0.5], 'DisplayName', 'P Cell' );
					% h(1) = plot( tFreqs_D(tFreqs_D>0), mCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', 'k', 'DisplayName', 'M Cell' );
					% set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 70], 'XTick', [1 10 40], 'XTickLabel', [1 10 40], 'box', 'off' );
					% title( 'Cell sensitivity', 'FontSize', 20 );
					% xlabel( 'Temporal frequency (Hz)' );
					% ylabel( 'Gain' );
					% set( legend(h), 'location', 'southwest', 'FontSize', 18 );
					
					% subplot(2,4,8); hold on; h = [];
					% h(1) = bar( 1, weighted_D.P, 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
					% h(2) = bar( 2, weighted_DB.P, 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
					% bar( 5, weighted_D.M, 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
					% bar( 6, weighted_DB.M, 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
					% set( gca, 'XLim', [-1 8], 'XTick', [1.5 5.5], 'XTickLabel', { 'P Cell', 'M Cell' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
					% title( 'Weighted PSD', 'FontSize', 20 );
					% ylabel('PSD');
					% set( legend(h), 'location', 'northwest', 'fontsize', 18 );

					PSD_FV_Test.PS_D{iFolder} = PS_D;
					PSD_FV_Test.sFreqs_D = sFreqs_D;
					PSD_FV_Test.tFreqs_D = tFreqs_D;
					PSD_FV_Test.PS_DB{iFolder} = PS_DB;
					PSD_FV_Test.sFreqs_DB = sFreqs_DB;
					PSD_FV_Test.tFreqs_DB = tFreqs_DB;
					PSD_FV_Test.weighted_D(iFolder) = weighted_D;
					PSD_FV_Test.weighted_DB(iFolder) = weighted_DB;
					PSD_FV_Test.pCellGain = pCellGain;
					PSD_FV_Test.mCellGain = mCellGain;

					pause(5);
					saveas( gcf, sprintf( '%s/FV_Test_w%03d_rSlope%.2f_gainMin%.2f_%s.fig', destFolder, w, rSlope, gainMin, folders(iFolder).name(1:end-4) ) );
					saveas( gcf, sprintf( '%s/FV_Test_w%03d_rSlope%.2f_gainMin%.2f_%s.png', destFolder, w, rSlope, gainMin, folders(iFolder).name(1:end-4) ) );
					close(gcf);
					pause(5);
				end
				save( [destFolder, '\PSD_FV_Test.mat'], 'PSD_FV_Test' );
			end

			PS_D = PSD_FV_Test.PS_D;
			sFreqs_D = PSD_FV_Test.sFreqs_D;
			tFreqs_D = PSD_FV_Test.tFreqs_D;
			PS_DB = PSD_FV_Test.PS_DB;
			sFreqs_DB = PSD_FV_Test.sFreqs_DB;
			tFreqs_DB = PSD_FV_Test.tFreqs_DB;
			weighted_D = PSD_FV_Test.weighted_D;
			weighted_DB = PSD_FV_Test.weighted_DB;
			pCellGain = PSD_FV_Test.pCellGain;
			mCellGain = PSD_FV_Test.mCellGain;

			for( weighted = [true false] )

				if(~weighted)
					for( i = 1 : size(PS_D,2) )
						weighted_D(i).P = sum( interp2( tFreqs_D, sFreqs_D, PS_D{i}, tFreqs_D(tFreqs_D>0), SF, 'linear' ) ) * (tFreqs_D(2) - tFreqs_D(1));
						weighted_D(i).M = sum( interp2( tFreqs_D, sFreqs_D, PS_D{i}, tFreqs_D(tFreqs_D>0), SF, 'linear' ) ) * (tFreqs_D(2) - tFreqs_D(1));
						weighted_DB(i).P = sum( interp2( tFreqs_DB, sFreqs_DB, PS_DB{i}, tFreqs_DB(tFreqs_DB>0), SF, 'linear' ) ) * (tFreqs_DB(2) - tFreqs_DB(1));
						weighted_DB(i).M = sum( interp2( tFreqs_DB, sFreqs_DB, PS_DB{i}, tFreqs_DB(tFreqs_DB>0), SF, 'linear' ) ) * (tFreqs_DB(2) - tFreqs_DB(1));
					end
				else
					weighted_D = PSD_FV_Test.weighted_D;
					weighted_DB = PSD_FV_Test.weighted_DB;
				end
				[~, pVal.P, CI.P] = ttest( [weighted_D.P], [weighted_DB.P], 'alpha', 0.05 );
				[~, pVal.M, CI.M] = ttest( [weighted_D.M], [weighted_DB.M], 'alpha', 0.05 )
				if( pVal.P < 0.1 && pVal.P > 0.05 ) isShowValue.P = true;
				else isShowValue.P = false; end
				if( pVal.M < 0.1 && pVal.M > 0.05 ) isShowValue.M = true;
				else isShowValue.M = false; end

				set( figure, 'NumberTitle', 'off', 'name', sprintf( 'Population | PSD Based on FreeViewing Data. Test. | Weighted:%d | w:%d | rSlope:%.2f | gainMin:%.2f', weighted, w, rSlope, gainMin ), 'color', 'w' );
				pause(0.1);
				jf = get(handle(gcf),'javaframe');
				jf.setMaximized(1);
				pause(0.5);
				if(weighted)
					subplot(1,2,1); hold on;
					h(2) = plot( tFreqs_D(tFreqs_D>0), pCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', [0.5 0.5 0.5], 'DisplayName', 'P Cell' );
					h(1) = plot( tFreqs_D(tFreqs_D>0), mCellGain(tFreqs_D>0), 'LineWidth', LineWidth, 'color', 'k', 'DisplayName', 'M Cell' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 70], 'XTick', [1 10 40], 'XTickLabel', [1 10 40], 'box', 'off' );
					title( 'Cell sensitivity', 'FontSize', 20 );
					xlabel( 'Temporal frequency (Hz)' );
					ylabel( 'Gain' );
					set( legend(h), 'location', 'southwest', 'FontSize', 18 );
					
					subplot(1,2,2);
				end
				hold on; h = [];
				h(1) = bar( 1, mean( [weighted_D.P] ), 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
				plot( [1,1], [-1,1]*std([weighted_D.P])+mean([weighted_D.P]), '-k', 'LineWidth', LineWidth );
				h(2) = bar( 2, mean( [weighted_DB.P] ), 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
				plot( [2,2], [-1,1]*std([weighted_DB.P])+mean([weighted_DB.P]), '-k', 'LineWidth', LineWidth );
				ToolKit.ShowSignificance( [1, std([weighted_D.P]+mean([weighted_D.P]))], [2, std([weighted_DB.P]+mean([weighted_DB.P]))], pVal.P, 0.02, isShowValue.P, 'FontSize', 24 );

				bar( 5, mean( [weighted_D.M] ), 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
				plot( [5,5], [-1,1]*std([weighted_D.M])+mean([weighted_D.M]), '-k', 'LineWidth', LineWidth );
				bar( 6, mean( [weighted_DB.M] ), 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
				plot( [6,6], [-1,1]*std([weighted_DB.M])+mean([weighted_DB.M]), '-k', 'LineWidth', LineWidth );
				ToolKit.ShowSignificance( [5, std([weighted_D.M]+mean([weighted_D.M]))], [6, std([weighted_DB.M]+mean([weighted_DB.M]))], pVal.M, 0.02, isShowValue.M, 'FontSize', 24 );

				set( gca, 'XLim', [-1 8], 'XTick', [1.5 5.5], 'XTickLabel', { 'P Cell', 'M Cell' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
				title( 'PSD', 'FontSize', 20 );
				ylabel('PSD');
				set( legend(h), 'location', 'northeastout', 'fontsize', 18 );

				saveas( gcf, sprintf( '%s/FV_Test_w%03d_rSlope%.2f_gainMin%.2f_Population_Weighted%d.fig', destFolder, w, rSlope, gainMin, weighted ) );
				saveas( gcf, sprintf( '%s/FV_Test_w%03d_rSlope%.2f_gainMin%.2f_Population_Weighted%d.png', destFolder, w, rSlope, gainMin, weighted ) );
			end

		end


		function [bPS, nbPS, PS] = PopulationPSD( SF, version, destFolder )
			%% population comparison of PSD weighted with RGC's temporal frequency sensitivity, based on drift only trials
			%	subjects: Bin, A058, A082, A088, A002, A050
			%	ramp: 1.5s
			%	plateau:	0.5s (Bin); 1s (A058, A082, A088, A002, A050)
			%
			%	SF:			spatial frequency of the grating, 3 cpd by default
			%	version:	duplicate:	re-use drifts from No Blink trials for the analysis of Blink Condition, the purpose is to avoid artifacts on eye traces around blinks due to the eye tracker; blinks will be randomly sampled from Blink trials
			%				unique:		use real eye traces for Blink Condition, and reduce artifacts by cutting eye samples too close to blinks marked by the eye tracker

			if( nargin() < 1 || isempty(SF) ) SF = 3; end
			if( nargin() < 2 || isempty(version) ) version = 'duplicate'; end
			if( nargin() < 3 || isempty(destFolder) ) destFolder = './'; end

			sbjs 	= { 'Bin',	'A058',	'A082',	'A088', 'A002', 'A050' };
			folders = { 'F:\BlinkTransient\Bin\Extracted_0.5s_sf3',...	% 0.5s
						'F:\BlinkTransient\A058\Extracted_1s_sf3',...
						'F:\BlinkTransient\A082\2 FixedLevels\Extracted_1s_sf3',...
						'F:\BlinkTransient\A088\Extracted_1s_sf3',...
						'F:\BlinkTransient\A002',...
						'F:\BlinkTransient\A050' };
			indices = { 1:29,...
						1:33,...
						1:29,...
						1:19,...
						4:57,...
						3:53 };
			plateaus = [500, 1000, 1000, 1000, 1000, 1000];

			FontSize = 24;
			LineWidth = 2;

			if( exist( ['F:\BlinkTransient\PSD\PSD_', version, '.mat'], 'file' ) == 2 )
				load( ['F:\BlinkTransient\PSD\PSD_', version, '.mat'] );
				PSD.PS_D = PSD.PS_D(1:4);
				PSD.PS_DB = PSD.PS_DB(1:4);
				PSD.weighted_D = PSD.weighted_D(1:4);
				PSD.weighted_DB = PSD.weighted_DB(1:4);
			
			else
				for( iSbj = 1:-1:1 ) %size(sbjs,2) : -1 : 1 )

		            data = BlinkTransient.GetLabeledTrials4Blinks( folders{iSbj}, [], [], 'tRampOn', 0, 0 );
					data = data(indices{iSbj});
					for( i = 1 : size(data,2) )
						data(i).trials( [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] > -600 & ~[data(i).trials.hasBlink] | [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] < -600 & [data(i).trials.hasBlink] ) = [];
					end
					trials = [data.trials];
					trials = trials( ~[trials.hasMicrosac] & ~[trials.hasSac] );
					sRate = trials(1).sRate;
					bTrials = trials( [trials.hasBlink] );		% blink trials
					nbTrials = trials( ~[trials.hasBlink] );	% no blink trials
					size(bTrials)
					size(nbTrials)


					swPix = 1366;%2560;	% screen width in pixels
					swMm = 600;		% screen width in mm
					shPix = 768;%1440;	% screen height in pixels
					shMm = 335;		% screen height in mm
					sDist = 1605;%1190;	% distance from screen to subject's eye in mm
					PSX = round(swPix/4)*2;
					PSY = round(shPix/4)*2;
					PSZ = round( (1500 + plateaus(iSbj) - 15) / 1000 * sRate / 2 ) * 2;	% -15ms to allow some variation in stimulus display time; round(x/2)*2 to get an even number
					NSamples = PSX * PSY * PSZ;
					bPS = zeros( PSX/2+1, PSY/2+1, PSZ/2+1, 'single' );		% blink condition
					nbPS = zeros( PSX/2+1, PSY/2+1, PSZ/2+1, 'single' );	% no blink condition
					Win = hann(PSX) * hann(PSY)';	% Hanning Window
					U = sum(Win(:));
					sHFreqs = (0 : size(bPS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
					sVFreqs = (0 : size(bPS,2)-1) / (atand( PSY/shPix*shMm/2 / sDist ) * 2);
					if( sHFreqs(end) < sVFreqs(end) )		% select the one with smaller spatial frequency range
						sFreqs = sHFreqs;
					else
						sFreqs = sVFreqs;
					end
					if( mod(size(sFreqs,2),2) == 0 ) sFreqs(end) = []; end 	% odd number of samples so we can rotate around the exact center
					tFreqs = (0 : size(bPS,3)-1) / (PSZ/sRate);

					contrast = 1;
					wlPix = swPix ./ ( atand( swMm/2 / sDist ) * 2 * SF );	% wave length for 3 cpd
					IMGs{2} = ToolKit.Gabor( wlPix, 45, 0, swPix, shPix, 'grating' )' * contrast + 1;
					IMGs{1} = ToolKit.Gabor( wlPix, -45, 0, swPix, shPix, 'grating' )' * contrast + 1;

					% ramp of 1500ms
					Gt = ones(1,PSZ);
					Gt( 1 : round(1500/1000*sRate) ) = ( 0 : round(1500/1000*sRate)-1 ) / (round(1500/1000*sRate)-1);

					mov = zeros( PSX, PSY, PSZ, 'single' );

					hMain = figure( 'NumberTitle', 'off', 'name', sprintf( 'PSD | sbj: %s', sbjs{iSbj} ), 'color', 'w' );
					pause(0.1);
					jf = get(handle(gcf),'javaframe');
					jf.setMaximized(1);
					pause(0.5);
					% hMov = figure( 'NumberTitle', 'off', 'name', sprintf( 'Input movie | sbj: %s', sbjs{iSbj} ), 'color', 'w' );
					% set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'nextplot', 'add' );
					% xlabel('Time (ms)');
					% ylabel('Pixels');

					for( condition = 1:2 )
						if( condition == 1 ) con = 'NoBlink';
						else con = 'Blink'; end
						hDrifts = figure( 'NumberTitle', 'off', 'name', sprintf( 'Drifts | sbj: %s | condition: %s', sbjs{iSbj}, con ), 'color', 'w' ); hold on;
						if( condition == 1 )		% No Blink Condition
							Trials = nbTrials; %(1:5);%(1:50);
						elseif( strcmpi( version, 'duplicate' ) )	% Blink Condition, re-use drifts from no blink trials for blink trials
							Trials = nbTrials; %(1:5);
						else 										% Blink Condition, use original drifts for blink trials
							Trials = bTrials; %(1:5);
						end

						panel2 = true;
						h = [];
						for( iTrial = 1 : size(Trials,2) )
							if( Trials(iTrial).gaborOri == 45 ) img = IMGs{2};
							else img = IMGs{1}; end

							% get eye drift
							t = (0:Trials(iTrial).samples-1)/Trials(iTrial).sRate*1000 + Trials(iTrial).tTrialStart;
							index = Trials(iTrial).tRampOn <= t & t <= Trials(iTrial).tMaskOn;
							x = Trials(iTrial).x.position(index);
							y = Trials(iTrial).y.position(index);
							x = x(1:PSZ);
							y = y(1:PSZ);

							% convert to pixels
							x = round( sDist * tand(x/60) / swMm * swPix );
							y = round( sDist * tand(y/60) / shMm * shPix );
							x = x - x(1);
							y = y - y(1);

							if( condition == 1 )
								%% No Blink Condition
								for( t = 1 : PSZ )
									tmpMov = zeros(PSX,PSY);
									xOff = round( ( size(img,1) - PSX ) / 2 ) + x(t);
									yOff = round( ( size(img,2) - PSY ) / 2 ) + y(t);
									tmpMov( max(1,2-xOff) : min( PSX , PSX - (xOff+PSX-1-size(img,1)) ),  max(1,2-yOff) : min( PSY, PSY - (yOff+PSY-1-size(img,2)) ) )  =  img( max(1,xOff) : min( xOff+PSX-1, end ), max(1,yOff) : min( yOff+PSY-1, end ) ) * Gt(t) + 1;
									% tmpMov = img( (0:PSX-1) + xOff, (0:PSY-1) + yOff );
									mov( :, :, t ) = tmpMov;
								end
								mov = ( mov - mean(mov(:)) ) .* Win;
								tPS = fftn(mov);
								nbPS = nbPS + abs( tPS( 1:size(nbPS,1), 1:size(nbPS,2), 1:size(nbPS,3) ) ).^2;	% discard negative frequency part
									% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)
							
							else %% Blink Condition: blink trace simulated as covering input image from top to bottom and then back to top
								
								% get trial
								if( strcmpi( version, 'duplicate' ) )
									trial = [];
									while(isempty(trial))
										trial = bTrials(randi(size(bTrials,2)));
										tStart = trial.blinks.start / sRate * 1000;
										tStart( tStart <= trial.tBlinkBeepOn - trial.tTrialStart ) = [];
										if( isempty(tStart) ) trial = [];
										else break; end
									end
								else
									trial = Trials(iTrial);
								end

								%% find blink parameters
								tStart = trial.blinks.start / sRate * 1000;
								dur = trial.blinks.duration / sRate * 1000;
                                index = tStart <= trial.tBlinkBeepOn - trial.tTrialStart | tStart+dur >= trial.tMaskOn - trial.tTrialStart - 50;
								dur(index) = [];
								tStart(index) = [];
                                if( isempty(tStart) ) continue; end
								tStart = tStart(1);			% time when P1 occluded (ms)
								tEnd = tStart + dur(1);		% time when P1 un-occluded (ms)
								s2 = round( tStart/1000*sRate );
								s1 = s2;	% start of eye lid movement (suppose eye lid and eye start to move simultaniously), in samples
								lim = floor((tStart-80)/1000*sRate);
								while(true)
									s = find( trial.velocity(lim:s1) > 180, 1, 'last' );
									if( ~isempty(s) && lim + s -1 > s1 - 15/1000*sRate )
										s1 = lim-1 + find( trial.velocity(lim+(0:s-1)) < 180, 1, 'last' );
										if( isempty(s1) )
											s1 = lim;
											break;
										end
									else
										break;
									end
								end
								s2 = (s2-s1) * 0.1538 + s2;		% time when eye lid fully closed, in samples

								s3 = round( tEnd/1000*sRate );
								s4 = round( tEnd/1000*sRate );	% end of eye lid movement (suppose eye lid and eye stop moving simultatneously), in samples
								lim = ceil( (tEnd+150)/1000*sRate );
								while(true)
									s = find( trial.velocity(s4:lim) > 180, 1, 'first' );
									if( ~isempty(s) && s4 + s - 1 < s4 + 15/1000*sRate )
										s4 = s4-1 + find( trial.velocity(s4+s-1:lim) < 180, 1, 'first' );
										if( isempty(s4) )
											s4 = lim;
											break;
										end
									else
										break;
									end
								end
								s3 = s3 - (s4-s3) * 0.1563;		% time when eye starts to open
								tLid = round( [s1 s2 s3 s4] - (trial.tRampOn - trial.tTrialStart) / 1000 * sRate );	% in samples


								%% find parameters of eye movements during blink
								lim = floor((tStart-50)/1000*sRate);
								vel = trial.velocity( lim : round(tStart/1000*sRate) );
								derive = diff(vel);
								idx = find( derive(2:end) .* derive(1:end-1) <= 0, 1, 'last' );
								if( ~isempty(idx) )
									tEye(1) = (lim + idx + 1);		% time when P4 occluded therefore eye trace afterwards is not reliable, in samples
								else
									tEye(1) = tStart/1000*sRate;
								end
								% tmpX = Trials(iTrial).x.position( lim : round((tStart+5)/1000*sRate) );
								% tmpY = Trials(iTrial).y.position( lim : round((tStart+5)/1000*sRate) );
								% tmpX = tmpX - tmpX(end);
								% tmpY = tmpY - tmpY(end);
								% [~,ix] = max(abs(tmpX));
								% [~,iy] = max(abs(tmpY));
								% tEye(1) = (lim + min(ix,iy)-1) / sRate * 1000;

								lim = ceil( (tEnd+150)/1000*sRate );
								vel = trial.velocity( round((tEnd+5)/1000*sRate) : lim );
								derive = diff(vel);
								idx = find( derive(2:end) .* derive(1:end-1) <=0, 1, 'first' );
								if( ~isempty(idx) )
									tEye(2) = (tEnd+5)/1000*sRate + (idx + 1);		% time when P4 un-occluded, eye trace before which is not reliable, in samples
								else
									tEye(2) = (tEnd+5) / 1000 * sRate;
								end
								tEye = round( tEye - (trial.tRampOn - trial.tTrialStart)/1000*sRate );	% in samples
								tEye(1) = max(2, tEye(1));
								tEye(2) = min(size(x,2)-1, tEye(2));
								% tmpX = Trials(iTrial).x.position( round((tEnd-5)/1000*sRate) : lim );
								% tmpY = Trials(iTrial).y.position( round((tEnd-5)/1000*sRate) : lim );
								% tmpX = tmpX - tmpX(1);
								% tmpY = tmpY - tmpY(1);
								% [~,ix] = max(abs(tmpX));
								% [~,iy] = max(abs(tmpY));
								% tEye(2) = (round((tEnd-5)/1000*sRate) + max(ix,iy)-1) / sRate * 1000;
								% tEye = round( tEye - (trial.tRampOn - trial.tTrialStart)/1000*sRate );	% in samples

								%% freeze eye trace between [tEye(1), tEye(2)]
								if( ~strcmpi( version, 'duplicate' ) )
									x(tEye(1):tEye(2)) = x(tEye(1)-1);
									y(tEye(1):tEye(2)) = y(tEye(1)-1);
									x(tEye(2)+1:end) = x(tEye(2)+1:end) - ( x(tEye(2)+1) - x(tEye(1)-1) );
									y(tEye(2)+1:end) = y(tEye(2)+1:end) - ( y(tEye(2)+1) - y(tEye(1)-1) );
								end
								

								%% cover visual field
								bTrace = ones(1,PSZ) * PSY;
								tStart = tLid(1); % round( 1300 / 1000 * sRate );		% blink start time relative to ramp on set, in samples
								tFullCover = tLid(3)-tLid(2); %round( 150 / 1000 * sRate );			% duration of complete covering, in samples
								tDown = tLid(2)-tLid(1); %round( 20 / 1000 * sRate );		% 20 ms to complete cover down
								tUp = tLid(4)-tLid(3); %round( 30 / 1000 * sRate ); 		% 30 ms to complete open
								bTrace( tStart + tDown + (0:tFullCover-1) ) = 0;
								bTrace( tStart + (0:tDown-1) ) = (tDown-1:-1:0) / (tDown-1) * PSY;
								bTrace( tStart + tDown + tFullCover + (0:tUp-1) ) = (0:tUp-1) / (tUp-1) * PSY;


							
								if( panel2 )
									panel2 = false;
									figure(hMain);
				                    subplot(2,2,2); hold on;
									[AX, H1, H2] = plotyy( (1:PSZ)/sRate*1000, bTrace, (1:PSZ)/sRate*1000, Gt );
									set( AX(1), 'YColor', 'b', 'XLim', [0 PSZ], 'YLim', [-1.1 1.1] * (max(bTrace)-min(bTrace)) / 2 + mean([min(bTrace),max(bTrace)]), 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off', 'nextplot', 'add' );
									AX(1).YLabel.String = 'Front edge (pixel)';
				                    set( H1, 'LineWidth', 2, 'color', 'b' );
									set( AX(2), 'XLim', [0 PSZ]/sRate*1000, 'YLim', [0 1.1], 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off', 'nextplot', 'add' );
									AX(2).YLabel.String = 'Stimulus gain';
									AX(2).XLabel.String = 'Time (ms)';
				                    set( H2, 'LineWidth', LineWidth );
				                else
				                	;%plot( AX(1), 1:PSZ, bTrace, 'b' );
				                end

				                % create movie
				                for( t = 1 : PSZ )
				                	tmpMov = zeros(PSX,PSY);
									xOff = round( ( size(img,1) - PSX ) / 2 ) + x(t);
									yOff = round( ( size(img,2) - PSY ) / 2 ) + y(t);
									tmpMov( max(1,2-xOff) : min( PSX , PSX - (xOff+PSX-1-size(img,1)) ),  max(1,2-yOff) : min( PSY, PSY - (yOff+PSY-1-size(img,2)) ) )  =  img( max(1,xOff) : min( xOff+PSX-1, end ), max(1,yOff) : min( yOff+PSY-1, end ) ) * Gt(t) + 1;
									% tmpMov = img( (0:PSX-1) + round( ( size(img,1) - PSX ) / 2 ) + x(t), (0:PSY-1) + round( ( size(img,2) - PSY ) / 2 ) + y(t) );
				                    tmpMov( :, (1:PSY) > bTrace(t) ) = 0;
									mov( :, :, t ) = tmpMov;
									% if( t > tStart - 3 )
									% 	figure(hMov);
									% 	imshow( mov(:,:,t)', [] );
									% 	set( gca, 'YDir', 'normal' );
									% 	pause
									% end
								end
								
								mov = ( mov - mean(mov(:)) ) .* Win;
								tPS = fftn(mov);
								bPS = bPS + abs( tPS( 1:size(bPS,1), 1:size(bPS,2), 1:size(bPS,3) ) ).^2;	% discard negative frequency part
									% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)
							end

							figure(hDrifts);
							h(2) = plot( (0:size(x,2)-1)/sRate*1000, x, 'color', 'b', 'DisplayName', 'Horizontal' );
							h(1) = plot( (0:size(y,2)-1)/sRate*1000, y, 'color', 'r', 'DisplayName', 'Vertical' );
						end
						if( ~isempty(h) ) set( legend(h(2:-1:1)), 'FontSize', FontSize ); end
						pause(10);
						saveas( hDrifts, [ destFolder, '\Drifts_', version, '_', con, '_', sbjs{iSbj}, '.fig' ] );
						saveas( hDrifts, [ destFolder, '\Drifts_', version, '_', con, '_', sbjs{iSbj}, '.png' ] );
						close(hDrifts);
					end

					bPS(2:end-1, 2:end-1, 2:end-1) = 2^3 * bPS(2:end-1, 2:end-1, 2:end-1);	% convert to single sided
					bPS = bPS / ( PSX * (PSX/(atand(PSX/swPix*swMm/2/sDist)*2)) * PSY * (PSY/(atand(PSY/shPix*shMm/2/sDist)*2)) * PSZ * 1000 * U ) / size(Trials,2);
					bPS = interp3( sVFreqs, sHFreqs, tFreqs, bPS, sFreqs, sFreqs', tFreqs, 'linear' );
					PS_DB = imrotate( bPS, -45, 'bilinear' );
					PS_DB = reshape( sum( PS_DB(1:size(sFreqs,2),:,:), 2 ), size(sFreqs,2), [] )';


					nbPS(2:end-1, 2:end-1, 2:end-1) = 2^3 * nbPS(2:end-1, 2:end-1, 2:end-1);	% convert to single sided
					nbPS = nbPS / ( PSX * (PSX/(atand(PSX/swPix*swMm/2/sDist)*2)) * PSY * (PSY/(atand(PSY/shPix*shMm/2/sDist)*2)) * PSZ * 1000 * U ) / size(Trials,2);
					nbPS = interp3( sVFreqs, sHFreqs, tFreqs, nbPS, sFreqs, sFreqs', tFreqs, 'linear' );
					PS_D = imrotate( nbPS, -45, 'bilinear' );
					PS_D = reshape( sum( PS_D(1:size(sFreqs,2),:,:), 2 ), size(sFreqs,2), [] )';

					figure(hMain);
					subplot(2,2,1);
					colormap('hot');
					contour( sFreqs(sFreqs>0.5), tFreqs(2:50), PS_DB(2:50, sFreqs>0.5), 1000, 'LineStyle', 'none', 'fill', 'on' );
					caxis( [ min(reshape( [PS_DB(2:50, sFreqs>0.5), PS_D(2:50, sFreqs>0.5)], 1, [] ) ), max(reshape( [PS_DB(2:50, sFreqs>0.5), PS_D(2:50, sFreqs>0.5)], 1, [] ) ) ] );
					colorbar;
					xlabel( 'Spatial frequency (cpd)' );
					ylabel( 'Temporal frequency (Hz)' );
					title( 'Blink Condition' );
					set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [0.5 sFreqs(end)], 'YLim', tFreqs([2 50]), 'XTick', [1 5 10 20 40], 'YTick', [1 5 10 20 40 80] );

					subplot(2,2,3);
					colormap('hot');
					contour( sFreqs(sFreqs>0.5), tFreqs(2:50), PS_D(2:50, sFreqs>0.5), 1000, 'LineStyle', 'none', 'fill', 'on' );
					caxis( [ min(reshape( [PS_DB(2:50, sFreqs>0.5), PS_D(2:50, sFreqs>0.5)], 1, [] ) ), max(reshape( [PS_DB(2:50, sFreqs>0.5), PS_D(2:50, sFreqs>0.5)], 1, [] ) ) ] );
					colorbar;
					xlabel( 'Spatial frequency (cpd)' );
					ylabel( 'Temporal frequency (Hz)' );
					title( 'No Blink Condition' );
					set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [0.5 sFreqs(end)], 'YLim', tFreqs([2 50]), 'XTick', [1 5 10 20 40], 'YTick', [1 5 10 20 40 80] );

					pCellGain = RGC.TemporalFreqGainProfile( tFreqs, 'p', 'center' ) - RGC.TemporalFreqGainProfile( tFreqs, 'p', 'surround' );
					mCellGain = RGC.TemporalFreqGainProfile( tFreqs, 'm', 'on' );
					weighted_D.P = interp2( sFreqs, tFreqs, PS_D, SF, tFreqs(tFreqs>0), 'linear' )' * pCellGain(tFreqs>0)';
					weighted_D.M = interp2( sFreqs, tFreqs, PS_D, SF, tFreqs(tFreqs>0), 'linear' )' * mCellGain(tFreqs>0)';
					weighted_DB.P = interp2( sFreqs, tFreqs, PS_DB, SF, tFreqs(tFreqs>0), 'linear' )' * pCellGain(tFreqs>0)';
					weighted_DB.M = interp2( sFreqs, tFreqs, PS_DB, SF, tFreqs(tFreqs>0), 'linear' )' * mCellGain(tFreqs>0)';

					subplot(2,4,7); hold on;
					h(2) = plot( tFreqs(tFreqs>0), pCellGain(tFreqs>0), 'LineWidth', LineWidth, 'color', [0.5 0.5 0.5], 'DisplayName', 'P Cell' );
					h(1) = plot( tFreqs(tFreqs>0), mCellGain(tFreqs>0), 'LineWidth', LineWidth, 'color', 'k', 'DisplayName', 'M Cell' );
					set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs(2), 70], 'XTick', [1 10 40], 'XTickLabel', [1 10 40], 'box', 'off' );
					title( 'Cell sensitivity', 'FontSize', 20 );
					xlabel( 'Temporal frequency (Hz)' );
					ylabel( 'Gain' );
					set( legend(h), 'location', 'southwest', 'FontSize', 18 );
					
					subplot(2,4,8); hold on; h = [];
					h(1) = bar( 1, weighted_D.P, 1, 'b', 'LineStyle', 'none', 'DisplayName', 'NBC' );
					h(2) = bar( 2, weighted_DB.P, 1, 'r', 'LineStyle', 'none', 'DisplayName', 'BC' );
					bar( 5, weighted_D.M, 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
					bar( 6, weighted_DB.M, 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
					set( gca, 'XLim', [-1 8], 'XTick', [1.5 5.5], 'XTickLabel', { 'P Cell', 'M Cell' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
					title( 'Weighted PSD', 'FontSize', 20 );
					ylabel('PSD');
					set( legend(h), 'location', 'northwest', 'fontsize', 18 );

					pause(10);
					saveas( hMain, [ destFolder, '\PSD_', version, '_', sbjs{iSbj}, '.fig' ] );
					saveas( hMain, [ destFolder, '\PSD_', version, '_', sbjs{iSbj}, '.png' ] );
					close(hMain);

					PSD.PS_D{iSbj} = PS_D;
					PSD.sFreqs{iSbj} = sFreqs;
					PSD.tFreqs{iSbj} = tFreqs;
					PSD.PS_DB{iSbj} = PS_DB;
					PSD.weighted_D(iSbj) = weighted_D;
					PSD.weighted_DB(iSbj) = weighted_DB;
					PSD.pCellGain{iSbj} = pCellGain;
					PSD.mCellGain{iSbj} = mCellGain;
					save( ['F:\BlinkTransient\PSD\PSD_', version, '.mat'], 'PSD' );
				end
				save( ['F:\BlinkTransient\PSD\PSD_', version, '.mat'], 'PSD' );
			end

			PS_D = PSD.PS_D;
			sFreqs = PSD.sFreqs{2};
			tFreqs = PSD.tFreqs{2};
			PS_DB = PSD.PS_DB;
			weighted_D = PSD.weighted_D;
			weighted_DB = PSD.weighted_DB;
			pCellGain = PSD.pCellGain{2};
			mCellGain = PSD.mCellGain{2};
			[~, pVal.P, CI.P] = ttest( [weighted_D.P], [weighted_DB.P], 'alpha', 0.05 );
			[~, pVal.M, CI.M] = ttest( [weighted_D.M], [weighted_DB.M], 'alpha', 0.05 )
			if( pVal.P < 0.1 && pVal.P > 0.05 ) isShowValue.P = true;
			else isShowValue.P = false; end
			if( pVal.M < 0.1 && pVal.M > 0.05 ) isShowValue.M = true;
			else isShowValue.M = false; end

			set( figure, 'NumberTitle', 'off', 'name', [ 'Population | PSD | Version: ', version ], 'color', 'w' );
			subplot(1,2,1); hold on;
			h(2) = plot( tFreqs(tFreqs>0), pCellGain(tFreqs>0), 'LineWidth', LineWidth, 'color', [0.5 0.5 0.5], 'DisplayName', 'P Cell' );
			h(1) = plot( tFreqs(tFreqs>0), mCellGain(tFreqs>0), 'LineWidth', LineWidth, 'color', 'k', 'DisplayName', 'M Cell' );
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs(2), 70], 'XTick', [1 10 40], 'XTickLabel', [1 10 40], 'box', 'off' );
			title( 'Cell sensitivity', 'FontSize', 20 );
			xlabel( 'Temporal frequency (Hz)' );
			ylabel( 'Gain' );
			set( legend(h), 'location', 'southwest', 'FontSize', 18 );
			
			subplot(1,2,2); hold on; h = [];
			h(1) = bar( 1, mean( [weighted_D.P] ), 1, 'b', 'LineStyle', 'none', 'DisplayName', 'NBC' );
			plot( [1,1], [-1,1]*std([weighted_D.P])+mean([weighted_D.P]), '-k', 'LineWidth', LineWidth );
			h(2) = bar( 2, mean( [weighted_DB.P] ), 1, 'r', 'LineStyle', 'none', 'DisplayName', 'BC' );
			plot( [2,2], [-1,1]*std([weighted_DB.P])+mean([weighted_DB.P]), '-k', 'LineWidth', LineWidth );
			ToolKit.ShowSignificance( [1, std([weighted_D.P]+mean([weighted_D.P]))], [2, std([weighted_DB.P]+mean([weighted_DB.P]))], pVal.P, 0.02, isShowValue.P, 'FontSize', 24 );

			bar( 5, mean( [weighted_D.M] ), 1, 'b', 'LineStyle', 'none', 'DisplayName', 'drift' );
			plot( [5,5], [-1,1]*std([weighted_D.M])+mean([weighted_D.M]), '-k', 'LineWidth', LineWidth );
			bar( 6, mean( [weighted_DB.M] ), 1, 'r', 'LineStyle', 'none', 'DisplayName', 'drift+blink' );
			plot( [6,6], [-1,1]*std([weighted_DB.M])+mean([weighted_DB.M]), '-k', 'LineWidth', LineWidth );
			ToolKit.ShowSignificance( [5, std([weighted_D.M]+mean([weighted_D.M]))], [6, std([weighted_DB.M]+mean([weighted_DB.M]))], pVal.M, 0.02, isShowValue.M, 'FontSize', 24 );

			set( gca, 'XLim', [-1 8], 'XTick', [1.5 5.5], 'XTickLabel', { 'P Cell', 'M Cell' }, 'XTickLabelRotation', 10, 'YScale', 'log', 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
			title( 'Weighted PSD', 'FontSize', 20 );
			ylabel('PSD');
			set( legend(h), 'location', 'northwest', 'fontsize', 18 );

			pause(10);
			saveas( gcf, [ destFolder, '\PSD_', version, '_Population', '.fig' ] );
			saveas( gcf, [ destFolder, '\PSD_', version, '_Population', '.png' ] );
			% close(gcf);

		end


		function [bPS, nbPS, PS] = PopulationPSD_backup( SF, version )
			%% population comparison of PSD weighted with RGC's temporal frequency sensitivity, based on drift only trials
			%	subjects: Bin, A058, A082, A088, A002, A050
			%	ramp: 1.5s
			%	plateau:	0.5s (Bin); 1s (A058, A082, A088, A002, A050)
			%
			%	SF:			spatial frequency of the grating, 3 cpd by default
			%	version:	duplicate:	re-use drifts from No Blink trials for the analysis of Blink Condition, the purpose is to avoid artifacts on eye traces around blinks due to the eye tracker; blinks will be randomly sampled from Blink trials
			%				unique:		use real eye traces for Blink Condition, and reduce artifacts by cutting eye samples too close to blinks marked by the eye tracker

			if( nargin() < 1 || isempty(SF) ) SF = 3; end

			sbjs = { 'Bin' };
			folders = { 'F:\BlinkTransient\Bin\1.5s+0_0.5s (sf3)' };
			blockIndices = { 8:36 };
			plateaus = [500];
			iSbj = 1;

            data = BlinkTransient.GetLabeledTrials4Blinks( folders{iSbj}, [], [], 'tRampOn', 0, 0 );
			data = data(blockIndices{iSbj});
			for( i = 1 : size(data,2) )
				data(i).trials( [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] > -600 & ~[data(i).trials.hasBlink] | [data(i).trials.tBlinkBeepOn] - [data(i).trials.tRampOn] < -600 & [data(i).trials.hasBlink] ) = [];
			end
			trials = [data.trials];
			trials = trials( ~[trials.hasMicrosac] & ~[trials.hasSac] & abs( [trials.tMaskOn] - [trials.tPlateauOn] - plateaus(iSbj) ) < 50 );
			sRate = trials(1).sRate;
			bTrials = trials( [trials.hasBlink] );		% blink trials
			nbTrials = trials( ~[trials.hasBlink] );	% no blink trials
			size(bTrials)
			size(nbTrials)


			swPix = 1366;%2560;	% screen width in pixels
			swMm = 600;		% screen width in mm
			shPix = 768;%1440;	% screen height in pixels
			shMm = 335;		% screen height in mm
			sDist = 1605;%1190;	% distance from screen to subject's eye in mm
			PSX = round(swPix/4)*2;
			PSY = round(shPix/4)*2;
			PSZ = round( (1500 + plateaus(iSbj) - 10) / 1000 * sRate / 2 ) * 2;	% -10ms to allow some variation in stimulus display time; round(x/2)*2 to get an even number
			NSamples = PSX * PSY * PSZ;
			bPS = zeros( PSX/2+1, PSY/2+1, PSZ/2+1, 'single' );		% blink condition
			nbPS = zeros( PSX/2+1, PSY/2+1, PSZ/2+1, 'single' );	% no blink condition
			Win = hann(PSX) * hann(PSY)';	% Hanning Window
			U = sum(Win(:));
			sHFreqs = (0 : size(bPS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
			sVFreqs = (0 : size(bPS,2)-1) / (atand( PSY/shPix*shMm/2 / sDist ) * 2);
			if( sHFreqs(2) < sVFreqs(2) )		% select the one with higher spatial frequency sampling rate
				sFreqs = sHFreqs;
			else
				sFreqs = sVFreqs;
			end
			if( mod(size(sFreqs,2),2) == 0 ) sFreqs(end) = []; end 	% odd number of samples so we can rotate around the exact center
			tFreqs = (0 : size(bPS,3)-1) / (PSZ/sRate);

			contrast = 1;
			wlPix = swPix ./ ( atand( swMm/2 / sDist ) * 2 * SF );	% wave length for 3 cpd
			IMGs{2} = ToolKit.Gabor( wlPix, 45, 0, swPix, shPix, 'grating' )' * contrast + 1;
			IMGs{1} = ToolKit.Gabor( wlPix, -45, 0, swPix, shPix, 'grating' )' * contrast + 1;

			mov = zeros( PSX, PSY, PSZ, 'single' );

			FontSize = 24;
			LineWidth = 2;
			hMain = figure( 'NumberTitle', 'off', 'name', sprintf( 'PSD | sbj: %s', sbjs{iSbj} ), 'color', 'w' );
			hDrifts = figure( 'NumberTitle', 'off', 'name', sprintf( 'Drifts | sbj: %s', sbjs{iSbj} ), 'color', 'w' ); hold on;
			driftLegend = false;
			% hMov = figure( 'NumberTitle', 'off', 'name', sprintf( 'Input movie | sbj: %s', sbjs{iSbj} ), 'color', 'w' );
			% set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'nextplot', 'add' );
			% xlabel('Time (ms)');
			% ylabel('Pixels');

			Trials = nbTrials(10);%(1:50);		% for blink condition, we apply a simulated blink to drifts from drift only trials
			for( iTrial = 1 : size(Trials,2) )
				if( Trials(iTrial).gaborOri == 45 ) img = IMGs{2};
				else img = IMGs{1}; end

				% ramp of 1500ms
				Gt = ones(1,PSZ);
				Gt( 1 : round(1500/1000*sRate) ) = ( 0 : round(1500/1000*sRate)-1 ) / (round(1500/1000*sRate)-1);

				% if( iTrial == 51 ) continue; end
				% get eye drift
				t = (0:Trials(iTrial).samples-1)/Trials(iTrial).sRate*1000 + Trials(iTrial).tTrialStart;
				index = Trials(iTrial).tRampOn <= t & t <= Trials(iTrial).tMaskOn;
				x = Trials(iTrial).x.position(index);
				y = Trials(iTrial).y.position(index);
				x = x(1:PSZ);
				y = y(1:PSZ);

				% % rotate by -orientation
				% xx = x * cosd(orientation) + y * sind(orientation);
				% yy = y * cosd(orientation) - x * sind(orientation);

				% convert to pixels
				x = round( sDist * tand(x/60) / swMm * swPix );
				y = round( sDist * tand(y/60) / shMm * shPix );

				figure(hDrifts);
				h(2) = plot( (0:size(x,2)-1)/sRate*1000, x, 'color', 'b', 'DisplayName', 'Horizontal' );
				h(1) = plot( (0:size(y,2)-1)/sRate*1000, y, 'color', 'r', 'DisplayName', 'Vertical' );
				if( ~driftLegend )
					driftLegend = true;
					set( legend(h(2:-1:1)), 'FontSize', FontSize );
				end


				%% no blink trial
				for( t = 1 : PSZ )
					tmpMov = img( (0:PSX-1) + round( ( size(img,1) - PSX ) / 2 ) + x(t), (0:PSY-1) + round( ( size(img,2) - PSY ) / 2 ) + y(t) );
					mov( :, :, t ) = tmpMov * Gt(t);
				end
				mov = ( mov - mean(mov(:)) ) .* Win;
				tPS = fftn(mov);
				nbPS = nbPS + abs( tPS( 1:size(nbPS,1), 1:size(nbPS,2), 1:size(nbPS,3) ) ).^2;	% discard negative frequency part
					% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)


				%% blink trial
				% blink trace simulated as covering input image from top to bottom and then back to top
				bTrace = ones(1,PSZ) * PSY;
				tStart = round( 1300 / 1000 * sRate );		% blink start time relative to ramp on set
				tFullCover = round( 150 / 1000 * sRate );			% 150 ms of complete covering
				tDown = round( 20 / 1000 * sRate );		% 20 ms to complete cover down
				tUp = round( 30 / 1000 * sRate ); 		% 30 ms to complete open
				bTrace( tStart + tDown + (0:tFullCover-1) ) = 0;
				bTrace( tStart + (0:tDown-1) ) = (tDown-1:-1:0) / (tDown-1) * PSY;
				bTrace( tStart + tDown + tFullCover + (0:tUp-1) ) = (0:tUp-1) / (tUp-1) * PSY;
				
				% freeze eye trace during blink
				iStart = find( bTrace < PSY, 1, 'first' );	% start of blink
				iEnd = find( bTrace < PSY, 1, 'last' );		% end of blink
				if( ~isempty(iStart) && ~isempty(iEnd) )
					x(iStart:iEnd) = x(iStart-1);
					x(iEnd+1:end) = x(iEnd+1:end) - ( x(iEnd+1) - x(iStart-1) );
					y(iStart:iEnd) = y(iStart-1);
					y(iEnd+1:end) = y(iEnd+1:end) - ( y(iEnd+1) - y(iStart-1) );
				end

				if( iTrial == 1 )
					figure(hMain);
                    subplot(2,2,2); hold on;
					[AX, H1, H2] = plotyy( (1:PSZ)/sRate*1000, bTrace, (1:PSZ)/sRate*1000, Gt );
					set( AX(1), 'YColor', 'b', 'XLim', [0 PSZ], 'YLim', [-1.1 1.1] * (max(bTrace)-min(bTrace)) / 2 + mean([min(bTrace),max(bTrace)]), 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off', 'nextplot', 'add' );
					AX(1).YLabel.String = 'Front edge (pixel)';
                    set( H1, 'LineWidth', 2, 'color', 'b' );
					set( AX(2), 'XLim', [0 PSZ], 'YLim', [0 1.1], 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off', 'nextplot', 'add' );
					AX(2).YLabel.String = 'Stimulus gain';
					AX(2).XLabel.String = 'Time (ms)';
                    set( H2, 'LineWidth', LineWidth );
                else
                	;%plot( AX(1), 1:PSZ, bTrace, 'b' );
                end

                % create movie
                for( t = 1 : PSZ )
					tmpMov = img( (0:PSX-1) + round( ( size(img,1) - PSX ) / 2 ) + x(t), (0:PSY-1) + round( ( size(img,2) - PSY ) / 2 ) + y(t) );
                    tmpMov( :, (1:PSY) > bTrace(t) ) = 0;
					mov( :, :, t ) = tmpMov * Gt(t);
					% if( t > tStart - 3 )
					% 	figure(hMov);
					% 	imshow( mov(:,:,t)', [] );
					% 	set( gca, 'YDir', 'normal' );
					% 	pause
					% end
				end
				
				mov = ( mov - mean(mov(:)) ) .* Win;
				tPS = fftn(mov);
				bPS = bPS + abs( tPS( 1:size(bPS,1), 1:size(bPS,2), 1:size(bPS,3) ) ).^2;	% discard negative frequency part
					% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)
			end

			bPS(2:end-1, 2:end-1, 2:end-1) = 2^3 * bPS(2:end-1, 2:end-1, 2:end-1);	% convert to single sided
			bPS = bPS / ( PSX * (PSX/(atand(PSX/swPix*swMm/2/sDist)*2)) * PSY * (PSY/(atand(PSY/shPix*shMm/2/sDist)*2)) * PSZ * 1000 * U ) / size(Trials,2);
			bPS = interp3( sVFreqs, sHFreqs, tFreqs, bPS, sFreqs, sFreqs', tFreqs, 'linear' );
			PS{1} = imrotate( bPS, -45, 'bilinear' );
			PS{1} = reshape( sum( PS{1}(1:size(sFreqs,2),:,:), 2 ), size(sFreqs,2), [] )';


			nbPS(2:end-1, 2:end-1, 2:end-1) = 2^3 * nbPS(2:end-1, 2:end-1, 2:end-1);	% convert to single sided
			nbPS = nbPS / ( PSX * (PSX/(atand(PSX/swPix*swMm/2/sDist)*2)) * PSY * (PSY/(atand(PSY/shPix*shMm/2/sDist)*2)) * PSZ * 1000 * U ) / size(Trials,2);
			nbPS = interp3( sVFreqs, sHFreqs, tFreqs, nbPS, sFreqs, sFreqs', tFreqs, 'linear' );
			PS{2} = imrotate( nbPS, -45, 'bilinear' );
			PS{2} = reshape( sum( PS{2}(1:size(sFreqs,2),:,:), 2 ), size(sFreqs,2), [] )';

			figure(hMain);
			subplot(2,2,1);
			colormap('hot');
			contour( sFreqs(sFreqs>0.5), tFreqs(2:50), PS{1}(2:50, sFreqs>0.5), 1000, 'LineStyle', 'none', 'fill', 'on' );
			caxis( [ min(reshape( [PS{1}(2:50, sFreqs>0.5), PS{2}(2:50, sFreqs>0.5)], 1, [] ) ), max(reshape( [PS{1}(2:50, sFreqs>0.5), PS{2}(2:50, sFreqs>0.5)], 1, [] ) ) ] );
			colorbar;
			xlabel( 'Spatial frequency (cpd)' );
			ylabel( 'Temporal frequency (Hz)' );
			title( 'Blink Condition' );
			set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [0.5 sFreqs(end)], 'YLim', tFreqs([2 50]), 'XTick', [1 5 10 20 40], 'YTick', [1 5 10 20 40 80] );

			subplot(2,2,3);
			colormap('hot');
			contour( sFreqs(sFreqs>0.5), tFreqs(2:50), PS{2}(2:50, sFreqs>0.5), 1000, 'LineStyle', 'none', 'fill', 'on' );
			caxis( [ min(reshape( [PS{1}(2:50, sFreqs>0.5), PS{2}(2:50, sFreqs>0.5)], 1, [] ) ), max(reshape( [PS{1}(2:50, sFreqs>0.5), PS{2}(2:50, sFreqs>0.5)], 1, [] ) ) ] );
			colorbar;
			xlabel( 'Spatial frequency (cpd)' );
			ylabel( 'Temporal frequency (Hz)' );
			title( 'No Blink Condition' );
			set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [0.5 sFreqs(end)], 'YLim', tFreqs([2 50]), 'XTick', [1 5 10 20 40], 'YTick', [1 5 10 20 40 80] );

			subplot(2,2,4); hold on;
			colors = {'r', 'b'};
			names = {'Blink', 'No blink'};
			for(i = 2:-1:1)
				h(i) = plot( tFreqs(2:end), interp2( sFreqs, tFreqs(2:end), PS{i}(2:end,:), SF, tFreqs(2:end), 'linear' ), '-', 'LineWidth', LineWidth, 'color', colors{i}, 'DisplayName', names{i} );
			end
			set( legend(h), 'location', 'Northeast' );
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs(2), 60], 'XTick', [1 10 40], 'XTickLabel', [1 10 40] );
			xlabel('Temporal frequency (Hz)');
			ylabel('Power spectral density');

		end


		function FixedReportVaryDur20181125( tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink )
			%% tLBEvent4Blink:		hasBlink is true only if a blink happens after tLBEvent4Blink
			%  tLBOffset4Blink:		offset regarding tLBEvent4Blink
			%  tUBOffset4Blink:		offset regarding upper bound for hasBlink

			if( nargin() < 1 || isempty(tAlignEvent) ) tAlignEvent = 'tRampOn'; end 	% start event for microsaccades/saccades control analysis
			if( nargin() < 2 || isempty(tStart) ) tStart = 0; end 						% start time for microsaccades/saccades control analysis (relative to tAlignEvent)
			if( nargin() < 3 || isempty(tLBEvent4Blink) ) tLBEvent4Blink = 'tRampOn'; end
			if( nargin() < 4 || isempty(tLBOffset4Blink) ) tLBOffset4Blink = 0; end
			if( nargin() < 5 || isempty(tUBOffset4Blink) ) tUBOffset4Blink = 0; end

			sbjs = { 'Bin', 'MAC', 'Bin', 'Bin', 'Bin', 'Bin', 'A043', 'A043', 'A058', 'A058', 'A088', 'A088', 'A082' };
			folders = { 'F:\BlinkTransient\Bin\1.5s+0.75_1.25s',...
						'F:\BlinkTransient\MAC',...
						'F:\BlinkTransient\Bin\1.5s+0.5_0.7s',...
						'F:\BlinkTransient\Bin\1.5s+0.25_0.75_1.25s',...
						'F:\BlinkTransient\Bin\1.5s+0_0.5s (sf3)',...
						'F:\BlinkTransient\Bin\1.5s+0_0.5s (sf0.1)',...
						'F:\BlinkTransient\A043\0_0.25_0.5s',...
						'F:\BlinkTransient\A043\0.5_1s',...
						'F:\BlinkTransient\A058\0.5_1s',...
						'F:\BlinkTransient\A058\0_0.5s',...
						'F:\BlinkTransient\A088\mix_1s',...
						'F:\BlinkTransient\A088\0.25_1s',...
						'F:\BlinkTransient\A082\2 FixedLevels\0.25_1s' };
			blockIndices = { [1:16,19:35], 3:5, [1:5,7:20], [8:36], [8:36], [1:24], [3:16], 5:23, 10:42, 1:6, 1:22, 8:13, 4:31 };

			iSbj = 8;
			data = BlinkTransient.GetLabeledTrials4Blinks( folders{iSbj}, tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink );
			Trials = [data(blockIndices{iSbj}).trials];
			if( isfield(Trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
				beepFreq = [Trials.beepFreq];
				beepFreq = beepFreq - mean( unique(beepFreq) );
				if( size( unique(beepFreq), 2 ) == 2 )
					Trials( beepFreq < 0 & [Trials.hasBlink] | beepFreq > 0 & ~[Trials.hasBlink] ) = [];
				else
					Trials( [Trials.tBlinkBeepOn] - [Trials.tRampOn] > -600 & ~[Trials.hasBlink] | [Trials.tBlinkBeepOn] - [Trials.tRampOn] < -600 & [Trials.hasBlink] ) = [];
				end	
			else
				Trials( [Trials.tBlinkBeepOn] - [Trials.tRampOn] > -600 & ~[Trials.hasBlink] | [Trials.tBlinkBeepOn] - [Trials.tRampOn] < -600 & [Trials.hasBlink] ) = [];
			end

			% Trials( [Trials.tMaskOn] - [Trials.tPlateauOn] > 500 & [Trials.tMaskOn] - [Trials.tPlateauOn] < 1000 ) = [];

			set( figure, 'NumberTitle', 'off', 'name', [ sbjs{iSbj}, ': FixedReport_VaryDur' ], 'color', 'w' );


			%% saccade amplitude
			subplot(2,4,1);
			microsaccades = [Trials.microsaccades];
			amplitudes.microsaccades = [microsaccades.amplitude];
			saccades = [Trials.saccades];
			amplitudes.saccades = [saccades.amplitude];
			amplitudes.nTrials = size(Trials,2);

			ampStep = 3;
			cutAmp = 30;
			edges = 0 : ampStep : cutAmp;
			h(2) = bar( (edges(1:end-1) + edges(2:end)) / 2, ToolKit.Hist( amplitudes.microsaccades, edges, false ) / amplitudes.nTrials, 0.9, 'm', 'LineStyle', 'none', 'DisplayName', 'microsaccades', 'FaceAlpha', 0.6 );
			hold on;
			edges = cutAmp : ampStep : min( [max(amplitudes.saccades), 300] );
			h(1) = bar( (edges(1:end-1) + edges(2:end)) / 2, ToolKit.Hist( amplitudes.saccades, edges, false ) / amplitudes.nTrials, 0.9, 'g', 'LineStyle', 'none', 'DisplayName', 'saccades', 'FaceAlpha', 0.6 );
			
			set( gca, 'XLim', [0 180], 'XTick', 0:30:180, 'box', 'off', 'LineWidth', 1, 'FontSize', 20 );
			ylabel( 'Number of m/sacs' );
			xlabel( 'Amplitude (arc min)' );
			legend(h);
			title('Saccade Amplitude');


			%% performance
			[n, p, pVal] = BlinkTransient.CompVaryDur( sbjs{iSbj}, folders{iSbj}, blockIndices{iSbj}, 'tRampOn', 0, false, 'tRampOn', 0, 0 )

			
			%% rasters; and tEnd VS tResponse
			subplot(1,2,2); hold on;
			hFlags = false(1,6);
			h(6) = gca;
			xlim1 = mean( [Trials.tFpOn] - [Trials.tPlateauOn] ) - 150;
			xlim2 = mean( [Trials.tMaskOn] - [Trials.tPlateauOn] ) + 1100;
			txtTags = { 'b', 'nb', 'drift', 'msac', 'sac' };
			txtColors = {'r', 'b'};
			blinkFlags = [true, false];
			sacFlags = [ false, false; true, false; false, true ];
			nTrials = 0;
			for( j = 1:3 )
				for( i = 1:2 )
					trials = Trials( [Trials.hasBlink] == blinkFlags(i) & [Trials.hasMicrosac] == sacFlags(j,1) & [Trials.hasSac] == sacFlags(j,2) );
					if( isempty(trials) ) continue; end
					tSort = -Inf * ones(size(trials));
					for( iTrial = size(trials,2) : -1 : 1 )
						sRate = trials(iTrial).sRate;
						if( blinkFlags(i) )
							blinks = [trials(iTrial).microsaccades, trials(iTrial).saccades, trials(iTrial).blinks];
							blinks = [trials(iTrial).blinks];
							tEnd = sort( ( [blinks.start] + [blinks.duration] - 2 ) / sRate * 1000 );
							index = find( tEnd < min( trials(iTrial).tResponse, trials(iTrial).tMaskOn ) - trials(iTrial).tTrialStart, 1, 'last' );
							if( ~isempty(index) )
								tSort(iTrial) = tEnd(index) - ( trials(iTrial).tPlateauOn - trials(iTrial).tTrialStart );
							end
						else
							sacs = [trials(iTrial).microsaccades, trials(iTrial).saccades, trials(iTrial).blinks];
							% sacs = [trials(iTrial).blinks];
							tEnd = sort( ( [sacs.start] + [sacs.duration] - 2 ) / sRate * 1000 );
							index = find( tEnd < min( trials(iTrial).tResponse, trials(iTrial).tMaskOn ) - trials(iTrial).tTrialStart, 1, 'last' );
							if( ~isempty(index) )
								tSort(iTrial) = tEnd(index) - ( trials(iTrial).tPlateauOn - trials(iTrial).tTrialStart );
							end
							% tSort(iTrial) = trials(iTrial).tBlinkBeepOn - trials(iTrial).tPlateauOn;
						end
					end
					[tSort, index] = sort(tSort);
					trials = trials(index);

					x = []; y = [];
					x{size(trials,2),3} = [];
					y{size(trials,2),3} = [];
					evnts = {'blinks', 'microsaccades', 'saccades'};
					for( iTrial = size(trials,2) : -1 : 1 )
						sRate = trials(iTrial).sRate;
						for( iEvnt = 1 : 3 )
							index = trials(iTrial).tFpOn - trials(iTrial).tTrialStart <= ( trials(iTrial).(evnts{iEvnt}).start -1 ) / sRate * 1000 & (trials(iTrial).(evnts{iEvnt}).start + trials(iTrial).(evnts{iEvnt}).duration - 2)/sRate*1000 <= min( trials(iTrial).tMaskOn, trials(iTrial).tResponse ) - trials(iTrial).tTrialStart;
							if( sum(index) == 0 ) continue; end
							x{iTrial,iEvnt}(3,:) = ones(1,sum(index)) * NaN;
							x{iTrial,iEvnt}(1,:) = trials(iTrial).(evnts{iEvnt}).start(index);
							x{iTrial,iEvnt}(2,:) = trials(iTrial).(evnts{iEvnt}).start(index) + trials(iTrial).(evnts{iEvnt}).duration(index) - 1;
							x{iTrial,iEvnt} = reshape( ( x{iTrial,iEvnt} - 1 ) / sRate * 1000 - (trials(iTrial).tPlateauOn - trials(iTrial).tTrialStart), 1, [] );
							y{iTrial,iEvnt} = repmat( [iTrial, iTrial, NaN], 1, sum(index) );
						end
					end

					subplot(1,2,2);
					% plot blinks/sacs/msacs
					colors = {'k', [0.3 0.3 0.3], [0.4 0.4 0.4]};
					for( iEvnt = 1 : 3 )
						xx = [x{:,iEvnt}];
						yy = [y{:,iEvnt}] + nTrials;
						if( isempty(xx) ) continue; end
						h(iEvnt) = plot( xx, yy, 'color', colors{iEvnt}, 'LineWidth', 2, 'DisplayName', evnts{iEvnt} );
						hFlags(iEvnt) = true;
					end

					% plot response
					tResponse = [trials.tResponse] - [trials.tPlateauOn];
					y = (1 : size(trials,2)) + nTrials;
					if( any( [trials.trialType] == 'c' ) )
						h(3) = plot( tResponse( [trials.trialType] == 'c' ), y( [trials.trialType] == 'c' ), '.', 'color', [0 0.5 0], 'MarkerSize', 10, 'DisplayName', 'crct rpt' );
						hFlags(3) = true;
					end
					if( any(  [trials.trialType] == 'e') )
						h(4) = plot( tResponse( [trials.trialType] == 'e' ), y( [trials.trialType] == 'e' ), '.', 'color', 'r', 'MarkerSize', 10, 'DisplayName', 'error rpt' );
						hFlags(4) = true;
					end

					% plot beep
					tBeep = [trials.tBlinkBeepOn] - [trials.tPlateauOn];
					if( ~isempty(tBeep) )
						h(5) = plot( tBeep, y, '.', 'color', 'c', 'MarkerSize', 10, 'DisplayName', 'tBeep' );
						hFlags(5) = true;
					end

					% plot fp on
					tFpOn = [trials.tFpOn] - [trials.tPlateauOn];
					if( ~isempty(tFpOn) )
						h(6) = plot( tFpOn, y, '.', 'color', 'y', 'MarkerSize', 10, 'DisplayName', 'tFp' );
						hFlags(6) = true;
					end

					nTrials = nTrials + size(trials,2) + 5;
					plot( [xlim1 xlim2], [1 1] * (nTrials-2), 'k:', 'LineWidth', 1 );
					text( xlim2, nTrials-2, [txtTags{j+2} ' ' txtTags{i} ], 'color', txtColors{i}, 'FontSize', 14, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle' );

				end
			end

			% Rasters
			subplot(1,2,2);
			if( hFlags(2) ) h(2).DisplayName = 'm/sac'; end
			h = h(hFlags);
			plot( [1 1] * mean( [Trials.tRampOn] - [Trials.tPlateauOn] ), [0 nTrials], 'k--', 'LineWidth', 1 );	% ramp on
			plot( [0 0], [0 nTrials], 'k--', 'LineWidth', 1 );	% ramp off / plateau on
			plot( [1 1] * mean( [Trials.tMaskOn] - [Trials.tPlateauOn] ), [0 nTrials], 'k--', 'LineWidth', 1 );	% mask on
			% plot( -[1 1]*350, [0 nTrials], 'k:', 'LineWidth', 1 );
			set( gca, 'XLim', [xlim1 xlim2], 'YLim', [0 nTrials], 'LineWidth', 1, 'box', 'off', 'FontSize', 20 );
			set( xlabel('Time aligned to Ramp offset (ms)'), 'FontSize', 20);
			set( ylabel('Trial #'), 'FontSize', 20 );
			set( title('Rasters'), 'FontSize', 20 );
			set( legend(h), 'location', 'NorthEastOutside', 'FontSize', 14 );


			%% Panel labels
			set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
			text( 0.1, 0.97, 'A', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );
			text( (0.1+0.5508)/2, 0.97, 'B', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );
			text( 0.1, 0.485, 'C', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );
			text( (0.1+0.5508)/2, 0.485, 'D', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );
			text( 0.5508, 0.97, 'E', 'color', 'k', 'fontsize', 22, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold' );

			h = findall(gcf,'type','axes');
			uistack( h(2:end), 'top' );
			set( h(1), 'layer', 'bottom' );
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

			for( i = 8:-1:1 )
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
						elseif( str2num(list(i).name(1:8)) == 20181005 ) 												% fix dot invisible during stimulus, fix window visible as 4 arcs, instructed to hold eyes still
							rates(5).microsaccades(end+1) = microsaccades;
							rates(5).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181009 ) 												% fix dot invisible during stimulus, fix window visible as 4 arcs, instructed to hold eyes still
							rates(6).microsaccades(end+1) = microsaccades;
							rates(6).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181011 ) 												% fix dot invisible during stimulus, fix window visible as 4 arcs, instructed to hold eyes still
							rates(7).microsaccades(end+1) = microsaccades;
							rates(7).saccades(end+1) = saccades;
						% elseif( str2num(list(i).name(1:8)) == 20181014 ) 												% fix dot invisible during stimulus, fix window visible as 4 arcs, instructed to hold eyes still
						% 	rates(8).microsaccades(end+1) = microsaccades;
						% 	rates(8).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181016 && str2num(list(i).name(10:11)) == 1 )
							rates(1).microsaccades(end+1) = microsaccades;
							rates(1).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181016 && str2num(list(i).name(10:11)) == 2 )
							rates(2).microsaccades(end+1) = microsaccades;
							rates(2).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181018 && str2num(list(i).name(10:11)) == 1 )
							rates(3).microsaccades(end+1) = microsaccades;
							rates(3).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181018 && str2num(list(i).name(10:11)) == 2 )
							rates(4).microsaccades(end+1) = microsaccades;
							rates(4).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181018 && str2num(list(i).name(10:11)) == 3 )
							rates(5).microsaccades(end+1) = microsaccades;
							rates(5).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181018 && str2num(list(i).name(10:11)) == 4 )
							rates(6).microsaccades(end+1) = microsaccades;
							rates(6).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181018 && str2num(list(i).name(10:11)) == 5 )
							rates(7).microsaccades(end+1) = microsaccades;
							rates(7).saccades(end+1) = saccades;
						elseif( str2num(list(i).name(1:8)) == 20181017 && str2num(list(i).name(10:11)) == 6 )
							rates(8).microsaccades(end+1) = microsaccades;
							rates(8).saccades(end+1) = saccades;
						else 												% fix dot invisible during stimulus, fix window visible as 4 arcs, instructed to hold eyes still
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
				colors = {'r', 'y', 'b', 'm', 'c', 'g', [0 0.5 0.5], [0 0.5 0] };
				names = { 'Nothing', 'WithFixDot', 'Dot&4Arcs', 'HoldFixDot', 'Hold4Arcs' };
				names = { 'Nothing', 'WithFixDot', 'Dot&4Arcs', 'HoldFixDot', 'Hold4Arcs1', 'Hold4Arcs2', 'Hold4Arcs3', 'Hold4Arcs4' };
				nConds = 0;
				h = [];
				for( i = 1 : size(names,2) )
					if( isempty(rates(i).microsaccades) ) continue; end
					nConds = nConds + 1;
					data = [rates(i).microsaccades; rates(i).saccades];
					data(3,:) = data(1,:) + data(2,:);
					w = size(names,2);
					h(end+1) = bar( (0:2)*w + nConds, mean(data,2)', 0.95/w, 'FaceColor', colors{i}, 'LineStyle', 'none', 'DisplayName', names{i}, 'FaceAlpha', 1 );
					plot( reshape( [ repmat( (0:2)*w+nConds, 2, 1 ); ones(1,3)*NaN ], 1, [] ), reshape( [std(data,0,2)*[-1,1] + repmat(mean(data,2),1,2), ones(3,1)*NaN]', 1, [] ), 'k', 'LineWidth', 2 );
                end
                h(isnan(h)) = [];
				set( legend(h), 'location', 'NorthWest', 'FontSize', 16 );
				set( gca, 'XLim', [0 2*w+nConds+1], 'XTick', (0:2)*w+nConds/2+0.5, 'XTickLabel', {'microsac', 'sac', 'overall'}, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				ylabel( 'Rates (Hz)' );
				title( [ sbjFolder(end-3:end), ' (', period, ')' ] );
			end
		end


		function EIS2Mat( folder, sRate, has2Tones, reverse2Tones )
			if( nargin() < 2 || isempty(sRate) ) sRate = 1000; end
			if( nargin() < 3 || isempty(has2Tones) ) has2Tones = false; end 	% whether low tone for no blink and high tone for blink
			if( nargin() < 4 || isempty(reverse2Tones) ) reverse2Tones = false; end

			if( folder(end) == '\' || folder(end) == '/' ) folder(end) = []; end
			fprintf('%s\n', folder);
			if( size(folder,2) > 10 && strcmpi( folder(end-10:end), 'calibration' ) ) return; end
			
			if(0&& exist( [folder,'/Trials.mat'], 'file' ) == 2 )%&& isempty(strfind(folder,'DDPI')) )
				return;
				load( [folder, '/Trials.mat'] );
				if( ~isfield( Trials, 'sRate' ) )
					[Trials.sRate] = deal(sRate);
					% save( [ folder, '/', 'Trials.mat' ], 'Trials' );
				end
				if( ~isfield( Trials, 'beepFreq' ) )
					[Trials.beepFreq] = deal(4000);
				end
				Trials = orderfields(Trials);
				save( [ folder, '/', 'Trials.mat' ], 'Trials' );
			% else
			end
			if( exist( [folder,'/Trials.mat'], 'file' ) == 2 )
				% delete( [folder,'/Trials.mat'] );
				return;
			end
			% return;

			eisFNs = dir( [folder, '/*.eis'] );
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
				if(has2Tones) usrVars{end+1} = 'beepFreq'; end
				for( i = 1 : size(usrVars,2) )
					list = eis_readData(list, 'uservar', usrVars{i} );
				end
				data = eis_eisdir2mat(folder,list);

				for( iTrial = size(data.user,1) : -1 : 1 )
					trial = createTrial( iTrial, data.x{iTrial}, data.y{iTrial}, data.triggers{iTrial}.blink, data.triggers{iTrial}.notrack, ones(1,size(data.x{iTrial},2)), [], sRate );
					% trial = createTrial( iTrial, [], [], [], [], 0 );
					trial.notracks.start( trial.notracks.duration / sRate * 1000 < 5 ) = [];
					trial.notracks.duration( trial.notracks.duration / sRate * 1000 < 5 ) = [];
					trial = findSaccades( trial, 'minvel', 180, 'minsa', 30 );	% min arc
					trial = findMicrosaccades( trial, 'minvel', 180, 'minmsa', 3, 'maxmsa', 30 );	% min arc
			  		trial = findDrifts(trial);

			  		% conbine blinks with interval shorter than 15ms
		  			iBlink = 1;
		  			while( iBlink < size(trial.blinks.start,2) )
		  				if( ( trial.blinks.start(iBlink+1) - ( trial.blinks.start(iBlink) + trial.blinks.duration(iBlink)-1 ) ) / sRate * 1000 < 15 )
		  					trial.blinks.duration(iBlink) = trial.blinks.start(iBlink+1) + trial.blinks.duration(iBlink+1) - trial.blinks.start(iBlink);
		  					trial.blinks.start(iBlink+1) = [];
		  					trial.blinks.duration(iBlink+1) = [];
		  				else
		  					iBlink = iBlink + 1;
		  				end
		  			end

		  			% remove blinks with duration shorter than 15ms
			  		trial.blinks.start( trial.blinks.duration < 15/1000*sRate ) = [];
			  		trial.blinks.duration( trial.blinks.duration < 15/1000*sRate ) = [];

			  		if( ~isempty( strfind( folder, 'DDPI' ) ) )
			  			% mearge notracks right before & after a blink into that blink
			  			blinks = trial.blinks;
				  		notracks = trial.notracks;
				  		for( iBlink = 1 : size(trial.blinks.start,2) )
				  			for( iNotrack = 1 : size(trial.notracks.start,2) )
				  				dif1 = ( trial.blinks.start(iBlink) - ( trial.notracks.start(iNotrack) + trial.notracks.duration(iNotrack)-1 ) ) / sRate * 1000;
				  				if( 0 < dif1 && dif1 < 50 )
				  					blinks.start(iBlink) = trial.notracks.start(iNotrack);
				  					blinks.duration(iBlink) = trial.blinks.start(iBlink) + trial.blinks.duration(iBlink) - trial.notracks.start(iNotrack);
				  					notracks.start(iNotrack) = NaN;
				  				end
				  				dif2 = ( trial.notracks.start(iNotrack) - ( trial.blinks.start(iBlink) + trial.blinks.duration(iBlink)-1 ) ) / sRate * 1000;
				  				if(0 < dif2 && dif2 < 50 )
				  					blinks.duration(iBlink) = trial.notracks.start(iNotrack) + trial.notracks.duration(iNotrack) - trial.blinks.start(iBlink);
				  					notracks.start(iNotrack) = NaN;
				  				end
				  			end
				  		end
				  		trial.blinks = blinks;
			  			notracks.duration( isnan( notracks.start ) ) = [];
			  			notracks.start( isnan( notracks.start ) ) = [];
			  			trial.notracks = notracks;
				  	end

				  	% conbine blinks with intervals shorter than 15ms
		  			iBlink = 1;
		  			while( iBlink < size(trial.blinks.start,2) )
		  				if( ( trial.blinks.start(iBlink+1) - ( trial.blinks.start(iBlink) + trial.blinks.duration(iBlink)-1 ) ) / sRate * 1000 < 15 )
		  					trial.blinks.duration(iBlink) = trial.blinks.start(iBlink+1) + trial.blinks.duration(iBlink+1) - trial.blinks.start(iBlink);
		  					trial.blinks.start(iBlink+1) = [];
		  					trial.blinks.duration(iBlink+1) = [];
		  				else
		  					iBlink = iBlink + 1;
		  				end
		  			end


			    	trial.evntRenderTimes = data.stream00{iTrial};
			    	trial.evntRenderIFrames = data.stream01{iTrial};
			    	% trial.postSwapTimes = data.stream02{iTrial};
			    	% trial.postSwapIFrames = data.stream03{iTrial};

			    	varNames = fieldnames(data.user{iTrial});
				    for i = 1 : size(varNames,1)
				        trial.(varNames{i}) = data.user{iTrial}.(varNames{i});
				    end

				    trial.trialType = char(trial.trialType);

				    if(~has2Tones) trial.beepFreq = 4000; end
				    if( has2Tones && reverse2Tones ) trial.beepFreq = 6000 - trial.beepFreq; end

				    Trials(iTrial) = trial;
				end 

				Trials = orderfields(Trials);
				save( [ folder, '/', 'Trials.mat' ], 'Trials' );
				% delete( [ folder, '/', folder( find( folder == '/' | folder == '\', 1, 'last' ) + 1 : end ), '.mat' ] );
			end

			subfolders = ToolKit.ListFolders(folder);
			for( iFolder = 1 : size(subfolders,1) )
				BlinkTransient.EIS2Mat( ToolKit.RMEndSpaces( subfolders(iFolder,:) ), sRate, has2Tones, reverse2Tones );
			end
		end


		function EIS2Mat_Simulated( folder, sRate )
			if( nargin() < 2 || isempty(sRate) ) sRate = 1000; end

			if( folder(end) == '\' || folder(end) == '/' ) folder(end) = []; end
			fprintf('%s\n', folder);
			if( size(folder,2) > 10 && strcmpi( folder(end-10:end), 'calibration' ) ) return; end
			
			if( 0&& exist( [folder,'/Trials.mat'], 'file' ) == 2 )%&& isempty(strfind(folder,'DDPI')) )
				delete( [folder,'/Trials.mat'] );
				% return;
				load( [folder, '/Trials.mat'] );
				if( ~isfield( Trials, 'sRate' ) )
					[Trials.sRate] = deal(sRate);
					% save( [ folder, '/', 'Trials.mat' ], 'Trials' );
				end
				Trials = orderfields(Trials);
				save( [ folder, '/', 'Trials.mat' ], 'Trials' );
			else
				delete( [folder,'/Trials.mat'] );
				% return;
			end
			% return;

			eisFNs = dir( [folder, '/*.eis'] );
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
							'tSimBlinkOn',...
							'tSimBlinkOff',...
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
					trial = createTrial( iTrial, data.x{iTrial}, data.y{iTrial}, data.triggers{iTrial}.blink, data.triggers{iTrial}.notrack, ones(1,size(data.x{iTrial},2)), [], sRate );
					% trial = createTrial( iTrial, [], [], [], [], 0 );
					trial.notracks.start( trial.notracks.duration / sRate * 1000 < 5 ) = [];
					trial.notracks.duration( trial.notracks.duration / sRate * 1000 < 5 ) = [];
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

				index = false(1,size(data.user,1));
				for( iTrial = 1 : size(Trials,2) )
					Trials(iTrial).tSimBlinkOn = double( Trials(iTrial).tSimBlinkOn );
					Trials(iTrial).tSimBlinkOff = double( Trials(iTrial).tSimBlinkOff );
					blinks = Trials(iTrial).blinks;
			  		if( Trials(iTrial).tSimBlinkOn > Trials(iTrial).tPlateauOn ||...
			  			any( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart < (blinks.start + blinks.duration-2) / Trials(iTrial).sRate*1000 & (blinks.start-1) / Trials(iTrial).sRate * 1000 < Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart ) )
			  			index(iTrial) = true;
			  			continue;
			  		end
			  		if( Trials(iTrial).tSimBlinkOn > 0 )
				  		Trials(iTrial).tBlinkBeepOn = Trials(iTrial).tRampOn + 500;
				  		Trials(iTrial).blinks.start = [Trials(iTrial).blinks.start, round( (Trials(iTrial).tSimBlinkOn - Trials(iTrial).tTrialStart) / 1000 * Trials(iTrial).sRate + 1 ) ];
				  		Trials(iTrial).blinks.duration = [Trials(iTrial).blinks.duration, round( ( Trials(iTrial).tSimBlinkOff - Trials(iTrial).tSimBlinkOn ) / 1000 * Trials(iTrial).sRate ) ];
				  		[~,I] = sort( Trials(iTrial).blinks.start );
				  		Trials(iTrial).blinks.start = Trials(iTrial).blinks.start(I);
				  		Trials(iTrial).blinks.duration = Trials(iTrial).blinks.duration(I);
				  	else
				  		Trials(iTrial).tBlinkBeepOn = Trials(iTrial).tRampOn - 700;
				  		Trials(iTrial).blinks.start = [Trials(iTrial).blinks.start, round( (Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart + 300) / 1000 * Trials(iTrial).sRate + 1 ) ];
				  		Trials(iTrial).blinks.duration = [Trials(iTrial).blinks.duration, round( 150 / 1000 * Trials(iTrial).sRate ) ];
				  		[~,I] = sort( Trials(iTrial).blinks.start );
				  		Trials(iTrial).blinks.start = Trials(iTrial).blinks.start(I);
				  		Trials(iTrial).blinks.duration = Trials(iTrial).blinks.duration(I);
				  	end
				end
				Trials(index) = [];

				Trials = orderfields(Trials);
				save( [ folder, '/', 'Trials.mat' ], 'Trials' );
				% delete( [ folder, '/', folder( find( folder == '/' | folder == '\', 1, 'last' ) + 1 : end ), '.mat' ] );
			end

			subfolders = ToolKit.ListFolders(folder);
			for( iFolder = 1 : size(subfolders,1) )
				BlinkTransient.EIS2Mat_Simulated( ToolKit.RMEndSpaces( subfolders(iFolder,:) ), sRate );
			end
		end


		function EIS2Mat_SimulatedV2( folder, sRate )
			if( nargin() < 2 || isempty(sRate) ) sRate = 1000; end

			if( folder(end) == '\' || folder(end) == '/' ) folder(end) = []; end
			fprintf('%s\n', folder);
			if( size(folder,2) > 10 && strcmpi( folder(end-10:end), 'calibration' ) ) return; end
			
			if( exist( [folder,'/Trials.mat'], 'file' ) == 2 )%&& isempty(strfind(folder,'DDPI')) )
				delete( [folder,'/Trials.mat'] );
				return;
				load( [folder, '/Trials.mat'] );
				if( ~isfield( Trials, 'sRate' ) )
					[Trials.sRate] = deal(sRate);
					% save( [ folder, '/', 'Trials.mat' ], 'Trials' );
				end
				Trials = orderfields(Trials);
				save( [ folder, '/', 'Trials.mat' ], 'Trials' );
			else
				delete( [folder,'/Trials.mat'] );
				% return;
			end
			% return;

			eisFNs = dir( [folder, '/*.eis'] );
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
							'tSimBlinkOn',...
							'tSimBlinkOff',...
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
					trial = createTrial( iTrial, data.x{iTrial}, data.y{iTrial}, data.triggers{iTrial}.blink, data.triggers{iTrial}.notrack, ones(1,size(data.x{iTrial},2)), [], sRate );
					% trial = createTrial( iTrial, [], [], [], [], 0 );
					trial.notracks.start( trial.notracks.duration / sRate * 1000 < 5 ) = [];
					trial.notracks.duration( trial.notracks.duration / sRate * 1000 < 5 ) = [];
					trial = findSaccades( trial, 'minvel', 180, 'minsa', 30 );	% min arc
					trial = findMicrosaccades( trial, 'minvel', 300, 'minmsa', 3, 'maxmsa', 30 );	% min arc
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

				index = false(1,size(data.user,1));
				for( iTrial = 1 : size(Trials,2) )
					Trials(iTrial).tSimBlinkOn = double( Trials(iTrial).tSimBlinkOn );
					Trials(iTrial).tSimBlinkOff = double( Trials(iTrial).tSimBlinkOff );
					blinks = Trials(iTrial).blinks;
			  		if( Trials(iTrial).tSimBlinkOn > Trials(iTrial).tPlateauOn ||...
			  			any( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart < (blinks.start + blinks.duration-2) / Trials(iTrial).sRate*1000 & (blinks.start-1) / Trials(iTrial).sRate * 1000 < Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart ) )
			  			index(iTrial) = true;
			  			continue;
			  		end
			  		Trials(iTrial).blinks.start = [Trials(iTrial).blinks.start, round( (Trials(iTrial).tSimBlinkOn - Trials(iTrial).tTrialStart) / 1000 * Trials(iTrial).sRate + 1 ) ];
			  		Trials(iTrial).blinks.duration = [Trials(iTrial).blinks.duration, round( ( Trials(iTrial).tSimBlinkOff - Trials(iTrial).tSimBlinkOn ) / 1000 * Trials(iTrial).sRate ) ];
			  		[~,I] = sort( Trials(iTrial).blinks.start );
			  		Trials(iTrial).blinks.start = Trials(iTrial).blinks.start(I);
			  		Trials(iTrial).blinks.duration = Trials(iTrial).blinks.duration(I);
				end
				Trials(index) = [];

				Trials = orderfields(Trials);
				save( [ folder, '/', 'Trials.mat' ], 'Trials' );
				% delete( [ folder, '/', folder( find( folder == '/' | folder == '\', 1, 'last' ) + 1 : end ), '.mat' ] );
			end

			subfolders = ToolKit.ListFolders(folder);
			for( iFolder = 1 : size(subfolders,1) )
				BlinkTransient.EIS2Mat_SimulatedV2( ToolKit.RMEndSpaces( subfolders(iFolder,:) ), sRate );
			end
		end


		function [Trials, ratio, indices] = ETScreen(Trials)
			%% Screen the quality of eye traces and exclude trials with bad eye traces
			%  ratio:	proportion of trials remained
			for( iTrial = size(Trials,2) : -1 : 1 )
				notracks = Trials(iTrial).notracks;
				% notracks.start( notracks.duration / Trials(iTrial).sRate * 1000 < 15 ) = [];
				% notracks.duration( notracks.duration / Trials(iTrial).sRate * 1000 < 15 ) = [];
				index(iTrial) = sum( max( 0, ...
					min( (notracks.start+notracks.duration-1)/Trials(iTrial).sRate*1000, Trials(iTrial).tMaskOn-Trials(iTrial).tTrialStart ) - ...
						max( (notracks.start-1)/Trials(iTrial).sRate*1000, Trials(iTrial).tRampOn-Trials(iTrial).tTrialStart ) ) ) < 15;
			end
			Trials = Trials(index);
			ratio = sum(index) / size(index,2);
			indices = find(index);
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
				if( isfield( VT, 'sRate' ) )
					sRate = VT(1).sRate;
				else
					sRate = 1000;
				end

				tAlignEvent = 'tRampOn';
				% tAlignEvent = 'tPlateauOn';
				tStart = 0;%-1500;	% start time relative to tAlignEvent

				% tirals only with drifts
				Data4Blinks(iFolder).sessionName = subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end );
				Data4Blinks(iFolder).trialsWithoutBlink = VT;
				index = false(size(VT));
				for( i = 1 : size(VT,2) )
					if( ~isempty( VT(i).blinks.start ) &&  any( VT(i).tRampOn - VT(i).tTrialStart <= ( VT(i).blinks.start + VT(i).blinks.duration - 2 ) / sRate * 1000 & (VT(i).blinks.start-1)/sRate*1000 <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						...%~isempty( VT(i).notracks.start ) &&  any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= ( VT(i).notracks.start + VT(i).notracks.duration - 2 ) / sRate * 1000 & (VT(i).notracks.start-1)/sRate*1000 <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						discardSaccades && ~isempty( VT(i).saccades.start ) && any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= ( VT(i).saccades.start + VT(i).saccades.duration - 2 ) / sRate * 1000 & (VT(i).saccades.start-1)/sRate*1000 <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						discardMicrosaccades && ~isempty( VT(i).microsaccades.start ) && any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= ( VT(i).microsaccades.start + VT(i).microsaccades.duration - 2 ) /sRate * 1000 & (VT(i).microsaccades.start-1)/sRate*1000 <= VT(i).tMaskOn - VT(i).tTrialStart ) )
						index(i) = 1;
					end
				end
				Data4Blinks(iFolder).trialsWithoutBlink(index) = [];

				% trials only with blinks
				Data4Blinks(iFolder).trialsWithBlink = VT;
				index = false(size(VT));
				for( i = 1 : size(VT,2) )
					if( isempty( VT(i).blinks.start ) ||...
						...%all( VT(i).tPlateauOn + tStart - VT(i).tTrialStart > ( VT(i).blinks.start + VT(i).blinks.duration - 2 ) /sRate * 1000 | (VT(i).blinks.start-1)/sRate*1000 > VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						all( VT(i).tRampOn + 0 - VT(i).tTrialStart > ( VT(i).blinks.start -1 ) /sRate * 1000 | (VT(i).blinks.start + VT(i).blinks.duration - 2)/sRate*1000 + 300 > VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						...%~isempty( VT(i).notracks.start ) &&  any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= ( VT(i).notracks.start + VT(i).notracks.duration - 2 ) / sRate * 1000 & (VT(i).notracks.start-1)/sRate*1000 <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						discardSaccades && ~isempty( VT(i).saccades.start ) && any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= ( VT(i).saccades.start + VT(i).saccades.duration - 2 ) /sRate * 1000 & (VT(i).saccades.start-1)/sRate*1000 <= VT(i).tMaskOn - VT(i).tTrialStart ) ||...
						discardMicrosaccades && ~isempty( VT(i).microsaccades.start ) && any( VT(i).(tAlignEvent) + tStart - VT(i).tTrialStart <= ( VT(i).microsaccades.start + VT(i).microsaccades.duration - 2 ) /sRate * 1000 & (VT(i).microsaccades.start-1)/sRate*1000 <= VT(i).tMaskOn - VT(i).tTrialStart ) )
						index(i) = 1;
					end
				end
				Data4Blinks(iFolder).trialsWithBlink(index) = [];
				Data4Blinks(iFolder).discardMicrosaccades = discardMicrosaccades;
				Data4Blinks(iFolder).discardSaccades = discardSaccades;
			end
			save( [folder,'/Data4Blinks.mat'], 'Data4Blinks' );
		end

		function LabeledData4Blinks = GetLabeledTrials4Blinks( folder, tAlignEvent, tOffset, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink )
			%% tAlignEvent:			hasMicrosac/hasSac is true oly if a microsaccade/saccade happens after the event specified by tAlignEvent
			%  tOffset:				offset regarding tAlignEvent
			%  tLBEvent4Blink:		hasBlink is true only if a blink happens after tLBEvent4Blink
			%  tLBOffset4Blink:		offset regarding tLBEvent4Blink
			%  tUBOffset4Blink:		offset regarding upper bound for hasBlink

			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			if( nargin() < 2 || isempty(tAlignEvent) ) tAlignEvent = 'tRampOn'; end 	% start event for microsaccades/saccades control analysis
			if( nargin() < 3 || isempty(tOffset) ) tOffset = 0; end 						% time offset for microsaccades/saccades control analysis (relative to tAlignEvent)
			if( nargin() < 4 || isempty(tLBEvent4Blink) ) tLBEvent4Blink = 'tRampOn'; end
			if( nargin() < 5 || isempty(tLBOffset4Blink) ) tLBOffset4Blink = 1000; end
			if( nargin() < 6 || isempty(tUBOffset4Blink) ) tUBOffset4Blink = -300; end

			LabeledData4Blinks = [];
			if( exist( [folder,'/LabeledData4Blinks.mat'], 'file' ) == 2 )	delete( [folder,'/LabeledData4Blinks.mat'] ); end
			subfolders = ToolKit.ListFolders(folder);
			index =  false( size(subfolders,1), 1 ) ;
			for( iFolder = 1 : size(subfolders,1) )
				if( strcmp( subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + (1:3) ), 'X. ' ) ) index(iFolder) = 1; end
			end
			subfolders(index,:) = [];

			for( iFolder = size(subfolders,1) : -1 : 1 )
				LabeledData4Blinks(iFolder).sessionName = subfolders( iFolder, find( subfolders(iFolder,:) == '/' | subfolders(iFolder,:) == '\', 1, 'last' ) + 1 : end );
				load( [ ToolKit.RMEndSpaces(subfolders(iFolder,:)), '/Trials.mat' ], 'Trials' );
				LabeledData4Blinks(iFolder).trials = Trials( [Trials.trialType] == 'c' | [Trials.trialType] == 'e' );
				if( isfield( Trials, 'sRate' ) )
					sRate = Trials(1).sRate;
				else
					sRate = 1000;
				end

				for( iTrial = 1 : size( LabeledData4Blinks(iFolder).trials, 2 ) )
					
					if( LabeledData4Blinks(iFolder).trials(iTrial).tResponse < LabeledData4Blinks(iFolder).trials(iTrial).tMaskOn )
						tUpper = LabeledData4Blinks(iFolder).trials(iTrial).tResponse - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart;
					else
						tUpper = LabeledData4Blinks(iFolder).trials(iTrial).tMaskOn - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart;
					end

					if( any( ( LabeledData4Blinks(iFolder).trials(iTrial).blinks.start ) /sRate * 1000 > LabeledData4Blinks(iFolder).trials(iTrial).tBlinkBeepOn - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart ) &&...
						( isempty( LabeledData4Blinks(iFolder).trials(iTrial).blinks.start ) ||...
						all( LabeledData4Blinks(iFolder).trials(iTrial).tRampOn - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart > ( LabeledData4Blinks(iFolder).trials(iTrial).blinks.start + LabeledData4Blinks(iFolder).trials(iTrial).blinks.duration - 2 ) / sRate * 1000 |...
						    (LabeledData4Blinks(iFolder).trials(iTrial).blinks.start-1)/sRate*1000 > tUpper ) ) )
						% no blink overlaps with ramp+plateau
						LabeledData4Blinks(iFolder).trials(iTrial).hasBlink = false;
					
					elseif( any( ( LabeledData4Blinks(iFolder).trials(iTrial).blinks.start ) /sRate * 1000 > LabeledData4Blinks(iFolder).trials(iTrial).tBlinkBeepOn - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart ) &&...
							~isempty( LabeledData4Blinks(iFolder).trials(iTrial).blinks.start ) &&...
							sum( ( LabeledData4Blinks(iFolder).trials(iTrial).blinks.start -1 ) /sRate * 1000 > LabeledData4Blinks(iFolder).trials(iTrial).tFpOn - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart & (LabeledData4Blinks(iFolder).trials(iTrial).blinks.start + LabeledData4Blinks(iFolder).trials(iTrial).blinks.duration - 2)/sRate*1000 < tUpper ) == 1 &&...
							any( LabeledData4Blinks(iFolder).trials(iTrial).(tLBEvent4Blink) + tLBOffset4Blink - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart <= ( LabeledData4Blinks(iFolder).trials(iTrial).blinks.start -1 ) /sRate * 1000 &...
							    (LabeledData4Blinks(iFolder).trials(iTrial).blinks.start + LabeledData4Blinks(iFolder).trials(iTrial).blinks.duration - 2)/sRate*1000 <= tUpper + tUBOffset4Blink ) )
						% start 1000ms after ramp on, end 300ms before mask on
						LabeledData4Blinks(iFolder).trials(iTrial).hasBlink = true;

					else
						% cross stimulus boundary
						LabeledData4Blinks(iFolder).trials(iTrial).hasBlink = NaN;
					end

					
					if( isempty( LabeledData4Blinks(iFolder).trials(iTrial).microsaccades.start ) ||...
						all( LabeledData4Blinks(iFolder).trials(iTrial).('tRampOn') + 0 - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart > ( LabeledData4Blinks(iFolder).trials(iTrial).microsaccades.start + LabeledData4Blinks(iFolder).trials(iTrial).microsaccades.duration - 2 ) /sRate*1000 |...
						   ( LabeledData4Blinks(iFolder).trials(iTrial).microsaccades.start - 1 ) /sRate*1000 > tUpper ) )
						% no microsaccade overlaps with the observing time window
						LabeledData4Blinks(iFolder).trials(iTrial).hasMicrosac = false;
					
					elseif( ~isempty( LabeledData4Blinks(iFolder).trials(iTrial).microsaccades.start ) &&...
						any( LabeledData4Blinks(iFolder).trials(iTrial).(tAlignEvent) + tOffset - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart <= ( LabeledData4Blinks(iFolder).trials(iTrial).microsaccades.start - 1 ) /sRate*1000 &...
						   ( LabeledData4Blinks(iFolder).trials(iTrial).microsaccades.start + LabeledData4Blinks(iFolder).trials(iTrial).microsaccades.duration - 2 ) /sRate*1000 <= tUpper ) )
						% start after tAlignEvent+tOffset, end before mask on
						LabeledData4Blinks(iFolder).trials(iTrial).hasMicrosac = true;

					else
						% cross time window boundary
						LabeledData4Blinks(iFolder).trials(iTrial).hasMicrosac = NaN;
					end


					if( isempty( LabeledData4Blinks(iFolder).trials(iTrial).saccades.start ) ||...
						all( LabeledData4Blinks(iFolder).trials(iTrial).('tRampOn') + 0 - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart > ( LabeledData4Blinks(iFolder).trials(iTrial).saccades.start + LabeledData4Blinks(iFolder).trials(iTrial).saccades.duration - 2 ) /sRate*1000 |...
						   ( LabeledData4Blinks(iFolder).trials(iTrial).saccades.start - 1 ) /sRate*1000 > tUpper ) )
						% no microsaccade overlaps with the observing time window
						LabeledData4Blinks(iFolder).trials(iTrial).hasSac = false;
					
					elseif( ~isempty( LabeledData4Blinks(iFolder).trials(iTrial).saccades.start ) &&...
						any( LabeledData4Blinks(iFolder).trials(iTrial).(tAlignEvent) + tOffset - LabeledData4Blinks(iFolder).trials(iTrial).tTrialStart <= ( LabeledData4Blinks(iFolder).trials(iTrial).saccades.start - 1 ) /sRate*1000 &...
						   ( LabeledData4Blinks(iFolder).trials(iTrial).saccades.start + LabeledData4Blinks(iFolder).trials(iTrial).saccades.duration - 2 ) /sRate*1000 <= tUpper ) )
						% start after tAlignEvent+tOffset, end before mask on
						LabeledData4Blinks(iFolder).trials(iTrial).hasSac = true;

					else
						% cross time window boundary
						LabeledData4Blinks(iFolder).trials(iTrial).hasSac = NaN;
					end

				end

				LabeledData4Blinks(iFolder).trials( isnan( [LabeledData4Blinks(iFolder).trials.hasBlink] ) | isnan( [LabeledData4Blinks(iFolder).trials.hasMicrosac] ) | isnan( [LabeledData4Blinks(iFolder).trials.hasSac] ) ) = [];
			end

			save( [folder,'/LabeledData4Blinks.mat'], 'LabeledData4Blinks' );
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

			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end

			Data4Blinks = BlinkTransient.GetData4Blinks( folder, discardMicrosaccades, discardSaccades );
			if( isempty(Data4Blinks) ) return; end
			if( nargin() < 2 ) groups = mat2cell( 1:size(Data4Blinks,2), 1, ones(size(Data4Blinks)) ); end

			for( iGroup = size(groups,2) : -1 : 1 )
				data(iGroup).sessionName = sprintf( '%s | ', Data4Blinks(groups{iGroup}).sessionName );
				data(iGroup).sessionName(end-2:end) = [];
				data(iGroup).trialsWithBlink = [Data4Blinks(groups{iGroup}).trialsWithBlink];
				data(iGroup).trialsWithoutBlink = [Data4Blinks(groups{iGroup}).trialsWithoutBlink];
			end

			set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Blink VS No Blink', folder( find( folder == '\' | folder == '/', 1, 'last' ) + 1 : end ) ), 'color', 'w' );
			nCols = ceil( sqrt( size(data,2) ) );
			nRows = ceil( size(data,2) / nCols );
			for( iGroup = 1 : size(data,2) )
				trials{2} = data(iGroup).trialsWithoutBlink;	% tirals only with drifts
				trials{2}( [trials{2}.gaborAmp] < lowestAmp ) = [];
				trials{1} = data(iGroup).trialsWithBlink;		% trials only with blinks
				trials{1}( [trials{1}.gaborAmp] < lowestAmp ) = [];
				if(noCompare) trials = {[trials{:}]}; end
				if( isempty(trials{1}) || ~noCompare && isempty(trials{2}) ) continue; end

				bgnLuminance = double(trials{1}(1).bgnLuminance);

				% subplot( nRows, nCols, iGroup );
				hold on;
				colors = {'r', 'b'};
				names = {'b', 'nb'};%{ 'blink', 'no blink' };
				hAligns = { 'left', 'right' };	% horizontal alignments
				if(noCompare)
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
					% contrasts = BlinkTransient.Intensity2Luminance( [trials{j}.gaborAmp] + bgnLuminance ) / BlinkTransient.Intensity2Luminance(bgnLuminance) - 1;
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
					[~, ~, nThresh(j,:), nPar, g(j), chisq(j)] = psyfit( contrasts, [trials{j}.trialType] == 'c', 'Thresh', 0.75, 'Chance', 0.5, 'Lapses', 0, 'Log', 'Extra', 'PlotOff', 'Boots', 20 );
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
					% set( fill( [x x(end:-1:1)], [yLow yUp(end:-1:1)], colors{j} ), 'LineStyle', 'none', 'FaceAlpha', 0.5 );
					plot( [1, 1] * thresh, [0, 0.75], '--', 'color', colors{j} );
					% set( fill( [-1, 1, 1, -1]*semThresh + thresh, [0, 0, 0.75, 0.75], colors{j} ), 'LineStyle', 'none', 'FaceAlpha', 0.5 );
				end
				set( legend(h), 'location', 'Southeast', 'FontSize', 12 );
				xlabel('Contrast');
				ylabel('Correct rate');
				% set( gca, 'XLim', [0, 0.008], 'YLim', [0 1], 'FontSize', 20 );
				set( gca, 'XLim', [0, 3], 'YLim', [0 1], 'FontSize', 20 );
				set( gca, 'XLim', [0, 0.15], 'YLim', [0 1], 'FontSize', 20 );
				set( gca, 'XLim', [0, 0.08], 'YLim', [0 1], 'FontSize', 20 );
				x = get( gca, 'XLim' );
				for( j = size(trials,2) : -1 : 1 )
					if( ~isempty(names{j}) ) names{j} = [names{j}, ': ']; end
					% text( x(2), 0.1*j, sprintf( '%sgof = %.3f, chisq = %.3f', names{j}, g(j), chisq(j) ), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 20 );
				end
				if( ~noCompare )
					% text( x(2), 0, sprintf( 'p = %.3f', ranksum( nThresh(1,:), nThresh(2,:), 'tail', 'both' ) ), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 20 );
				end
				title( data(iGroup).sessionName, 'FontSize', 12, 'Interpreter', 'none' );
			end
		end


		function SigTest( folder, groups, discardMicrosaccades, discardSaccades, contrastBin, isOverLap, lowestAmp, method, isNewFigure )
			%% groups:					cell array, each element defines the indices of one data group
			%  discardMicrosaccades:	whether discard microsaccades (<30 arc mins); true by default
			%  discardSaccades:			whether discard saccades (>30 arc mins); true by default
			%  contrastBin:				bin size when binning data; 0 by default
			%  isOverLap:				whether contrast bins overlap with each other; false by default
			%  lowestAmp:				lowest gabor amplitude to include in analysis

			if( nargin() < 3 || isempty(discardMicrosaccades) ) discardMicrosaccades = true; end
			if( nargin() < 4 || isempty(discardSaccades) ) discardSaccades = true; end
			if( nargin() < 5 || isempty(contrastBin) ) contrastBin = 0; end
			if( nargin() < 6 || isempty(isOverLap) ) isOverLap = false; end
			if( nargin() < 7 || isempty(lowestAmp) ) lowestAmp = 0; end
			if( nargin() < 8 || isempty(method) ) method = 'ttest'; end
			if( nargin() < 9 || isempty(isNewFigure) ) isNewFigure = true; end

			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			groupsStr = groups;
			groups = eval( [ '{', groups '}' ] );

			Data4Blinks = BlinkTransient.GetData4Blinks( folder, discardMicrosaccades, discardSaccades );
			if( isempty(Data4Blinks) ) return; end
			if( nargin() < 2 ) groups = mat2cell( 1:size(Data4Blinks,2), 1, ones(size(Data4Blinks)) ); end

			for( iGroup = size(groups,2) : -1 : 1 )
				data(iGroup).sessionName = sprintf( '%s | ', Data4Blinks(groups{iGroup}).sessionName );
				data(iGroup).sessionName(end-2:end) = [];
				data(iGroup).trialsWithBlink = [Data4Blinks(groups{iGroup}).trialsWithBlink];
				data(iGroup).trialsWithoutBlink = [Data4Blinks(groups{iGroup}).trialsWithoutBlink];
			end

			if(isNewFigure)
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: %s', folder( find( folder == '\' | folder == '/', 1, 'last' ) + 1 : end ), groupsStr ), 'color', 'w' );
			end

			points = [];

			for( iGroup = 1 : size(data,2) )
				trials{2} = data(iGroup).trialsWithoutBlink;	% tirals only with drifts
				trials{2}( [trials{2}.gaborAmp] < lowestAmp ) = [];
				trials{1} = data(iGroup).trialsWithBlink;		% trials only with blinks
				trials{1}( [trials{1}.gaborAmp] < lowestAmp ) = [];
				if( isempty(trials{1}) || isempty(trials{2}) ) continue; end

				bgnLuminance = double(trials{1}(1).bgnLuminance);

				for( j = size(trials,2):-1:1 )
					contrasts = [trials{j}.gaborAmp];
					contrasts = BlinkTransient.Intensity2Luminance( [trials{j}.gaborAmp] + bgnLuminance ) / BlinkTransient.Intensity2Luminance(bgnLuminance) - 1;
					uniConts = unique(contrasts);
					tmpPoints(j).contrasts = uniConts;
					tmpPoints(j).crctRates = zeros(size(uniConts));
					tmpPoints(j).nTrials = 0;
					for( iUni = size(uniConts,2) : -1 : 1 )
						tmpPoints(j).nTrials(iUni) = sum( contrasts == uniConts(iUni) );
						tmpPoints(j).crctRates(iUni) = sum( [trials{j}( contrasts == uniConts(iUni) ).trialType] == 'c' ) / tmpPoints(j).nTrials(iUni);
					end
				end

				if( contrastBin == 0 || isOverLap )
					contrasts = unique( [tmpPoints.contrasts] );
					for( iCont = 1 : size(contrasts,2) )
						x = find( contrasts(iCont) - contrastBin/2 <= tmpPoints(1).contrasts & tmpPoints(1).contrasts <= contrasts(iCont) + contrastBin/2 );
						y = find(  contrasts(iCont) - contrastBin/2 <= tmpPoints(2).contrasts & tmpPoints(2).contrasts <= contrasts(iCont) + contrastBin/2 );
						if( ~isempty(x) && ~isempty(y) )
							points(1,end+1).contrast = contrasts(iCont);
							points(1,end).nTrials = sum( tmpPoints(1).nTrials(x) );
							points(1,end).crctRate = tmpPoints(1).crctRates(x) * tmpPoints(1).nTrials(x)' / points(1,end).nTrials;
							points(2,end).contrast = contrasts(iCont);
							points(2,end).nTrials = sum( tmpPoints(2).nTrials(y) );
							points(2,end).crctRate = tmpPoints(2).crctRates(y) * tmpPoints(2).nTrials(y)' / points(2,end).nTrials;
						end
					end
				end

			end

			if(isempty(points)) return; end

			hold on;
			h = [];
			index = false( 1, size(points,2) );
			for( i = 1 : size(points,2) )	% ztest
				P = ( points(1,i).crctRate * points(1,i).nTrials + points(2,i).crctRate * points(2,i).nTrials ) / sum( [points(:,i).nTrials] );
				sd = sqrt( P * (1-P) * ( 1/points(1,i).nTrials + 1/points(2,i).nTrials ) );
				if( sd > 0 && ( 1 - normcdf( abs( diff([points(:,i).crctRate]) ), 0, sd ) ) * 2 <= 0.05 ) index(i) = true; end
			end
			index1 = [points(1,:).nTrials] < 4 | [points(2,:).nTrials] < 4; 
			index2 = [points(1,:).nTrials] < 8 | [points(2,:).nTrials] < 8;
            index2(index1) = false;
			% if( any(index1) )
			% 	h(end+1) = plot( [points(1,index1).crctRate], [points(2,index1).crctRate], 'o', 'color', [0.5 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'nTrials < 4' );
			% end
			% if( any(index2) )
			% 	h(end+1) = plot( [points(1,index2).crctRate], [points(2,index2).crctRate], 'o', 'color', 'k', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'nTrials < 8' );
			% end
			% if( any(~(index1|index2)) )
			% 	h(end+1) = plot( [points(1,~(index1|index2)).crctRate], [points(2,~(index1|index2)).crctRate], 'ro', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'nTrials >= 8' );
			% end

			n = size(h,2);
			for( i = 1 : size(points,2) )
				text( points(1,i).crctRate, points(2,i).crctRate, num2str(points(1,i).nTrials), 'color', [1 0.5 0.5], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 20, 'DisplayName', 'b' );
				text( points(1,i).crctRate, points(2,i).crctRate, num2str(points(2,i).nTrials), 'color', [0.5 0.5 1], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'FontSize', 20, 'DisplayName', 'nb' );
			end

			if( any(index) )
				h(end+1) = plot( [points(1,index).crctRate], [points(2,index).crctRate], 'd', 'color', 'k', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Significant' );
			end
			if( any(~index) )
				h(end+1) = plot( [points(1,~index).crctRate], [points(2,~index).crctRate], 'o', 'color', 'k', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Non significant' );
			end
			plot( [0 1], [0 1], 'k--', 'LineWidth', 1 );

			switch(method)
				case 'signrank'
					if( any(~(index1|index2)) )
						p{1} = signrank( [points(1,~(index1|index2)).crctRate], [points(2,~(index1|index2)).crctRate] );
					else
						p{1} = [];
					end
					if( any(~index1) )
						p{2} = signrank( [points(1,~index1).crctRate], [points(2,~index1).crctRate] );
					else
						p{2} = [];
					end
					p{3} = signrank( [points(1,:).crctRate], [points(2,:).crctRate] );
				case 'ttest'
					[~, p{1}] = ttest( [points(1,~(index1|index2)).crctRate], [points(2,~(index1|index2)).crctRate] );
					[~, p{2}] = ttest( [points(1,~index1).crctRate], [points(2,~index1).crctRate] );
					[~, p{3}] = ttest( [points(1,:).crctRate], [points(2,:).crctRate] );
				case 'ranksum'
					p{1} = ranksum( [points(1,~(index1|index2)).crctRate], [points(2,~(index1|index2)).crctRate] );
					p{2} = ranksum( [points(1,~index1).crctRate], [points(2,~index1).crctRate] );
					p{3} = ranksum( [points(1,:).crctRate], [points(2,:).crctRate] );
				case 'ztest'	% this test is meaningless for data containing more than one contrast levels
					n1 = sum([points(1,:).nTrials]);
					P1 = [points(1,:).crctRate] * [points(1,:).nTrials]' / n1;
					n2 = sum([points(2,:).nTrials]);
					P2 = [points(2,:).crctRate] * [points(2,:).nTrials]' / n2;
					P = ( n1*P1 + n2*P2 ) / (n1 + n2);
					sd = sqrt( P*(1-P) * ( 1/n1 + 1/n2 ) );
					p{3} = ( 1 - normcdf( abs(P1-P2), 0, sd ) ) * 2;
					p{1} = [];
					p{2} = [];
			end
			% text( 0, 0.98, sprintf( '  p = %.3f', p{1} ), 'color', 'r', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 15 );
			% text( 0, 0.93, sprintf( '  p = %.3f', p{2} ), 'color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 15 );
			% text( 0, 0.88, sprintf( '  p = %.3f', p{3} ), 'color', [0.5 0.5 0.5], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 15 );
			text( 0, 0.93, sprintf( '  p = %.3f', p{3} ), 'color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 20 );

			legend( h, 'location', 'Southeast' );
			xlabel('Blink condition');
			ylabel('No blink condition');
			set( gca, 'XLim', [0 1], 'YLim', [0 1], 'FontSize', 20 );
			title( 'Correct rate', 'FontSize', 12, 'FontSize', 20 );
		end


		function FixLevelEffect( sbj, folder, groups, hasMicrosac, hasSac, isNewFigure, reverse2Tones, isAND )
			%% groups:					cell array, each element defines the indices of one data group
			%  hasMicrosac:				whether trials contain microsaccades (<30 arc mins); false by default; empty or NaN mean don't care
			%  hasSac:					whether trials contain saccades (>30 arc mins); false by default; empty or NaN mean don't care
			%  reverse2Tones:			assign true for the paradigm where lower tone signaling later report and higher tone signaling immediate report
			%  isAND:					whether apply AND between hasMicrosac and hasSac, if false then apply OR between them; true by default


			if( nargin() < 4 ) hasMicrosac = false; end
			if( nargin() < 5 ) hasSac = false; end
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end
			if( nargin() < 7 || isempty(reverse2Tones) ) reverse2Tones = false; end
			if( nargin() < 8 || isempty(isAND) ) isAND = true; end

			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end

			Data4Blinks = BlinkTransient.GetLabeledTrials4Blinks(folder,[],[],'tRampOn',0,0);%,'tPlateauOn',0);

			%% remove blocks with correct rate outside [0.8, 0.9]
			% bound = [0. 0.9];
			% bound = [0.8 1];
			bound = [0 1];
			index = false(size(Data4Blinks));
			for( i = 1 : size(Data4Blinks,2) )
				rate = sum( [Data4Blinks(i).trials.trialType] == 'c' ) / sum( [Data4Blinks(i).trials.trialType] == 'c' | [Data4Blinks(i).trials.trialType] == 'e' );
				if( rate < bound(1) || rate > bound(2)  ) index(i) = true; end
				% if( abs( Data4Blinks(i).trials(1).gaborAmp - 0.48 ) > 0.005 & abs( Data4Blinks(i).trials(1).gaborAmp - 0.50 ) > 0.005 ) index(i) = true; end
				% if( Data4Blinks(i).trials(1).gaborAmp - 0.525 < 0 ) index(i) = true; end
				% fprintf( '%d: %f\n', i, Data4Blinks(i).trials(1).gaborAmp );
			end
			for( iGroup = 1 : size(groups,2) )
				index2 = false(size(groups{iGroup}));
				for( i = 1 : size(groups{iGroup}, 2) )
					if( any( groups{iGroup}(i) == find(index) ) ) index2(i) = true; end
				end
				groups{iGroup}(index2) = [];
			end
			index = false(size(groups));
			for( iGroup = 1 : size(groups,2) )
				if( isempty(groups{iGroup}) ) index(iGroup) = true; end
			end
			groups(index) = [];

			if( isempty(Data4Blinks) ) return; end
			if( nargin() < 3 || isempty(groups) ) groups = mat2cell( 1:size(Data4Blinks,2), 1, ones(size(Data4Blinks)) ); end

			for( i = 1 : size(Data4Blinks,2) )
				trials = Data4Blinks(i).trials;
				if( isfield(trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
					beepFreq = [trials.beepFreq];
					beepFreq = beepFreq - mean( unique(beepFreq) );
					if(reverse2Tones) beepFreq = -beepFreq; end
					if( size( unique(beepFreq), 2 ) == 2 )
						trials( beepFreq > 0 & [trials.hasBlink] | beepFreq < 0 & ~[trials.hasBlink] ) = [];
					else
						trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
					end	
				else
					trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
				end
				Data4Blinks(i).trials = trials;
			end
			% trials = [data.trials];

			for( iGroup = size(groups,2) : -1 : 1 )
				data(iGroup).sessionName = sprintf( '%s | ', Data4Blinks(groups{iGroup}).sessionName );
				data(iGroup).sessionName(end-2:end) = [];
				tmpTrials = [Data4Blinks(groups{iGroup}).trials];
				data(iGroup).trialsWithBlink = tmpTrials( [tmpTrials.hasBlink] );
				data(iGroup).trialsWithoutBlink = tmpTrials( ~[tmpTrials.hasBlink] );
				if( isAND )
					if( ~isempty(hasMicrosac) && ~isnan(hasMicrosac) )
						data(iGroup).trialsWithBlink = data(iGroup).trialsWithBlink( [data(iGroup).trialsWithBlink.hasMicrosac] == hasMicrosac );
						data(iGroup).trialsWithoutBlink = data(iGroup).trialsWithoutBlink( [data(iGroup).trialsWithoutBlink.hasMicrosac] == hasMicrosac );
					end
					if( ~isempty(hasSac) && ~isnan(hasSac) )
						data(iGroup).trialsWithBlink = data(iGroup).trialsWithBlink( [data(iGroup).trialsWithBlink.hasSac] == hasSac );
						data(iGroup).trialsWithoutBlink = data(iGroup).trialsWithoutBlink( [data(iGroup).trialsWithoutBlink.hasSac] == hasSac );
					end
				else
					index1 = false(size(data(iGroup).trialsWithBlink));
					index2 = false(size(data(iGroup).trialsWithoutBlink));
					if( ~isempty(hasMicrosac) && ~isnan(hasMicrosac) )
						index1 = index1 | ( [data(iGroup).trialsWithBlink.hasMicrosac] == hasMicrosac );
						index2 = index2 | ( [data(iGroup).trialsWithoutBlink.hasMicrosac] == hasMicrosac );
					end
					if( ~isempty(hasSac) && ~isnan(hasSac) )
						index1 = index1 | ( [data(iGroup).trialsWithBlink.hasSac] == hasSac );
						index2 = index2 | ( [data(iGroup).trialsWithoutBlink.hasSac] == hasSac );
					end
					data(iGroup).trialsWithBlink = data(iGroup).trialsWithBlink(index1);
					data(iGroup).trialsWithoutBlink = data(iGroup).trialsWithoutBlink(index2);
				end

				iii = true(1,size(data(iGroup).trialsWithBlink,2));
				for( iTrial = 1:size(data(iGroup).trialsWithBlink,2) )
					dt = data(iGroup).trialsWithBlink(iTrial).blinks.start / data(iGroup).trialsWithBlink(iTrial).sRate * 1000 - (data(iGroup).trialsWithBlink(iTrial).tRampOn - data(iGroup).trialsWithBlink(iTrial).tTrialStart);
					% if( any( 0 < dt & dt < 1002 ) ) iii(iTrial) = false; end 	% A050: 1007;	A082: 1132;	A002: 1002
					if( data(iGroup).trialsWithBlink(iTrial).blinks.duration( find( dt > 0, 1, 'first' ) ) / data(iGroup).trialsWithBlink(iTrial).sRate * 1000 < 123 ) iii(iTrial) = false; end 	% A002: 171; A050: 123; A082: 131
				end
				% data(iGroup).trialsWithoutBlink = data(iGroup).trialsWithBlink(iii);
				% data(iGroup).trialsWithBlink(iii) = [];
			end

			%% remove trials with too much notracks during stimulus
			trials = [];
			for( iGroup = 1 : size(data,2) )
				trials{2} = data(iGroup).trialsWithoutBlink;	% tirals only with drifts
				trials{1} = data(iGroup).trialsWithBlink;		% trials only with blinks
				for( j = 1 : size(trials,2) )
					index = true( size(trials{j}) );
					for( iTrial = 1 : size(trials{j},2) )
						notracks = trials{j}(iTrial).notracks;
						index(iTrial) = sum( max( 0, ...
									min( (notracks.start+notracks.duration-1)/trials{j}(iTrial).sRate*1000, trials{j}(iTrial).tMaskOn-trials{j}(iTrial).tTrialStart ) - ...
									max( (notracks.start-1)/trials{j}(iTrial).sRate*1000, trials{j}(iTrial).tRampOn-trials{j}(iTrial).tTrialStart ) ) ) < 15;
					end
					trials{j} = trials{j}(index);
				end
				data(iGroup).trialsWithBlink = trials{1};
				data(iGroup).trialsWithoutBlink = trials{2};

			end

			if(isNewFigure)
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Blink VS No Blink @ FixedLevel', sbj ), 'color', 'w' );
			end

			hold on;

			points = [];
			hAligns = {'left', 'right'};
			colors = {'r', 'b'};
			trials = [];
			for( iGroup = size(data,2) : -1 : 1 )
				trials{2} = data(iGroup).trialsWithoutBlink;	% tirals only with drifts
				trials{1} = data(iGroup).trialsWithBlink;		% trials only with blinks

				for( j = size(trials,2):-1:1 )
					points(j,iGroup).nTrials = size(trials{j},2);
					if( points(j,iGroup).nTrials > 0 )
						points(j,iGroup).crctRate = sum( [trials{j}.trialType] == 'c' ) / points(j,iGroup).nTrials;
						text( iGroup, points(j,iGroup).crctRate, sprintf('%d', points(j,iGroup).nTrials), 'HorizontalAlignment', hAligns{j}, 'VerticalAlignment', 'top', 'FontSize', 20, 'color', colors{j} );
					else
						points(j,iGroup).crctRate = NaN;
					end
				end
			end

			% ztest
			index = [points(1,:).nTrials] ~= 0;
			n1 = sum([points(1,index).nTrials]);
			P1 = [points(1,index).crctRate] * [points(1,index).nTrials]' / n1;
			index = [points(2,:).nTrials] ~= 0;
			n2 = sum([points(2,index).nTrials]);
			P2 = [points(2,index).crctRate] * [points(2,index).nTrials]' / n2;

			% correct for continuity
			if( P1 < P2 )
				P1 = P1 + 0.5/n1;
				P2 = P2 - 0.5/n2;
			elseif( P1 > P2 )
				P1 = P1 - 0.5/n1;
				P2 = P2 + 0.5/n2;
			end
			
			P = ( n1*P1 + n2*P2 ) / (n1 + n2);
			sd = sqrt( P*(1-P) * ( 1/n1 + 1/n2 ) );
			p = ( 1 - normcdf( abs(P1-P2), 0, sd ) ) * 2;

			h(1) = plot( 1 : size(groups,2), [points(1,:).crctRate], 'ro', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', sprintf( 'b %d', sum([points(1,:).nTrials]) ) );
			plot( 1 : size(groups,2), [points(1,:).crctRate], 'r--', 'MarkerSize', 8, 'LineWidth', 1 );
			h(2) = plot( 1 : size(groups,2), [points(2,:).crctRate], 'bo', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', sprintf( 'nb %d', sum([points(2,:).nTrials]) ) );
			plot( 1 : size(groups,2), [points(2,:).crctRate], 'b--', 'MarkerSize', 8, 'LineWidth', 1 );

			if( P1 > P2 )
				vAlign = {'bottom', 'top'};
			else
				vAlign = {'top','bottom'};
            end
            if( ~isempty(P1) )
    			plot( size(groups,2)+1, P1, 'rs', 'MarkerSize', 10, 'LineWidth', 2 );
        		text( size(groups,2)+1, P1, num2str(n1), 'color', 'r', 'HorizontalAlignment', 'left', 'VerticalAlignment', vAlign{1}, 'FontSize', 20 );
            end
            if( ~isempty(P2) )
                plot( size(groups,2)+1, P2, 'bs', 'MarkerSize', 10, 'LineWidth', 2 );
                text( size(groups,2)+1, P2, num2str(n2), 'color', 'b', 'HorizontalAlignment', 'left', 'VerticalAlignment', vAlign{2}, 'FontSize', 20 );
            end

			text( 0.1, 0.05, sprintf( '  p = %.3f', p ), 'color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 20 );
			set( legend(h), 'location', 'Southeast' );
			set( gca, 'xlim', [0 size(groups,2)+2], 'ylim', [0 1], 'LineWidth', 2, 'FontSize', 20 );
			xlabel( 'Block #' );
			ylabel( 'Performance' );
			title(sbj);
		end


		function [n, p, pVal] = FixLevelMultiComp( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones, rtFilter )
			%  tLBEvent4Blink:		hasBlink is true only if a blink happens after tLBEvent4Blink
			%  tLBOffset4Blink:		offset regarding tLBEvent4Blink
			%  tUBOffset4Blink:		offset regarding upper bound for hasBlink
			%  reverse2Tones:		assign true for the paradigm where lower tone signaling later report and higher tone signaling immediate report


			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			if( nargin() < 4 || isempty(tAlignEvent) ) tAlignEvent = 'tRampOn'; end 	% start event for microsaccades/saccades control analysis
			if( nargin() < 5 || isempty(tStart) ) tStart = 0; end 						% start time for microsaccades/saccades control analysis (relative to tAlignEvent)
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end
			if( nargin() < 7 || isempty(tLBEvent4Blink) ) tLBEvent4Blink = 'tRampOn'; end
			if( nargin() < 8 || isempty(tLBOffset4Blink) ) tLBOffset4Blink = 1000; end
			if( nargin() < 9 || isempty(tUBOffset4Blink) ) tUBOffset4Blink = -300; end
			if( nargin() < 10 || isempty(reverse2Tones) ) reverse2Tones = false; end
			if( nargin() < 11 || isempty(rtFilter) ) rtFilter = 'all'; end

			data = BlinkTransient.GetLabeledTrials4Blinks( folder, tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink );
			if( nargin() < 3 || isempty(blockIndices) ) blockIndices = 1 : size(data,2); end
			data = data(blockIndices);
			
			for( i = 1 : size(data,2) )
				trials = data(i).trials;
				if( isfield(trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
					beepFreq = [trials.beepFreq];
					beepFreq = beepFreq - mean( unique(beepFreq) );
					if(reverse2Tones) beepFreq = -beepFreq; end
					if( size( unique(beepFreq), 2 ) == 2 )
						trials( beepFreq < 0 & [trials.hasBlink] | beepFreq > 0 & ~[trials.hasBlink] ) = [];
					else
						trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
					end	
				else
					trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
				end
				data(i).trials = trials;
			end

			Trials = [data.trials];
			switch(lower(rtFilter))
				case 'late'
					Trials( [Trials.tResponse] < [Trials.tMaskOn] + 250 ) = [];
				case 'early'
					Trials( [Trials.tResponse] > [Trials.tMaskOn] ) = [];
			end

			blinkFlag = [true, false];	% Blink, No Blink
			sacFlags = [ false, false; true, false; false, true; NaN, NaN ];	% drift only; microsaccades only; saccades only
			for( i = 1 : 2 )
				for( j = 1 : size(sacFlags,1) )
					trials = Trials( [Trials.hasBlink] == blinkFlag(i) & ( [Trials.hasMicrosac] == sacFlags(j,1) | isnan(sacFlags(j,1)) ) & ( [Trials.hasSac] == sacFlags(j,2) | isnan(sacFlags(j,2)) ) );
					if( j == 4 )
						trials = Trials( [Trials.hasBlink] == blinkFlag(i) & ( [Trials.hasMicrosac] | [Trials.hasSac] ) );
					end

					n(j,i) = size(trials,2);
					p(j,i) = sum( [trials.trialType] == 'c' );

				end
			end

			n(end+1,1) = sum( [Trials.hasBlink] );
			p(end+1,1) = sum( [Trials.hasBlink] & [Trials.trialType] == 'c' );
			n(end,2) = sum( ~[Trials.hasBlink] );
			p(end,2) = sum( ~[Trials.hasBlink] & [Trials.trialType] == 'c' );

			nBars = size(n,1);	% number of pairs of bars

			p = p ./ n;
			sd = sqrt( p .* (1-p) ./ n );
			sd(n==0) = NaN;

			% Z-test
			p1 = p(:,1);
			p2 = p(:,2);
			index1 = p1 < p2;
			index2 = p1 > p2;
			p1(index1) = p1(index1) + 0.5 ./ n(index1,1);
			p2(index1) = p2(index1) - 0.5 ./ n(index1,2);
			p1(index2) = p1(index2) - 0.5 ./ n(index2,1);
			p2(index2) = p2(index2) + 0.5 ./ n(index2,2);

			P = ( n(:,1).*p1 + n(:,2).*p2 ) ./ (n(:,1) + n(:,2));
			SD = sqrt( P.*(1-P) .* ( 1./n(:,1) + 1./n(:,2) ) );
			SD(SD==0) = NaN;
			pVal = ( 1 - normcdf( abs(p1-p2), 0, SD ) ) * 2;

			if(isNewFigure)
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Multiple Comparisons @ FixedLevel', sbj ), 'color', 'w' );
			end
			w = 5;
			x = [ (1:nBars)*w-3, (1:nBars)*w-2 ];

			% bars
			h(1) = bar( x(1:nBars), p(:,1), 0.95/w, 'r', 'LineStyle', 'none', 'DisplayName', 'Blink', 'FaceAlpha', 0.6 ); hold on;
			h(2) = bar( x( nBars+1 : nBars*2 ), p(:,2), 0.95/w, 'b', 'LineStyle', 'none', 'DisplayName', 'No Blink', 'FaceAlpha', 0.6 );

			% error bars
			plot( reshape( [ repmat( x(1:nBars), 2, 1 ); ones(1,nBars)*NaN ], 1, [] ), reshape( [ sd(:,1)*[-1,1] + repmat( p(:,1), 1, 2 ), ones(nBars,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );
			plot( reshape( [ repmat( x( nBars+1 : nBars*2 ), 2, 1 ); ones(1,nBars)*NaN ], 1, [] ), reshape( [ sd(:,2)*[-1,1] + repmat( p(:,2), 1, 2 ), ones(nBars,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );

			% show significance
			YL = [nanmin(p(:)-sd(:)) nanmax(p(:)+sd(:))];
			YL = [-0.1 0.1] * (YL(2)-YL(1)) + YL;
			YL = [ max(0, YL(1)) YL(2) ];
			YL = [0 1];
			set( gca, 'XLim', [0 w*nBars], 'XTick', (1:nBars)*w - 2.5, 'XTickLabel', {'drift', 'msac', 'sac', 'm/s', 'all'}, 'XTickLabelRotation', 10, 'YLim', YL, 'LineWidth', 1, 'FontSize', 20, 'box', 'off', 'YGrid', 'on', 'YMinorGrid', 'on' );
			for( i = 1 : nBars )
				if( pVal(i) < 0.1 )
					isShowValue = true;
					if( pVal(i) < 0.05 ) isShowValue = false; end
					ToolKit.ShowSignificance( [x(i), p(i,1)+sd(i,1)], [x(i+nBars), p(i,2)+sd(i,2)], pVal(i), 0.02, isShowValue, 'FontSize', 14 );
				end
			end
			
			% show number of trials
			hAlign = {'right', 'left'};
			vAlign = {'bottom', 'top'};
			for( i = 1 : size(n(:),1) )
				text( mean( x( [1 nBars+1] + mod(i-1,nBars) ) ), YL(1) + (i>nBars)*0.05*(YL(2)-YL(1)), num2str(n(i)), 'color', 'k', 'FontSize', 14, 'HorizontalAlignment', hAlign{ (i>nBars) + 1 }, 'VerticalAlignment', 'bottom' );
			end


			set( legend(h), 'location', 'northeast', 'FontSize', 12 );
			ylabel('Correct rate');
			title('Performance');
		end


		function [n, p, pVal] = BootStrapMultiComp( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones, replaced )
			%% use bootstrap to exclude possible effect of RT
			%  tLBEvent4Blink:		hasBlink is true only if a blink happens after tLBEvent4Blink
			%  tLBOffset4Blink:		offset regarding tLBEvent4Blink
			%  tUBOffset4Blink:		offset regarding upper bound for hasBlink
			%  reverse2Tones:		assign true for the paradigm where lower tone signaling later report and higher tone signaling immediate report


			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			if( nargin() < 4 || isempty(tAlignEvent) ) tAlignEvent = 'tRampOn'; end 	% start event for microsaccades/saccades control analysis
			if( nargin() < 5 || isempty(tStart) ) tStart = 0; end 						% start time for microsaccades/saccades control analysis (relative to tAlignEvent)
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end
			if( nargin() < 7 || isempty(tLBEvent4Blink) ) tLBEvent4Blink = 'tRampOn'; end
			if( nargin() < 8 || isempty(tLBOffset4Blink) ) tLBOffset4Blink = 1000; end
			if( nargin() < 9 || isempty(tUBOffset4Blink) ) tUBOffset4Blink = -300; end
			if( nargin() < 10 || isempty(reverse2Tones) ) reverse2Tones = false; end
			if( nargin() < 11 || isempty(replaced) ) replaced = true; end

			if(isNewFigure)
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Multiple Comparisons @ FixedLevel | Exclude RT Effect by Bootstrap', sbj ), 'color', 'w' );
				hFig(1) = gcf;
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Bootstrap | Trial index', sbj ), 'color', 'w' );
				hFig(2) = gcf;
			end

			rng('shuffle');

			data = BlinkTransient.GetLabeledTrials4Blinks( folder, tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink );
			if( nargin() < 3 || isempty(blockIndices) ) blockIndices = 1 : size(data,2); end
			data = data(blockIndices);
			
			for( i = 1 : size(data,2) )
				Trials = data(i).trials;
				if( isfield(Trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
					beepFreq = [Trials.beepFreq];
					beepFreq = beepFreq - mean( unique(beepFreq) );
					if(reverse2Tones) beepFreq = -beepFreq; end
					if( size( unique(beepFreq), 2 ) == 2 )
						Trials( beepFreq < 0 & [Trials.hasBlink] | beepFreq > 0 & ~[Trials.hasBlink] ) = [];
					else
						Trials( [Trials.tBlinkBeepOn] - [Trials.tRampOn] > -600 & ~[Trials.hasBlink] | [Trials.tBlinkBeepOn] - [Trials.tRampOn] < -600 & [Trials.hasBlink] ) = [];
					end	
				else
					Trials( [Trials.tBlinkBeepOn] - [Trials.tRampOn] > -600 & ~[Trials.hasBlink] | [Trials.tBlinkBeepOn] - [Trials.tRampOn] < -600 & [Trials.hasBlink] ) = [];
				end
				data(i).trials = Trials;
			end

			Trials = [data.trials];

			blinkFlag = [true, false];	% Blink, No Blink
			sacFlags = [ false, false; true, false; false, true ];	% drift only; microsaccades only; saccades only
			for( i = 1 : 2 )
				for( j = 1 : size(sacFlags,1) )
					trials{j,i} = Trials( [Trials.hasBlink] == blinkFlag(i) & ( [Trials.hasMicrosac] == sacFlags(j,1) | isnan(sacFlags(j,1)) ) & ( [Trials.hasSac] == sacFlags(j,2) | isnan(sacFlags(j,2)) ) );
				end
				trials{4,i} = Trials( [Trials.hasBlink] == blinkFlag(i) & ( [Trials.hasMicrosac] | [Trials.hasSac] ) );
				trials{5,i} = [trials{[1,4],i}];
			end

			tStep = 50;
			for( j = 1 : 5 )
				tResponse{1} = [trials{j,1}.tResponse] - [trials{j,1}.tRampOn];
				tResponse{2} = [trials{j,2}.tResponse] - [trials{j,2}.tRampOn];
				MIN = max( min(tResponse{1}), min(tResponse{2}) );
				MAX = min( max(tResponse{1}), max(tResponse{2}) );
				trials{j,1}( tResponse{1} < MIN | MAX < tResponse{1} ) = [];
				trials{j,2}( tResponse{2} < MIN | MAX < tResponse{2} ) = [];
				tResponse{1}( tResponse{1} < MIN | MAX < tResponse{1} ) = [];
				tResponse{2}( tResponse{2} < MIN | MAX < tResponse{2} ) = [];
				edges = MIN - randi(tStep,1) : tStep : MAX + tStep;

				RT = [];
				bootIndex = [];
				
				trialIndex = [];

				nBoots = 2000;
				meanRTs = zeros(2,nBoots);		% mean RTs from each bootstrap, 1st row for blink, 2nd row for no blink
				meanPerforms = zeros(2,nBoots);	% mean performance (correct ratio) from each bootstrap, 1st row for blink, 2nd row for no blink
				for( iBoot = 1 : nBoots )
					if( replaced )
						index = [];
						ii = randperm(2);
						% data = ToolKit.Hist( tResponse{ii(1)}, edges, false ); 
						% index{ii(1)} = 1 : size(tResponse{ii(1)},2);
						for( iBin = 1 : size(edges,2)-1 )
							x = find( edges(iBin) <= tResponse{ii(1)} & tResponse{ii(1)} < edges(iBin+1) );
							y = find( edges(iBin) <= tResponse{ii(2)} & tResponse{ii(2)} < edges(iBin+1) );
							if( isempty(x) || isempty(y) )
								index{ii(1)}{iBin} = [];
								index{ii(2)}{iBin} = [];
							else
								index{ii(1)}{iBin} = x;
								index{ii(2)}{iBin} = y( randi( size(y,2), 1, size(x,2) ) );
							end
						end
						index{1} = [index{1}{:}];
						index{2} = [index{2}{:}];
						
						RT{1,iBoot} = tResponse{1}(index{1});
						RT{2,iBoot} = tResponse{2}(index{2});
						meanRTs(1,iBoot) = mean(RT{1,iBoot});
						meanRTs(2,iBoot) = mean(RT{2,iBoot});
						pVals.RT(iBoot) = ranksum( RT{1,iBoot}, RT{2,iBoot} );
						bootIndex{1,iBoot} = ones( 1, size(index{1},2) ) * iBoot;
						bootIndex{2,iBoot} = ones( 1, size(index{2},2) ) * iBoot;
						trialIndex{1,iBoot} = index{1};
						trialIndex{2,iBoot} = index{2};

						n1 = size(index{1},2);
						n2 = size(index{2},2);
						p1 = sum( [trials{j,1}(index{1}).trialType] == 'c' ) / size(index{1},2);
						p2 = sum( [trials{j,2}(index{2}).trialType] == 'c' ) / size(index{2},2);
						if( p1 > p2 )
							p1 = p1 - 0.5/n1;
							p2 = p2 + 0.5/n2;
						elseif( p1 < p2 )
							p1 = p1 + 0.5/n1;
							p2 = p2 - 0.5/n2;
						end
						p = (n1*p1 + n2*p2) / (n1 + n2);
						sd = sqrt( p.*(1-p) .* ( 1/n1 + 1/n2 ) );
						pVals.perform(iBoot) = ( 1 - normcdf( abs(p1-p2), 0, sd ) ) * 2;
						meanPerforms(1,iBoot) = sum( [trials{j,1}(index{1}).trialType] == 'c' ) / size(index{1},2);
						meanPerforms(2,iBoot) = sum( [trials{j,2}(index{2}).trialType] == 'c' ) / size(index{2},2);

					else
						index1 = false( size(trials{j,1}) );
						index2 = false( size(trials{j,2}) );
						x = randperm( size(trials{j,1},2) );
						index1( x( 1 : round(end/4*3) ) ) = true;

						data = round( ToolKit.Hist( tResponse{1}(index1), edges, false ) / size( trials{j,1}, 2 ) * size( trials{j,2}, 2 ) ); 
						for( iBin = 1 : size(edges,2)-1 )
							x = find( edges(iBin) <= tResponse{2} & tResponse{2} < edges(iBin+1) );
							if( size(x,2) < data(iBin) )
								index2(x) = true;
								y = find( edges(iBin) <= tResponse{1} & tResponse{1} <= edges(iBin+1) & index1 );
								z = randperm( size(y,2) );
								index1( y( round( size(x,2) / size(trials{j,2},2) * size(trials{j,1},2) ) + 1 : end ) ) = false;
							else
								y = randperm( size(x,2) );
								index2( x( y( 1 : data(iBin) ) ) ) = true;
							end
						end

						meanRTs(1,iBoot) = mean(tResponse{1}(index1));
						meanRTs(2,iBoot) = mean(tResponse{2}(index2));
						meanPerforms(1,iBoot) = sum( [trials{j,1}(index1).trialType] == 'c' ) / sum(index1);
						meanPerforms(2,iBoot) = sum( [trials{j,2}(index2).trialType] == 'c' ) / sum(index2);
						RT{1,iBoot} = tResponse{1}(index1);
						RT{2,iBoot} = tResponse{2}(index2);
						bootIndex{1,iBoot} = ones(1,sum(index1)) * iBoot;
						bootIndex{2,iBoot} = ones(2,sum(index2)) * iBoot;

						trialIndex{1,iBoot} = find(index1);
						trialIndex{2,iBoot} = find(index2);
					end
					
				end
				figure(hFig(1));
				subplot(2,3,j); hold on;
				plot( [RT{1,:}], [bootIndex{1,:}] * 2 - 1, 'r.' );
				plot( [RT{2,:}], [bootIndex{2,:}] * 2, 'b.' );
				plot( meanRTs(1,:), (1:nBoots)*2-1, 'r*' );
				plot( meanRTs(2,:), (1:nBoots)*2, 'b*' );

				title( sprintf( 'p=%.3f, pVal=%.3f\\pm %.3f', sum( meanRTs(1,:) <= meanRTs(2,:) ) / nBoots, mean(pVals.RT), std(pVals.RT) ) );


				figure(hFig(2));
				subplot(2,3,j); hold on;
				plot( [trialIndex{1,:}], [bootIndex{1,:}], 'r.' );
				plot( [trialIndex{2,:}], [bootIndex{2,:}]+nBoots, 'b.' );

				title( sprintf( 'p=%.3f, pVals=%.3f\\pm %.3f', sum( meanPerforms(1,:) <= meanPerforms(2,:) ) / nBoots, mean(pVals.perform), std(pVals.perform) ) );

				% subplot(2,3,j); hold on;
				% hist( tResponse{1}, edges );
				% h1 = findobj( gca, 'type', 'patch' );
				% hist( tResponse{2}, edges );
				% h2 = findobj( gca, 'type', 'patch' );
				% set( h2, 'FaceAlpha', 0.6, 'FaceColor', 'b' );
				% set( h1, 'FaceAlpha', 0.6, 'FaceColor', 'r' );
				% title( sprintf( '%.3f, %.1f\\pm %.1f; %.3f, %.1f\\pm %.1f', sum(index1)/size(index1,2), mean(tResponse{1}(index1)), std(tResponse{1}(index1)), sum(index2)/size(index2,2), mean(tResponse{2}(index2)), std(tResponse{2}(index2)) ) );
			end
			return;

			for( i = 1 : 2 )
				for( j = 1 : 5 )
					n(j,i) = size(trials{j,i},2);
					p(j,i) = sum([trials{j,i}.trialType]=='c');
				end
			end

			% n(end+1,1) = sum( [Trials.hasBlink] );
			% p(end+1,1) = sum( [Trials.hasBlink] & [Trials.trialType] == 'c' );
			% n(end,2) = sum( ~[Trials.hasBlink] );
			% p(end,2) = sum( ~[Trials.hasBlink] & [Trials.trialType] == 'c' );

			nBars = size(n,1);	% number of pairs of bars

			p = p ./ n;
			sd = sqrt( p .* (1-p) ./ n );
			sd(n==0) = NaN;

			% Z-test
			p1 = p(:,1);
			p2 = p(:,2);
			index1 = p1 < p2;
			index2 = p1 > p2;
			p1(index1) = p1(index1) + 0.5 ./ n(index1,1);
			p2(index1) = p2(index1) - 0.5 ./ n(index1,2);
			p1(index2) = p1(index2) - 0.5 ./ n(index2,1);
			p2(index2) = p2(index2) + 0.5 ./ n(index2,2);

			P = ( n(:,1).*p1 + n(:,2).*p2 ) ./ (n(:,1) + n(:,2));
			SD = sqrt( P.*(1-P) .* ( 1./n(:,1) + 1./n(:,2) ) );
			SD(SD==0) = NaN;
			pVal = ( 1 - normcdf( abs(p1-p2), 0, SD ) ) * 2;

			
			w = 5;
			x = [ (1:nBars)*w-3, (1:nBars)*w-2 ];

			% bars
			h(1) = bar( x(1:nBars), p(:,1), 0.95/w, 'r', 'LineStyle', 'none', 'DisplayName', 'Blink', 'FaceAlpha', 0.6 ); hold on;
			h(2) = bar( x( nBars+1 : nBars*2 ), p(:,2), 0.95/w, 'b', 'LineStyle', 'none', 'DisplayName', 'No Blink', 'FaceAlpha', 0.6 );

			% error bars
			plot( reshape( [ repmat( x(1:nBars), 2, 1 ); ones(1,nBars)*NaN ], 1, [] ), reshape( [ sd(:,1)*[-1,1] + repmat( p(:,1), 1, 2 ), ones(nBars,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );
			plot( reshape( [ repmat( x( nBars+1 : nBars*2 ), 2, 1 ); ones(1,nBars)*NaN ], 1, [] ), reshape( [ sd(:,2)*[-1,1] + repmat( p(:,2), 1, 2 ), ones(nBars,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );

			% show significance
			YL = [nanmin(p(:)-sd(:)) nanmax(p(:)+sd(:))];
			YL = [-0.1 0.1] * (YL(2)-YL(1)) + YL;
			YL = [ max(0, YL(1)) YL(2) ];
			YL = [0 1];
			set( gca, 'XLim', [0 w*nBars], 'XTick', (1:nBars)*w - 2.5, 'XTickLabel', {'drift', 'msac', 'sac', 'm/s', 'all'}, 'XTickLabelRotation', 10, 'YLim', YL, 'LineWidth', 1, 'FontSize', 20, 'box', 'off', 'YGrid', 'on', 'YMinorGrid', 'on' );
			for( i = 1 : nBars )
				if( pVal(i) < 0.1 )
					isShowValue = true;
					if( pVal(i) < 0.05 ) isShowValue = false; end
					ToolKit.ShowSignificance( [x(i), p(i,1)+sd(i,1)], [x(i+nBars), p(i,2)+sd(i,2)], pVal(i), 0.02, isShowValue, 'FontSize', 14 );
				end
			end
			
			% show number of trials
			hAlign = {'right', 'left'};
			vAlign = {'bottom', 'top'};
			for( i = 1 : size(n(:),1) )
				text( mean( x( [1 nBars+1] + mod(i-1,nBars) ) ), YL(1) + (i>nBars)*0.05*(YL(2)-YL(1)), num2str(n(i)), 'color', 'k', 'FontSize', 14, 'HorizontalAlignment', hAlign{ (i>nBars) + 1 }, 'VerticalAlignment', 'bottom' );
			end


			set( legend(h), 'location', 'northeast', 'FontSize', 12 );
			ylabel('Correct rate');
			title('Performance');
		end


		function [n, tResponse, average, pVal] = FixLevelMultiComp_RT( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones, cutBlinks, noLateReport )
			%  tLBEvent4Blink:		hasBlink is true only if a blink happens after tLBEvent4Blink
			%  tLBOffset4Blink:		offset regarding tLBEvent4Blink
			%  tUBOffset4Blink:		offset regarding upper bound for hasBlink
			%  reverse2Tones:		assign true for the paradigm where lower tone signaling later report and higher tone signaling immediate report
			%  cutBlinks:			whether subtract blink duration from RT; false by default
			%  noLateReport:		whether discard trials reported after mask onset; true by default


			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			if( nargin() < 4 || isempty(tAlignEvent) ) tAlignEvent = 'tRampOn'; end 	% start event for microsaccades/saccades control analysis
			if( nargin() < 5 || isempty(tStart) ) tStart = 0; end 						% start time for microsaccades/saccades control analysis (relative to tAlignEvent)
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end
			if( nargin() < 7 || isempty(tLBEvent4Blink) ) tLBEvent4Blink = 'tRampOn'; end
			if( nargin() < 8 || isempty(tLBOffset4Blink) ) tLBOffset4Blink = 1000; end
			if( nargin() < 9 || isempty(tUBOffset4Blink) ) tUBOffset4Blink = -300; end
			if( nargin() < 10 || isempty(reverse2Tones) ) reverse2Tones = false; end
			if( nargin() < 11 || isempty(cutBlinks) ) cutBlinks = false; end
			if( nargin() < 12 || isempty(noLateReport) ) noLateReport = true; end

			data = BlinkTransient.GetLabeledTrials4Blinks( folder, tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink );
			if( nargin() < 3 || isempty(blockIndices) ) blockIndices = 1 : size(data,2); end
			data = data(blockIndices);
			
			for( i = 1 : size(data,2) )
				trials = data(i).trials;
				if( isfield(trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
					beepFreq = [trials.beepFreq];
					beepFreq = beepFreq - mean( unique(beepFreq) );
					if(reverse2Tones) beepFreq = -beepFreq; end
					if( size( unique(beepFreq), 2 ) == 2 )
						trials( beepFreq < 0 & [trials.hasBlink] | beepFreq > 0 & ~[trials.hasBlink] ) = [];
					else
						trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
					end	
				else
					trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
				end
				data(i).trials = trials;
			end

			Trials = [data.trials];
			Trials(logical(randi(2,size(Trials))-1)) = [];

			txtTags = { 'Drift', 'MSac', 'Sac', 'M/Sac', 'All' };
			blinkFlag = [true, false];	% Blink, No Blink
			sacFlags = [ false, false; true, false; false, true; NaN, NaN; NaN, NaN ];	% drift only; microsaccades only; saccades only
			for( j = 1 : size(sacFlags,1) )
				for( i = 1 : 2 )
					if( j < 4 )
						trials = Trials( [Trials.hasBlink] == blinkFlag(i) & [Trials.hasMicrosac] == sacFlags(j,1) & [Trials.hasSac] == sacFlags(j,2) );
					elseif( j == 4 )		% trials with microsaccades or saccades
						trials = Trials( [Trials.hasBlink] == blinkFlag(i) & ( [Trials.hasMicrosac] | [Trials.hasSac] ) );
					else 					% all trials
						trials = Trials( [Trials.hasBlink] == blinkFlag(i) );
					end
					if( ~isempty(trials) && noLateReport )
						trials( [trials.tResponse] > [trials.tMaskOn] ) = [];
					end
					n(j,i) = size(trials,2);
					if( isempty(trials) )
						tResponse{j,i} = NaN;
						sd(j,i) = NaN;
						continue;
					else
						tResponse{j,i} = [trials.tResponse] - [trials.tRampOn];
						if( cutBlinks )
							for( iTrail = 1 : size(trials,2) )
								evnts = [trials(iTrail).blinks, trials(iTrail).microsaccades, trials(iTrail).saccades];
								starts = max( [ ([evnts.start]-1)/trials(iTrail).sRate*1000; ones(size([evnts.start])) * ( trials(iTrail).tRampOn- trials(iTrail).tTrialStart ) ] );
								ends = min( [ ([evnts.start]+[evnts.duration]-2)/trials(iTrail).sRate*1000; ones(size([evnts.start])) * ( min( trials(iTrail).tMaskOn, trials(iTrail).tResponse )- trials(iTrail).tTrialStart ) ] );
								durations = ends - starts;
								tResponse{j,i}(iTrail) = tResponse{j,i}(iTrail) - sum(durations(durations>0));
							end
						end
						if( i == 1 ) tResponse{j,i}( tResponse{j,i} > quantile(tResponse{j,i},0.6) ) = [];
						else tResponse{j,i}( tResponse{j,i} < quantile(tResponse{j,i},0.4) ) = []; end
						sd(j,i) = std(tResponse{j,i});
					end
					average(j,i) = mean(tResponse{j,i});
				end
				if( all(isnan(tResponse{j,1})) || all(isnan(tResponse{j,2})) )
					pVal(j) = NaN;
				else
					pVal(j) = ranksum( tResponse{j,1}, tResponse{j,2} );
				end
			end

			nBars = size(n,1);	% number of pairs of bars
			
			if(isNewFigure)
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Multiple Comparisons of RT @ FixedLevel', sbj ), 'color', 'w' );
			end
			w = 5;
			x = [ (1:nBars)*w-3, (1:nBars)*w-2 ];

			% bars
			h(1) = bar( x(1:nBars), average(:,1), 0.95/w, 'r', 'LineStyle', 'none', 'DisplayName', 'Blink', 'FaceAlpha', 0.6 ); hold on;
			h(2) = bar( x( nBars+1 : nBars*2 ), average(:,2), 0.95/w, 'b', 'LineStyle', 'none', 'DisplayName', 'No Blink', 'FaceAlpha', 0.6 );

			% error bars
			plot( reshape( [ repmat( x(1:nBars), 2, 1 ); ones(1,nBars)*NaN ], 1, [] ), reshape( [ sd(:,1)*[-1,1] + repmat( average(:,1), 1, 2 ), ones(nBars,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );
			plot( reshape( [ repmat( x( nBars+1 : nBars*2 ), 2, 1 ); ones(1,nBars)*NaN ], 1, [] ), reshape( [ sd(:,2)*[-1,1] + repmat( average(:,2), 1, 2 ), ones(nBars,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );

			% show significance
			YL = [nanmin(average(:)-sd(:)) nanmax(average(:)+sd(:))];
			YL = [-0.1 0.1] * (YL(2)-YL(1)) + YL;
			YL = [ max(0, YL(1)) YL(2) ];
			% YL = [0 1];
			set( gca, 'XLim', [0 w*nBars], 'XTick', (1:nBars)*w - 2.5, 'XTickLabel', {'drift', 'msac', 'sac', 'm/s', 'all'}, 'XTickLabelRotation', 10, 'YLim', YL, 'LineWidth', 1, 'FontSize', 20, 'box', 'off', 'YGrid', 'on', 'YMinorGrid', 'on' );
			for( i = 1 : nBars )
				if( pVal(i) < 0.1 )
					isShowValue = true;
					if( pVal(i) < 0.05 ) isShowValue = false; end
					ToolKit.ShowSignificance( [x(i), average(i,1)+sd(i,1)], [x(i+nBars), average(i,2)+sd(i,2)], pVal(i), 0.02, isShowValue, 'FontSize', 14 );
				end
			end
			
			% show number of trials
			hAlign = {'right', 'left'};
			vAlign = {'bottom', 'top'};
			for( i = 1 : size(n(:),1) )
				text( mean( x( [1 nBars+1] + mod(i-1,nBars) ) ), YL(1) + (i>nBars)*0.05*(YL(2)-YL(1)), num2str(n(i)), 'color', 'k', 'FontSize', 14, 'HorizontalAlignment', hAlign{ (i>nBars) + 1 }, 'VerticalAlignment', 'bottom' );
			end


			set( legend(h), 'location', 'northeast', 'FontSize', 12 );
			ylabel('RT - tRampOn (ms)');
			title('RT');
		end


		function [n, p, pVal] = BlinkRT_VS_Performance( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink, reverse2Tones )
			%  tLBEvent4Blink:		hasBlink is true only if a blink happens after tLBEvent4Blink
			%  tLBOffset4Blink:		offset regarding tLBEvent4Blink
			%  tUBOffset4Blink:		offset regarding upper bound for hasBlink
			%  reverse2Tones:		assign true for the paradigm where lower tone signaling later report and higher tone signaling immediate report

			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			if( nargin() < 4 || isempty(tAlignEvent) ) tAlignEvent = 'tRampOn'; end 	% start event for microsaccades/saccades control analysis
			if( nargin() < 5 || isempty(tStart) ) tStart = 0; end 						% start time for microsaccades/saccades control analysis (relative to tAlignEvent)
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end
			if( nargin() < 7 || isempty(tLBEvent4Blink) ) tLBEvent4Blink = 'tRampOn'; end
			if( nargin() < 8 || isempty(tLBOffset4Blink) ) tLBOffset4Blink = 1000; end
			if( nargin() < 9 || isempty(tUBOffset4Blink) ) tUBOffset4Blink = -300; end
			if( nargin() < 10 || isempty(reverse2Tones) ) reverse2Tones = false; end

			if(isNewFigure)
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: BlinkRT VS Performance', sbj ), 'color', 'w' );
			end


			data = BlinkTransient.GetLabeledTrials4Blinks( folder, tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink );
			if( nargin() < 3 || isempty(blockIndices) ) blockIndices = 1 : size(data,2); end
			data = data(blockIndices);
			
			% exclude trials where blinks didn't follow experimental instruction
			for( i = 1 : size(data,2) )
				trials = data(i).trials;
				if( isfield(trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
					beepFreq = [trials.beepFreq];
					beepFreq = beepFreq - mean( unique(beepFreq) );
					if(reverse2Tones) beepFreq = -beepFreq; end
					if( size( unique(beepFreq), 2 ) == 2 )
						trials( beepFreq < 0 & [trials.hasBlink] | beepFreq > 0 & ~[trials.hasBlink] ) = [];
					else
						trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
					end	
				else
					trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
				end
				data(i).trials = trials;
			end

			Trials = [data.trials];

			txtTags = { 'Drift', 'MSac', 'Sac', 'M/Sac', 'All' };
			blinkFlag = [true, false];	% Blink, No Blink
			sacFlags = [ false, false; true, false; false, true; NaN, NaN; NaN, NaN ];	% drift only; microsaccades only; saccades only
			for( i = 1 : 2 )
				for( j = 1 : size(sacFlags,1) )
					if( j < 4 )
						trials = Trials( [Trials.hasBlink] == blinkFlag(i) & [Trials.hasMicrosac] == sacFlags(j,1) & [Trials.hasSac] == sacFlags(j,2) );
					elseif( j == 4 )		% trials with microsaccades or saccades
						trials = Trials( [Trials.hasBlink] == blinkFlag(i) & ( [Trials.hasMicrosac] | [Trials.hasSac] ) );
					else 					% all trials
						trials = Trials( [Trials.hasBlink] == blinkFlag(i) );
					end
					if( isempty(trials) ) continue; end
					tSort = -Inf * ones(size(trials));
					for( iTrial = size(trials,2) : -1 : 1 )
						sRate = trials(iTrial).sRate;
						if( blinkFlag(i) )
							% blinks = [trials(iTrial).microsaccades, trials(iTrial).saccades, trials(iTrial).blinks];
							blinks = [trials(iTrial).blinks];
							tEnd = sort( ( [blinks.start] + [blinks.duration] - 2 ) / sRate * 1000 );
							index = find( tEnd < min( trials(iTrial).tResponse, trials(iTrial).tMaskOn ) - trials(iTrial).tTrialStart, 1, 'last' );
							if( ~isempty(index) )
								tSort(iTrial) = tEnd(index) - ( trials(iTrial).tRampOn - trials(iTrial).tTrialStart );
							end
						else
							sacs = [trials(iTrial).microsaccades, trials(iTrial).saccades, trials(iTrial).blinks];
							% sacs = [trials(iTrial).blinks];
							tEnd = sort( ( [sacs.start] + [sacs.duration] - 2 ) / sRate * 1000 );
							index = find( tEnd < min( trials(iTrial).tResponse, trials(iTrial).tMaskOn ) - trials(iTrial).tTrialStart, 1, 'last' );
							if( ~isempty(index) )
								tSort(iTrial) = tEnd(index) - ( trials(iTrial).tRampOn - trials(iTrial).tTrialStart );
							end
						end
					end
					[tSort, index] = sort(tSort);
					trials = trials(index);

					tResponse = [trials.tResponse] - [trials.tRampOn];

					subplot( 2, size(sacFlags,1), (i-1)*size(sacFlags,1) + j ); hold on;
					tResponse(tSort == -Inf) = [];
					trials(tSort == -Inf) = [];
					tSort(tSort == -Inf) = [];
					plot( tSort( [trials.trialType] == 'c' ), tResponse( [trials.trialType] == 'c' ), '.', 'color', [0 0.5 0], 'MarkerSize', 10 );
					plot( tSort( [trials.trialType] == 'e' ), tResponse( [trials.trialType] == 'e' ), '.', 'color', [1 0 0], 'MarkerSize', 10 );

					if( size(tSort,2) <= 1 )
						x = get( gca, 'xlim' );
						y = get( gca, 'ylim' );
						if( diff(y) < 200 ) y = [-100 100] + round(mean(y)); end
					else
						x = [-3 3]*std(tSort) + mean(tSort);
						y = [-3 3]*std(tResponse) + mean(tResponse);
					end

					eTrials = trials( tSort < median(tSort) );	% early trials
					lTrials = trials( tSort > median(tSort) );	% late trials
					plot( ones(1,2)*median(tSort), y, 'k--', 'LineWidth', 1 );

					n1 = size(eTrials,2);
					n2 = size(lTrials,2);
					p1 = sum( [eTrials.trialType] == 'c' ) / n1;
					p2 = sum( [lTrials.trialType] == 'c' ) / n2;
					p1(n1==0) = NaN;
					p2(n2==0) = NaN;

					p = ( n1.*p1 + n2.*p2 ) ./ (n1 + n2);
					SD = sqrt( p.*(1-p) .* ( 1./n1 + 1./n2 ) );
					SD(SD==0) = NaN;
					pVal = ( 1 - normcdf( abs( abs(p1-p2) - 0.5/n1 - 0.5/n2 ), 0, SD ) ) * 2;

					text( x(1) + 0.02*diff(x), y(2), sprintf( '$\\mathbf{n_1=%d}$\n$\\mathbf{p_1=%.3f}$', n1, p1 ), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 16, 'color', 'k', 'Interpreter', 'LaTex' );
					text( x(2)+0.05*diff(x), y(2), sprintf( '$\\mathbf{n_2=%d}$\n$\\mathbf{p_2=%.3f}$', n2, p2 ), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'FontSize', 16, 'color', 'k', 'Interpreter', 'LaTex' );
					text( x(2)+0.05*diff(x), y(1)+0.02*diff(y), sprintf( '$\\mathbf{pVal=%.3f}$', pVal ), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 16, 'color', 'k', 'Interpreter', 'LaTex' );
					
					set( gca, 'xlim', x, 'ylim', y, 'LineWidth', 1, 'box', 'off', 'FontSize', 18 );
					% axis equal;
					if( i == 1 ) 
						set( title(txtTags{j}), 'FontSize', 18 );
						if( j == 3 ) xlabel('tEnd of last blink aligned to Ramp Onset (ms)'); end
					end
					if( i == 2 && j == 3 ) xlabel('tEnd of last blink/m/sac aligned to Ramp Onset (ms)'); end
					if( j == 1 ) ylabel('Report time (ms)'); end
				end
			end

			subplot( 2, size(sacFlags,1), 1 );
			pos1 = get( gca, 'position' );
			subplot( 2, size(sacFlags,1), size(sacFlags,1) + 1 );
			pos2 = get( gca, 'position' );
			set( axes( 'position', [0 0 1 1] ), 'visible', 'off' );
			text( pos1(1)/2, pos1(2) + pos1(4)/2, 'Blink', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
			text( pos2(1)/2, pos2(2) + pos2(4)/2, 'No Blink', 'FontWeight', 'bold', 'FontSize', 22, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle' );
		end


		function [n, r, pVal] = CompVaryDur( sbj, folder, blockIndices, tAlignEvent, tStart, isNewFigure, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink )
			%  tLBEvent4Blink:		hasBlink is true only if a blink happens after tLBEvent4Blink
			%  tLBOffset4Blink:		offset regarding tLBEvent4Blink
			%  tUBOffset4Blink:		offset regarding upper bound for hasBlink

			if( folder(end) == '/' || folder(end) == '\' ) folder(end) = []; end
			if( nargin() < 4 || isempty(tAlignEvent) ) tAlignEvent = 'tRampOn'; end 	% start event for microsaccades/saccades control analysis
			if( nargin() < 5 || isempty(tStart) ) tStart = 0; end 						% start time for microsaccades/saccades control analysis (relative to tAlignEvent)
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end
			if( nargin() < 7 || isempty(tLBEvent4Blink) ) tLBEvent4Blink = 'tRampOn'; end
			if( nargin() < 8 || isempty(tLBOffset4Blink) ) tLBOffset4Blink = 500; end
			if( nargin() < 9 || isempty(tUBOffset4Blink) ) tUBOffset4Blink = 0; end

			data = BlinkTransient.GetLabeledTrials4Blinks( folder, tAlignEvent, tStart, tLBEvent4Blink, tLBOffset4Blink, tUBOffset4Blink );
			if( nargin() < 3 || isempty(blockIndices) ) blockIndices = 1 : size(data,2); end
			data = data(blockIndices);
			
			for( i = 1 : size(data,2) )
				trials = data(i).trials;
				if( isfield(trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
					beepFreq = [trials.beepFreq];
					beepFreq = beepFreq - mean( unique(beepFreq) );
					if( size( unique(beepFreq), 2 ) == 2 )
						trials( beepFreq > 0 & [trials.hasBlink] | beepFreq < 0 & ~[trials.hasBlink] ) = [];
					else
						trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
					end	
				else
					trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
				end
				data(i).trials = trials;

				% data(i).trials = trials( [trials.tMaskOn] - [trials.tPlateauOn] < 800 & [trials.tMaskOn] - [trials.tPlateauOn] > 250 );
				% [data(i).trials.isShort] = deal(true);
				% trials = trials( [trials.tMaskOn] - [trials.tPlateauOn] > 800 & [trials.tMaskOn] - [trials.tPlateauOn] > 800 );
				% [trials.isShort] = deal(false);
				% data(i).trials = [data(i).trials, trials];

				bound = mean( [data(i).trials.tMaskOn] - [data(i).trials.tPlateauOn] );
				bound = 750;
				[data(i).trials( [data(i).trials.tMaskOn] - [data(i).trials.tPlateauOn] < bound ).isShort] = deal(true);
				[data(i).trials( [data(i).trials.tMaskOn] - [data(i).trials.tPlateauOn] > bound ).isShort] = deal(false);
			end
			Trials = [data.trials];

			if(isNewFigure)
				set( figure, 'NumberTitle', 'off', 'name', sprintf( '%s: Multiple Comparisons @ FixedLevel', sbj ), 'color', 'w' );
			end


			titles = {'Drift', 'M/Sac', 'All'};
			for( i = 1 : 3 )	% each page for each eye movement condition
				switch(i)
					case 1	% drift only
						trials = Trials( ~[Trials.hasMicrosac] & ~[Trials.hasSac] );
					case 2	% with m/sac
						trials = Trials( [Trials.hasMicrosac] | [Trials.hasSac] );
					case 3	% all
						trials = Trials;
				end

				for( j = 1 : 2 )	% each row for either short duration or long duration
					for( k = 1 : 2 )	% each column for either blink or no blink
						n(j,k,i) = sum( [trials.isShort] == mod(j,2) & [trials.hasBlink] == mod(k,2) );
						r(j,k,i) = sum( [trials.isShort] == mod(j,2) & [trials.hasBlink] == mod(k,2) & [trials.trialType] == 'c' );	% correct rate
					end
				end
				n(:,3,i) = sum(n(:,:,i),2);
				n(3,:,i) = sum(n(:,:,i),1);
				n(3,3,i) = NaN;
				r(:,3,i) = sum(r(:,:,i),2);
				r(3,:,i) = sum(r(:,:,i),1);
				r(3,3,i) = NaN;
				r(:,:,i) = r(:,:,i) ./ n(:,:,i);
				sd = sqrt( r(:,:,i) .* (1-r(:,:,i)) ./ n(:,:,i) );
				sd(n(:,:,i)==0) = NaN;

				% z-test
				for( z = 1 : 2 )
					if(z==1)	% short VS long
						n1 = n(1,:,i);
						n2 = n(2,:,i);
						p1 = r(1,:,i);
						p2 = r(2,:,i);
					else 		% blink VS no blink
						n1 = n(:,1,i)';
						n2 = n(:,2,i)';
						p1 = r(:,1,i)';
						p2 = r(:,2,i)';
					end

					index1 = p1 < p2;
					index2 = p1 > p2;
					p1(index1) = p1(index1) + 0.5 ./ n1(index1);
					p2(index1) = p2(index1) - 0.5 ./ n2(index1);
					p1(index2) = p1(index2) - 0.5 ./ n1(index2);
					p2(index2) = p2(index2) + 0.5 ./ n2(index2);

					p = ( n1.*p1 + n2.*p2 ) ./ (n1 + n2);
					SD = sqrt( p.*(1-p) .* ( 1./n1 + 1./n2 ) );
					SD(SD==0) = NaN;
					pVal(z,:,i) = ( 1 - normcdf( abs(p1-p2), 0, SD ) ) * 2;
				end

				subplot(2,4,(i<2)*2+(i>1)*(i+3)); cla; hold on;
				w = 5;
				nBars = 3;	% number of pairs of bars
				x = [ (1:nBars)*w-3.5, (1:nBars)*w-2.5, (1:nBars-1)*w-1.5 ];

				% bars
				h(1) = bar( x(1:nBars), r(1,:,i), 0.95/w, 'b', 'LineStyle', 'none', 'DisplayName', 'short dur', 'FaceAlpha', 0.6 );
				h(2) = bar( x( nBars+1 : nBars*2 ), r(2,:,i), 0.95/w, 'r', 'LineStyle', 'none', 'DisplayName', 'long dur', 'FaceAlpha', 0.6 );
				h(3) = bar( x( nBars*2+1 : nBars*2+2 ), r(3,1:2,i), 0.95/w, 'k', 'LineStyle', 'none', 'DisplayName', 'mixed dur', 'FaceAlpha', 0.6 );

				% error bars
				plot( reshape( [ repmat( x(1:nBars), 2, 1 ); ones(1,nBars)*NaN ], 1, [] ), reshape( [ sd(1,:)'*[-1,1] + repmat( r(1,:,i)', 1, 2 ), ones(nBars,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );
				plot( reshape( [ repmat( x( nBars+1 : nBars*2 ), 2, 1 ); ones(1,nBars)*NaN ], 1, [] ), reshape( [ sd(2,:)'*[-1,1] + repmat( r(2,:,i)', 1, 2 ), ones(nBars,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );
				plot( reshape( [ repmat( x( nBars*2+1 : nBars*2+2 ), 2, 1 ); ones(1,nBars-1)*NaN ], 1, [] ), reshape( [ sd(3,1:2)'*[-1,1] + repmat( r(3,1:2,i)', 1, 2 ), ones(nBars-1,1)*NaN ]', 1, [] ), 'k', 'LineWidth', 2 );

				% show significance
				% YL = [nanmin(p(:)-sd(:)) nanmax(p(:)+sd(:))];
				% YL = [-0.1 0.1] * (YL(2)-YL(1)) + YL;
				% YL = [ max(0, YL(1)) YL(2) ];
				YL = [0 1.1];
				set( gca, 'XLim', [0 w*nBars-1], 'XTick', [x(4), x(5), mean(x([3 6]))], 'XTickLabel', {'blink', 'no blink', 'mix'}, 'XTickLabelRotation', 10, 'YLim', YL, 'LineWidth', 1, 'FontSize', 20, 'box', 'off', 'YGrid', 'on', 'YMinorGrid', 'on' );
				for( z = 1 : 2 )
					for( k = 1 : 3 )
						if( pVal(z,k,i) < 0.1 )
							if( pVal(z,k,i) < 0.05 )
								isShowValue = false;
							else
								isShowValue = true;
							end
							if( z == 1 )
								ToolKit.ShowSignificance( [x(k), r(1,k,i)+sd(1,k)], [x(k+nBars), r(2,k,i)+sd(2,k)], pVal(z,k,i), 0.02, isShowValue, 'FontSize', 14 );
							else
								ToolKit.ShowSignificance( [x(1+(k-1)*nBars), r(k,1,i)+sd(k,1)], [x(2+(k-1)*nBars), r(k,2,i)+sd(k,2)], pVal(z,k,i), 0.02 * (k+1), isShowValue, 'FontSize', 14 );
							end
						end
					end
				end
				
				% show number of trials
				hAlign = {'right', 'left'};
				vAlign = {'bottom', 'top'};
				for( k = 1 : 3 )
					text( mean( x( [1 nBars+1] + k-1 ) ), YL(1), num2str(n(1,k,i)), 'color', 'k', 'FontSize', 14, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom' );
				end
				for( k = 1 : 3 )
					text( x(nBars+k), YL(1) + 0.05*(YL(2)-YL(1)), num2str(n(2,k,i)), 'color', 'k', 'FontSize', 14, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom' );
				end
				for( k = 1 : 2 )
					text( mean( x( [nBars+1 nBars*2+1] + k-1 ) ), YL(1), num2str(n(3,k,i)), 'color', 'k', 'FontSize', 14, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom' );
				end

				set( legend(h), 'location', 'northeast', 'FontSize', 12 );
				ylabel('Correct rate');
				title(titles{i});


			end


			
		end


		function SimulateBinoDiff( p1, p2, nTrials, nBlocks, nSimulations, method )
			%%  In order to assess the viability of an experimental design (nBlocks * nTrials each condition) aiming at testing the difference between the true correct ratios (p1 and p2)
			% under two different experimental conditions, we simulate two data sets using binomial distributions with probabilities p1 and p2 respectively, each data set consists of 
			% nBlocks * nTrials trials, and then repeat the the simulation for nSimulations times.
			%   After the simulation, we do two statistical tests:
			%		1. For each simulation, we calculate the correct ratio for each simulated block, then do a paired test (paired t-test or signed-ranksum test) between the correct ratios
			%		  from two conditions, and finally plot the distribution of p-values from all simulations
			%		2. We calculate the overall correct ratio for each block, then do a paired test (paired t-test or signed-ranksum test) between the correct ratios from two conditions
			%
			%	method:		test method, 'signrank' (default), 'ttest', 'ranksum', or 'ztest'

			if( nargin() < 6 ) method = 'signrank'; end
			
			rng('shuffle');

			for( i = nSimulations : -1 : 1 )
				sim1(i,:) = binornd( nTrials, p1 , 1, nBlocks );
				sim2(i,:) = binornd( nTrials, p2 , 1, nBlocks );

				switch(method)
					case 'signrank'
						pVals(i) = signrank( sim1(i,:) / nTrials, sim2(i,:) / nTrials );
					case 'ttest'
						[~, pVals(i)] = ttest( sim1(i,:) / nTrials, sim2(i,:) / nTrials );
					case 'ranksum'
						pVals(i) = ranksum( sim1(i,:) / nTrials, sim2(i,:) / nTrials );
					case 'ztest'
						% [~, pVals(i)] = ztest( sim1(i,:) / nTrials - sim2(i,:) / nTrials, mean( sim1(i,:) - sim2(i,:) ), sqrt( ( mean(sim1(i,:)) * ( 1-mean(sim1(i,:)) ) + mean(sim2(i,:)) * ( 1 - mean(sim2(i,:)) ) ) / nTrials ) );
						p = mean( sim1(i,:) + sim2(i,:) ) / 2 / nTrials;
						pVals(i) = ( 1 - normcdf( abs( mean( sim1(i,:) / nTrials ) - mean( sim2(i,:) / nTrials ) ), 0, sqrt( p*(1-p) * ( 1/(nTrials*nBlocks) + 1/(nTrials*nBlocks) ) ) ) ) * 2;
					otherwise
						pVals(i) = signrank( sim1(i,:) / nTrials, sim2(i,:) / nTrials );
						
				end
			end
			MPDs = ( mean(sim1,2) - mean(sim2,2) ) / nTrials;	% mean simulated performance difference across blocks for each simulation 

			set( figure, 'NumberTitle', 'off', 'name', 'Simulate Binomial Difference', 'color', 'w' );
			FontSize = 20;
			LineWidth = 1;

			subplot(1,2,1);
			centers = 0.0125:0.025:1;
			data = hist( pVals, centers );
			bar( centers, data, 0.9, 'k', 'LineStyle', 'none' );
			set( gca, 'xlim', [0 1], 'ylim', [0 max(data)*1.2], 'FontSize', 20, 'LineWidth', LineWidth );
			text( 0.5, max(data)*1.15, sprintf( 'Prop <0.05: %.1f%%\nProp <0.1: %.1f%%', sum( [pVals<0.05; pVals<0.1], 2 ) / nSimulations * 100 ), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', FontSize-5 );
			xlabel( 'p-value' );
			ylabel( 'Number of simulations' );


			subplot(1,2,2);
			centers = -0.9875:0.025:1;
			data = hist( MPDs, centers );
			bar( centers, data, 0.9, 'k', 'LineStyle', 'none' );
			set( gca, 'xlim', [-1 1], 'ylim', [0 max(data)*1.2], 'FontSize', 20, 'LineWidth', LineWidth );
			text( 0, max(data)*1.15, sprintf( 'Prop <0: %.1f%%', sum(MPDs<0.0316) / nSimulations * 100 ), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', FontSize-5 );
			xlabel( 'Average performance difference across blocks' );
			ylabel( 'Number of simulations' );

		end


		function CheckEyeTrace( data )
			if(ischar(data))
				Trials = load(data);
				Trials = Trials.Trials;
			elseif(isstruct(data))
				Trials = data;
			end

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

				plot( [Trials(iTrial).x.position; Trials(iTrial).y.position]'/60 );
				YLim = get( gca, 'YLim' );
				cla;

				h = [];

				% fp on
				h(end+1) = plot( [1 1] * (Trials(iTrial).tFpOn - Trials(iTrial).tTrialStart), YLim, 'b', 'DisplayName', 'Fp On' );

				% beep on
				h(end+1) = plot( [1 1] * (Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart), YLim, 'r', 'DisplayName', 'Beep On' );

				% response
				h(end+1) = plot( [1 1] * (Trials(iTrial).tResponse - Trials(iTrial).tTrialStart), YLim, 'g', 'DisplayName', 'Response' );

				% ramp
				h(end+1) = fill( [ [1 1] * Trials(iTrial).tRampOn, [1 1] * Trials(iTrial).tPlateauOn ] - Trials(iTrial).tTrialStart, YLim([1 2 2 1]),...
							 [0 0 0], 'LineStyle', 'none', 'FaceColor', 'c', 'FaceAlpha', 0.25, 'DisplayName', 'Ramp' );

				% plateau
				h(end+1) = fill( [ [1 1] * Trials(iTrial).tPlateauOn, [1 1] * Trials(iTrial).tMaskOn ] - Trials(iTrial).tTrialStart, YLim([1 2 2 1]),...
							 [0 0 0], 'LineStyle', 'none', 'FaceColor', 'g', 'FaceAlpha', 0.5, 'DisplayName', 'Plateau' );

				% blinks
				starts = ([Trials(iTrial).blinks.start] - 1) / Trials(iTrial).sRate * 1000;
				ends = starts + ([Trials(iTrial).blinks.duration] - 1) / Trials(iTrial).sRate * 1000;
				if( ~isempty( starts ) )
					h(end+1) = fill( reshape( [starts; ends; ends; starts; starts], 1, [] ), reshape( repmat( YLim([1 1 2 2 1])', 1, size(starts,2) ), 1, [] ),...
								 [0 0 0], 'LineStyle', 'none', 'FaceColor', 'k', 'FaceAlpha', 0.75, 'DisplayName', 'Blink' );
				else
					title( sprintf( 'iTrial: %d | NO BLINK DETECTED!!!', iTrial ) );
				end

				sRate = Trials(iTrial).sRate;
				ends( starts > length(Trials(iTrial).x.position) / Trials(iTrial).sRate * 1000 ) = [];
				starts( starts > length(Trials(iTrial).x.position) / Trials(iTrial).sRate * 1000 ) = [];
				for( ii = 1 : -1)%size(starts,2) )
					tStart = starts(ii);			% time when P1 occluded (ms)
					tEnd = ends(ii);				% time when P1 un-occluded (ms)
					s2 = round( tStart/1000*sRate );
					s1 = s2;	% start of eye lid movement (suppose eye lid and eye start to move simultaniously), in samples
					lim = floor((tStart-50)/1000*sRate);
					while(true)
						s = find( Trials(iTrial).velocity(lim:s1) > 180, 1, 'last' );
						if( ~isempty(s) && lim + s -1 > s1 - 15/1000*sRate )
							s1 = lim-1 + find( Trials(iTrial).velocity(lim+(0:s-1)) < 180, 1, 'last' );
							if( isempty(s1) )
								s1 = lim;
								break;
							end
						else
							break;
						end
					end
					s2 = (s2-s1) * 0.1538 + s2;		% time when eye lid fully closed, in samples

					x = Trials(iTrial).x.position( lim : round((tStart+5)/1000*sRate) );
					y = Trials(iTrial).y.position( lim : round((tStart+5)/1000*sRate) );
					x = x - x(end);
					y = y - y(end);
					[~,ix] = max(abs(x));
					[~,iy] = max(abs(y));
					tEye(1) = (lim + min(ix,iy)-1) / sRate * 1000;

					vel = Trials(iTrial).velocity( lim : round(tStart/1000*sRate) );
					derive = diff(vel);
					idx = find( derive(2:end) .* derive(1:end-1) <= 0, 1, 'last' );
					if( ~isempty(idx) )
						tEye(1) = (lim + idx + 1);		% time when P4 occluded therefore eye trace afterwards is not reliable, in samples
					else
						tEye(1) = tStart/1000*sRate;
					end

					s3 = round( tEnd/1000*sRate );
					s4 = round( tEnd/1000*sRate );	% end of eye lid movement (suppose eye lid and eye stop moving simultatneously), in samples
					lim = min( ceil( (tEnd+150)/1000*sRate ), Trials(iTrial).samples );
					while(true)
						s = find( Trials(iTrial).velocity(s4:lim) > 180, 1, 'first' );
						if( ~isempty(s) && s4 + s - 1 < s4 + 15/1000*sRate )
							s4 = s4-1 + find( Trials(iTrial).velocity(s4+s-1:lim) < 180, 1, 'first' );
							if( isempty(s4) )
								s4 = lim;
								break;
							end
						else
							break;
						end
					end
					s3 = s3 - (s4-s3) * 0.1563;		% time when eye starts to open
					tLid = [s1 s2 s3 s4] / sRate * 1000;

					x = Trials(iTrial).x.position( round((tEnd-5)/1000*sRate) : lim );
					y = Trials(iTrial).y.position( round((tEnd-5)/1000*sRate) : lim );
					x = x - x(1);
					y = y - y(1);
					[~,ix] = max(abs(x));
					[~,iy] = max(abs(y));
					tEye(2) = (round((tEnd-5)/1000*sRate) + max(ix,iy)-1) / sRate * 1000;
					vel = Trials(iTrial).velocity( round((tEnd+5)/1000*sRate) : lim );
					derive = diff(vel);
					idx = find( derive(2:end) .* derive(1:end-1) <=0, 1, 'first' );
					if( ~isempty(idx) )
						tEye(2) = (tEnd+5)/1000*sRate + (idx + 1);		% time when P4 un-occluded, eye trace before which is not reliable, in samples
					else
						tEye(2) = (tEnd+5) / 1000 * sRate;
					end


					plot( reshape([tLid; tLid; ones(1,4)*NaN],1,[]), reshape( repmat([YLim,NaN],1,4), 1, [] ), 'r--', 'LineWidth', 1 );
					plot( reshape([tEye; tEye; ones(1,2)*NaN],1,[]), reshape( repmat([YLim,NaN],1,2), 1, [] ), 'g--', 'LineWidth', 1 );
				end


				% notracks
				starts = ([Trials(iTrial).notracks.start] - 1) / Trials(iTrial).sRate * 1000;
				ends = starts + ([Trials(iTrial).notracks.duration] - 1) / Trials(iTrial).sRate * 1000;
				if( ~isempty( starts ) )
					h(end+1) = fill( reshape( [starts; ends; ends; starts; starts], 1, [] ), reshape( repmat( YLim([1 1 2 2 1])', 1, size(starts,2) ), 1, [] ),...
								 [1 1 0], 'LineStyle', 'none','FaceAlpha', 0.75, 'DisplayName', 'NoTrack' );
				end
				
				% eye trace
				h(end+1) = plot( (0 : Trials(iTrial).samples - 1) / Trials(iTrial).sRate * 1000, Trials(iTrial).x.position/60, 'color', 'b', 'LineWidth', 1, 'DisplayName', 'Eye X' );
				h(end+1) = plot( (0 : Trials(iTrial).samples - 1) / Trials(iTrial).sRate * 1000, Trials(iTrial).y.position/60, 'color', 'r', 'LineWidth', 1, 'DisplayName', 'Eye Y' );
				
				% saccades
				n = size(h,2);
				saccades = Trials(iTrial).saccades;
				for( iSac = 1 : size( saccades.start, 2 ) )
					h(n+1) = plot( ( (0:saccades.duration(iSac)-1) + saccades.start(iSac) - 1 ) / Trials(iTrial).sRate * 1000, Trials(iTrial).x.position( (0:saccades.duration(iSac)-1) + saccades.start(iSac) )/60, 'color', 'k', 'LineWidth', 2, 'DisplayName', 'Saccade' );
					plot( ( (0:saccades.duration(iSac)-1) + saccades.start(iSac) - 1 ) / Trials(iTrial).sRate * 1000, Trials(iTrial).y.position( (0:saccades.duration(iSac)-1) + saccades.start(iSac) )/60, 'color', 'k', 'LineWidth', 2 );
				end

				% microsaccades
				n = size(h,2);
				microsaccades = Trials(iTrial).microsaccades;
				for( iSac = 1 : size( microsaccades.start, 2 ) )
					h(n+1) = plot( ( (0:microsaccades.duration(iSac)-1) + microsaccades.start(iSac) - 1 ) / Trials(iTrial).sRate * 1000, Trials(iTrial).x.position( (0:microsaccades.duration(iSac)-1) + microsaccades.start(iSac) )/60, 'color', [0.5 0.5 0.5], 'LineWidth', 2, 'DisplayName', 'Microsaccade' );
					plot( ( (0:microsaccades.duration(iSac)-1) + microsaccades.start(iSac) - 1 ) / Trials(iTrial).sRate * 1000, Trials(iTrial).y.position( (0:microsaccades.duration(iSac)-1) + microsaccades.start(iSac) )/60, 'color', [0.5 0.5 0.5], 'LineWidth', 2 );
				end

				set( legend(h), 'location', 'EastOutside' );
			end
		end


		function CheckEyeDrift( data )
			if(ischar(data))
				Trials = load(data);
				Trials = Trials.Trials;
			elseif(isstruct(data))
				Trials = data;
			end
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
				ylabel( 'Eye position (arc mins)' );
				
				% eye trace
				% x = zeros( 1, sum([Trials(iTrial).drifts.duration]) );
				% y = zeros(size(x));
				% index = 0;
				% for( i = 1 : size( Trials(iTrial).drifts.start, 2 ) )
				% 	if( any( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration ) || any( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start ) )
				% 		continue;
				% 	end
				% 	x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).x.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
				% 	y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).y.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
				% 	if( index > 0 )
				% 		x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = x( (1 : Trials(iTrial).drifts.duration(i)) + index ) - x(index+1) + x(index);
				% 		y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = y( (1 : Trials(iTrial).drifts.duration(i)) + index ) - y(index+1) + y(index);
				% 	end
				% 	index = index + Trials(iTrial).drifts.duration(i);
				% end
				% x( index+1 : end ) = [];
				% y( index+1 : end ) = [];


				x = zeros( 1, sum([Trials(iTrial).drifts.duration]) );
				y = zeros(size(x));
				index = 0;
				Trials(iTrial).blinks.start = [Trials(iTrial).blinks.start, Trials(iTrial).notracks.start];
				Trials(iTrial).blinks.duration = [Trials(iTrial).blinks.duration, Trials(iTrial).notracks.duration];
				for( i = 1 : size( Trials(iTrial).drifts.start, 2 ) )
					idx = find( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration );
					if( ~isempty(idx) )
						st = Trials(iTrial).drifts.start(i) + 250;
						dur = Trials(iTrial).drifts.duration(i) - 250;
						if( dur < 1 )
							continue;
						else
							Trials(iTrial).drifts.start(i) = st;
							Trials(iTrial).drifts.duration(i) = dur;
						end
					end
					idx = find( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start );
					if( ~isempty(idx) )
						dur = Trials(iTrial).drifts.duration(i) - 50;
						if( dur < 1 )
							continue;
						else
							Trials(iTrial).drifts.duration(i) = dur;
						end
					end
					x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).x.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
					y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).y.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
					if( index > 0 )
						x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = x( (1 : Trials(iTrial).drifts.duration(i)) + index ) - x(index+1) + x(index);
						y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = y( (1 : Trials(iTrial).drifts.duration(i)) + index ) - y(index+1) + y(index);
					end
					index = index + Trials(iTrial).drifts.duration(i);
				end
				x( [1:min(10,end), index+1 : end] ) = [];
				y( [1:min(10,end), index+1 : end] ) = [];


				h = plot( [x; y]'/1 );
				if( isempty(h) ) return; end
				set( h(1), 'DisplayName', 'Eye X' );
				set( h(2), 'DisplayName', 'Eye Y' );
				set( legend(h), 'location', 'EastOutside' );
			end
		end

		function [tTriggers, tLid, tEye, x, y] = BlinkParams(trials)
			tTriggers = ones( length(trials), 2 ) * NaN;
			tLid = ones( length(trials), 4 ) * NaN;
			tEye = ones( length(trials), 2 ) * NaN;
			x{length(trials)} = [];
			y{length(trials)} = [];

			for( iTrial = 1 : length(trials) )
				%% find blink parameters
				tStart = trials(iTrial).blinks.start / trials(iTrial).sRate * 1000;
				dur = trials(iTrial).blinks.duration / trials(iTrial).sRate * 1000;
				dur( tStart <= trials(iTrial).tBlinkBeepOn - trials(iTrial).tTrialStart ) = [];
				tStart( tStart <= trials(iTrial).tBlinkBeepOn - trials(iTrial).tTrialStart ) = [];
				if( isempty(tStart) ) continue; end
				tStart = tStart(1);			% time when P1 occluded (ms)
				tEnd = tStart + dur(1);		% time when P1 un-occluded (ms)
				if( tEnd/1000*trials(iTrial).sRate >= size(trials(iTrial).x.position,2) ) continue; end
				s2 = round( tStart/1000*trials(iTrial).sRate );
				s1 = s2;	% start of eye lid movement (suppose eye lid and eye start to move simultaniously), in samples
				lim = floor((tStart-80)/1000*trials(iTrial).sRate);
				while(true)
					s = find( trials(iTrial).velocity(lim:s1) > 180, 1, 'last' );
					if( ~isempty(s) && lim + s -1 > s1 - 15/1000*trials(iTrial).sRate )
						s1 = lim-1 + find( trials(iTrial).velocity(lim+(0:s-1)) < 180, 1, 'last' );
						if( isempty(s1) )
							s1 = lim;
							break;
						end
					else
						break;
					end
				end
				s2 = (s2-s1) * 0.1538 + s2;		% time when eye lid fully closed, in samples

				s3 = round( tEnd/1000*trials(iTrial).sRate );
				s4 = round( tEnd/1000*trials(iTrial).sRate );	% end of eye lid movement (suppose eye lid and eye stop moving simultatneously), in samples
				lim = ceil( (tEnd+150)/1000*trials(iTrial).sRate );
				while(true)
					s = find( trials(iTrial).velocity(s4:lim) > 180, 1, 'first' );
					if( ~isempty(s) && s4 + s - 1 < s4 + 15/1000*trials(iTrial).sRate )
						s4 = s4-1 + find( trials(iTrial).velocity(s4+s-1:lim) < 180, 1, 'first' );
						if( isempty(s4) )
							s4 = lim;
							break;
						end
					else
						break;
					end
				end
				s3 = s3 - (s4-s3) * 0.1563;		% time when eye starts to open
				tLid(iTrial,:) = round( [s1 s2 s3 s4] / trials(iTrial).sRate*1000 - (trials(iTrial).tRampOn - trials(iTrial).tTrialStart) );	% in ms


				%% find parameters of eye movements during blink
				lim = floor((tStart-50)/1000*trials(iTrial).sRate);
				vel = trials(iTrial).velocity( lim : round(tStart/1000*trials(iTrial).sRate) );
				derive = diff(vel);
				idx = find( derive(2:end) .* derive(1:end-1) <= 0, 1, 'last' );
				if( ~isempty(idx) )
					tEye(iTrial,1) = (lim + idx + 1);		% time when P4 occluded therefore eye trace afterwards is not reliable, in samples
				else
					tEye(iTrial,1) = tStart/1000*trials(iTrial).sRate;
				end

				lim = ceil( (tEnd+150)/1000*trials(iTrial).sRate );
				vel = trials(iTrial).velocity( round((tEnd+5)/1000*trials(iTrial).sRate) : lim );
				derive = diff(vel);
				idx = find( derive(2:end) .* derive(1:end-1) <=0, 1, 'first' );
				if( ~isempty(idx) )
					tEye(iTrial,2) = (tEnd+5)/1000*trials(iTrial).sRate + (idx + 1);		% time when P4 un-occluded, eye trace before which is not reliable, in samples
				else
					tEye(iTrial,2) = (tEnd+5) / 1000 * trials(iTrial).sRate;
				end
				tEye(iTrial,:) = round( tEye(iTrial,:)/trials(iTrial).sRate*1000 - (trials(iTrial).tRampOn - trials(iTrial).tTrialStart) );	% in ms
				index = (0:trials(iTrial).samples-1)/trials(iTrial).sRate*1000 >= tEye(iTrial,1) + (trials(iTrial).tRampOn - trials(iTrial).tTrialStart) & (0:trials(iTrial).samples-1)/trials(iTrial).sRate*1000 <= tEye(iTrial,2) + (trials(iTrial).tRampOn - trials(iTrial).tTrialStart);
				x{iTrial} = trials(iTrial).x.position(index);
				y{iTrial} = trials(iTrial).y.position(index);

				tTriggers(iTrial,:) = round( [tStart, tEnd] - ( trials(iTrial).tRampOn - trials(iTrial).tTrialStart ) );
			end

			x(isnan(tTriggers(:,1))) = [];
			y(isnan(tTriggers(:,1))) = [];
			tTriggers( isnan(tTriggers(:,1)), : ) = [];
			tLid( isnan(tLid(:,1)), : ) = [];
			tEye( isnan(tEye(:,1)), : ) = [];
		end


		function RT = BlinkRT_OLD20190527( sbj, folder, indices, alignEvt, fitKernel, isPlot, tStep, isNewFigure )
			%% RT:	in ms

			if( nargin() < 4 || isempty(alignEvt) ) alignEvt = 'tBlinkBeepOn'; end
			if( nargin() < 5 || isempty(fitKernel) ) isFit = false;
			else isFit = true; end
			if( nargin() < 6 ) isPlot = true; end
			if( nargin() < 7 || isempty(tStep) ) tStep = 5; end 	% by default, 5 ms
			if( nargin() < 8 ) isNewFigure = true; end

			RT = [];
			list = dir(folder);
			index = false(size(list));
			for( i = 1 : size(list,1) )
				if( strcmp( list(i).name, '.' ) || strcmp( list(i).name, '..' ) || strcmpi( list(i).name(1:4), 'demo' ) || strcmpi( list(i).name(1:3), 'X. ' ) || strcmpi( list(i).name, 'calibration') )
					index(i) = true;
				end
			end
			list(index) = [];

			if( nargin() < 3 || isempty(indices) ) indices = 1 : size(list,1); end

			for( i = 1 : size(list,1) )
				if( all( i ~= indices ) ) continue; end
				if( list(i).isdir() )
					RT = [ RT, BlinkTransient.BlinkRT( sbj, fullfile(folder, list(i).name), [], alignEvt, [], 0 ) ];
				else
					if( strcmp( list(i).name, 'Trials.mat' ) )
						load( fullfile(folder, list(i).name), 'Trials' );
						Trials = BlinkTransient.ETScreen(Trials);

						tmpRT = zeros(size(Trials));
						for( iTrial = size(Trials,2) : -1 : 1 )
							starts = [Trials(iTrial).blinks.start] / Trials(iTrial).sRate * 1000;
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


			%% fitting the distribution
			if(isFit)
				switch( fitKernel )
					case { 'gev' }
						pdffun = @(x, param1, param2, param3) pdf( fitKernel, x, param1, param2, param3 );
						cdffun = @(x, param1, param2, param3) cdf( fitKernel, x, param1, param2, param3 );

					case { 'norm', 'normal', 'logn', 'lognormal', 'beta' }
						iParams = [ 2, 3; 2, 3 ];
						pdffun = @(x, param1, param2) pdf( fitKernel, x, param1, param2 );
						cdffun = @(x, param1, param2) cdf( fitKernel, x, param1, param2 );
				end
				
				if( strcmpi( alignEvt, 'tblinkbeepon' ) )
					rt = {RT};
				else
					rt = { RT(RT<mean(RT)), RT(RT>mean(RT)) };
				end
				options = statset( 'display', 'off', 'MaxIter', 100000, 'MaxFunEvals', 200000, 'FunValCheck', 'off' );
				
				for( i = size(rt,2) : -1 : 1 )

					%% fitdist
					pd = fitdist( (rt{i})', fitKernel, 'options', options );
					paramsCell{i} = num2cell(pd.Params);

					if( strcmpi( fitKernel, 'gev' ) )
						lowerbounds = [paramsCell{i}{1}-0.5, paramsCell{i}{2}/5, paramsCell{i}{3}-50]; %[ -0.05 std(rt{i})/5 0 ];
                    	upperbounds = [paramsCell{i}{1}+0.5, paramsCell{i}{2}*5, paramsCell{i}{3}+50]; %[ 1 std(rt{i}) mean(rt{i}) ];
						
						%% brute force
						% optimal.params = num2cell(lowerbounds);
						% optimal.p1 = 0;
						% optimal.p2 = 0;
						% N = 100;
						% for( iIter = 0 : (N+1)^size(lowerbounds,2)-1 )
						% 	for( iBit = size(lowerbounds,2) : -1 : 1 )
						% 		bitScales(iBit) = mod( floor( iIter/(N+1)^(size(lowerbounds,2)-iBit) ), N+1 );
						% 	end
						% 	fprintf( [ 'index: ', repmat('%4d ',1,size(lowerbounds,2)) ], bitScales );
						% 	params = num2cell( lowerbounds + (upperbounds - lowerbounds) / N .* bitScales );
						% 	fprintf( [ ' | params: ', repmat('%.3f ',1,size(lowerbounds,2)) ], params{:} );
						% 	tmpRT = sort(rt{i});
						% 	edges = unique( [ rt{i}( 1 : max([5,ceil(size(rt{i},2)/100)]) : end ), rt{i}(end) ] );
						% 	[ ~, p1 ] = chi2gof( rt{i}, 'cdf', [ {cdffun}, params(1,:) ], 'edges', edges );
						% 	[ ~, p2 ] = kstest( rt{i}, [ unique(rt{i})', cdffun( unique(rt{i})', params{:} ) ] );
						% 	fprintf( ' | p1=%.3f | p2=%.3f\n', p1, p2 );
						% 	if( optimal.p1 + optimal.p2 < p1 + p2 )
						% 		optimal.p1 = p1;
						% 		optimal.p2 = p2;
						% 		optimal.params = params;
						% 	end
						% end
						% paramsCell{i} = optimal.params;


						%% curve fitting with least square root
						edges = min(RT) - tStep/2 : tStep : max(RT) + tStep/2;
						[fitobj, gof, output] = fit( mean( [edges(1:end-1); edges(2:end)] )', ToolKit.Hist( rt{i}, edges, false, true )' / tStep, fittype( 'gevpdf(x,param1,param2,param3)' ), 'StartPoint', [paramsCell{i}{:}] );
						paramsCell{i} = { fitobj.param1, fitobj.param2, fitobj.param3 };

					end


					% test the fitting
					tmpRT = sort(rt{i});
		            edges = unique( [ tmpRT( 1 : max([5,ceil(size(tmpRT,2)/100)]) : end ), tmpRT(end) ] );
					[ chi2_h, chi2_p(i), chi2_st ] = chi2gof( tmpRT, 'cdf', [ {cdffun}, paramsCell{i} ], 'edges', edges );
					[ ks_h, ks_p(i), ks_st, ks_cv ] = kstest( tmpRT, [ unique(tmpRT)', cdffun( unique(tmpRT)', paramsCell{i}{:} ) ] );
				end
			end

			
			%% plot
			if( isPlot )
				if( isNewFigure )
					name = [sbj, ': Blink'];
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
				if(isFit)
					hold on;
					y = get( gca, 'ylim' );
					if( strcmpi( alignEvt, 'tblinkbeepon' ) )
						xLoc = 0.5*x(1) + 0.5*mean(x);
					else
						xLoc = [0.95*x(1)+0.05*mean(x), 0.95*mean(x)+0.05*x(2)];
					end
					for( i = 1 : size(rt,2) )
						t = min(rt{i}) - tStep*3 : tStep : max(rt{i}) + tStep*3;
						plot( t, pdf( fitKernel, t, paramsCell{i}{:} ) * size(rt{i},2) * tStep, 'k', 'LineWidth', 2 );

						text( xLoc(i), y(2),...
						{ 'During Fixation:';...
						  sprintf( '\\indent Chi2\\_gof: $p=%.4f$', chi2_p(i) );...
						  sprintf( '\\indent KS\\_Test:  $p = %.4f$', ks_p(i) );...
						  sprintf( [ '\\indent $f(x)=\\mbox{pdf}("%s",x,%.3f', repmat(',%.3f',1,size(paramsCell{1},2)-1), ')$' ], fitKernel, paramsCell{i}{:} ) },...
						'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'interpreter', 'latex', 'FontSize', 20 );
					end
					
					% text( , y(2),...
					% 	{ 'During Stimulus:';...
					% 	  sprintf( '\\indent Chi2\\_gof: $p=%.4f$', chi2_p(2) );...
					% 	  sprintf( '\\indent KS\\_Test:  $p=%.4f$', ks_p(2) );...
					% 	  sprintf( [ '\\indent $f(x)=\\mbox{pdf}("%s",x,%.3f', repmat(',%.3f',1,size(paramsCell{1},2)-1), ')$' ], fitKernel, paramsCell{2}{:} ) },...
					% 	'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'interpreter', 'latex', 'FontSize', 20 );
				end
				set( gca, 'XLim', x, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				xlabel( sprintf( 'Time aligned to %s (ms)', alignEvt ) );
				ylabel( 'Number of trials' );
			end
		end

		function RT = BlinkRT( sbj, folder, indices, alignEvt, fitKernel, isPlot, tStep, isNewFigure )
			%% RT:	in ms

			if( nargin() < 4 || isempty(alignEvt) ) alignEvt = 'tBlinkBeepOn'; end
			if( nargin() < 5 || isempty(fitKernel) ) isFit = false;
			else isFit = true; end
			if( nargin() < 6 ) isPlot = true; end
			if( nargin() < 7 || isempty(tStep) ) tStep = 5; end 	% by default, 5 ms
			if( nargin() < 8 ) isNewFigure = true; end

			RT = [];
			Data4Blinks = BlinkTransient.GetLabeledTrials4Blinks(folder,[],[],'tRampOn',0,0);%,'tPlateauOn',0);
			if( nargin() < 3 || isempty(indices) )
				Trials = [Data4Blinks.trials];
			else
				Trials = [Data4Blinks(indices).trials];
			end
			Trials( isnan([Trials.hasBlink]) ) = [];
			Trials( [Trials.tBlinkBeepOn] - [Trials.tRampOn] > -600 & ~[Trials.hasBlink] | [Trials.tBlinkBeepOn] - [Trials.tRampOn] < -600 & [Trials.hasBlink] ) = [];
			Trials = BlinkTransient.ETScreen(Trials);
			if( isempty(Trials) ) return; end

			RT = zeros(size(Trials));
			for( iTrial = size(Trials,2) : -1 : 1 )
				starts = [Trials(iTrial).blinks.start] / Trials(iTrial).sRate * 1000;
				starts( starts <= Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart ) = [];
				if( isempty(starts) )
					RT(iTrial) = NaN;
					continue;
				end

				RT(iTrial) = starts(1) - (Trials(iTrial).(alignEvt) - Trials(iTrial).tTrialStart);
			end
			% RT(RT < 0) = [];
			RT(isnan(RT)) = [];
			
			%% fitting the distribution
			if(isFit)
				switch( fitKernel )
					case { 'gev' }
						pdffun = @(x, param1, param2, param3) pdf( fitKernel, x, param1, param2, param3 );
						cdffun = @(x, param1, param2, param3) cdf( fitKernel, x, param1, param2, param3 );

					case { 'norm', 'normal', 'logn', 'lognormal', 'beta' }
						iParams = [ 2, 3; 2, 3 ];
						pdffun = @(x, param1, param2) pdf( fitKernel, x, param1, param2 );
						cdffun = @(x, param1, param2) cdf( fitKernel, x, param1, param2 );
				end
				
				if( strcmpi( alignEvt, 'tblinkbeepon' ) )
					rt = {RT};
				else
					rt = { RT(RT<mean(RT)), RT(RT>mean(RT)) };
				end
				options = statset( 'display', 'off', 'MaxIter', 100000, 'MaxFunEvals', 200000, 'FunValCheck', 'off' );
				
				for( i = size(rt,2) : -1 : 1 )

					%% fitdist
					pd = fitdist( (rt{i})', fitKernel, 'options', options );
					paramsCell{i} = num2cell(pd.Params);

					if( strcmpi( fitKernel, 'gev' ) )
						lowerbounds = [paramsCell{i}{1}-0.5, paramsCell{i}{2}/5, paramsCell{i}{3}-50]; %[ -0.05 std(rt{i})/5 0 ];
                    	upperbounds = [paramsCell{i}{1}+0.5, paramsCell{i}{2}*5, paramsCell{i}{3}+50]; %[ 1 std(rt{i}) mean(rt{i}) ];
						
						%% brute force
						% optimal.params = num2cell(lowerbounds);
						% optimal.p1 = 0;
						% optimal.p2 = 0;
						% N = 100;
						% for( iIter = 0 : (N+1)^size(lowerbounds,2)-1 )
						% 	for( iBit = size(lowerbounds,2) : -1 : 1 )
						% 		bitScales(iBit) = mod( floor( iIter/(N+1)^(size(lowerbounds,2)-iBit) ), N+1 );
						% 	end
						% 	fprintf( [ 'index: ', repmat('%4d ',1,size(lowerbounds,2)) ], bitScales );
						% 	params = num2cell( lowerbounds + (upperbounds - lowerbounds) / N .* bitScales );
						% 	fprintf( [ ' | params: ', repmat('%.3f ',1,size(lowerbounds,2)) ], params{:} );
						% 	tmpRT = sort(rt{i});
						% 	edges = unique( [ rt{i}( 1 : max([5,ceil(size(rt{i},2)/100)]) : end ), rt{i}(end) ] );
						% 	[ ~, p1 ] = chi2gof( rt{i}, 'cdf', [ {cdffun}, params(1,:) ], 'edges', edges );
						% 	[ ~, p2 ] = kstest( rt{i}, [ unique(rt{i})', cdffun( unique(rt{i})', params{:} ) ] );
						% 	fprintf( ' | p1=%.3f | p2=%.3f\n', p1, p2 );
						% 	if( optimal.p1 + optimal.p2 < p1 + p2 )
						% 		optimal.p1 = p1;
						% 		optimal.p2 = p2;
						% 		optimal.params = params;
						% 	end
						% end
						% paramsCell{i} = optimal.params;


						%% curve fitting with least square root
						edges = min(RT) - tStep/2 : tStep : max(RT) + tStep/2;
						[fitobj, gof, output] = fit( mean( [edges(1:end-1); edges(2:end)] )', ToolKit.Hist( rt{i}, edges, false, true )' / tStep, fittype( 'gevpdf(x,param1,param2,param3)' ), 'StartPoint', [paramsCell{i}{:}] );
						paramsCell{i} = { fitobj.param1, fitobj.param2, fitobj.param3 };

					end


					% test the fitting
					tmpRT = sort(rt{i});
		            edges = unique( [ tmpRT( 1 : max([5,ceil(size(tmpRT,2)/100)]) : end ), tmpRT(end) ] );
					[ chi2_h, chi2_p(i), chi2_st ] = chi2gof( tmpRT, 'cdf', [ {cdffun}, paramsCell{i} ], 'edges', edges );
					[ ks_h, ks_p(i), ks_st, ks_cv ] = kstest( tmpRT, [ unique(tmpRT)', cdffun( unique(tmpRT)', paramsCell{i}{:} ) ] );
				end
			end

			
			%% plot
			if( isPlot )
				if( isNewFigure )
					name = [sbj, ': Blink'];
					if( strcmpi( alignEvt, 'tblinkbeepon' ) ) name = [name,'RT'];
					else name = [name, 'Aligned2', alignEvt]; end
					set( figure, 'NumberTitle', 'off', 'name', name, 'color', 'w' );
				end
				ToolKit.Hist( RT, min(RT) - tStep/2 : tStep : max(RT) + tStep/2, true, true );
				set( findobj( gca, 'type', 'bar' ), 'FaceAlpha', 1, 'FaceColor', 'k' );
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
				if(isFit)
					hold on;
					y = get( gca, 'ylim' );
					if( strcmpi( alignEvt, 'tblinkbeepon' ) )
						xLoc = 0.5*x(1) + 0.5*mean(x);
					else
						xLoc = [0.95*x(1)+0.05*mean(x), 0.95*mean(x)+0.05*x(2)];
					end
					for( i = 1 : size(rt,2) )
						t = min(rt{i}) - tStep*3 : tStep : max(rt{i}) + tStep*3;
						plot( t, pdf( fitKernel, t, paramsCell{i}{:} ) * size(rt{i},2) * tStep, 'k', 'LineWidth', 2 );

						text( xLoc(i), y(2),...
						{ 'During Fixation:';...
						  sprintf( '\\indent Chi2\\_gof: $p=%.4f$', chi2_p(i) );...
						  sprintf( '\\indent KS\\_Test:  $p = %.4f$', ks_p(i) );...
						  sprintf( [ '\\indent $f(x)=\\mbox{pdf}("%s",x,%.3f', repmat(',%.3f',1,size(paramsCell{1},2)-1), ')$' ], fitKernel, paramsCell{i}{:} ) },...
						'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'interpreter', 'latex', 'FontSize', 20 );
					end
					
					% text( , y(2),...
					% 	{ 'During Stimulus:';...
					% 	  sprintf( '\\indent Chi2\\_gof: $p=%.4f$', chi2_p(2) );...
					% 	  sprintf( '\\indent KS\\_Test:  $p=%.4f$', ks_p(2) );...
					% 	  sprintf( [ '\\indent $f(x)=\\mbox{pdf}("%s",x,%.3f', repmat(',%.3f',1,size(paramsCell{1},2)-1), ')$' ], fitKernel, paramsCell{2}{:} ) },...
					% 	'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'interpreter', 'latex', 'FontSize', 20 );
				end
				set( gca, 'XLim', x, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				xlabel( sprintf( 'Time aligned to %s (ms)', alignEvt ) );
				ylabel( 'Proportion of trials' );
			end
		end


		function [durations, trials] = BlinkDuration( sbj, folder, blockIndices, fitKernel, isPlot, durStep, isNewFigure )
			%% analyze duration distribution of blinks happen during(around) Plateau

			if( nargin() < 4 || isempty(fitKernel) ) isFit = false;
			else isFit = true; end
			if( nargin() < 5 || isempty(isPlot) ) isPlot = true; end
			if( nargin() < 6 || isempty(durStep) ) durStep = 10; end
			if( nargin() < 7 || isempty(isNewFigure) ) isNewFigure = true; end

			% data = BlinkTransient.GetData4Blinks( folder, false, false );
			data = BlinkTransient.GetLabeledTrials4Blinks(folder,[],[],'tRampOn',0,0);
			for( i = 1 : size(data,2) )
				trials = data(i).trials;
				if( isfield(trials, 'beepFreq') )	% lower tone for no blink, higher tone for blink
					beepFreq = [trials.beepFreq];
					beepFreq = beepFreq - mean( unique(beepFreq) );
					if( size( unique(beepFreq), 2 ) == 2 )
						trials( beepFreq > 0 & [trials.hasBlink] | beepFreq < 0 & ~[trials.hasBlink] ) = [];
					else
						trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
					end	
				else
					trials( [trials.tBlinkBeepOn] - [trials.tRampOn] > -600 & ~[trials.hasBlink] | [trials.tBlinkBeepOn] - [trials.tRampOn] < -600 & [trials.hasBlink] ) = [];
				end
				data(i).trials = trials;
			end

			trials = BlinkTransient.ETScreen( [data(blockIndices).trials] );
			trials = trials([trials.hasBlink]);
			durations = zeros(size(trials));
			for( iTrial = 1 : size(trials,2) )
				sRate = trials(iTrial).sRate;
				index = trials(iTrial).tRampOn - trials(iTrial).tTrialStart <= ( trials(iTrial).blinks.start -1 ) / sRate * 1000 & (trials(iTrial).blinks.start + trials(iTrial).blinks.duration - 2)/sRate*1000 <= trials(iTrial).tMaskOn - trials(iTrial).tTrialStart;
				if( sum(index) == 1 )
					durations(iTrial) = (trials(iTrial).blinks.duration(index) - 1) / sRate * 1000;
				elseif( sum(index) > 1 )
					[~, iMin] = min( abs( (trials(iTrial).blinks.start -1)/sRate*1000 - (trials(iTrial).tPlateauOn - trials(iTrial).tTrialStart) ) );
					durations(iTrial) = (trials(iTrial).blinks.duration(iMin) - 1) / sRate * 1000;
				else
					fprintf('%d blinks!!!\n', sum(index));
					fprintf('\tiTrial: %d\n', iTrial);
				end
				if(durations(iTrial) < 50)

					fprintf('TOO SHORT duration: %.1f ms!!!\n', durations(iTrial));
					fprintf('\tiTrial: %d\n', iTrial);
				end
			end

			%% fitting the distribution
			if(isFit)
				switch( fitKernel )
					case { 'gev' }
						pdffun = @(x, param1, param2, param3) pdf( fitKernel, x, param1, param2, param3 );
						cdffun = @(x, param1, param2, param3) cdf( fitKernel, x, param1, param2, param3 );

					case { 'norm', 'normal', 'logn', 'lognormal', 'beta' }
						iParams = [ 2, 3; 2, 3 ];
						pdffun = @(x, param1, param2) pdf( fitKernel, x, param1, param2 );
						cdffun = @(x, param1, param2) cdf( fitKernel, x, param1, param2 );
				end
				
				options = statset( 'display', 'off', 'MaxIter', 100000, 'MaxFunEvals', 200000, 'FunValCheck', 'off' );
				
				%% fitdist
				pd = fitdist( durations', fitKernel, 'options', options );
				params = num2cell(pd.Params);

				if( strcmpi( fitKernel, 'gev' ) )
					lowerbounds = [params{1}-0.5, params{2}/5, params{3}-50];
                	upperbounds = [params{1}+0.5, params{2}*5, params{3}+50];
					
					%% curve fitting
					edges = min(durations) - durStep/2 : durStep : max(durations) + durStep/2;
					[fitobj, gof, output] = fit( mean( [edges(1:end-1); edges(2:end)] )', ToolKit.Hist( durations, edges, false, true )' / durStep, fittype( 'gevpdf(x,param1,param2,param3)' ), 'StartPoint', [params{:}] );
					params = { fitobj.param1, fitobj.param2, fitobj.param3 };

				end

				% test the fitting
				tmpDurs = sort(durations);
	            edges = unique( [ tmpDurs( 1 : max([5,ceil(size(tmpDurs,2)/100)]) : end ), tmpDurs(end) ] );
				[ chi2_h, chi2_p, chi2_st ] = chi2gof( tmpDurs, 'cdf', [ {cdffun}, params ], 'edges', edges );
				[ ks_h, ks_p, ks_st, ks_cv ] = kstest( tmpDurs, [ unique(tmpDurs)', cdffun( unique(tmpDurs)', params{:} ) ] );
			end


			if(isPlot)
				if(isNewFigure)
					set( figure, 'NumberTitle', 'off', 'name', sprintf('%s: Blink Duration Distribution During Plateau', sbj), 'color', 'w' );
				end
				edges = 0 : durStep : 500;
				data = ToolKit.Hist( durations, edges, false );
				data = data / sum(data);
				bar( (edges(1:end-1) + edges(2:end)) / 2, data, 0.9, 'FaceColor', [0.4 0.4 0.4], 'LineStyle', 'none', 'FaceAlpha', 1 ); hold on;
				med = median(durations);
				plot( [1 1]*med, [0 0.3], 'k--', 'LineWidth', 2 );
				text( med, 0.29, sprintf( ' %.2fms', med ), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 18 );
				set( gca, 'XLim', [0 410], 'YLim', [0 0.3], 'LineWidth', 1, 'box', 'off', 'FontSize', 20 );

				if(isFit)
					t = mean( [edges(1:end-1); edges(2:end)] );
					plot( t, pdf( fitKernel, t, params{:} ) * size(durations,2) * durStep, 'k', 'LineWidth', 2 );
					x = get( gca, 'xlim' );
					y = get( gca, 'ylim' );
					text( mean(x), y(2),...
						{ sprintf( 'Chi2\\_gof: $p=%.4f$', chi2_p );...
						  sprintf( 'KS\\_Test:  $p = %.4f$', ks_p );...
						  sprintf( [ '$f(x)=\\mbox{pdf}("%s",x,%.3f', repmat(',%.3f',1,size(params,2)-1), ')$' ], fitKernel, params{:} ) },...
						'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'interpreter', 'latex', 'FontSize', 20 );
				end

				xlabel('Blink duration (ms)');
				ylabel('Number of trials');
			end

		end


		function BlinkRaster( sbj, folder, blockIndices, isNewFigure )
			%% plot a raster of blinks happen during(around) Plateau
			if( nargin() < 4 || isempty(isNewFigure) ) isNewFigure = true; end

			data = BlinkTransient.GetData4Blinks( folder, false, false );
			data = data(blockIndices);
			trials = [data.trialsWithBlink];
			for( iTrial = size(trials,2) : -1 : 1 )
				sRate = trials(iTrial).sRate;
				index = trials(iTrial).tRampOn - trials(iTrial).tTrialStart <= ( trials(iTrial).blinks.start -1 ) / sRate * 1000 & (trials(iTrial).blinks.start + trials(iTrial).blinks.duration - 2)/sRate*1000 <= trials(iTrial).tMaskOn - trials(iTrial).tTrialStart;
				x{iTrial}(3,:) = ones(1,sum(index)) * NaN;
				x{iTrial}(1,:) = trials(iTrial).blinks.start(index);
				x{iTrial}(2,:) = trials(iTrial).blinks.start(index) + trials(iTrial).blinks.duration(index) - 1;
				x{iTrial} = reshape( ( x{iTrial} - 1 ) / sRate * 1000 - (trials(iTrial).tPlateauOn - trials(iTrial).tTrialStart), 1, [] );
				y{iTrial} = repmat( [iTrial, iTrial, NaN], 1, sum(index) );
			end
			x = [x{:}];
			y = [y{:}];

			if( isNewFigure )
				set( figure, 'NumberTitle', 'off', 'name', sprintf('%s: Blink Rasters During Plateau', sbj), 'color', 'w' );
			end
			plot( x, y, 'k', 'LineWidth', 2 ); hold on;
			plot( [0 0], [0 size(trials,2)+1], 'k--', 'LineWidth', 1 );
			set( gca, 'XLim', [-2500 1500], 'YLim', [0 size(trials,2)+1], 'LineWidth', 1, 'box', 'off', 'FontSize', 20 );
			xlabel('Time aligned to Plateau onset (ms)');
			ylabel('Trial #');

		end


		function amplitudes = FixSacAmp( folder, subfolderIndices, isPlot, ampStep, cutAmp, isNewFigure )
			%% amplitudes:
			%    amplitudes.microsaccades:	for recorded "microsaccades"; in arc mins
			%    amplitudes.saccades:		for recorded "saccades"; in arc mins
			%  input:
			%	 cutAmp:					amplitude threshold for microsaccades and saccades, 30 arc mins by default

			if( nargin() < 2 ) subfolderIndices = []; end
			if( nargin() < 3 || isempty(isPlot) ) isPlot = true; end
			if( nargin() < 4 || isempty(ampStep) ) ampStep = 3; end 	% by default, 3 arc mins
			if( nargin() < 5 || isempty(cutAmp) ) cutAmp = 30; end
			if( nargin() < 6 || isempty(isNewFigure) ) isNewFigure = true; end

			amplitudes.microsaccades = [];
			amplitudes.saccades = [];
			amplitudes.nTrials = 0;

			list = dir(folder);
			index = false( size(list) );
			for( i = 1 : size(list,1) )
				if( list(i).isdir() && ( strcmp( list(i).name, '.' ) || strcmp( list(i).name, '..' ) || strcmpi( list(i).name(1:4), 'demo' ) || strcmpi( list(i).name(1:3), 'X. ' ) || strcmpi( list(i).name, 'calibration') ) )
					index(i) = true;
				end
			end
			list(index) = [];

			if(isempty(subfolderIndices)) subfolderIndices = 1 : size(list,1); end
			for( i = subfolderIndices )
				if( list(i).isdir() )
					tmpAmp = BlinkTransient.FixSacAmp( fullfile(folder, list(i).name), [], false, ampStep, cutAmp );
					amplitudes.microsaccades = [amplitudes.microsaccades, tmpAmp.microsaccades];
					amplitudes.saccades = [amplitudes.saccades, tmpAmp.saccades];
					amplitudes.nTrials = amplitudes.nTrials + tmpAmp.nTrials;
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
				h(2) = bar( (edges(1:end-1) + edges(2:end)) / 2, ToolKit.Hist( amplitudes.microsaccades, edges, false ) / amplitudes.nTrials, 0.9, 'm', 'LineStyle', 'none', 'DisplayName', 'microsaccades', 'FaceAlpha', 0.6 );
				hold on;
				% edges = min(amplitudes.saccades) - ampStep/2 : ampStep : min( [max(amplitudes.saccades), 300] ) + ampStep/2;
				edges = cutAmp : ampStep : min( [max(amplitudes.saccades), 300] );
				h(1) = bar( (edges(1:end-1) + edges(2:end)) / 2, ToolKit.Hist( amplitudes.saccades, edges, false ) / amplitudes.nTrials, 0.9, 'g', 'LineStyle', 'none', 'DisplayName', 'saccades', 'FaceAlpha', 0.6 );
				legend(h);
				title( sprintf( 'nTrials: %d', amplitudes.nTrials ) );
				set( gca, 'XLim', [0 180], 'XTick', 0:30:180, 'box', 'off', 'LineWidth', 2, 'FontSize', 20 );
				xlabel( 'Amplitude (arc min)' );
				ylabel( 'Number of (micro)saccades' );
			end
		end


		function rates = SaccadesRate_OLD20190527( folder, alignment, smooth, window, isPlot, isNewFigure )
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
						Trials = BlinkTransient.ETScreen(Trials);
						if( isempty(Trials) ) continue; end
						microsaccades = [Trials.microsaccades];
						saccades = [Trials.saccades];
						switch(lower(alignment))
							case 'fpon'
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tFpOn - Trials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tFpOn - Trials(iTrial).tTrialStart );
								end
							case 'rampon'
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart );
								end
							case 'plateauon'
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart );
								end
							case 'maskon'
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart );
								end
							case 'blink'	% first blink after beep for blink
								index = false(size(Trials));
								for( iTrial = 1 : size(Trials,2) )
									t = Trials(iTrial).blinks.start( find( Trials(iTrial).blinks.start / Trials(iTrial).sRate * 1000 > Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart, 1, 'first' ) ) / Trials(iTrial).sRate * 1000;
									if(isempty(t))
										index(iTrial) = true;
									else
										microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - t;
										saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - t;
									end
								end
								microsaccades(index) = [];
								saccades(index) = [];
							case 'response'
								tmpTrials = Trials( [Trials.tResponse] > 0 );
								microsaccades = [tmpTrials.microsaccades];
								saccades = [tmpTrials.saccades];
								for( iTrial = 1 : size(tmpTrials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start / tmpTrials(iTrial).sRate * 1000 - ( tmpTrials(iTrial).tResponse - tmpTrials(iTrial).tTrialStart );
									saccades(iTrial).start = saccades(iTrial).start / tmpTrials(iTrial).sRate * 1000 - ( tmpTrials(iTrial).tResponse - tmpTrials(iTrial).tTrialStart );
								end
							otherwise
								for( iTrial = 1 : size(Trials,2) )
									microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000;
									saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000;
								end

						end
						tMicrosaccades = round( [microsaccades.start] );
						tSaccades = round( [saccades.start] );
						if( ~isempty( [tMicrosaccades, tSaccades] ) )
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
				elseif( newRates.nTrials > 0 )
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

		function rates = SaccadesRate( folder, indices, alignment, smooth, window, isPlot, isNewFigure )
			%% alignment:					event to align the rates; by default, aligned to the time point of the first recorded eye position
			%  window:						sliding window size (ms)
			%  smooth:						'gaussian', 'square', 'raw'
			%  rates:						structure array for "microsaccades" and "saccades" rate distributions
			%    rates.rate.microsaccades:	rate for microsaccades (Hz)
			%	 rates.rate.saccades:		rate for large saccades (Hz)
			%    rates.tTicks:				timeline for rates.rate (ms)
			%    rates.nTrials: 			number of trials used

			if( nargin() < 3 || isempty(alignment) ) alignment = 'startTrial'; end
			if( nargin() < 4 || isempty(smooth) ) smooth = 'raw'; end
			if( nargin() < 5 || isempty(window) ) window = 10; end
			if( nargin() < 6 || isempty(isPlot) ) isPlot = true; end
			if( nargin() < 7 || isempty(isNewFigure) ) isNewFigure = true; end

			rates.rate = [];
			rates.tTicks = [];
			rates.nTrials = 0;

			Data4Blinks = BlinkTransient.GetLabeledTrials4Blinks(folder,[],[],'tRampOn',0,0);%,'tPlateauOn',0);
			if( nargin() < 2 || isempty(indices) )
				Trials = [Data4Blinks.trials];
			else
				Trials = [Data4Blinks(indices).trials];
			end
			Trials( isnan([Trials.hasBlink]) ) = [];
			Trials( [Trials.tBlinkBeepOn] - [Trials.tRampOn] > -600 & ~[Trials.hasBlink] | [Trials.tBlinkBeepOn] - [Trials.tRampOn] < -600 & [Trials.hasBlink] ) = [];
			Trials = BlinkTransient.ETScreen(Trials);
			if( isempty(Trials) ) return; end

			microsaccades = [Trials.microsaccades];
			saccades = [Trials.saccades];
			switch(lower(alignment))
				case 'fpon'
					for( iTrial = 1 : size(Trials,2) )
						microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tFpOn - Trials(iTrial).tTrialStart );
						saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tFpOn - Trials(iTrial).tTrialStart );
					end
				case 'rampon'
					for( iTrial = 1 : size(Trials,2) )
						microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart );
						saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart );
					end
				case 'plateauon'
					for( iTrial = 1 : size(Trials,2) )
						microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart );
						saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tPlateauOn - Trials(iTrial).tTrialStart );
					end
				case 'maskon'
					for( iTrial = 1 : size(Trials,2) )
						microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart );
						saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - ( Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart );
					end
				case 'blink'	% first blink after beep for blink
					index = false(size(Trials));
					for( iTrial = 1 : size(Trials,2) )
						t = Trials(iTrial).blinks.start( find( Trials(iTrial).blinks.start / Trials(iTrial).sRate * 1000 > Trials(iTrial).tBlinkBeepOn - Trials(iTrial).tTrialStart, 1, 'first' ) ) / Trials(iTrial).sRate * 1000;
						if(isempty(t))
							index(iTrial) = true;
						else
							microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000 - t;
							saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000 - t;
						end
					end
					microsaccades(index) = [];
					saccades(index) = [];
				case 'response'
					tmpTrials = Trials( [Trials.tResponse] > 0 );
					microsaccades = [tmpTrials.microsaccades];
					saccades = [tmpTrials.saccades];
					for( iTrial = 1 : size(tmpTrials,2) )
						microsaccades(iTrial).start = microsaccades(iTrial).start / tmpTrials(iTrial).sRate * 1000 - ( tmpTrials(iTrial).tResponse - tmpTrials(iTrial).tTrialStart );
						saccades(iTrial).start = saccades(iTrial).start / tmpTrials(iTrial).sRate * 1000 - ( tmpTrials(iTrial).tResponse - tmpTrials(iTrial).tTrialStart );
					end
				otherwise
					for( iTrial = 1 : size(Trials,2) )
						microsaccades(iTrial).start = microsaccades(iTrial).start / Trials(iTrial).sRate * 1000;
						saccades(iTrial).start = saccades(iTrial).start / Trials(iTrial).sRate * 1000;
					end

			end
			tMicrosaccades = round( [microsaccades.start] );
			tSaccades = round( [saccades.start] );
			if( ~isempty( [tMicrosaccades, tSaccades] ) )
				rates.nTrials = size(microsaccades,2);
				rates.tTicks = min( [ tMicrosaccades, tSaccades ] ) : max( [ tMicrosaccades, tSaccades ] );
				rates.rate.microsaccades = ToolKit.Hist( tMicrosaccades, [ rates.tTicks - 0.5, rates.tTicks(end) + 0.5 ], false ) / rates.nTrials / 0.001;
				rates.rate.saccades = ToolKit.Hist( tSaccades, [ rates.tTicks - 0.5, rates.tTicks(end) + 0.5 ], false ) / rates.nTrials / 0.001;
				switch( lower(smooth) )
					case 'gaussian'
						SIGMA = window/2;
		        		rates.rate.microsaccades = conv( rates.rate.microsaccades, normpdf( -4*SIGMA : 4*SIGMA, 0, SIGMA ), 'same' );
		        		rates.rate.saccades = conv( rates.rate.saccades, normpdf( -4*SIGMA : 4*SIGMA, 0, SIGMA ), 'same' );
					case 'square'
						rates.rate.microsaccades = conv( rates.rate.microsaccades, ones(1,window)/window, 'same' );
		        		rates.rate.saccades = conv( rates.rate.saccades, ones(1,window)/window, 'same' );
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
		end


		function  [sacRate, crctRate] = FLSacRateVSPerformance( folder, gaborAmps )
			%% check if performance is correalted with fixational saccades rate; the logic behind is that when subject gets tired, they will make more fixational saccades

			crctRate = [];
			sacRate = [];
			list = dir(folder);
			for( i = 1 : size(list,1) )
				if( list(i).isdir() )
					if( strcmp( list(i).name, '.' ) || strcmp( list(i).name, '..' ) || strcmpi( list(i).name(1:4), 'demo' ) || strcmpi( list(i).name(1:3), 'X. ' ) || strcmpi( list(i).name, 'calibration') )
						continue;
					else
						load( fullfile(folder, list(i).name, 'Trials.mat'), 'Trials' );
						crctRate(end+1) = sum( [Trials.trialType] == 'c' ) / sum( [Trials.trialType] == 'c' | [Trials.trialType] == 'e' );
						nSac = 0;
						for( iTrial = 1 : size(Trials,2) )
							t = (Trials(iTrial).microsaccades.start - 1 ) / Trials(iTrial).sRate * 1000;
							nSac = nSac + sum( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart <= t & t <= Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart );
							t = (Trials(iTrial).saccades.start - 1 ) / Trials(iTrial).sRate * 1000;
							nSac = nSac + sum( Trials(iTrial).tRampOn - Trials(iTrial).tTrialStart <= t & t <= Trials(iTrial).tMaskOn - Trials(iTrial).tTrialStart );
						end
						sacRate(end+1) = nSac / size(Trials,2) / mean( [Trials.tMaskOn] - [Trials.tRampOn] ) * 1000;
					end
				end
			end
			figure;
			plot( sacRate, crctRate, 'ro', 'LineWidth', 2, 'MarkerSize', 8 ); hold on;
			c = polyfit( sacRate, crctRate, 1 );
			[r pval] = corrcoef( sacRate, crctRate );
            if( size(r,2) == 1 ) r(2) = r(1); end
            if( size(pval,2) == 1) pval(2) = pval(1); end
			plot( sacRate, polyval( c, sacRate ), 'k--', 'LineWidth', 1 );

			text( 0.25, 0.21, sprintf('k = %.3f',c(1)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'FontSize', 18 );
			text( 0.25, 0.13, sprintf('r = %.4f',r(2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'FontSize', 18 );
			text( 0.25, 0.05, sprintf('pval = %.4f',pval(2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'FontSize', 18 );
			set( gca, 'xlim', [0 3], 'ylim', [0.5 1], 'LineWidth', 1, 'FontSize', 20 );
			xlabel('Saccade rate (Hz)');
			ylabel('Performance');

		end


		function [PS, sHFreqs, sVFreqs, tFreqs, img] = PowerSpectrumAna( data, version, varargin )
			%%
			% version:	covering; simulating a blink as upper eye lid covers the visual input image from top to bottom then back to top (padding input image with dark area)
			% PS:		1st dimension: horizontal space; 2nd dimension: vertical space; 3rd dimension: time space
			% sHFreqs:	spatial horizontal frequncies for PS
			% sVFreqs:  spatial vertical frequencies for PS
			% tFreqs:	temporal frequencies for PS

			if(ischar(data))
				Trials = load(data);
				Trials = Trials.Trials;
			elseif(isstruct(data))
				Trials = data;
			end

			if( nargin() >= 3 )
				for( i = 1 : 2 : size(varargin,2) )
					switch( lower(varargin{i}) )
						case {'spatialfrequency', 'sf'}
							sf = varargin{i+1};
						case 'orientation'
							orientation = varargin{i+1};
						case 'modulator'
							modulator = lower(varargin{i+1});
						case 'withramp'
							withRamp = varargin{i+1};
						otherwise
							varargin{i+1}
					end
				end
			end

			if( ~exist( 'modulator', 'var' ) ) modulator = 'blink'; end
			if( ~exist( 'withRamp', 'var' ) ) withRamp = false; end

			swPix = 1366;%2560;	% screen width in pixels
			swMm = 600;		% screen width in mm
			shPix = 768;%1440;	% screen height in pixels
			shMm = 335;		% screen height in mm
			sDist = 1605;%1190;	% distance from screen to subject's eye in mm
			gwPix = 1366;	% width of gabor patch in pixels
			ghPix = 768;

			Win = 1;	% e.g., Hanning Window
			U = 1;	% scale factor for Win
			PSX = round(swPix/4)*2;%floor(gwPix);
			PSY = round(shPix/4)*2;%floor(ghPix);
			tRamp = 1024+512;
			tPlateau = 1024;%+512;
			PSZ = tRamp + tPlateau;
			NSamples = PSX * PSY * PSZ;
			PS = zeros( PSX/2+1, PSY/2+1, PSZ/2+1, 'single' );
			sHFreqs = (0 : size(PS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
			sVFreqs = (0 : size(PS,2)-1) / (atand( PSX/shPix*shMm/2 / sDist ) * 2);
			sFreqs = (0 : size(PS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
			tFreqs = (0 : size(PS,3)-1) / (PSZ/1000);
			mov = zeros( PSX, PSY, PSZ, 'single' );
			% Win = zeros(PSX,PSY,PSZ,'single');
			w = 512;
			% Win( :, :, (1:w) + (PSZ-150)/2-w/2 ) = repmat( reshape( hann(w), 1, 1, w ), PSX, PSY );
            
			sigma = 180;%120;
			if( ~exist( 'orientation', 'var' ) ) orientation = 0; end
			phase = 0;
			bgnLuminance = BlinkTransient.Intensity2Luminance(128);
			gbAmp = BlinkTransient.Intensity2Luminance(128+8) - bgnLuminance;
			img = zeros( swPix, shPix );	% 1st dimension: horizontal (width); 2nd dimension: vertical (height)
			gabor = zeros( gwPix, ghPix );
			% sf = 0 : 0.1 : 10000;
			% wlPix = gwPix ./ ( atand( gwPix/shPix*shMm/2 / sDist ) * 2 * sf );
			% for( wl = wlPix )
			% 	% gabor = gabor + ToolKit.Gabor( wl, orientation, phase, gwPix, gwPix, 'grating', sigma );
			% 	gabor = gabor + ToolKit.Gabor( wl, 0, phase, gwPix, gwPix, 'gabor', sigma );
			% end
			if( ~exist( 'spatialfrequency', 'var' ) && ~exist( 'sf', 'var' ) )
				gabor = zeros(ghPix,gwPix);
				gabor(:,gwPix/2) = 1;
			else
				wlPix = gwPix ./ ( atand( gwPix/shPix*shMm/2 / sDist ) * 2 * sf );
				gabor = ToolKit.Gabor( wlPix, orientation, phase, gwPix, ghPix, 'grating' );
			end
			% img( (swPix-gwPix)/2 + (1:gwPix), (shPix-ghPix)/2 + (1:ghPix) ) = gabor' * gbAmp / bgnLuminance;		% in contrast
			img( (swPix-gwPix)/2 + (1:gwPix), (shPix-ghPix)/2 + (1:ghPix) ) = gabor';	% range of [-1,1]
			% figure; imshow(img);

			contrast = 1;
			Gt = ones(1,PSZ) * contrast;
			if( withRamp )
				Gt(1:tRamp) = ( 0 : tRamp-1 ) / (tRamp-1) * contrast;		% ramp of 1024 ms + plateau of 1024ms
			end
			
			FontSize = 24;
			LineWidth = 2;
			hMain = gcf;
			% hDrifts = figure( 'NumberTitle', 'off', 'name', 'Connected Drifts', 'color', 'w' );
			% set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'nextplot', 'add' );
			% xlabel('Time (ms)');
			% ylabel('Pixels');

			nValidTrials = size(Trials,2);
			panel2 = true;
			for( iTrial = 1 : size(Trials,2) )
				if( strcmp( modulator, 'blink' ) )
					x = zeros(1,PSZ);
					y = zeros(1,PSZ);
				else
					% get eye drift
					x = zeros( 1, sum([Trials(iTrial).drifts.duration]) );
					y = zeros(size(x));
					index = 0;
					Trials(iTrial).blinks.start = [Trials(iTrial).blinks.start, Trials(iTrial).notracks.start];
					Trials(iTrial).blinks.duration = [Trials(iTrial).blinks.duration, Trials(iTrial).notracks.duration];
					for( i = 1 : size( Trials(iTrial).drifts.start, 2 ) )
						idx = find( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration );
						if( ~isempty(idx) )
							st = Trials(iTrial).drifts.start(i) + 250;
							dur = Trials(iTrial).drifts.duration(i) - 250;
							if( dur < 1 )
								continue;
							else
								Trials(iTrial).drifts.start(i) = st;
								Trials(iTrial).drifts.duration(i) = dur;
							end
						end
						idx = find( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start );
						if( ~isempty(idx) )
							dur = Trials(iTrial).drifts.duration(i) - 50;
							if( dur < 1 )
								continue;
							else
								Trials(iTrial).drifts.duration(i) = dur;
							end
						end
						x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).x.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
						y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = Trials(iTrial).y.position( (0 : Trials(iTrial).drifts.duration(i)-1) + Trials(iTrial).drifts.start(i) );
						if( index > 0 )
							x( (1 : Trials(iTrial).drifts.duration(i)) + index ) = x( (1 : Trials(iTrial).drifts.duration(i)) + index ) - x(index+1) + x(index);
							y( (1 : Trials(iTrial).drifts.duration(i)) + index ) = y( (1 : Trials(iTrial).drifts.duration(i)) + index ) - y(index+1) + y(index);
						end
						index = index + Trials(iTrial).drifts.duration(i);
					end
					x( [1:min(10,end), index+1 : end] ) = [];
					y( [1:min(10,end), index+1 : end] ) = [];
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
                    x = x - x(1);
                    y = y - y(1);

					% figure(hDrifts);
					% h(2) = plot( 1:size(x,2), x, 'color', 'b', 'DisplayName', 'Horizontal' );
					% h(1) = plot( 1:size(y,2), y, 'color', 'r', 'DisplayName', 'Vertical' );
					% if( iTrial == size(Trials,2) )
					% 	set( legend(h(2:-1:1)), 'FontSize', FontSize );
					% end
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
						tFullCover = 150;			% 150 ms of complete covering
						d = - round(tFullCover/2);% + randi(50) - 26;		% blink central time relative to stimulus center
						bTrace( (1:tFullCover) + (end-tFullCover)/2 + d ) = max( a * bx(:) - b * by(:) );
						dur = round(dc/PSX*50);	% move by PSX in 20 ms
						% bTrace( (1-dur:0) + (end-tFullCover)/2 + d ) = min( a * bx(:) - b * by(:) ) - 1 + round( (1:dur)/dur * dc );
						% bTrace( (dur:-1:1) + tFullCover + (end-tFullCover)/2 + d ) = min( a * bx(:) - b * by(:) ) - 1 + round( (1:dur)/dur * dc );
						
						% freeze eye trace during blink
						iStart = find( bTrace > min( a * bx(:) - b * by(:) ) - 1, 1, 'first' );	% start of blink
						iEnd = find( bTrace > min( a * bx(:) - b * by(:) ) - 1, 1, 'last' );		% end of blink
						if( ~isempty(iStart) && ~isempty(iEnd) )
							x(iStart:iEnd) = x(iStart-1);
							x(iEnd+1:end) = x(iEnd+1:end) - ( x(iEnd+1) - x(iStart-1) );
							y(iStart:iEnd) = y(iStart-1);
							y(iEnd+1:end) = y(iEnd+1:end) - ( y(iEnd+1) - y(iStart-1) );
						end

						if( panel2 )
							panel2 = false;
							figure(hMain);
                            subplot(2,2,2); hold on;

							plot( reshape(Win(1,1,:),1,[])*400-400, 'LineStyle', '--', 'LineWidth', 2, 'color', 'r' );
							% plot( 1:PSZ, bTrace, 'LineWidth', LineWidth );
							% set( gca, 'XLim', [0 PSZ], 'YLim', [min(bTrace) max(bTrace)] * 1.05, 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
							% xlabel( 'Time (ms)' );
							% ylabel( 'Front edge (pixel)' );
							% title( 'Blink simulated as covering visual field' );
							[AX, H1, H2] = plotyy( 1:PSZ, bTrace, 1:PSZ, Gt );
							set( AX(1), 'YColor', 'b', 'XLim', [0 PSZ], 'YLim', [-1.1 1.1] * (max(bTrace)-min(bTrace)) / 2 + mean([min(bTrace),max(bTrace)]), 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off', 'nextplot', 'add' );
							AX(1).YLabel.String = 'Front edge (pixel)';
	                        set( H1, 'LineWidth', 2, 'color', 'b' );
							set( AX(2), 'XLim', [0 PSZ], 'YLim', [0 1.1], 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off', 'nextplot', 'add' );
							AX(2).YLabel.String = 'Stimulus gain';
							AX(2).XLabel.String = 'Time (ms)';
	                        set( H2, 'LineWidth', LineWidth );
	                        pause(3);
	                    else
	                    	;%plot( AX(1), 1:PSZ, bTrace, 'b' );
	                    end
					end

					% power spectrum
					nOverlaps = 1;
					for( t = 1 : PSZ )
						tmpMov = img( (0:PSX-1) + round( ( size(img,1) - PSX ) / 2 ) + x(t), (0:PSY-1) + round( ( size(img,2) - PSY ) / 2 ) + y(t) ) * 1 * Gt(t) + 128;
                        tmpMov( a * bx - b * by <= bTrace(t) ) = 0;
						mov( :, :, t ) = tmpMov;
						% imshow( mov(350:370,:,t), [] );
					end
					mov = ( mov - mean(mov(:)) ) .* Win;
					% mov = mov - repmat( mean(mov,3), 1, 1, size(mov,3) );
					tPS = fftn(mov);
					PS = PS + abs( tPS( 1:size(PS,1), 1:size(PS,2), 1:size(PS,3) ) ).^2;	% discard negative frequency part
						% power spectrum using fft: fft^2 / (N*Fs)		(N: number of data points, Fs: sampling rate)

					break;
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
			PS = PS / ( PSX * (PSX/(atand(PSX/swPix*swMm/2/sDist)*2)) * PSY * (PSY/(atand(PSY/shPix*shMm/2/sDist)*2)) * PSZ * 1000 * U ) / nOverlaps / nValidTrials;	% average over 9 overlapped windows and all eye traces
			% save( 'Drift_PS_theory.mat', 'PS' );

			figure(hMain);
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
			set( gca, 'color', 'k', 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [0.5 sHFreqs(end)], 'YLim', tFreqs([2 50]), 'XTick', [1 5 10 20 40], 'YTick', [1 5 10 20 40 80], 'position', position );
		end



		function [PS, sFreqs, tFreqs] = QRadPowerSpectrumAna( data, modulator, w, rSlope, gainMin )
			%% data:			file name containing Trials, or structure array Trials
			%  modulator:		drift, blink, or drift+blink
			%  w:				total duration of a simulated blink in ms; 200 by default
			%  rSlope:			proportion/ratio of two slopes over total duration for a simulated blink; 0.2 by default
			%  gainMin:			minimal gain during a simulated blink; 0 by default

			if(ischar(data))
				Trials = load(data);
				Trials = Trials.Trials;
			elseif(isstruct(data))
				Trials = data;
			end
			
			modulator = lower(modulator);

			if( nargin() < 3 || isempty(w) ) w = 200; end
			if( nargin() < 4 || isempty(rSlope) ) rSlope = 0.2; end
			if( nargin() < 5 || isempty(gainMin) ) gainMin = 0; end

			swPix = 2560;	% screen width in pixels
			swMm = 600;		% screen width in mm
			shPix = 1440;	% screen height in pixels
			shMm = 335;		% screen height in mm
			sDist = 1620;%1190;	% distance from screen to subject's eye in mm
			gwPix = 720;	% width of gabor patch in pixels; half of the screen height
			PSX = floor(gwPix);
			PSY = floor(gwPix);
			PSZ = 1024;
			NSamples = PSX * PSY * PSZ;
			% PS = zeros( PSX/2+1, 50, 'single');
			PS = zeros( PSX/2+1, PSZ/2+1, 'single');
			sFreqs = (0 : size(PS,1)-1) / (atand( PSX/swPix*swMm/2 / sDist ) * 2);
			tFreqs = (0 : size(PS,2)-1) / (PSZ/1000);

			FontSize = 20;
			LineWidth = 1.5;
			


			hMain = gcf;
			hDrifts = figure( 'NumberTitle', 'off', 'name', 'Connected Drifts', 'color', 'w' );
			figure(hDrifts);
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'nextplot', 'add' );
			xlabel('Time (ms)');

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
						idx = find( Trials(iTrial).drifts.start(i) == Trials(iTrial).blinks.start + Trials(iTrial).blinks.duration );
						if( ~isempty(idx) )
							st = Trials(iTrial).drifts.start(i) + 250;
							dur = Trials(iTrial).drifts.duration(i) - 250;
							if( dur < 1 )
								continue;
							else
								Trials(iTrial).drifts.start(i) = st;
								Trials(iTrial).drifts.duration(i) = dur;
							end
						end
						idx = find( Trials(iTrial).drifts.start(i) + Trials(iTrial).drifts.duration(i) == Trials(iTrial).blinks.start );
						if( ~isempty(idx) )
							dur = Trials(iTrial).drifts.duration(i) - 50;
							if( dur < 1 )
								continue;
							else
								Trials(iTrial).drifts.duration(i) = dur;
							end
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
					orientation = 45 * (randi(2)*2-3);
					xx = x * cosd(orientation) + y * sind(orientation);
					yy = y * cosd(orientation) - x * sind(orientation);
					% plot( [x;y]' );


					figure(hDrifts);
					plot( 1:size(x,2), x, 'color', 'b' );
					plot( 1:size(y,2), y, 'color', 'r' );
				end

				if( strcmp( modulator, 'drift' ) )		% drift only
					Gt = 1;
					Gt = (0:PSZ-1)/(PSZ-1);		% ramping
				else
					% consider that blink decreases the luminance (not contrast) to a proportion of p;
					%   contrast does not change!!! ((gbAmp + bgnLuminance) * p - bgnLuminance*p) / (bgnLuminance*p) == ( (gbAmp + bgnLuminance) - bgnLuminance ) / bgnLuminance;
					% p = 0;
					Gt = ones(1,PSZ);
					offset = 0;%randi(501) - 251;
					% w = 200;	% total duration
					% rSlope = 0.2;	% portion/ratio of two slopes over total duration
					% gainMin = 0.5;	% minimal gain during blink
					Gt( (1:w) + (end-w)/2 + offset ) = gainMin;
					down = w*rSlope/2;
					Gt( (1:down) + (end-w)/2 + offset ) = 1 - (1:down)/down * (1-gainMin);
					up = w*rSlope/2;
					Gt( ( w : -1 : w-up+1 ) + (end-w)/2 + offset ) = 1 - (1:up)/up * (1-gainMin);

					% Gt = (0:PSZ-1)/(PSZ-1);
					% Gt( (1:350) + (end-350)/2 + d ) = 0;
					% Gt( (1:20) + (end-350)/2 + d ) = ( 1 - (1:20)/20 ) * Gt((end-350)/2 + d + 1);
					% Gt( (350:-1:331) + (end-350)/2 + d ) = ( 1 - (1:20)/20 ) * Gt((end-350)/2 + d + 350);

					figure(hMain);
					subplot(2,2,2); hold off;
					plot( 1:PSZ, Gt*100, 'LineWidth', 2 );
					set( gca, 'XLim', [0 PSZ], 'YLim', [0 101], 'FontSize', FontSize, 'LineWidth', LineWidth, 'box', 'off' );
					xlabel( 'Time (ms)' );
					ylabel( 'Contrast gain (%)' );
					title( 'Blink simulated as gain modulation' );
				end

				% tPS = repmat( sum(PSImg,2), 1, size(x,2) ) .* QRad_fft2_SingleTrace(sFreqs, size(x,2), 0, x, y, Win)';
				if( strcmp( modulator, 'drift' ) )		% drift only
					% [tPS,tFreqs] = QRad_Welch_SingleTrace(sFreqs, PSZ/2, 0, x, y, Win(1:PSZ/2), 1000);
					% tPS = tPS' * 1000 * PSZ;
					% tFreqs = tFreqs(1:50);
					% tFreqs = (0 : size(PS,2)-1) / (PSZ/2/1000);
					tPS = QRad_fft2_SingleTrace(sFreqs, size(x,2), 0, x, y, Win)';
				else
					tPS = QRad_fft2_SingleTrace(sFreqs, size(x,2), 0, x, y, Win, Gt)';
				end
				PS = PS + tPS(:,1:size(PS,2));
			end
			if( size(PS,2) < PSZ/2+1 )
				PS( :, 2:end ) = 2 * PS( :, 2:end );	% convert to single sided
			else
				PS( :, 2:end-1 ) = 2 * PS( :, 2:end-1 );	% convert to single sided
			end
			PS = PS / (PSZ*1000) / nValidTrials;	% fft^2 / (N*Fs); and average over all eye traces
			% save( 'PS_QRad.mat', 'PS' );


			figure(hMain);
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
		
			close(hDrifts);
		end


		function PlotPSDSummary( version, withRamp, dataFileName )
			if( nargin() < 2 || isempty(withRamp) ) withRamp = false; end

			global PSD_Covering;
			global PSD_Gain;

			if( strcmpi( version, 'covering' ) )
				if( isempty(PSD_Covering) )
					figure;
					pause(0.1);
					jf = get(handle(gcf),'javaframe');
					jf.setMaximized(1);
					pause(0.5);
					% [PS_B, sFreqs_B, ~, tFreqs_B] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\A082\0 sf1\20180731_noPEST_03 (sf1)\Trials.mat','covering','modulator','blink');
					% [PS_D, sFreqs_D, ~, tFreqs_D] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\A082\0 sf1\20180731_noPEST_03 (sf1)\Trials.mat','covering','modulator','drift');
					% [PS_DB, sFreqs_DB, ~, tFreqs_DB] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\A082\0 sf1\20180731_noPEST_03 (sf1)\Trials.mat','covering','modulator','Drift+blink');
					[PS_B, sFreqs_B, ~, tFreqs_B] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\Bin\1.5s+0.25_0.75_1.25s\20181203_33 (sf0.1) (FixedLevels) (VariedDur)\Trials.mat','covering','modulator','blink','sf',3,'withRamp',withRamp);
					[PS_D, sFreqs_D, ~, tFreqs_D] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\Bin\1.5s+0.25_0.75_1.25s\20181203_33 (sf0.1) (FixedLevels) (VariedDur)\Trials.mat','covering','modulator','drift','sf',3,'withRamp',withRamp);
					[PS_DB, sFreqs_DB, ~, tFreqs_DB] = BlinkTransient.PowerSpectrumAna('F:\BlinkTransient\Bin\1.5s+0.25_0.75_1.25s\20181203_33 (sf0.1) (FixedLevels) (VariedDur)\Trials.mat','covering','modulator','Drift+blink','sf',3,'withRamp',withRamp);
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
					set( figure, 'NumberTitle', 'off', 'name', ['PSD.' version, '.', dataFileName] );
					pause(0.1);
					jf = get(handle(gcf),'javaframe');
					jf.setMaximized(1);
					pause(0.5);
					[PS_D, sFreqs_D, tFreqs_D] = BlinkTransient.QRadPowerSpectrumAna(dataFileName,'drift');
					[PS_B, sFreqs_B, tFreqs_B] = BlinkTransient.QRadPowerSpectrumAna(dataFileName,'blink');
					[PS_DB, sFreqs_DB, tFreqs_DB] = BlinkTransient.QRadPowerSpectrumAna(dataFileName,'drift+blink');
					
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


			set( figure, 'NumberTitle', 'off', 'name', [ 'PSDSummary.' version, '.', dataFileName ] );
			FontSize = 24;
			LineWidth = 2;
			subplot(1,2,1);
			hold on;
			colors = {'m', 'b', 'c', 'k'};
			f = [1 5 10];% [5 10 20];
			h = [];
			for( iF = 1:size(f,2) )
				y = zeros(size(sFreqs_D));
				y = interp2( tFreqs_D, sFreqs_D, PS_D, f(iF), sFreqs_D, 'linear' );
				plot( sFreqs_D, y, '--', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift', f(iF) ) );

				y = zeros(size(sFreqs_B));
				y = interp2( tFreqs_B, sFreqs_B, PS_B, f(iF), sFreqs_B, 'linear' );
				% plot( sFreqs_B, y, ':', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Blink', f(iF) ) );

				y = zeros(size(sFreqs_DB));
				y = interp2( tFreqs_DB, sFreqs_DB, PS_DB, f(iF), sFreqs_DB, 'linear' );
				plot( sFreqs_DB, y, '-', 'LineWidth', LineWidth, 'color', colors{iF}, 'DisplayName', sprintf( '%d Hz Drift+blink', f(iF) ) );
			end
			cut = 10;%min(tFreqs_D(end),tFreqs_DB(end));
			% plot( sFreqs_D, sum( PS_D(:,2:end), 2 ) * (tFreqs_D(2) - tFreqs_D(1)), '--', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift' );
			plot( sFreqs_D, sum( PS_D( :, 0 < tFreqs_D & tFreqs_D < cut ), 2 ) * (tFreqs_D(2) - tFreqs_D(1)), '--', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift' );
			% plot( sFreqs_B, sum( PS_B(:,2:end), 2 ) * (tFreqs_B(2) - tFreqs_B(1)), ':', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Blink' );
			% plot( sFreqs_DB, sum( PS_DB(:,2:end), 2 ) * (tFreqs_DB(2) - tFreqs_DB(1)), '-', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift+blink' );
			plot( sFreqs_DB, sum( PS_DB( :, 0 < tFreqs_DB & tFreqs_DB < cut ), 2 ) * (tFreqs_DB(2) - tFreqs_DB(1)), '-', 'LineWidth', LineWidth, 'color', colors{4}, 'DisplayName', 'NonZero Hz Drift+blink' );
			
			names = { num2str(f(1)), num2str(f(2)), num2str(f(3)), 'NonZero' };
			for( i = 1 : 4 )
				h(end+1) = plot( -1, -1, 'LineStyle', 'none', 'Marker', 'Square', 'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i}, 'DisplayName', [names{i} ' Hz'] );
			end
			h(end+1) = plot( -1, -1, 'k--', 'LineWidth', LineWidth, 'DisplayName', 'Drift' );
			% h(end+1) = plot( -1, -1, 'k:', 'LineWidth', LineWidth, 'DisplayName', 'Blink' );
			h(end+1) = plot( -1, -1, 'k', 'LineWidth', LineWidth, 'DisplayName', 'Drift+blink' );
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [sFreqs_D(2), 20], 'XTick', [1 10], 'XTickLabel', [1 10] );
			plot( [3 3], get(gca,'YLim'), 'k:' );
			set( legend(h), 'location', 'Southeast' );
			xlabel('Spatial frequency (cpd)');
			ylabel('Power spectral density');

			subplot(1,2,2);
			hold on;
			k = [3];
			colors = {'m', 'b'};
			h = [];
			for( iK = 1:size(k,2) )
				y = zeros(size(tFreqs_D));
				y = interp2( tFreqs_D, sFreqs_D, PS_D, tFreqs_D, k(iK), 'linear' );
				h(end+1) = plot( tFreqs_D, y, '--', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Drift', k(iK) ) );

				y = zeros(size(tFreqs_B));
				y = interp2( tFreqs_B, sFreqs_B, PS_B, tFreqs_B, k(iK), 'linear' );
				% h(end+1) = plot( tFreqs_B, y, ':', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Blink', k(iK) ) );

				y = zeros(size(tFreqs_DB));
				y = interp2( tFreqs_DB, sFreqs_DB, PS_DB, tFreqs_DB, k(iK), 'linear' );
				h(end+1) = plot( tFreqs_DB, y, '-', 'LineWidth', LineWidth, 'color', colors{iK}, 'DisplayName', sprintf( '%d cpd Drift+blink', k(iK) ) );
			end
			set( legend(h), 'location', 'Southeast' );
			set( gca, 'FontSize', FontSize, 'LineWidth', LineWidth, 'XScale', 'log', 'YScale', 'log', 'XLim', [tFreqs_D(2), 60], 'XTick', [1 10 40], 'XTickLabel', [1 10 40] );
			xlabel('Temporal frequency (Hz)');
			ylabel('Power spectral density');
		end


		function TemporalSingleCell()
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