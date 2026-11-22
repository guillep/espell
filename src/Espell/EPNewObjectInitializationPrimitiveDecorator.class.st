"
I am a primitive decorator in charge of initialize new objects created with the basicNew primitive. The VM will create them referencing the local nil instance. We will replace those references by the correct nil object (both variable and fixed fields).

Bit fields will stay as they are
"
Class {
	#name : 'EPNewObjectInitializationPrimitiveDecorator',
	#superclass : 'EPPrimitiveDecorator',
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'accessing' }
EPNewObjectInitializationPrimitiveDecorator >> nilObject [
	
	^ resolver backend nilObject
]

{ #category : 'execution' }
EPNewObjectInitializationPrimitiveDecorator >> postProcessResult: newObject [
	
	| theClass |	
	theClass := newObject basicClass.	
	theClass compactClassIndex = 14 "is method context"
		ifTrue:[ ^ newObject ].

	1 to: theClass instanceFixedSize do: [ :index |
		newObject instanceVariableAtIndex: index put: self nilObject.
	].
	theClass isBitsClass ifFalse: [
		1 to: newObject size do: [ :index |
			newObject at: index put: self nilObject.
		].
	].

	"To tell the VM this is an Object Space object"
	newObject markExperimentalBit: true.

	^newObject
]
