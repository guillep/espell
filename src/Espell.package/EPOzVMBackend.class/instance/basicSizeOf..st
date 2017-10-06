primitives
basicSizeOf: aMirror

	| result |
	result := self
		handle: aMirror target
		executePrimitive: 62
		withArgs: #().
	"if the returned value is an array the primive failed because the target is not a variable object"
	result class == Array ifTrue: [ ^ 0 ].
	^ result