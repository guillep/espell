Class {
	#name : 'EPRemoteOrderedCollection',
	#superclass : 'EPRemoteObject',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'iterating' }
EPRemoteOrderedCollection >> anySatisfy: aBlockClosure [ 
	
	self do: [ :each | (aBlockClosure value: each) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'iterating' }
EPRemoteOrderedCollection >> collect: aBlockClosure [ 
	
	| result |
	result := OrderedCollection new.
	self do: [ :each | result add: (aBlockClosure value: each) ].
	^ result
]

{ #category : 'iterating' }
EPRemoteOrderedCollection >> do: aBlockClosure [ 
	
	| array |
	array := mirror instanceVariableAtIndex: 1.
	1 to: array size do: [ :index | | elem |
		elem := array at: index.
		elem isNilObject ifFalse: [ aBlockClosure value: elem ] ]
]

{ #category : 'iterating' }
EPRemoteOrderedCollection >> size [
	
	| firstIndex lastIndex |
	firstIndex := (mirror instanceVariableAtIndex: 2) asSmallInteger.
	lastIndex := (mirror instanceVariableAtIndex: 3) asSmallInteger.
	^ lastIndex - firstIndex
]
