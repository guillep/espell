as yet unclassified
initializeTempsInStackOfContext: anEPContextMirror 
	
	^ self executePrimitiveNumber: 76 on: anEPContextMirror withArguments: { self smallIntegerMirrorOn: anEPContextMirror method numberOfTemps }