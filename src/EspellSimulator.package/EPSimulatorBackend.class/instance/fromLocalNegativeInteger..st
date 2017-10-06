as yet unclassified
fromLocalNegativeInteger: anInteger 
	
	^ self fromLocalInteger: anInteger
	"| integerClassMirror integerMirror |
	integerClassMirror := self largeNegativeIntegerClass asClassMirror.
	integerMirror := (integerClassMirror basicNew: anInteger basicSize).
	1 to: anInteger basicSize do: [ :i | integerMirror at: i put: ((anInteger at: i) asLiteralInObjectSpace: self) ].
	^integerMirror"