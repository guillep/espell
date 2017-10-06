as yet unclassified
fromLocalByteArray: aCollection 
	
	| remoteByteArray |
	remoteByteArray := (self byteArrayClass basicNew: aCollection size).
	1 to: aCollection size do: [ :i |
		remoteByteArray at: i put: (self smallIntegerMirrorOn: (aCollection at: i)). 
	].
	^ remoteByteArray