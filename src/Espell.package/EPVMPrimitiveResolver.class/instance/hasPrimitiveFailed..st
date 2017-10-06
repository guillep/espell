testing
hasPrimitiveFailed: result
	"A primitive that fails doesn't always return ContextPart primitiveFailToken but returns ContextPart primitiveFailTokenFor: errorCode.
	A possible errorCode is nil, which corresponds to ContextPart primitiveFailToken.
	Here we loop over the errorCodes to know if the primitive has failed."

	| errorCodes |
	Context primitiveFailToken class == result primitiveClass
		ifFalse: [ ^ false ].
	result target size < 2
		ifTrue: [ ^ false ].
	errorCodes := SmalltalkImage current specialObjectsArray at: 52.
	^ errorCodes
		anySatisfy: [ :errorCode | 
			| token |
			token := Context primitiveFailTokenFor: errorCode.
			token first == result target first and: [ token second == result target second ] ]