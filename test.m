bRatio = [];
for i = 1 : size(bTrials,2)
	notracks = bTrials(i).notracks;
	% notracks.start( notracks.duration / bTrials(1).sRate * 1000 < 15 ) = [];
	% notracks.duration( notracks.duration / bTrials(1).sRate * 1000 < 15 ) = [];
	
	bRatio(i) = sum( max( 0, ...
		min( (notracks.start+notracks.duration-1)/330*1000, bTrials(i).tMaskOn-bTrials(i).tTrialStart ) - ...
			max( (notracks.start-1)/330*1000, bTrials(i).tRampOn-bTrials(i).tTrialStart ) ) ) / (1500+1000);
end

nbRatio = [];
for i = 1 : size(nbTrials,2)
	notracks = nbTrials(i).notracks;
	% notracks.start( notracks.duration / nbTrials(1).sRate * 1000 < 15 ) = [];
	% notracks.duration( notracks.duration / nbTrials(1).sRate * 1000 < 15 ) = [];
	
	nbRatio(i) = sum( max( 0, ...
		min( (notracks.start+notracks.duration-1)/330*1000, nbTrials(i).tMaskOn-nbTrials(i).tTrialStart ) - ...
			max( (notracks.start-1)/330*1000, nbTrials(i).tRampOn-nbTrials(i).tTrialStart ) ) ) / (1500+1000);
end