transformations
fromRemote: aRemoteByteSymbol
	| localString |
	localString := super fromRemote: aRemoteByteSymbol.
	^Symbol intern: localString.