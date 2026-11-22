Class {
	#name : 'EPSimulatorAddressHandle',
	#superclass : 'EPSimulatorInternalObjectHandle',
	#instVars : [
		'address'
	],
	#category : 'EspellSimulator',
	#package : 'EspellSimulator'
}

{ #category : 'accessing' }
EPSimulatorAddressHandle >> address [

	^ address
]

{ #category : 'accessing' }
EPSimulatorAddressHandle >> address: anInteger [ 
	address := anInteger
]

{ #category : 'converting' }
EPSimulatorAddressHandle >> asClassIndexHandle [

	| hash |
	hash := (backend rawHashOf: address).
	hash > 0 ifFalse: [ ^ self ].
	^ backend handleOnClassIndex: hash.
]

{ #category : 'printing' }
EPSimulatorAddressHandle >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: address asString;
		nextPut: $)
]
