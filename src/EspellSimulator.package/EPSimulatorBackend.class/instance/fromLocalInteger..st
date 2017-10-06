transformations
fromLocalInteger: aLocalInteger
	
	| integer |
	integer := simulator objectMemory signedMachineIntegerFor: aLocalInteger.
	^ (simulator objectMemory isImmediate: integer)
		ifTrue: [ EPSimulatorSmallIntegerMirror on: (self handleOnAddress: integer) from: self ]
		ifFalse: [ self mirrorOnAddress: integer ].