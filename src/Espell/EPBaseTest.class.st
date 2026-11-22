Class {
	#name : 'EPBaseTest',
	#superclass : 'TestCase',
	#instVars : [
		'objectSpace'
	],
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'accessing' }
EPBaseTest class >> resources [

	^{ EPTestResource }
]

{ #category : 'running' }
EPBaseTest >> setUp [

	super setUp.
	objectSpace := EPTestResource current objectSpace
]
