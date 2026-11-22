Class {
	#name : 'EPBackendInterpreterTest',
	#superclass : 'EPBaseTest',
	#instVars : [
		'interpreter'
	],
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'running' }
EPBackendInterpreterTest >> setUp [

	super setUp.
	objectSpace := EPTestResource current objectSpace.
	interpreter := (EPASTEvaluator new 
		codeProvider: ((EPRemoteEnvironment
			on: objectSpace backend systemDictionary)
			imageFileName: EPTestResource current imageFileName;
			yourself);
		objectSpace: objectSpace backend)
]

{ #category : 'tests' }
EPBackendInterpreterTest >> testInterpreterDictionary [

	| result |
	result := EPRemoteDictionary on: (interpreter evaluateCode: 'Dictionary new') environment: interpreter codeProvider.
	self assert: result size equals: 0.
	self assert: result basicClass name equals: 'Dictionary'.
]

{ #category : 'tests' }
EPBackendInterpreterTest >> testInterpreterPrimitiveAdd [

	| result |
	result := interpreter evaluateCode: '1+2'.
	self assert: result isSmallInteger.
	self assert: result target equals: 3.
]
