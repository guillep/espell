*EspellSimulator
checkForAndFollowForwardedPrimitiveState: index
	"Override to log"
	<option: #SpurObjectMemory>
	| found |
	cogit recordPrimTrace ifTrue:
		[self fastLogPrim: TracePrimitiveFailure].
	found := super checkForAndFollowForwardedPrimitiveState: index.
	(found and: [cogit recordPrimTrace]) ifTrue:
		[self fastLogPrim: TracePrimitiveRetry].
	^found