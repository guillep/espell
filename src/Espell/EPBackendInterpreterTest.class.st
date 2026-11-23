Class {
	#name : #EPBackendInterpreterTest,
	#superclass : #EPBaseTest,
	#instVars : [
		'interpreter'
	],
	#category : #'Espell-Tests'
}

{ #category : #helpers }
EPBackendInterpreterTest >> evaluate: aString [

	^ interpreter evaluateCode: aString
]

{ #category : #running }
EPBackendInterpreterTest >> setUp [

	super setUp.
	interpreter := kernel interpreter
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretBlock [

	self assert: (self evaluate: '[ 3 + 4 ] value') asSmallInteger equals: 7
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretClassVariable [

	[ self assert: (self evaluate: 'Object dependentsFields: 7. Object dependentsFields') asSmallInteger equals: 7 ] ensure: [ self evaluate: 'Object dependentsFields: nil' ]
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretConditional [

	self assert: (self evaluate: '1 < 2 ifTrue: [ 3 ] ifFalse: [ 4 ]') asSmallInteger equals: 3
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretGlobal [

	self assert: (self evaluate: 'Object') target address equals: (kernel classMirrorNamed: #Object) target address
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretInstanceCreation [

	| dictionary |
	dictionary := self evaluate: 'Dictionary new'.
	self assert: dictionary basicClass className equals: #Dictionary.
	self assert: (EPRemoteDictionary on: dictionary) size equals: 0
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretInstanceVariables [

	self assert: (self evaluate: '(Association key: 1 value: 2) value') asSmallInteger equals: 2
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretLoop [

	self assert: (self evaluate: '| sum | sum := 0. 1 to: 3 do: [ :i | sum := sum + i ]. sum') asSmallInteger equals: 6
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretMissingSelector [

	self should: [ self evaluate: '1 foo' ] raise: Error
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretPrimitive [

	self assert: (self evaluate: '1 + 2') asSmallInteger equals: 3
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretPrimitiveAnsweringABoolean [

	self assert: ((self evaluate: '1 < 2') pointsToSameObject: self backend trueObject)
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretSharedPoolVariable [

	self assert: (self evaluate: 'ChronologyConstants initialize. Time secondsInMinute') asSmallInteger equals: 60
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretSuperSend [

	self assert: (self evaluate: '1 answer') asSmallInteger equals: 42
]

{ #category : #tests }
EPBackendInterpreterTest >> testInterpretWithTemps [

	| result |
	result := interpreter evaluateCode: 'x + 1' withTemps: { ('x' -> (self mirrorOn: 2)) }.
	self assert: result asSmallInteger equals: 3
]
