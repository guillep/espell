I am an abstract specific context for the ASTInterpreter that represents Context in Pharo.

Instance Variables
	arguments:		<Collection>
	closure:		<CompiledMethod | ASTBlockClosure>
	isExecuted:		<Boolean>
	outerContext:		<AIContext>
	temporaries:		<Dictionary>

arguments
	- is the collection of the arguments of the method

closure
	- is either a CompiledMethod or an ASTBlockClosure, depending if I am an AIBlockClosure or an AIMethodContext

isExecuted
	- permits to know if my method has already been executed. In Pharo, when I am terminated my pc is set to nil. Then, you can know if I am terminated by checking if my pc is nil. In the ASTInterpreter we don't have pc so we use isExecuted boolean to know if the context is terminated. (isExecuted make the test ASTInterpreterTest>>testNonLocalReturnPart2 pass with the returningBlock)

outerContext
	- is my sender

temporaries
	- is the collection of the arguments + the temporaries of the method
