accessing
value: anObject
	"we keep track in the local representation of the environment of the object space"
	environment at: self name put: anObject.
	objectSpace environment addGlobal: self name pointingTo: anObject.

	^super value: anObject.	