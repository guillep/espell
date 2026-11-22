Class {
	#name : 'EPCrossCompilerBinding',
	#superclass : 'Object',
	#instVars : [
		'class',
		'environment'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'slot-accessing' }
EPCrossCompilerBinding >> allSlots [

	^ class allSlots
]

{ #category : 'binding-accessing' }
EPCrossCompilerBinding >> binding [

	^ class isMeta
		  ifTrue: [ 
			  EPMetaclassBinding new
				  name: class instanceSide name objectSpace: environment;
				  yourself ]
		  ifFalse: [ 
			  EPGlobalBinding new
				  name: class instanceSide name objectSpace: environment;
				  yourself ]
]

{ #category : 'binding-accessing' }
EPCrossCompilerBinding >> bindingOf: aString [

	(class classVarNames includes: aString asSymbol)
		ifTrue: [ self assert: environment notNil.
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: class instanceSide name
					objectSpace: environment;
				yourself ].
	class sharedPools
		do: [ :pool | 
			((self newBindingFor: pool) bindingOf: aString)
				ifNotNil: [ :binding | ^ binding ] ].
	class superclass
		ifNotNil: [ (self superclassBinding bindingOf: aString)
				ifNotNil: [ :binding | ^ binding ] ].
	(environment includesClassNamed: aString)
		ifTrue: [ self assert: environment notNil.
			^ EPGlobalBinding new
				name: aString objectSpace: environment;
				yourself ].

	"If it is a temp or an instance variable"
	^ nil
]

{ #category : 'accessing' }
EPCrossCompilerBinding >> class: aRFiClass [ 
	class := aRFiClass
]

{ #category : 'accessing' }
EPCrossCompilerBinding >> className [
	
	^ class name
]

{ #category : 'accessing' }
EPCrossCompilerBinding >> environment [
	^ environment
]

{ #category : 'accessing' }
EPCrossCompilerBinding >> environment: aCompilerEnvironment [ 
	environment := aCompilerEnvironment
]

{ #category : 'testing' }
EPCrossCompilerBinding >> hasTempVector [
	
	^ false
]

{ #category : 'binding-accessing' }
EPCrossCompilerBinding >> innerBindingOf: aString [

	(class classVarNames includes: aString asSymbol) ifTrue: [ 
		self assert: environment notNil.
		^ EPClassVariableBinding new
			  name: aString asSymbol ownerName: class instanceSide name objectSpace: environment;
			  yourself ].
	class instanceSide sharedPools do: [ :pool | ((self newBindingFor: pool) innerBindingOf: aString) ifNotNil: [ :binding | ^ binding ] ].
	class superclass ifNotNil: [ (self superclassBinding innerBindingOf: aString) ifNotNil: [ :binding | ^ binding ] ].

	"If it is a temp or an instance variable"
	^ nil
]

{ #category : 'testing' }
EPCrossCompilerBinding >> isBehavior [ 

	"I am mimicing the outer scopes that are behaviors... so Opal is fine"
	^ true
]

{ #category : 'lookup' }
EPCrossCompilerBinding >> lookupVar: aName declare: aBoolean [

	self allSlots detect: [ :e | e name = aName ] ifFound: [ :e | ^ e ].

	Smalltalk globals reservedVariables at: aName ifPresent: [ :e | ^e ].
	
	(self innerBindingOf: aName) ifNotNil: [ :e | ^ e ].

	^ environment bindingOf: aName
]

{ #category : 'accessing' }
EPCrossCompilerBinding >> name [

	^ self className
]

{ #category : 'bindings' }
EPCrossCompilerBinding >> newBindingFor: aRFiClass [ 
	
	^ EPCrossCompilerBinding new
		class: aRFiClass;
		environment: environment
]

{ #category : 'bindings' }
EPCrossCompilerBinding >> superclassBinding [
	
	^ self newBindingFor: class superclass
]
