Extension { #name : 'CompiledMethod' }

{ #category : '*AST-Interpreter-Extension' }
CompiledMethod >> accept: visitor on: receiver message: aMessage [
	self isReflective ifTrue: [ 
		^ visitor 
			invokeReflectiveMethod: self
			on: receiver 
			message: aMessage].
	
	self isPrimitive ifTrue: [ 
			^ visitor 
				invokePrimitiveMethod: self 
				on: receiver 
				message: aMessage ].
			
	^ visitor 
		invokeMethod: self 
		on: receiver 
		message: aMessage
]

{ #category : '*AST-Interpreter-Extension' }
CompiledMethod >> code [

	^ self ast
]

{ #category : '*AST-Interpreter-Extension' }
CompiledMethod >> isReflective [
	^ (self hasPragmaNamed: #reflective:)
]
