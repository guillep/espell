Class {
	#name : 'EPRemoteMethod',
	#superclass : 'EPRemoteObject',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'source code' }
EPRemoteMethod >> ast [
	
	^ RBExplicitVariableParser parseMethod: self sourceCode
]

{ #category : 'accessing' }
EPRemoteMethod >> byteAt: anInteger [ 
	
	^ mirror byteAt: anInteger
]

{ #category : 'initialize-release' }
EPRemoteMethod >> initializeWithMirror: aMirror environment: anEnvironment [
	^ super
		initializeWithMirror: aMirror asMethodMirror
		environment: anEnvironment
]

{ #category : 'accessing' }
EPRemoteMethod >> selector [
	
	^ mirror selector
]

{ #category : 'accessing' }
EPRemoteMethod >> size [
	
	^ mirror size
]

{ #category : 'source code' }
EPRemoteMethod >> sourceCode [

	^ environment sourceCodeForMethod: self
]
