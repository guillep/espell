Class {
	#name : 'EPExternalSymbolTable',
	#superclass : 'EPSymbolTable',
	#instVars : [
		'symbols'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'public' }
EPExternalSymbolTable >> at: aLocalSymbol [

	^ symbols at: aLocalSymbol
]

{ #category : 'public' }
EPExternalSymbolTable >> includesKey: aLocalSymbol [

	^ symbols includesKey: aLocalSymbol
]

{ #category : 'initialization' }
EPExternalSymbolTable >> initialize [

	super initialize.
	symbols := EPDictionary new.
]

{ #category : 'public' }
EPExternalSymbolTable >> installSymbol: aRemoteSymbol [

	^ symbols at: aRemoteSymbol asLocalString asSymbol put: aRemoteSymbol
]

{ #category : 'public' }
EPExternalSymbolTable >> symbolsDo: aBlock [

	symbols copy keysAndValuesDo: [ :key :value |
		aBlock value: value.
	]
]

{ #category : 'accessing' }
EPExternalSymbolTable >> toInternalSymbolTable [

	| internal |
	internal := EPInternalSymbolTable new objectSpace: objectSpace.
	self symbolsDo: [ :symbol | 
		internal installSymbol: symbol ].
	objectSpace symbolTable: internal.
]
