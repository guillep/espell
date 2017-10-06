as yet unclassified
floatObject: anEPFloatMirror at: anInteger put: anEPMirror 
	
	self
		executePrimitiveNumber: 39
		on: anEPFloatMirror
		withArguments: { self smallIntegerMirrorOn: anInteger . anEPMirror }