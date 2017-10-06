initialize-release
process: aProcess context: aContext

	"aProcess stepToSendOrReturn ."
	"aProcess isSuspended ifTrue: [ aProcess stepToSendOrReturn ]."
	interruptedProcess := aProcess.
	interruptedContext := aContext.
	
