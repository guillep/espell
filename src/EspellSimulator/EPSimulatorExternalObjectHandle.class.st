Class {
	#name : 'EPSimulatorExternalObjectHandle',
	#superclass : 'EPSimulatorHandle',
	#instVars : [
		'object'
	],
	#category : 'EspellSimulator',
	#package : 'EspellSimulator'
}

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> = aHandle [

	^ self species = aHandle species
		and: [ self object == aHandle object ]
]

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> address [
	
	^ self isSmallInteger
		ifTrue: [ backend objectMemory integerObjectOf: object ]
		ifFalse: [
			"somebody is asking the address of a non immediate object!" 
			self halt ].
"	^ backend nilObject target address"
]

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> asSmallInteger [
	"Use carefully"
	self assert: self isSmallInteger.
	^ object
]

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> basicClass [

	^ backend handleOnExternalObject: object class
]

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> basicIdentityHashOnClass [

	^ object basicIdentityHash
]

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> hash [

	^ object hash
]

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> instanceVariableAtIndex: anInteger [ 
	
	^ backend mirrorOnExternalHandle: (object instVarAt: anInteger)
]

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> isSmallInteger [

	^ object isInteger and: [ object isLarge not ]
]

{ #category : 'accessing' }
EPSimulatorExternalObjectHandle >> object [
	^ object
]

{ #category : 'accessing' }
EPSimulatorExternalObjectHandle >> object: anInteger [ 
	object := anInteger
]

{ #category : 'as yet unclassified' }
EPSimulatorExternalObjectHandle >> species [

	^ EPSimulatorExternalObjectHandle
]
