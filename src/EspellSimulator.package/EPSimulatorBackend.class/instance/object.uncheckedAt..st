primitives
object: anObject uncheckedAt: anInteger
	
	^ self mirrorOnAddress: (simulator objectMemory
		fetchPointer: anInteger
		ofObject: anObject address)