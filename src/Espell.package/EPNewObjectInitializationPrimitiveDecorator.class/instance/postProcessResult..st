execution
postProcessResult: newObject
	
	| theClass |	
	theClass := newObject basicClass.	
	theClass compactClassIndex = 14 "is method context"
		ifTrue:[ ^ newObject ].

	1 to: theClass instanceFixedSize do: [ :index |
		newObject instanceVariableAtIndex: index put: self nilObject.
	].
	theClass isBitsClass ifFalse: [
		1 to: newObject size do: [ :index |
			newObject at: index put: self nilObject.
		].
	].

	"To tell the VM this is an Object Space object"
	newObject markExperimentalBit: true.

	^newObject