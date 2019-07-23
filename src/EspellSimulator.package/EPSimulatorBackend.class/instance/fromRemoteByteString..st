instance creation
fromRemoteByteString: anEPMirror 
	
	| localString |
	localString := ByteString new: anEPMirror basicSize.
	1 to: localString size do: [ :i |
		localString byteAt: i put: (anEPMirror byteAt: i).
	].
	^ localString