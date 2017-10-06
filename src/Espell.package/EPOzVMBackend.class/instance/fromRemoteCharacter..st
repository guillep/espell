converting
fromRemoteCharacter: anEPMirror
	
	^Character value: (anEPMirror instanceVariableAtIndex: 1) asSmallInteger.