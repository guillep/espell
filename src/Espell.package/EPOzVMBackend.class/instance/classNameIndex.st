private
classNameIndex

	| arrayClass |
	classNameIndex ifNotNil: [ ^ classNameIndex ].
	arrayClass := self arrayClass.
	4 to: arrayClass fixedSize do: [ :index | | maybeName |
		maybeName := arrayClass instanceVariableAtIndex: index.
		(maybeName size = 5 
			and: [ maybeName basicClass isBytesClass
				and: [ maybeName asLocalString = 'Array' ]])
					ifTrue: [ ^ classNameIndex := index ]].
	Error signal: 'Could not guess where is the class name!'.