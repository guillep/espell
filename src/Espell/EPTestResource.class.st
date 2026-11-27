"
I build the `EPTestKernel` shared by the tests of Espell, once for all the test classes that use me.

## Variables

### Instance variables

- **kernel** (`EPTestKernel`): the kernel built in `#setUp`.
"
Class {
	#name : #EPTestResource,
	#superclass : #TestResource,
	#instVars : [
		'kernel'
	],
	#category : #'Espell-Tests'
}

{ #category : #accessing }
EPTestResource >> kernel [

	^ kernel
]

{ #category : #accessing }
EPTestResource >> objectSpace [

	^ kernel objectSpace
]

{ #category : #running }
EPTestResource >> setUp [

	super setUp.
	kernel := EPTestKernel new build
]

{ #category : #running }
EPTestResource >> tearDown [

	kernel := nil.
	super tearDown
]
