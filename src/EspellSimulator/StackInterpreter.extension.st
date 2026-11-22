Extension { #name : 'StackInterpreter' }

{ #category : '*EspellSimulator' }
StackInterpreter >> checkForAndFollowForwardedPrimitiveState: primitiveIndex [
	"In Spur a primitive may fail due to encountering a forwarder. On failure,
	 check the accessorDepth for the primitive and if non-negative scan the
	 args to the depth, following any forwarders.  Answer if any are found so
	 the prim can be retried.  The primitive index is derived from newMethod.
	 If the primitive is 118, then primitiveDoPrimitiveWithArgs sets newMethod
	 to a SmallInteger whose value is the primitive it is evaluating."
	<option: #SpurObjectMemory>
	| accessorDepth found scannedStackFrame |
	self assert: self failed.
	found := scannedStackFrame := false.
	accessorDepth := primitiveAccessorDepthTable at: primitiveIndex.
	"For the method-executing primitives, failure could have been in those primitives or the
	 primitives of the methods they execute.  Find out which failed by seeing what is in effect."
	((primitiveIndex = 117 and: [primitiveFunctionPointer ~~ #primitiveExternalCall])
	 or: [primitiveIndex = 218 and: [primitiveFunctionPointer ~~ #primitiveDoNamedPrimitiveWithArgs]])
		ifTrue:
			[accessorDepth := self primitiveAccessorDepthForExternalPrimitiveMethod: newMethod]
		ifFalse:
			[self assert: (self saneFunctionPointerForFailureOfPrimIndex: primitiveIndex)].
	self assert: (accessorDepth between: -127 and: 127).
	accessorDepth >= 0 ifTrue:
		[0 to: argumentCount do:
			[:index| | oop |
			oop := self stackValue: index.
			(objectMemory isNonImmediate: oop) ifTrue:
				[(objectMemory isForwarded: oop) ifTrue:
					[self assert: index < argumentCount. "receiver should have been caught at send time."
					 found := true.
					 oop := objectMemory followForwarded: oop.
					 self stackValue: index put: oop.
					 scannedStackFrame ifFalse:
						[scannedStackFrame := true.
						 self
							followForwardedFrameContents: framePointer
							stackPointer: stackPointer + (argumentCount + 1 * objectMemory wordSize) "don't repeat effort"]].
				(accessorDepth > 0
			 	 and: [(objectMemory hasPointerFields: oop)
				 and: [objectMemory followForwardedObjectFields: oop toDepth: accessorDepth]]) ifTrue:
					[found := true]]]].
	^found
]

{ #category : '*EspellSimulator' }
StackInterpreter >> maybeRetryFailureDueToForwarding [
	"In Spur a primitive may fail due to encountering a forwarder. On failure, check
	 the accessorDepth for the primitive and if non-negative scan the args to the
	 depth, following any forwarders.  Retry the primitive if any are found."
	<inline: true>
	(objectMemory hasSpurMemoryManagerAPI
	 and: [self failed
	 and: [self checkForAndFollowForwardedPrimitiveState]]) ifTrue:
		[self initPrimCall.
		 self dispatchFunctionPointer: primitiveFunctionPointer]
]

{ #category : '*EspellSimulator' }
StackInterpreter >> maybeRetryFailureDueToForwarding: primitiveIndex [
	"In Spur a primitive may fail due to encountering a forwarder. On failure, check
	 the accessorDepth for the primitive and if non-negative scan the args to the
	 depth, following any forwarders.  Retry the primitive if any are found."
	<inline: true>
	(objectMemory hasSpurMemoryManagerAPI
	 and: [self failed
	 and: [self checkForAndFollowForwardedPrimitiveState: primitiveIndex ]]) ifTrue:
		[self initPrimCall.
		 self dispatchFunctionPointer: primitiveFunctionPointer]
]

{ #category : '*EspellSimulator' }
StackInterpreter >> uncheckedStSizeOf: oop [
	"Return the number of indexable fields in the given object. (i.e., what Smalltalk would return for <obj> size)."
	"Note: Assume oop is not a SmallInteger!"

	| hdr fmt totalLength fixedFields |
	<inline: false>
	hdr := objectMemory baseHeader: oop.
	fmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: oop baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: oop format: fmt length: totalLength.
	^totalLength - fixedFields
]
