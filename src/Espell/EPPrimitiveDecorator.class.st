"
I am an abstract primitive decorator provinding special pre and post execution transformations. Check my subclasses for specific transformations.
"
Class {
	#name : 'EPPrimitiveDecorator',
	#superclass : 'EPPrimitive',
	#instVars : [
		'decoree'
	],
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'instance creation' }
EPPrimitiveDecorator class >> decorate: aPrimitive [

	^self new
			decoree: aPrimitive;
			yourself
]

{ #category : 'installing' }
EPPrimitiveDecorator >> basicInstall: aPrimitive inResolver: aPrimitiveResolver [

	self resolver: aPrimitiveResolver.
	decoree basicInstall: aPrimitive inResolver: aPrimitiveResolver.
]

{ #category : 'accessing' }
EPPrimitiveDecorator >> decoree: aDecoree [

	decoree := aDecoree
]

{ #category : 'execution' }
EPPrimitiveDecorator >> execute: anExecution [

	| result |
	result := decoree execute: (self preProcessExecution: anExecution).
	(resolver hasPrimitiveFailed: result) ifTrue: [ ^ result ].
	^ self postProcessResult: result.
]

{ #category : 'accessing' }
EPPrimitiveDecorator >> module: aModule [

	decoree module: aModule
]

{ #category : 'accessing' }
EPPrimitiveDecorator >> name [

	^ decoree name
]

{ #category : 'execution' }
EPPrimitiveDecorator >> postProcessResult: aResult [
	
	^aResult
]

{ #category : 'execution' }
EPPrimitiveDecorator >> preProcessExecution: anExecution [
	
	^anExecution
]
