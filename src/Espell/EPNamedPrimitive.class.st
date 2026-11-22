"
I represent a named primitive that comes from a module.
"
Class {
	#name : 'EPNamedPrimitive',
	#superclass : 'EPPrimitive',
	#instVars : [
		'name',
		'module'
	],
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'installing' }
EPNamedPrimitive >> basicInstall: aPrimitive inResolver: aPrimitiveResolver [

	self resolver: aPrimitiveResolver.
	module installOn: aPrimitiveResolver
]

{ #category : 'execution' }
EPNamedPrimitive >> execute: anExecution [

	| result |
	result := ((EPNamedPrimitiveTable get: self name asSymbol)
		executeOn: anExecution receiver target
		withArguments: (anExecution arguments collect: #target)).
	^self objectSpace objectMirrorOn: result
]

{ #category : 'accessing' }
EPNamedPrimitive >> module: aModule [ 

	module := aModule
]

{ #category : 'accessing' }
EPNamedPrimitive >> name [
	
	^ name
]

{ #category : 'accessing' }
EPNamedPrimitive >> name: anObject [
	
	name := anObject
]
