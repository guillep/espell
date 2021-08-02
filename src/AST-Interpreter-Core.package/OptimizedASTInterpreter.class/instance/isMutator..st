testing
isMutator: aMethodNode

	| assignment |
	aMethodNode isCompiledMethod ifTrue: [ ^ false ].
	aMethodNode body statements size = 1 ifFalse: [ ^ false ].
	aMethodNode body statements first isAssignment ifFalse: [ ^ false ].
	aMethodNode arguments size = 1 ifFalse: [ ^ false ].

	assignment := aMethodNode body statements first.

	assignment variable isInstanceVariable ifFalse: [ ^ false ].
	^ assignment value isArgumentVariable