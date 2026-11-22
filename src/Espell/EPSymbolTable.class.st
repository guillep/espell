Class {
	#name : 'EPSymbolTable',
	#superclass : 'Object',
	#instVars : [
		'objectSpace'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'public' }
EPSymbolTable >> at: aLocalSymbol [

	^ self at: aLocalSymbol ifAbsent: [ self error: 'key not found: ', aLocalSymbol ]
]

{ #category : 'public' }
EPSymbolTable >> at: aLocalSymbol ifAbsent: aBlock [

	self symbolsDo: [ :remoteSymbol | remoteSymbol asLocalString = aLocalSymbol
		ifTrue: [ ^ remoteSymbol ] ].
	^ aBlock value
]

{ #category : 'public' }
EPSymbolTable >> at: aLocalSymbol ifAbsentPut: aBlock [

	^ self at: aLocalSymbol ifAbsent: [ self installSymbol: aBlock value ]
]

{ #category : 'public' }
EPSymbolTable >> includesKey: aLocalSymbol [

	self symbolsDo: [ :remoteSymbol | remoteSymbol asLocalString = aLocalSymbol 
		ifTrue: [ ^true ] ].
	^ false
]

{ #category : 'public' }
EPSymbolTable >> installSymbol: aRemoteSymbol [
	self subclassResponsibility
]

{ #category : 'accessing' }
EPSymbolTable >> objectSpace: anObjectSpace [

	objectSpace := anObjectSpace
]

{ #category : 'public' }
EPSymbolTable >> symbolsDo: aBlock [
	self subclassResponsibility
]
