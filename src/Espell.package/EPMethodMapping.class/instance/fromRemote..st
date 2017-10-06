transformations
fromRemote: aRemoteCompiledMethod
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