*EspellSimulator
maybeRetryFailureDueToForwarding: primitiveIndex
	"In Spur a primitive may fail due to encountering a forwarder. On failure, check
	 the accessorDepth for the primitive and if non-negative scan the args to the
	 depth, following any forwarders.  Retry the primitive if any are found."

	<inline: true>
	(self failed and: [ self checkForAndFollowForwardedPrimitiveState: primitiveIndex ]) ifTrue: [
		self initPrimCall.
		self dispatchFunctionPointer: primitiveFunctionPointer ]