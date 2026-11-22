"
I represent a primitive module for named primitives.  A module is a library that contains primitives. Usually it is used with a pragma as:

normalizePositive

	<primitive: 'primNormalizePositive' module:'LargeIntegers'>
	ContextPart primitiveFailToken
"
Class {
	#name : 'EPNamedPrimitiveModule',
	#superclass : 'Object',
	#instVars : [
		'primitives',
		'name'
	],
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'primitive-accessing' }
EPNamedPrimitiveModule >> addPrimitive: aPrimitive [ 

	aPrimitive module: self.
	primitives at: aPrimitive name put: aPrimitive.
	^ aPrimitive
]

{ #category : 'initialize-release' }
EPNamedPrimitiveModule >> initialize [ 
	
	super initialize.
	primitives := Dictionary new.
]

{ #category : 'installing' }
EPNamedPrimitiveModule >> installOn: aPrimitiveResolver [ 

	"self resolver: aPrimitiveResolver."
	aPrimitiveResolver primitiveForModuleName: name put: self.
]

{ #category : 'accessing' }
EPNamedPrimitiveModule >> name: primitiveName [ 

	name := primitiveName
]

{ #category : 'primitive-accessing' }
EPNamedPrimitiveModule >> primitiveNamed: aPrimitiveName [

	^ primitives
		at: aPrimitiveName
		ifAbsent: [ self addPrimitive: (EPNamedPrimitive new name: aPrimitiveName) ]
]
