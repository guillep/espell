accessing
instVarNamed: aName
	^ self instanceVariableAtIndex: (self basicClassFromEnvironment instVarIndexFor: aName asString ifAbsent: [ InstanceVariableNotFound signalFor: aName asString ]).