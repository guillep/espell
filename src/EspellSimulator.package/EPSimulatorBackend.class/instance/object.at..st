primitives
object: anObject at: anInteger
	
	^ self mirrorOnAddress: (simulator stObject: anObject address at: anInteger)