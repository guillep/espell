special objects
processorAssociation: anAssociation

	"The Association object that references the processor.
	Should be index 4.
	Smalltalk specialObjectsArray indexOf: (Smalltalk bindingOf: #Processor)"
	^ specialObjectsArray at: 4 put: anAssociation