Class {
	#name : 'EPCompilationRequestor',
	#superclass : 'Object',
	#instVars : [
		'temps'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'instance creation' }
EPCompilationRequestor class >> withTemps: aCollection [ 
	
	^ self new
			addTemps: aCollection;
			yourself
]

{ #category : 'adding' }
EPCompilationRequestor >> addTemps: aCollection [ 
	
	aCollection do: [ :association | temps add: association ]
]

{ #category : 'adding' }
EPCompilationRequestor >> bindingOf: aName [

	^ EPRealLiteralBinding name: aName value: (temps at: aName)
]

{ #category : 'adding' }
EPCompilationRequestor >> initialize [

	super initialize.
	temps := Dictionary new.
]
