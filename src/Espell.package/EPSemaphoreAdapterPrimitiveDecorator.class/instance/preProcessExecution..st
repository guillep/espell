as yet unclassified
preProcessExecution: anExecution
	
	anExecution receiver instanceVariableAtIndex: 1 put: (resolver backend mirrorOn: nil).
	^ anExecution