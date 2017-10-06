public
at: aLocalSymbol ifAbsent: aBlock

	self symbolsDo: [ :remoteSymbol | remoteSymbol asLocalString = aLocalSymbol
		ifTrue: [ ^ remoteSymbol ] ].
	^ aBlock value