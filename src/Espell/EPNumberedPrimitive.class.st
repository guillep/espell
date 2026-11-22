"
I represent a numbered primitive.
"
Class {
	#name : 'EPNumberedPrimitive',
	#superclass : 'EPPrimitive',
	#instVars : [
		'number'
	],
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'installing' }
EPNumberedPrimitive >> basicInstall: aPrimitive inResolver: aPrimitiveResolver [

	self resolver: aPrimitiveResolver.
	aPrimitiveResolver primitiveForNumber: number put: aPrimitive.
]

{ #category : 'execution' }
EPNumberedPrimitive >> execute: anExecution [

	| result |
	result := ((ProtoObject>>#tryPrimitive:withArgs:)
		executeOn: anExecution receiver target
		withArguments: { number . anExecution arguments collect: [ :mirror | mirror target ] }).
	^ self objectSpace mirrorOn: result
]

{ #category : 'accessing' }
EPNumberedPrimitive >> number: aPrimitiveNumber [
	
	number := aPrimitiveNumber
]
