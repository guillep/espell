I represent the BlockClosure>>on:do: temporaries in Pharo.

Instance Variables
	block:		<ASTBlockClosure>
	enabled:		<Boolean>
	exception:		<Exception>

block
	- is the handler block

enabled
	- is false if not active (to avoid running twice an handler block))

exception
	- is the exceptionClass
