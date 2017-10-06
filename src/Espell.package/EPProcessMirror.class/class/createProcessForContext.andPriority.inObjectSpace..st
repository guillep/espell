instance creation
createProcessForContext: aContextMirror andPriority: aPriority inObjectSpace: anObjectSpace
	| newProcess |
	newProcess := anObjectSpace backend processClass asClassMirror basicNew asProcessMirror.
	newProcess priority: aPriority.
	newProcess context: aContextMirror.
	^newProcess