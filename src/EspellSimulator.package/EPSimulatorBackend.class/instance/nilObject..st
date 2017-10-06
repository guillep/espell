special objects
nilObject: anEPMirror
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"

	self specialObjectsArray
		ifNotNil: [ :soa | soa at: 1 put: anEPMirror ].
	simulator objectMemory nilObject: anEPMirror target address