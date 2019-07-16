printing
printOn: aStream with: anEPMirror 
	aStream nextPutAll: anEPMirror class name asString, ' (a ', anEPMirror basicClass classNameFromAnyOrigin asString, ')'