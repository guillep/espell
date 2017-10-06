accessing
methodClass
	| binding |
	binding := self literalAt: self numberOfLiterals.
	binding isNilObject ifTrue: [ ^nil ].
	^(binding instanceVariableAtIndex: 2) asClassMirror