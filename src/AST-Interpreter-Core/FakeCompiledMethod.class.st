"
I hold the source code for DoIt.

It is needed if you want to debug with ASTDebugger (Smalltalkhub user:'dh83' project:'ast-interpreter') a DoIt method or if you want to look at the stack in the AIContextInspector
"
Class {
	#name : 'FakeCompiledMethod',
	#superclass : 'Object',
	#instVars : [
		'sourceCode'
	],
	#category : 'AST-Interpreter-Core-Base',
	#package : 'AST-Interpreter-Core',
	#tag : 'Base'
}

{ #category : 'accessing' }
FakeCompiledMethod >> methodClass [
	^AIRootContext
]

{ #category : 'accessing' }
FakeCompiledMethod >> selector [
	^#DoIt
]

{ #category : 'accessing' }
FakeCompiledMethod >> sourceCode [
	^ sourceCode
]

{ #category : 'accessing' }
FakeCompiledMethod >> sourceCode: aString [
	sourceCode := (self selector, String lf, String tab, aString) asText
]
