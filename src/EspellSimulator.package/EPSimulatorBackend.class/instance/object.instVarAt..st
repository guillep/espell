primitives
object: anObject instVarAt: index 
	
	| address |
	address := self objectMemory fetchPointer: index - 1 ofObject: anObject target address.	
	((self objectMemory isNonImmediate: address)
		and: [self objectMemory isForwarded: address])
			ifTrue: [ | forwardedObject |
				forwardedObject := self objectMemory followForwarded: address.
				self object: anObject address instVarAt: index put: forwardedObject.
				address := forwardedObject ].
	^ self mirrorOnAddress: address