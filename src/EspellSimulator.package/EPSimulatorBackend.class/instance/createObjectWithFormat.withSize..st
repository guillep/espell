bootstrap
createObjectWithFormat: classFormat withSize: aSize
	
	^ self mirrorOnAddress: (simulator objectMemory 
		newBootstrapInstanceFromClassFormat: classFormat
		indexableSize: aSize)