special objects
falseObject: anEPMirror
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"

	"^ self specialObjectsArray at: 1 put: anEPMirror"

	self specialObjectsArray
		ifNotNil: [ :soa | soa at: 2 put: anEPMirror ].
	simulator objectMemory falseObject: anEPMirror target address