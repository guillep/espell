Class {
	#name : #EPRemoteClassTest,
	#superclass : #EPBaseTest,
	#instVars : [
		'environment'
	],
	#category : #'Espell-Tests'
}

{ #category : #running }
EPRemoteClassTest >> setUp [

	super setUp.
	environment := EPRemoteEnvironment on: self backend systemDictionary
]

{ #category : #tests }
EPRemoteClassTest >> testBindingOfClassVariableReturnsClassVariableBinding [

	| object binding |
	object := environment globalNamed: #Character.
	binding := (object bindingOf: #CharacterTable).
	
	self assert: binding isClassVariableBinding.
	self assert: binding name equals: #CharacterTable.
	self assert: binding ownerName equals: #Character.
]

{ #category : #tests }
EPRemoteClassTest >> testBindingOfGlobalReturnsGlobalBinding [

	| object binding |
	"Time uses chronology constants"
	object := environment globalNamed: #Object.
	binding := (object bindingOf: #Object).
	
	self assert: binding isGlobalVariableBinding.
	self assert: binding name equals: #Object.
]

{ #category : #tests }
EPRemoteClassTest >> testBindingOfInstanceVariableReturnsNil [

	| object |
	object := environment globalNamed: #HashedCollection.
	self assert: (object bindingOf: 'tally') isNil.
]

{ #category : #tests }
EPRemoteClassTest >> testBindingOfSharedPoolReturnsClassVariableBinding [

	| object binding |
	"Time uses chronology constants"
	object := environment globalNamed: #Time.
	binding := (object bindingOf: #SecondsInMinute).
	
	self assert: binding isClassVariableBinding.
	self assert: binding name equals: #SecondsInMinute.
	self assert: binding ownerName equals: #ChronologyConstants.
]

{ #category : #tests }
EPRemoteClassTest >> testBindingisLookedUpInSuperclass [

	| object binding |
	"Time uses chronology constants"
	object := environment globalNamed: #Collection.
	binding := (object bindingOf: #DependentsFields).
	
	self assert: binding isClassVariableBinding.
	self assert: binding name equals: #DependentsFields.
	self assert: binding ownerName equals: #Object.
]

{ #category : #tests }
EPRemoteClassTest >> testClassName [

	| remoteClass |
	remoteClass := environment classNamed: #HashedCollection.
	self assert: remoteClass name equals: HashedCollection name.
]

{ #category : #tests }
EPRemoteClassTest >> testClassVariableNames [

	| remoteClass |
	remoteClass := environment classNamed: #Object.
	self assert: remoteClass classVariableNames equals: Object classVarNames.
]

{ #category : #tests }
EPRemoteClassTest >> testEmptyClassVariableNames [

	| remoteClass |
	remoteClass := environment classNamed: #ProtoObject.
	self assert: remoteClass classVariableNames equals: ProtoObject classVarNames.
]

{ #category : #tests }
EPRemoteClassTest >> testEmptyInstanceVariableNames [

	| remoteClass |
	remoteClass := environment classNamed: #Object.
	self assert: remoteClass instanceVariableNames isEmpty.
]

{ #category : #tests }
EPRemoteClassTest >> testInstanceVariableNames [

	| remoteClass |
	remoteClass := environment classNamed: #HashedCollection.
	self assert: remoteClass instanceVariableNames equals: HashedCollection instVarNames.
]
