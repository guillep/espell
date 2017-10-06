special objects
trueObject: anEPMirror
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"

	"^ self specialObjectsArray at: 1 put: anEPMirror"

	self specialObjectsArray
		ifNotNil: [ :soa | soa at: 3 put: anEPMirror ].
	simulator objectMemory trueObject: anEPMirror target address