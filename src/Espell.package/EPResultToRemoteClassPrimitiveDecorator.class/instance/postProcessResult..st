as yet unclassified
postProcessResult: aResult

	| format compactClassIndex  |
	format := (aResult instanceVariableAtIndex: 3) asSmallInteger.
	compactClassIndex := self compactClassIndexOfFormat: format.
	compactClassIndex ~= 0 ifTrue: [
		^ (self compactClassAt: compactClassIndex ifNone: [ aResult ]) ].
	aResult target == SmallInteger ifTrue: [ ^ self smallIntegerClass ].
	^aResult