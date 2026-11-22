Class {
	#name : 'EPSimulatorSmallIntegerMirror',
	#superclass : 'EPMirror',
	#category : 'EspellSimulator',
	#package : 'EspellSimulator'
}

{ #category : 'accessing' }
EPSimulatorSmallIntegerMirror >> asLocalSmallInteger [
	
	^ backend integerValueOf: target
]
