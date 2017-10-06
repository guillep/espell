primitives
become: anObject into: anotherObject

	(Array with: anObject target)
		elementsForwardIdentityTo:
			(Array with: anotherObject target)