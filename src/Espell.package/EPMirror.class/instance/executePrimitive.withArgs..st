special
executePrimitive: number withArgs: args

	| result |
	result := backend
		handle: target
		executePrimitive: number
		withArgs: args.
	^ backend mirrorOn: result