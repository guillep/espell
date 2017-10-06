execution
preProcessExecution: anExecution

	^ anExecution withArgumentsAs: [ :each | [ self objectSpace mirrorOn: each asLocalLiteral] on: Error do: [ each ] ]