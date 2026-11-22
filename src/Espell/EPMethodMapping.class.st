Class {
	#name : 'EPMethodMapping',
	#superclass : 'Object',
	#instVars : [
		'objectSpace'
	],
	#category : 'Espell-LowLevel-Mappings',
	#package : 'Espell',
	#tag : 'LowLevel-Mappings'
}

{ #category : 'transformations' }
EPMethodMapping >> createCompiledMethodWithSize: bytecodeSize andHeader: aMethodHeader [
	
	^ self objectSpace backend methodMirrorOn: 
		(self objectSpace backend
				createCompiledMethodWithSize: bytecodeSize
				andHeader: (aMethodHeader asLiteralInObjectSpace: self objectSpace))
]

{ #category : 'transformations' }
EPMethodMapping >> fromLocal: aCompiledMethod [
	| methodMirror methodSize |
	methodSize := aCompiledMethod bytecodes size + CompiledMethodTrailer empty size.
	methodMirror := self
						createCompiledMethodWithSize: methodSize
						andHeader: aCompiledMethod header.
	methodMirror bytecodes: aCompiledMethod bytecodes.
	methodMirror literals: aCompiledMethod literals.
	^methodMirror
]

{ #category : 'transformations' }
EPMethodMapping >> fromLocal: aCompiledMethod inEnvironment: anEnvironment [
	| methodMirror methodSize |
	methodSize := aCompiledMethod bytecode size + CompiledMethodTrailer empty size.
	methodMirror := self
						createCompiledMethodWithSize: methodSize
						andHeader: aCompiledMethod header.
	methodMirror bytecodes: aCompiledMethod bytecode.
	aCompiledMethod literals withIndexDo: [ :literal :index |
		methodMirror literalAt: index put: (literal asLiteralInObjectSpace: objectSpace).
	].
	^methodMirror
]

{ #category : 'transformations' }
EPMethodMapping >> fromRemote: aRemoteCompiledMethod [
	| method mirror methodTrailer |
	mirror := aRemoteCompiledMethod asMethodMirror.
	methodTrailer := CompiledMethodTrailer empty.
	method := methodTrailer
		createMethod: mirror bytecodes size
		class: CompiledMethod
		header: mirror header.
	method bytecodes: mirror bytecodes.
	method literals: mirror literals.
	method selector: mirror selector.
	method methodClass ifNotNil: [ 
		method literalAt: method numLiterals put: nil -> mirror methodClass asClassMirror.
	].
	^ method
]

{ #category : 'accessing' }
EPMethodMapping >> objectSpace [
	^objectSpace
]

{ #category : 'accessing' }
EPMethodMapping >> objectSpace: anObjectSpace [
	objectSpace := anObjectSpace
]
