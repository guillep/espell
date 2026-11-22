"
I represent a primitive execution.
"
Class {
	#name : 'EPPrimitiveExecution',
	#superclass : 'Object',
	#instVars : [
		'primitive',
		'receiver',
		'arguments'
	],
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'accessing' }
EPPrimitiveExecution >> arguments [

	^ arguments
]

{ #category : 'accessing' }
EPPrimitiveExecution >> arguments: anArrayOfArguments [

	arguments := anArrayOfArguments
]

{ #category : 'accessing' }
EPPrimitiveExecution >> execute [

	^primitive execute: self
]

{ #category : 'accessing' }
EPPrimitiveExecution >> primitive: aPrimitive [

	primitive := aPrimitive
]

{ #category : 'accessing' }
EPPrimitiveExecution >> receiver [

	^ receiver
]

{ #category : 'accessing' }
EPPrimitiveExecution >> receiver: aReceiver [
	
	receiver := aReceiver
]

{ #category : 'accessing' }
EPPrimitiveExecution >> withArgumentsAs: aTransformationBlock [

	| newExecution |
	newExecution := self copy.
	newExecution arguments: (self arguments collect: aTransformationBlock).
	^ newExecution
]
