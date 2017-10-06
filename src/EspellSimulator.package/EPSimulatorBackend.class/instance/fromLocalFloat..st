as yet unclassified
fromLocalFloat: aLocalFloat 
	
	^ self floatMirrorOn: (self handleOnAddress: (simulator objectMemory floatObjectOf: aLocalFloat))