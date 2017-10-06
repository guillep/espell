method evaluation
invokeReflectiveMethod: aClosure on: receiver message: aMessage
	| annotation selector result |
	
	annotation := aClosure pragmaAt: #reflective:.
	selector := annotation arguments first value.
	
	result := self 
		perform: selector 
		withArguments: (Array with: receiver with: aMessage).
	
	 ByteSymbol == result basicClass target ifFalse: [ ^result ].
	 result = self reflectiveFailedToken ifFalse: [ ^ result ].

	"primitive failed"
	^self 
		invokeMethod: aClosure 
		on: receiver 
		message: aMessage