as yet unclassified
handleOnExternalObject: anObject

	^ EPSimulatorExternalObjectHandle new
			backend: self;
			object: anObject;
			yourself