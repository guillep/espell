Class {
	#name : 'EPDummyEnvironment',
	#superclass : 'Object',
	#instVars : [
		'objectSpace'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'instance creation' }
EPDummyEnvironment class >> on: anEPObjectSpace [ 
	
	^ self new
		objectSpace: anEPObjectSpace;
		yourself
]

{ #category : 'binding' }
EPDummyEnvironment >> bindingOf: aName [

	^ EPGlobalBinding new
		name: aName objectSpace: objectSpace;
		yourself
]

{ #category : 'accessing' }
EPDummyEnvironment >> objectSpace: anEPObjectSpace [ 

	objectSpace := anEPObjectSpace
]
