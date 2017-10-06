public api
setClass: aClassMirror
	[
		backend classHandle: aClassMirror target setTo: self target
	] on: PrimitiveFailed do: [ 
		(aClassMirror format ~= self basicClass format) ifTrue: [ 
			self error: ('format of instance {1} of format {2} should match class format: {3} ' 
				format: { self printString . self basicClass format . aClassMirror format asString })
		].
	]