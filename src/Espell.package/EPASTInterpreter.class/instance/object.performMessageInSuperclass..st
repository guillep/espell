reflective
object: receiver performMessageInSuperclass: aMessage	
	"Check if the message to perform is valid and if so, execute it"
	
	| selector arguments lookupClass message|
	
	selector := aMessage arguments first.
	arguments := aMessage arguments second.
	lookupClass := aMessage arguments third.
			
	message := Message selector: selector asLocalLiteral arguments: arguments.

	^self send: message to: receiver class: lookupClass