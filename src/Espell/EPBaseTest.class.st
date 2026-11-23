Class {
	#name : #EPBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'kernel',
		'objectSpace'
	],
	#category : #'Espell-Tests'
}

{ #category : #accessing }
EPBaseTest class >> resources [

	^{ EPTestResource }
]

{ #category : #accessing }
EPBaseTest >> backend [

	^ objectSpace backend
]

{ #category : #helpers }
EPBaseTest >> mirrorOn: anInteger [

	^ self backend smallIntegerMirrorOn: anInteger
]

{ #category : #running }
EPBaseTest >> setUp [

	super setUp.
	kernel := EPTestResource current kernel.
	objectSpace := kernel objectSpace
]
