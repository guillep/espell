private
basicCompileDoItFromSourceCode: sourceCode

	"Ugly. We should not build a remote environment on demand like this. Think wether to put it in the object space or make the cross compiler know it."
	| highLevelUndefinedObjectClass |
	highLevelUndefinedObjectClass := (EPRemoteEnvironment on: objectSpace backend systemDictionary) classForClassMirror: objectSpace nilObject basicClass.
	^ (OpalCompiler new
		noPattern: true;
		compile: sourceCode
		in: highLevelUndefinedObjectClass
		notifying: nil
		ifFail: [ self error ]) generate