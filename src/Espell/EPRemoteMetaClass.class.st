Class {
	#name : 'EPRemoteMetaClass',
	#superclass : 'EPRemoteClass',
	#instVars : [
		'instanceSide'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'class variables' }
EPRemoteMetaClass >> allClassVariableNames [
	
	^ self instanceSide allClassVariableNames
]

{ #category : 'as yet unclassified' }
EPRemoteMetaClass >> binding [

	^ EPMetaclassBinding  new
			name: self name objectSpace: environment;
			yourself 
]

{ #category : 'as yet unclassified' }
EPRemoteMetaClass >> bindingOf: aString [
	
	^ self instanceSide bindingOf: aString
]

{ #category : 'class variables' }
EPRemoteMetaClass >> classVariableNames [
	
	^ self instanceSide classVariableNames
]

{ #category : 'accessing' }
EPRemoteMetaClass >> instanceSide [

	^ instanceSide
]

{ #category : 'accessing' }
EPRemoteMetaClass >> instanceSide: aClass [

	instanceSide := aClass
]

{ #category : 'class variables' }
EPRemoteMetaClass >> name [

	^ self instanceSide name
]

{ #category : 'shared pools' }
EPRemoteMetaClass >> sharedPools [

	^ self instanceSide sharedPools
]

{ #category : 'shared pools' }
EPRemoteMetaClass >> usesLocalPoolVarNamed: aString [

	^ self instanceSide usesLocalPoolVarNamed: aString
]
