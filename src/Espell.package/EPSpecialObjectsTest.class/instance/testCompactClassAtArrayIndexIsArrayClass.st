tests
testCompactClassAtArrayIndexIsArrayClass

	self assert: ((objectSpace backend compactClassAt: Array indexIfCompact ifNone: [ nil ])
		pointsToSameObject: objectSpace backend arrayClass)