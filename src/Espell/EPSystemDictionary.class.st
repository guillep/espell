"
I am a system dictionary. I provide access to the system dictionary inside an object space.
"
Class {
	#name : 'EPSystemDictionary',
	#superclass : 'Object',
	#instVars : [
		'systemDictionary',
		'objectSpace',
		'cache'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'as yet unclassified' }
EPSystemDictionary class >> withSystemDictionary: aSystemDictionaryMirror [

	^ self new withSystemDictionary: aSystemDictionaryMirror; yourself
]

{ #category : 'testing' }
EPSystemDictionary >> at: aString [ 
	
	cache at: aString ifPresent: [ :global | ^global ].
	^ objectSpace interpreter
			evaluateCode: 'systemDictionary at: key'
			withTemps: {
				'systemDictionary' -> systemDictionary.
				'key' -> (aString asSymbol asLiteralInObjectSpace: objectSpace) }
]

{ #category : 'testing' }
EPSystemDictionary >> at: aString put: aValue [
	
	cache at: aString put: aValue.
	
	^ objectSpace interpreter
			evaluateCode: 'systemDictionary at: key put: aValue'
			withTemps: { 
				'systemDictionary' -> systemDictionary.
				'key' -> (aString asSymbol asLiteralInObjectSpace: objectSpace).
				'aValue' -> aValue }
]

{ #category : 'binding' }
EPSystemDictionary >> bindingOf: aName [

	^ objectSpace interpreter
		evaluateCode: 'systemDictionary bindingOf: key'
		withTemps: { 
			'systemDictionary' -> systemDictionary.
			'key' -> (aName asSymbol asLiteralInObjectSpace: objectSpace) }
]

{ #category : 'initialization' }
EPSystemDictionary >> buildCache [

	objectSpace backend classes do: [ :each |
		cache at: each className put: each ]
]

{ #category : 'accessing' }
EPSystemDictionary >> globalObjects [
	
	"We get the real system dictionary"
	| globalsArray |
	systemDictionary := self internalSystemDictionary.
	
	"We get the internal array"
	globalsArray := systemDictionary instanceVariableAtIndex: (self instanceVariableMapping dictionaryArrayIndex).
	
	"We collect the values"
	^ (1 to: globalsArray size) collect: [ :i | globalsArray at: i ]
]

{ #category : 'testing' }
EPSystemDictionary >> includesGlobalNamed: aString [ 
	
	cache at: aString ifPresent: [ :global | ^ true ].
	^ (objectSpace interpreter
		evaluateCode: 'systemDictionary includesKey: key'
		withTemps: { 
			'systemDictionary' -> systemDictionary.
			'key' -> (aString asSymbol asLiteralInObjectSpace: objectSpace) })
			asBoolean
]

{ #category : 'initialization' }
EPSystemDictionary >> initialize [

	super initialize.
	cache := EPDictionary new.
]

{ #category : 'initialization' }
EPSystemDictionary >> initializeWithObjectSpace: anObjectSpace [
	
	objectSpace := anObjectSpace
]

{ #category : 'private' }
EPSystemDictionary >> internalSystemDictionary [
	
	^ objectSpace backend systemDictionary
]

{ #category : 'accessing' }
EPSystemDictionary >> objectSpace [
	^ objectSpace
]

{ #category : 'accessing' }
EPSystemDictionary >> objectSpace: anObjectSpace [ 
	objectSpace := anObjectSpace
]

{ #category : 'testing' }
EPSystemDictionary >> size [
	
	^ (objectSpace interpreter
			evaluateCode: 'systemDictionary size'
			withTemps: { 'systemDictionary' -> systemDictionary }) asSmallInteger
]

{ #category : 'initialization' }
EPSystemDictionary >> withSystemDictionary: aSystemDictionary [

	systemDictionary := aSystemDictionary
]
