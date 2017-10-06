initialize-release
initialize

	super initialize.
	"classMap := OzRemoteKeyDictionary new."
	interpreterClass := EPASTInterpreter.
	astCache := IdentityDictionary new.