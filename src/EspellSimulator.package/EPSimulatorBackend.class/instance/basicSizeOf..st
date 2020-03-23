primitives
basicSizeOf: anEPMirror 
	anEPMirror isSmallInteger ifTrue: [ ^ 0 ].
	^ self simulator uncheckedStSizeOf: anEPMirror target address