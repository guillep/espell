testing
isAccessor: aMethodNode

	aMethodNode isCompiledMethod ifTrue: [ ^ false ].
	aMethodNode body statements size = 1 ifFalse: [ ^ false ].
	aMethodNode body statements first value isVariable ifFalse: [ 
		^ false ].
	^ aMethodNode body statements first value isInstanceVariable