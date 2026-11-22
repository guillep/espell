"
I am a primitive decorator that transforms the result of the getclass primitive into a class of the object space. This decorator is needed for the following cases:

- immediate objects: the VM will always return the installed class instead of the one of the object space. This is the case of SmallIntegers for example. If we get an immediate object we return the corresponding class from the object space.

- compact classes: instances of compact classes have no direct pointer to their classes but an index to a special array. The VM will then fetch the corresponding class from this array but not use the one in the object space. We perform the corresponding mapping if it is a compact class.
"
Class {
	#name : 'EPResultToRemoteClassPrimitiveDecorator',
	#superclass : 'EPPrimitiveDecorator',
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'compact classes' }
EPResultToRemoteClassPrimitiveDecorator >> compactClassAt: anInteger ifNone: aBlockClosure [ 
	
	^ resolver backend compactClassAt: anInteger ifNone: aBlockClosure 
]

{ #category : 'compact classes' }
EPResultToRemoteClassPrimitiveDecorator >> compactClassIndexOfFormat: anInteger [ 
	
	^ resolver backend compactClassIndexOfFormat: anInteger
]

{ #category : 'as yet unclassified' }
EPResultToRemoteClassPrimitiveDecorator >> postProcessResult: aResult [

	| format compactClassIndex  |
	format := (aResult instanceVariableAtIndex: 3) asSmallInteger.
	compactClassIndex := self compactClassIndexOfFormat: format.
	compactClassIndex ~= 0 ifTrue: [
		^ (self compactClassAt: compactClassIndex ifNone: [ aResult ]) ].
	aResult target == SmallInteger ifTrue: [ ^ self smallIntegerClass ].
	^aResult
]

{ #category : 'immediate classes' }
EPResultToRemoteClassPrimitiveDecorator >> smallIntegerClass [
	
	^ resolver backend smallIntegerClass
]
