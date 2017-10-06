as yet unclassified
handleOnAddress: anAddress

	^ EPSimulatorAddressHandle new
			backend: self;
			address: anAddress;
			yourself