public
includesKey: aLocalSymbol

	self symbolsDo: [ :remoteSymbol | remoteSymbol asLocalString = aLocalSymbol 
		ifTrue: [ ^true ] ].
	^ false