as yet unclassified
fromRemoteByteString: anEPMirror 
	
	| localString |
	localString := ByteString new: anEPMirror basicSize.
	1 to: localString size do: [ :i |
		localString byteAt: i put: (anEPMirror at: i) asSmallInteger.
	].
	^ localString