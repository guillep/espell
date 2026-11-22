"
I am a collection of named primitives used for easily index them.
"
Class {
	#name : 'EPNamedPrimitiveTable',
	#superclass : 'Object',
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'as yet unclassified' }
EPNamedPrimitiveTable class >> get: aPrimitive [ 

	^ self methods
		detect: [ :m | m pragmas anySatisfy: [ :p | p arguments first = aPrimitive ] ]
		ifNone: [ self error: 'Primitive not found: ', aPrimitive ]
]

{ #category : 'primitives' }
EPNamedPrimitiveTable >> compare: string1 with: string2 collated: order [

	<primitive: 'primitiveCompareString' module: 'MiscPrimitivePlugin'>
	Context primitiveFailToken
]

{ #category : 'private' }
EPNamedPrimitiveTable >> digitAdd: arg [ 

	<primitive: 'primDigitAdd' module:'LargeIntegers'>
	Context primitiveFailToken
]

{ #category : 'private' }
EPNamedPrimitiveTable >> digitCompare: arg [ 
	"Compare the magnitude of self with that of arg.   
	Return a code of 1, 0, -1 for self >, = , < arg"
	<primitive: 'primDigitCompare' module:'LargeIntegers'>
	Context primitiveFailToken
]

{ #category : 'private' }
EPNamedPrimitiveTable >> digitMultiply: arg neg: ng [ 

	<primitive: 'primDigitMultiplyNegative' module:'LargeIntegers'>
	Context primitiveFailToken
]

{ #category : 'primitives' }
EPNamedPrimitiveTable >> indexOfAscii: anInteger inString: aString startingAt: start [

	<primitive: 'primitiveIndexOfAsciiInString' module: 'MiscPrimitivePlugin'>
	Context primitiveFailToken
]

{ #category : 'primitives' }
EPNamedPrimitiveTable >> normalizeNegative [

	<primitive: 'primNormalizeNegative' module:'LargeIntegers'>
	Context primitiveFailToken
]

{ #category : 'primitives' }
EPNamedPrimitiveTable >> normalizePositive [

	<primitive: 'primNormalizePositive' module:'LargeIntegers'>
	Context primitiveFailToken
]

{ #category : 'primitives' }
EPNamedPrimitiveTable >> stringHash: aString initialHash: speciesHash [

	<primitive: 'primitiveStringHash' module: 'MiscPrimitivePlugin'>
	Context primitiveFailToken
]
