converting
fromLocalByteSymbol: aByteSymbol

	| remoteSymbol |
	remoteSymbol := (self byteSymbolClass basicNew: aByteSymbol size).
	1 to: aByteSymbol size do: [ :i |
		remoteSymbol at: i put: (self smallIntegerMirrorOn: (aByteSymbol at: i) asciiValue). 
	].
	^ remoteSymbol