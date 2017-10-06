accessing
format: aFormat
	^ self instanceVariableAtIndex: 3 put: (backend smallIntegerMirrorOn: aFormat)