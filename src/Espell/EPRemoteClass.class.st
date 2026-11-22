Class {
	#name : 'EPRemoteClass',
	#superclass : 'EPRemoteObject',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'class variables' }
EPRemoteClass >> allClassVariableNames [
	
	self superclass ifNil: [ ^ self classVariableNames ].
	^ self superclass allClassVariableNames, self classVariableNames
]

{ #category : 'instance variables' }
EPRemoteClass >> allInstanceVariableNames [
	
	self superclass ifNil: [ ^ self instanceVariableNames ].
	^ self superclass allInstanceVariableNames, self instanceVariableNames
]

{ #category : 'instance variables' }
EPRemoteClass >> allSlots [
	
	^ self allInstanceVariableNames withIndexCollect: [ :each :index |
		(InstanceVariableSlot named: each asSymbol)
			index: index;
			yourself ]
]

{ #category : 'accessing' }
EPRemoteClass >> basicClass [

	^ (environment metaclassForClassMirror: mirror basicClass)
		instanceSide: self;
		yourself
]

{ #category : 'accessing' }
EPRemoteClass >> binding [
	
	^ self bindingOf: self name
]

{ #category : 'binding' }
EPRemoteClass >> bindingOf: aString [
	(self definesClassVariable: aString asSymbol)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: self name
					objectSpace: environment;
				yourself ].
	self sharedPools
		do:
			[ :pool | (pool bindingOf: aString) ifNotNilDo: [ :binding | ^ binding ] ].
	(self superclass bindingOf: aString)
		ifNotNil: [ :binding | ^ binding ].
	(environment includesClassNamed: aString)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPGlobalBinding new
				name: aString objectSpace: environment;
				yourself ].

	"If it is a temp or an instance variable"
	^ nil
]

{ #category : 'class variables' }
EPRemoteClass >> classPool [
	
	^ EPRemoteDictionary on: (mirror classPool)
]

{ #category : 'accessing' }
EPRemoteClass >> classSide [

	^ self basicClass
]

{ #category : 'class variables' }
EPRemoteClass >> classVariableNames [
	
	mirror classPool isNilObject ifTrue: [ ^ #() ].
	^ self classPool keys asArray
]

{ #category : 'class variables' }
EPRemoteClass >> definesClassVariable: aString [ 
	
	^ self classVariableNames includes: aString
]

{ #category : 'accessing' }
EPRemoteClass >> environment [

	^ environment 
]

{ #category : 'methods' }
EPRemoteClass >> includesSelector: aString [ 
	
	^ self methodDictionary includesKey: aString
]

{ #category : 'initialize-release' }
EPRemoteClass >> initializeWithMirror: aMirror [

	mirror := aMirror asClassMirror
]

{ #category : 'initialize-release' }
EPRemoteClass >> initializeWithMirror: aMirror environment: anEnvironment [

	^ super
		initializeWithMirror: aMirror asClassMirror
		environment: anEnvironment
]

{ #category : 'binding' }
EPRemoteClass >> innerBindingOf: aString [
	(self definesClassVariable: aString asSymbol)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: self name
					objectSpace: environment;
				yourself ].
	self sharedPools
		do:
			[ :pool | (pool innerBindingOf: aString) ifNotNil: [ :binding | ^ binding ] ].
	self superclass ifNotNil:[	
		(self superclass innerBindingOf: aString)
			ifNotNil: [ :binding | ^ binding ]].

	^ nil
]

{ #category : 'instance variables' }
EPRemoteClass >> instanceVariableNames [
	| remoteInstVars index |

	index := self mirror backend instanceVariableMapping classInstanceVariableNamesIndex.
	index ifNil: [ ^ #() ].
	remoteInstVars := mirror instanceVariableAtIndex: index.
	remoteInstVars isNilObject
		ifTrue: [ ^ #() ].
	^ remoteInstVars asLocalLiteral
]

{ #category : 'bindings' }
EPRemoteClass >> lookupVar: aString declare: aBoolean [ 
	
	^ self bindingOf: aString
]

{ #category : 'methods' }
EPRemoteClass >> methodDictionary [
	
	^ EPRemoteMethodDictionary on: mirror methodDictionary environment: environment
]

{ #category : 'methods' }
EPRemoteClass >> methods [
	
	^ self methodDictionary values collect: [ :each | EPRemoteMethod on: each environment: environment ]
]

{ #category : 'accessing' }
EPRemoteClass >> name [

	^ mirror className
]

{ #category : 'printing' }
EPRemoteClass >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self name;
		nextPutAll: ')'
]

{ #category : 'shared pools' }
EPRemoteClass >> sharedPools [
	
	| sharedPools maybeSharedPool |
	maybeSharedPool := mirror instanceVariableAtIndex: (mirror instanceVariableMapping classSharedPoolsIndex).
	maybeSharedPool isNilObject ifTrue: [ ^ #() ].
	sharedPools := EPRemoteOrderedCollection on: maybeSharedPool.
	^ sharedPools collect: [ :sharedPool | EPRemoteClass on: sharedPool environment: environment ]
]

{ #category : 'accessing' }
EPRemoteClass >> superclass [
	
	mirror superclass isNilObject ifTrue: [ ^ nil ].
	^ EPRemoteClass on: mirror superclass environment: environment
]

{ #category : 'shared pools' }
EPRemoteClass >> usesLocalPoolVarNamed: aString [ 
	
	| sharedPools |
	sharedPools := EPRemoteOrderedCollection on: (self instanceVariableMapping classSharedPoolsIndex).
	^ sharedPools anySatisfy: [ :sharedPool | 
		(EPRemoteClass on: sharedPool environment: environment) allClassVariableNames includes: aString ]
]
