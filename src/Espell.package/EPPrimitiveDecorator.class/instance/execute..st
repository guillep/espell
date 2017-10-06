execution
execute: anExecution

	| result |
	result := decoree execute: (self preProcessExecution: anExecution).
	(resolver hasPrimitiveFailed: result) ifTrue: [ ^ result ].
	^ self postProcessResult: result.