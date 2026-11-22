Extension { #name : 'RBMethodNode' }

{ #category : '*AST-Interpreter-Extension' }
RBMethodNode >> accept: visitor on: receiver message: aMessage [
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
RBMethodNode >> ast [
	
	^ self
]

{ #category : '*AST-Interpreter-Extension' }
RBMethodNode >> code [

	^ self
]

{ #category : '*AST-Interpreter-Extension' }
RBMethodNode >> isNamedPrimitive [
	
	^ self primitive isString
]

{ #category : '*AST-Interpreter-Extension' }
RBMethodNode >> isReflective [
	^ (self hasPragmaNamed: #reflective:)
]

{ #category : '*AST-Interpreter-Extension' }
RBMethodNode >> parseTree [
	
	^ self
]

{ #category : '*AST-Interpreter-Extension' }
RBMethodNode >> primitive [
	^ (self pragmas detect: [ :each | each isPrimitive ])
			arguments first value
]
