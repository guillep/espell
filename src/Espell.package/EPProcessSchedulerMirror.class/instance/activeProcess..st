accessing
activeProcess: anEPProcessMirror 
	
	self instanceVariableAtIndex: (self backend instanceVariableMapping processSchedulerActiveProcessIndex) put: anEPProcessMirror