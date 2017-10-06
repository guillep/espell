as yet unclassified
numberOfLiteralsOf: anEPSimulatorAddressHandle 
	
	^ (self headerOfCompiledMethod: anEPSimulatorAddressHandle) bitAnd: 16r7FFF