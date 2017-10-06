*EspellSimulator
signedMachineIntegerFor: value
	
	^ self wordSize = 8
		ifTrue: [ coInterpreter signed64BitIntegerFor: value]
		ifFalse: [ coInterpreter signed32BitIntegerFor: value]