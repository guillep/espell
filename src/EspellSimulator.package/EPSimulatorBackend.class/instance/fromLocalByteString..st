as yet unclassified
fromLocalByteString: aString 
	
	| remoteString |
	remoteString := (self byteStringClass basicNew: aString size).
	1 to: aString size do: [ :i |
		remoteString at: i put: (self smallIntegerMirrorOn: (aString at: i) asciiValue). 
	].
	^ remoteString