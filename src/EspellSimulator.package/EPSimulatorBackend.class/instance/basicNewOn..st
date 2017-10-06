as yet unclassified
basicNewOn: theClass
	
	| newOop newObject |
	newOop := self objectMemory instantiateClass: theClass target address.
	self assert: newOop notNil.
	
	newObject := self mirrorOnAddress: newOop.
	1 to: theClass instanceFixedSize do: [ :index |
		newObject instanceVariableAtIndex: index put: self nilObject.
	].
	theClass isBitsClass ifFalse: [
		1 to: newObject size do: [ :index |
			newObject at: index put: self nilObject.
		].
	].
	^ newObject