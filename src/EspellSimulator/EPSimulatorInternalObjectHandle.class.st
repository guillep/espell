Class {
	#name : 'EPSimulatorInternalObjectHandle',
	#superclass : 'EPSimulatorHandle',
	#category : 'EspellSimulator',
	#package : 'EspellSimulator'
}

{ #category : 'comparing' }
EPSimulatorInternalObjectHandle >> = aHandle [

	^ self species = aHandle species
		and: [ self address == aHandle address ]
]

{ #category : 'as yet unclassified' }
EPSimulatorInternalObjectHandle >> asSmallInteger [
	
	^ backend integerValueOf: self
]

{ #category : 'comparing' }
EPSimulatorInternalObjectHandle >> hash [

	^ self address hash
]

{ #category : 'as yet unclassified' }
EPSimulatorInternalObjectHandle >> instanceVariableAtIndex: anInteger [ 
	
	^ backend object: self instVarAt: anInteger
]

{ #category : 'comparing' }
EPSimulatorInternalObjectHandle >> species [

	^ EPSimulatorInternalObjectHandle
]
