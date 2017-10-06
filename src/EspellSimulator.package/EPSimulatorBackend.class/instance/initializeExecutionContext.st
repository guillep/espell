bootstrap
initializeExecutionContext

	| page pointer stackPages theIP theMethod rcvr numArgs |

"Create empty initial context to be able to execute primitives"
	stackPages := self simulator stackPages.
	page := stackPages newStackPage.
	pointer := page baseAddress.
	theIP := 0.
	theMethod := self nilObject target address.
	rcvr := self nilObject target address.
	numArgs := 0.
	
	"If this is a synthetic context its IP could be pointing at the CallPrimitive opcode.  If so, skip it."
	stackPages longAt: pointer put: rcvr.
	
	"saved caller ip is sender context in base frame"
	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: self nilObject target address.

	"base frame's saved fp is null"
	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: 0.
	page baseFP: pointer; headFP: pointer.

	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: theMethod.

	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: (self simulator encodeFrameFieldHasContext: true isBlock: true numArgs: numArgs).
	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: self nilObject target address.
	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: rcvr.
	
	"top of stack is the instruction pointer"
	stackPages longAt: (pointer := pointer - self objectMemory wordSize) put: theIP.
	page headSP: pointer.

	self simulator setStackPageAndLimit: page.
	self simulator framePointer: page headFP.
	self simulator stackPointer: page headSP.
	self simulator setMethodUnchecked: (self simulator iframeMethod: page headFP).
	self simulator instructionPointer: 0.
	self simulator internalizeIPandSP.