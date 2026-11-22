Class {
	#name : 'EPRemoteMethodDictionary',
	#superclass : 'EPRemoteObject',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'accessing' }
EPRemoteMethodDictionary >> array [

	^ mirror instanceVariableAtIndex: 2
]

{ #category : 'accessing' }
EPRemoteMethodDictionary >> at: aString [ 
	
	1 to: mirror size do: [ :index | | key |
		key := mirror at: index.
		key isNilObject ifFalse: [ key asLocalString = aString ifTrue: [ 
				^ EPRemoteMethod on: ((self array) at: index) environment: environment ] ] ].
	
	KeyNotFound signalFor: aString in: self
]

{ #category : 'accessing' }
EPRemoteMethodDictionary >> includesKey: aString [ 
	
	1 to: mirror size do: [ :index | | key |
		key := mirror at: index.
		key isNilObject ifFalse: [ key asLocalString = aString ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : 'accessing' }
EPRemoteMethodDictionary >> keys [
	| keys |
	keys := OrderedCollection new.
	1 to: mirror size do: [ :index | | key |
		key := mirror at: index.
		key isNilObject ifFalse: [ keys add: key asLocalString ] ].
	^ keys
]

{ #category : 'accessing' }
EPRemoteMethodDictionary >> values [
	| values array |
	values := OrderedCollection new.
	array := mirror instanceVariableAtIndex: 2.
	1 to: mirror size do: [ :index | | key |
		key := mirror at: index.
		key isNilObject ifFalse: [ values add: (array at: index) ] ].
	^ values
]
