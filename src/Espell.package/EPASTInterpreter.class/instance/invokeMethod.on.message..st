method evaluation
invokeMethod: aClosure on: receiver message: aMessage
	| result |

	self assert: aClosure numArgs = aMessage numArgs.
	
	self
		methodContextFor: aClosure
		receiver: receiver
		message: aMessage.

	result := self interpretMethod: (self closureAST: aClosure forReceiver: receiver ).
	
	self isExplicitelyReturning 
		ifFalse: [ result := self currentSelf ].
		
	self popContext.

	^ result