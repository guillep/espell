Class {
	#name : 'EPRemoteObject',
	#superclass : 'Object',
	#instVars : [
		'mirror',
		'environment'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'instance-creation' }
EPRemoteObject class >> on: anEPMirror [ 
	
	^ self new
		initializeWithMirror: anEPMirror;
		yourself
]

{ #category : 'instance-creation' }
EPRemoteObject class >> on: anEPMirror environment: anEnvironment [
	
	^ self new
		initializeWithMirror: anEPMirror environment: anEnvironment;
		yourself
]

{ #category : 'accessing' }
EPRemoteObject >> basicClass [

	^ environment classForClassMirror: mirror basicClass
]

{ #category : 'initialize-release' }
EPRemoteObject >> initializeWithMirror: anEPClassMirror [ 
	
	mirror := anEPClassMirror
]

{ #category : 'initialize-release' }
EPRemoteObject >> initializeWithMirror: anEPClassMirror environment: anEnvironment [
	
	mirror := anEPClassMirror.
	environment := anEnvironment
]

{ #category : 'testing' }
EPRemoteObject >> isMethodContextClass [

	^ mirror isMethodContextClass
]

{ #category : 'accessing' }
EPRemoteObject >> mirror [

	^ mirror
]
