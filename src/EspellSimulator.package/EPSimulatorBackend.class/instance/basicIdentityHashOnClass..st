as yet unclassified
basicIdentityHashOnClass: aHandle

	^ [ self objectMemory ensureBehaviorHash: aHandle address]
		on: AssertionFailure do: [ :e | 
			"Retry because we may have forwarders"
			e resumeUnchecked: nil ]