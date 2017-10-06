as yet unclassified
handleOnClassIndex: aClassIndex

	^ EPSimulatorClassTableHandle new
			backend: self;
			classIndex: aClassIndex;
			yourself