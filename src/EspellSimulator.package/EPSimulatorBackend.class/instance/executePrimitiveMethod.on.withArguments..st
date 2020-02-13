primitives
executePrimitiveMethod: aMethod on: receiver withArguments: aCollection 

	| returnValue |
	self simulator internalizeIPandSP.
	self simulator externalizeIPandSP.
	self simulator initPrimCall.
	self simulator argumentCount: aCollection size.
	self simulator push: receiver target address.
	aCollection do: [ :each |
		self simulator push: each target address.
	].

	
	^ [
		aMethod isNamedPrimitive
			ifTrue: [ | pragma function pluginName addr |
				pragma := aMethod pragmas detect: #isPrimitive.
				function := pragma arguments first value.
				pluginName := pragma arguments second value.
				addr := self simulator
					ioLoadFunction: function
					From: pluginName
					AccessorDepthInto: (CPluggableAccessor new
						setObject: nil;
						atBlock: [ :obj :idx | ]
						atPutBlock: [:obj :idx :val| ];
						yourself).
				self simulator callExternalPrimitive: addr.
				self simulator maybeRetryFailureDueToForwarding: 117.
				
				self simulator primitiveFailureCode > 0 ifTrue: [ 
					self halt.
					^ EPPrimitiveFailed new code: self simulator primitiveFailureCode ].
				
				returnValue := self simulator stackTop.
				self simulator pop: 1.
				^ EPPrimitiveSuccess new value: (self mirrorOnAddress: returnValue) 
			]
			ifFalse: [ | function |
				function := self simulator functionPointerFor: aMethod primitive inClass: nil.
				function = 0 ifTrue: [ ^ EPPrimitiveFailed new ].
				self simulator primitiveFunctionPointer: function.
				self simulator dispatchFunctionPointer: function.
				self simulator maybeRetryFailureDueToForwarding: aMethod primitive.
			].
			self simulator primitiveFailureCode > 0 ifTrue: [ 
				^ EPPrimitiveFailed new code: self simulator primitiveFailureCode ].
			
			returnValue := self simulator stackTop.
			self simulator pop: 1.
			^ EPPrimitiveSuccess new value: (self mirrorOnAddress: returnValue)
		] ensure: [ 
			"We pop extra things..."
			self simulator pop: (((self simulator stackPointer - self simulator framePointer) + (self simulator objectMemory wordSize * 4)) min: 0)  abs / self simulator objectMemory wordSize.
			self assert: self stackIsEmpty.
			"Recursive xeq affects primErrorCode"
			self simulator initPrimCall.
			self simulator internalizeIPandSP].