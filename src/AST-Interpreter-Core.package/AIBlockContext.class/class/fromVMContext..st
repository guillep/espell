instance creation
fromVMContext: aBlockContext
	|sender|
	sender := aBlockContext sender.
	^ self new 
		initializeContext: aBlockContext;
		homeContext: aBlockContext home asASTInterpreterContext ; 
		closure: aBlockContext closure asASTBlockClosure;
		exceptionHandler: (sender ifNotNil: [ 
			sender isHandlerContext ifTrue: [
				ExceptionHandler on: (sender tempAt: 1) do: (sender tempAt: 2)]
			]) ;
		yourself