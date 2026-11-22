Class {
	#name : 'EPPrimitiveFailed',
	#superclass : 'EPPrimitiveResult',
	#instVars : [
		'code'
	],
	#category : 'Espell',
	#package : 'Espell'
}

{ #category : 'accessing' }
EPPrimitiveFailed >> code: anInteger [ 
	code := anInteger
]

{ #category : 'testing' }
EPPrimitiveFailed >> hasFailed [
	
	^ true
]
