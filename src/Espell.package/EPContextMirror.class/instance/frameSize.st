accessing
frameSize

	^ self method isNilObject ifTrue: [ CompiledMethod fullFrameSize ] ifFalse: [self method frameSize]