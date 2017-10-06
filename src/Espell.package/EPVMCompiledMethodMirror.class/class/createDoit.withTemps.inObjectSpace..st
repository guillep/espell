instance creation
createDoit: aString withTemps: aCollection inObjectSpace: anEPObjectSpace 
	
	^  anEPObjectSpace crossCompiler compileDoIt: aString