accessing
argumentNamed: aName
	
	| index |
	index := self code argumentNames indexOf: aName.
	
	index = 0 ifFalse: [ ^ self arguments at: index ].
	
	^ self tempNamed: aName