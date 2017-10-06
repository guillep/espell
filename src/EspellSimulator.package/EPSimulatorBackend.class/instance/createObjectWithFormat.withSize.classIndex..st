bootstrap
createObjectWithFormat: classFormat withSize: aSize classIndex: classIndex
	
	| oop |
	oop := aSize = 0 ifTrue: [ 
		simulator objectMemory 
			newBootstrapInstanceFromClassFormat: classFormat
			classIndex: classIndex.
	] ifFalse: [ 
		simulator objectMemory 
			newBootstrapInstanceFromClassFormat: classFormat
			indexableSize: aSize
			classIndex: classIndex.
	].
	^ self mirrorOnAddress: oop.