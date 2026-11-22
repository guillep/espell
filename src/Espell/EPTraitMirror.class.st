"
I am a trait mirror object providing basic operations to work on trait objects inside an object space.
"
Class {
	#name : 'EPTraitMirror',
	#superclass : 'EPMirror',
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'converting' }
EPTraitMirror >> asRemoteClassOrTraitFromEnvironment: anEPRemoteEnvironment [
	^ EPRemoteTrait
		on: self
		environment: anEPRemoteEnvironment
]

{ #category : 'accessing' }
EPTraitMirror >> classSide [
	
	^ self classTrait
]

{ #category : 'accessing' }
EPTraitMirror >> classTrait [
	
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping traitClassTraitIndex)) asClassMirror
]

{ #category : 'accessing' }
EPTraitMirror >> methodDictionary [

	^ self instanceVariableAtIndex: (self backend instanceVariableMapping traitMethodDictionaryIndex)
]

{ #category : 'accessing' }
EPTraitMirror >> traitName [
	
	^ backend fromRemoteByteSymbol: (self instanceVariableAtIndex: (self backend instanceVariableMapping traitNameIndex))
]
