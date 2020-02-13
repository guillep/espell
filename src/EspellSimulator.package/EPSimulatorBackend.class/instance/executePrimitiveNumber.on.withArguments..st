primitives
executePrimitiveNumber: number on: receiver withArguments: aCollection 

	| returnValue |
	self simulator internalizeIPandSP.
	self simulator externalizeIPandSP.
	self simulator initPrimCall.
	self simulator argumentCount: aCollection size.
	self simulator push: receiver target address.
	aCollection do: [ :each |
		self simulator push: each target address.
	].

	
	^ [		| function |
			function := self simulator functionPointerFor: number inClass: nil.
			function = 0 ifTrue: [ ^ EPPrimitiveFailed new ].
			self simulator primitiveFunctionPointer: function.
			self simulator dispatchFunctionPointer: function.
			self simulator primitiveFailureCode > 0 ifTrue: [ 
				^ EPPrimitiveFailed new code: self simulator primitiveFailureCode ].
			
			returnValue := self simulator stackTop.
			self simulator pop: 1.
			^ EPPrimitiveSuccess new value: (self mirrorOnAddress: returnValue)
		] ensure: [ 
			"We pop extra things..."
			self simulator pop: (((self simulator stackPointer - self simulator framePointer) + (self simulator objectMemory wordSize*4)) min: 0)  abs / self simulator objectMemory wordSize.
			self assert: self stackIsEmpty.
			"Recursive xeq affects primErrorCode"
			self simulator initPrimCall.
			self simulator internalizeIPandSP].