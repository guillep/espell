accessing
variableNamed: aName

	| index |

	index := self code argumentNames indexOf: aName.
	index = 0 ifFalse: [ ^ self arguments at: index ].

	self temporaries at: aName ifPresent: [ :e | ^ e ].
	
	^ self homeContext variableNamed: aName