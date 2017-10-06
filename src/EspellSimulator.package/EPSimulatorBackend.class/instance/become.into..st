as yet unclassified
become: anObject into: anotherObject
	
	| origin destiny |
	origin := self arrayClass basicNew: 1.
	origin at: 1 put: anObject.
	
	destiny := self arrayClass basicNew: 1.
	destiny at: 1 put: anotherObject.
	
	[self objectMemory
		become: origin target address
		with: destiny target address
		twoWay: false
		copyHash: true] on: AssertionFailure do: [ :e | 
			"Resume, we may have forwarders"
			e pass "resumeUnchecked: nil" ].
	
	extraRoots do: [ :each |
		"we become also the root objects such as byteSymbol class"
		anObject target == each target ifTrue: [ 
			each target: anotherObject target ]
	].