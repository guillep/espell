method evaluation
invokePrimitiveMethod: aMethod on: receiver message: aMessage
	| result |
	
	self flag: 'TODO: should track the tower of interpreters properly...'.
	
	aMethod isCompiledMethod ifTrue: [ 
		^ receiver backend mirrorOnExternalHandle: (aMethod
			valueWithReceiver: receiver target object
			arguments: aMessage arguments)
	].
	
	result := receiver executePrimitiveMethod: aMethod withArguments: aMessage arguments.
	result hasFailed ifFalse: [ 
		^ result value ].
	
	"primitive failed"
	^ self
		invokeMethod: aMethod 
		on: receiver 
		message: aMessage