Class {
	#name : 'EPSimulatorClassTableHandle',
	#superclass : 'EPSimulatorInternalObjectHandle',
	#instVars : [
		'classHash'
	],
	#category : 'EspellSimulator',
	#package : 'EspellSimulator'
}

{ #category : 'as yet unclassified' }
EPSimulatorClassTableHandle >> address [

	^ backend classAtIndex: classHash
]

{ #category : 'accessing' }
EPSimulatorClassTableHandle >> classIndex: anInteger [ 
	
	classHash := anInteger
]
