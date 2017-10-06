instance creation
createContextForMethod: aRemoteCompiledMethod inObjectSpace: anObjectSpace
	| contextClassMirror newContext |
	contextClassMirror := anObjectSpace backend contextClass asClassMirror.
	newContext := (contextClassMirror basicNew: aRemoteCompiledMethod frameSize) asContextMirror.
	newContext sender: anObjectSpace nilObject.
	newContext receiver: anObjectSpace nilObject.
	newContext method: aRemoteCompiledMethod.
	newContext closure: anObjectSpace nilObject.
	newContext startpc: aRemoteCompiledMethod initialPC.
	newContext stackPointer: 0.
	newContext initializeTemporaryVariables.
	^newContext