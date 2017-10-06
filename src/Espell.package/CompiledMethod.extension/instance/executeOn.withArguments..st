*Espell
executeOn: anObject withArguments: arguments
	"self halt."
	^(self receiver: anObject withArguments: arguments executeMethod: self)