accessing
instVarNamed: aName
	^ self instanceVariableAtIndex: (self classFromEnvironment instVarIndexFor: aName asString ifAbsent: [ InstanceVariableNotFound signalFor: aName asString ]).