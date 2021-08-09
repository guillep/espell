converting
convertHeaderToTargetPlatform: localCompiledCode

	"I need to convert the header to the target platform. If the target platform is different wordsize the minSmallInteger changes..."

	| encoderClass headerFlagForEncoder |

	encoderClass := localCompiledCode encoderClass.
	headerFlagForEncoder := (CompiledMethod headerFlagForEncoder:
		                         encoderClass) < 0
		                        ifTrue: [ self backend minSmallInteger ]
		                        ifFalse: [ 0 ].

	^ headerFlagForEncoder + (localCompiledCode numArgs bitShift: 24)
	  + (localCompiledCode numTemps bitShift: 18)
	  + localCompiledCode literals size
	  + (localCompiledCode isPrimitive asBit bitShift: 16)