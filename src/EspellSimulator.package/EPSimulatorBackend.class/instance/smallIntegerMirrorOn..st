mirrors
smallIntegerMirrorOn: anInteger 
	
	^ EPSimulatorSmallIntegerMirror on: (self handleOnAddress: (self objectMemory integerObjectOf: anInteger)) from: self