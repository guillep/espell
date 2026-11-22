Class {
	#name : 'EPRemoteTrait',
	#superclass : 'EPRemoteObject',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'accessing' }
EPRemoteTrait >> allSlots [
	^ #()
]

{ #category : 'binding' }
EPRemoteTrait >> binding [
	^ self bindingOf: self name
]

{ #category : 'binding' }
EPRemoteTrait >> bindingOf: aString [
	(environment includesClassNamed: aString) ifTrue: [
		^ EPGlobalBinding new
			name: aString objectSpace: environment;
			yourself ].

	"If it is a temp or an instance variable"
	^ nil
]

{ #category : 'accessing' }
EPRemoteTrait >> classSide [

	^  (EPRemoteClassTrait 
		on: mirror classTrait 
		environment: environment)
			instanceSide:  self
]

{ #category : 'accessing' }
EPRemoteTrait >> methodDictionary [

	^ EPRemoteMethodDictionary 
		on: mirror methodDictionary
		environment: environment
]

{ #category : 'accessing' }
EPRemoteTrait >> name [

	^ mirror  backend fromRemoteByteSymbol: (mirror instanceVariableAtIndex: (self instanceVariableMapping traitNameIndex))
]
