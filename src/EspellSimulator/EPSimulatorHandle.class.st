Class {
	#name : 'EPSimulatorHandle',
	#superclass : 'Object',
	#instVars : [
		'backend'
	],
	#category : 'EspellSimulator',
	#package : 'EspellSimulator'
}

{ #category : 'converting' }
EPSimulatorHandle >> asClassIndexHandle [
	
	self subclassResponsibility
]

{ #category : 'accessing' }
EPSimulatorHandle >> backend: anEPSimulatorBackend [ 
	backend := anEPSimulatorBackend
]

{ #category : 'as yet unclassified' }
EPSimulatorHandle >> basicClass [
	
	^ backend handleOnAddress: (backend classOf: self)
]

{ #category : 'as yet unclassified' }
EPSimulatorHandle >> basicIdentityHashOnClass [

	^ backend basicIdentityHashOnClass: self
]

{ #category : 'as yet unclassified' }
EPSimulatorHandle >> hash [

	^ self address hash
]

{ #category : 'testing' }
EPSimulatorHandle >> isForwarder [
	
	^ backend isForwarderAddress: self address
]

{ #category : 'testing' }
EPSimulatorHandle >> isSmallInteger [
	
	^ backend isSmallInteger: self
]
