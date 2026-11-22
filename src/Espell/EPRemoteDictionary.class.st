Class {
	#name : 'EPRemoteDictionary',
	#superclass : 'EPRemoteObject',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'accessing' }
EPRemoteDictionary >> associationsDo: aBlock [

	| array |
	array := mirror instanceVariableAtIndex: (mirror instanceVariableMapping dictionaryArrayIndex).
	^ (1 to: array size)
		select: [ :i | (array uncheckedAt: i) isNilObject not ]
		thenDo: [ :i | | association |
			association := array uncheckedAt: i.
			aBlock value: association  ]
]

{ #category : 'accessing' }
EPRemoteDictionary >> at: aName [

	self associationsDo: [ :association | 
		(association instanceVariableAtIndex: 1) asLocalLiteral = aName
			ifTrue: [ ^ association instanceVariableAtIndex: 2 ] ].
	^ KeyNotFound signalFor: aName in: self
]

{ #category : 'accessing' }
EPRemoteDictionary >> at: aName put: aValue [

	self associationsDo: [ :association | 
		(association instanceVariableAtIndex: 1) asLocalLiteral = aName
			ifTrue: [ ^ association instanceVariableAtIndex: 2 put: aValue ] ].
	^ KeyNotFound signalFor: aName in: self
]

{ #category : 'accessing' }
EPRemoteDictionary >> bindingOf: aName [

	self associationsDo: [ :association | 
		(association instanceVariableAtIndex: 1) asLocalLiteral = aName
			ifTrue: [ ^ association ] ].
	^ nil
]

{ #category : 'accessing' }
EPRemoteDictionary >> includesKey: aName [

	self associationsDo: [ :association | 
		(association instanceVariableAtIndex: 1) asLocalLiteral = aName
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'accessing' }
EPRemoteDictionary >> keys [

	| keys |
	keys := OrderedCollection new.
	self associationsDo: [ :association | 
		keys add: (association instanceVariableAtIndex: 1) asLocalLiteral ].
	^ keys
]

{ #category : 'accessing' }
EPRemoteDictionary >> size [

	^ (mirror instanceVariableAtIndex: 1) asSmallInteger
]
