well known objects
createSpecialObjectsArray
	| newSpecialObjectsArray |
	newSpecialObjectsArray := backend arrayClass asClassMirror basicNew: 56.
	newSpecialObjectsArray at: 1 put: self nilObject.
	newSpecialObjectsArray at: 2 put: self falseObject.
	newSpecialObjectsArray at: 3 put: self trueObject.
	newSpecialObjectsArray
		at: 4
		put: (self environment bindingOf: #Processor).
	newSpecialObjectsArray at: 5 put: backend nilObject.
	newSpecialObjectsArray at: 6 put: backend smallIntegerClass.
	newSpecialObjectsArray at: 7 put: backend byteStringClass.
	newSpecialObjectsArray at: 8 put: backend arrayClass.
	newSpecialObjectsArray at: 9 put: backend smalltalkInstance.
	newSpecialObjectsArray at: 10 put: backend floatClass.
	newSpecialObjectsArray at: 11 put: backend contextClass.
	newSpecialObjectsArray at: 12 put: backend nilObject.
	newSpecialObjectsArray at: 13 put: backend pointClass.
	newSpecialObjectsArray at: 14 put: backend largePositiveIntegerClass.
	newSpecialObjectsArray at: 15 put: backend nilObject.
	newSpecialObjectsArray at: 16 put: backend messageClass.
	newSpecialObjectsArray at: 17 put: backend methodClass.
	newSpecialObjectsArray at: 18 put: backend nilObject.
	newSpecialObjectsArray at: 19 put: backend semaphoreClass.
	newSpecialObjectsArray at: 20 put: backend characterClass.
	newSpecialObjectsArray at: 21 put: (#doesNotUnderstand: asLiteralInObjectSpace: self).
	newSpecialObjectsArray at: 22 put: (#cannotReturn: asLiteralInObjectSpace: self).
	newSpecialObjectsArray at: 23 put: backend nilObject.
	newSpecialObjectsArray at: 24 put: (#(#+ 1 #- 1 #< 1 #> 1 #'<=' 1 #'>=' 1 #= 1 #'~=' 1 #* 1 #/ 1 #'\\' 1 #@ 1 #bitShift: 1 #'//' 1 #bitAnd: 1 #bitOr: 1 #at: 1 #at:put: 2 #size 0 #next 0 #nextPut: 1 #atEnd 0 #'==' 1 nil 0 nil 1 #value 0 #value: 1 #do: 1 #new 0 #new: 1 #x 0 #y 0) asLiteralInObjectSpace: self).
	newSpecialObjectsArray
		at: 25
		put: backend characterTable. "character table"
	newSpecialObjectsArray at: 26 put: (#mustBeBoolean asLiteralInObjectSpace: self).
	newSpecialObjectsArray at: 27 put: backend byteArrayClass.
	newSpecialObjectsArray at: 28 put: backend processClass.
	newSpecialObjectsArray at: 29 put: self newCompactClassesArray.
	30 to: 56 do: [ :idx | newSpecialObjectsArray at: idx put: backend nilObject ].
	newSpecialObjectsArray at: 37 put: backend blockClass.
	"External semaphore table"
	newSpecialObjectsArray at: 39 put: (backend arrayClass asClassMirror basicNew: 20 ).
	newSpecialObjectsArray at: 43 put: backend largeNegativeIntegerClass.
	newSpecialObjectsArray at: 49 put: (#aboutToReturn:through: asLiteralInObjectSpace: self).
	newSpecialObjectsArray at: 50 put: (#run:with:in: asLiteralInObjectSpace: self).
	self flag: #'add WeakFinalization list'.
	^newSpecialObjectsArray.