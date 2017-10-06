*EspellSimulator
uncheckedContextStSzeOf: oop
	"Special version of primitiveSize for accessing contexts.
	 Written to be varargs for use from mirror primitives."
	| sz hdr fmt totalLength fixedFields |
	hdr := objectMemory baseHeader: oop.
	fmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: oop baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: oop format: fmt length: totalLength.
	(objectMemory isContextHeader: hdr)
		ifTrue:
			[self externalWriteBackHeadFramePointers.
			sz := self stackPointerForMaybeMarriedContext: oop]
		ifFalse: [sz := totalLength - fixedFields].
	^ objectMemory integerObjectOf: sz