accessing
format: aFormat
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classFormatIndex) put: (backend smallIntegerMirrorOn: aFormat)