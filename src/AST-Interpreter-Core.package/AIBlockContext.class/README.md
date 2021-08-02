I am a specific context for the ASTInterpreter that represents BlockContext in Pharo. I have one aditional role with is to manage myself the exception handling and I do not delegate it to the context of the BlockClosure>>on:do: method

Instance Variables
	exceptionHandler:		<ExceptionHandler>
	homeContext:		<AIContext>

exceptionHandler
	- is nil if there are no exception handler 
	  is an ExceptionHandler which represents an ExceptionClass, a handlerBlock and the isActive boolean. It represents in Pharo the temporaries of the BlockClosure>>on:do: method

homeContext
	- is the homeContext of the BlockClosure
	 <is duplicated with ASTBlockClosure - homeContext>
