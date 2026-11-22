"
I am a specific context for the ASTInterpreter that represents the first context that is interpreted. This way, when I am fully interpreted it means that the interpreting task is finished.

<method> holds the code from a DoIt


"
Class {
	#name : 'AIRootContext',
	#superclass : 'AIBlockContext',
	#instVars : [
		'method'
	],
	#category : 'AST-Interpreter-Core-Base',
	#package : 'AST-Interpreter-Core',
	#tag : 'Base'
}

{ #category : 'testing' }
AIRootContext >> = anObject [
	^ self == anObject
]

{ #category : 'debugging' }
AIRootContext >> debugPrintString [
	^self methodClass
]

{ #category : 'exception-handling' }
AIRootContext >> handleSignal: exception [

	<reflective: #rootContextHandleSignal:message:>
	^ exception resumeUnchecked: exception defaultAction
]

{ #category : 'testing' }
AIRootContext >> hasExceptionHandler [
	^ true
]

{ #category : 'testing' }
AIRootContext >> isRootContext [
	^true
]

{ #category : 'accessing' }
AIRootContext >> method [
	^ method
]

{ #category : 'accessing' }
AIRootContext >> method: aString [
	method := FakeCompiledMethod new sourceCode: aString
]

{ #category : 'accessing' }
AIRootContext >> methodClass [ 
	^self class
]

{ #category : 'accessing' }
AIRootContext >> outerContext [
	^ nil
]

{ #category : 'printing' }
AIRootContext >> printOn: aStream [
	aStream nextPutAll: 'AIRootContext: ';
		nextPutAll: 'AIRootContext>>DoIt'.
]

{ #category : 'accessing' }
AIRootContext >> receiver [
	^ self
]

{ #category : 'continuation' }
AIRootContext >> resume: aValue [
	"<reflective: #escape:message:>"
	^ super resume: aValue
]

{ #category : 'accessing' }
AIRootContext >> returnContext [
	^ self outerContext
]

{ #category : 'accessing' }
AIRootContext >> tempNamed: aName put: aValue [
	"This code permits temp to work in root context "
	
	^self temporaries at: aName put: aValue
		
]
