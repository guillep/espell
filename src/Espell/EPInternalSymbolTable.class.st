Class {
	#name : #EPInternalSymbolTable,
	#superclass : #EPSymbolTable,
	#instVars : [
		'cache'
	],
	#category : #'Espell-HighLevel'
}

{ #category : #public }
EPInternalSymbolTable >> at: aLocalSymbol [

	^ cache at: aLocalSymbol ifAbsentPut: [ super at: aLocalSymbol ]
]

{ #category : #public }
EPInternalSymbolTable >> at: aLocalSymbol ifAbsent: aBlock [

	^ cache at: aLocalSymbol ifAbsent: [ self like: aLocalSymbol ifAbsent: aBlock ].
]

{ #category : #public }
EPInternalSymbolTable >> at: aLocalSymbol ifAbsentPut: aBlock [

	^ cache at: aLocalSymbol ifAbsent: [
		super at: aLocalSymbol ifAbsentPut: aBlock ]
]

{ #category : #accessing }
EPInternalSymbolTable >> at: aLocalSymbol put: aMirrorOnTheSymbol [

	^ cache at: aLocalSymbol put: aMirrorOnTheSymbol
]

{ #category : #initialization }
EPInternalSymbolTable >> buildCache [

	self symbolsDo: [ :each | cache at: each asLocalString asSymbol put: each ]
]

{ #category : #accessing }
EPInternalSymbolTable >> cachedSymbols [
	
	^ cache keys
]

{ #category : #public }
EPInternalSymbolTable >> includesCachedKey: aLocalSymbol [

	^ cache includesKey: aLocalSymbol
]

{ #category : #public }
EPInternalSymbolTable >> includesKey: aLocalSymbol [

	^ (cache includesKey: aLocalSymbol) or: [ super includesKey: aLocalSymbol ]
]

{ #category : #initialization }
EPInternalSymbolTable >> initialize [

	super initialize.
	cache := EPDictionary new.
]

{ #category : #public }
EPInternalSymbolTable >> installSymbol: aRemoteSymbol [

	cache at: aRemoteSymbol asLocalLiteral put: aRemoteSymbol.
	^ objectSpace interpreter
		evaluateCode: 'SymbolTable system unsafeAdd: aSymbol'
		withTemps: { 'aSymbol' -> aRemoteSymbol }
]

{ #category : #'private-iterating' }
EPInternalSymbolTable >> iterateSymbolArray: anArray with: aBlock [

	| array |
	array := anArray.
	1 to: array size do: [ :i | | element |
		element := array at: i.
		aBlock value: element.
	]
]

{ #category : #'private-iterating' }
EPInternalSymbolTable >> iterateSymbolWeakSet: aWeakSet with: aBlock [
	| array flag |
	array := aWeakSet instanceVariableAtIndex: 2.
	flag := aWeakSet instanceVariableAtIndex: 3.
	1 to: array size do: [ :i | 
		| element |
		element := array at: i.
		(nil ~~ element target and: [ element isNilObject not and: [ element ~= flag ] ])
			ifTrue: [ aBlock value: element ] ]
]

{ #category : #public }
EPInternalSymbolTable >> like: aString ifAbsent: failBlock [

	self symbolsDo: [ :aRemoteSymbol | 
		aRemoteSymbol asLocalString = aString ifTrue: [ ^ aRemoteSymbol ] ].
	^ failBlock value
]

{ #category : #public }
EPInternalSymbolTable >> symbolsDo: aBlock [

	| symbolTable arrayClass newSymbolsWeakSet oldSymbolsWeakSet |
	arrayClass := objectSpace backend arrayClass.
	symbolTable := objectSpace interpreter evaluateCode: 'SymbolTable system'.
	newSymbolsWeakSet := symbolTable instanceVariableAtIndex: 1.
	oldSymbolsWeakSet := symbolTable instanceVariableAtIndex: 2.
	{ newSymbolsWeakSet . oldSymbolsWeakSet } do: [ :symbolSet |
		symbolSet isNilObject ifFalse: [
			symbolSet basicClass = arrayClass
				ifTrue: [ self iterateSymbolArray: symbolSet with: aBlock ]
				ifFalse: [ self iterateSymbolWeakSet: symbolSet with: aBlock] ] ]
]

{ #category : #accessing }
EPInternalSymbolTable >> toInternalSymbolTable [
	
	^ self
]
