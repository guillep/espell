accessing - literals
penultimateLiteral

	| index |
	index := self numberOfLiterals - 1.
	^ index > 0
		ifTrue: [ self literalAt: index ]
		ifFalse: [ self objectSpace nilObject ]