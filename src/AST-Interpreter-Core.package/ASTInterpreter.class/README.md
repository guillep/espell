I interpret AST. I run methods in my method-evalluation protocol, called through acceptMessageNode:receiver:

Instance Variables
	context:		<AIContext>
	currentNode:		<RBProgramNode>
	gotoContext:		<False | AIContext>
	primitiveFailed:		<Boolean>

context
	- is the current context being interpreted

currentNode
	- is the current node being interpreted

gotoContext
	- In the case of non local return or exception it is used to return to the right context after executing the unwinded blocks. 

primitiveFailed
	- primitiveFail token
