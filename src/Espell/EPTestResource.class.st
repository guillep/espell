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
