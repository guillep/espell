Class {
	#name : 'EPPrimitiveSuccess',
	#superclass : 'EPPrimitiveResult',
	#instVars : [
		'value'
	],
	#category : 'Espell',
	#package : 'Espell'
}

{ #category : 'accessing' }
EPPrimitiveSuccess >> value [
	^ value
]

{ #category : 'accessing' }
EPPrimitiveSuccess >> value: anEPMirror [ 
	value := anEPMirror
]
