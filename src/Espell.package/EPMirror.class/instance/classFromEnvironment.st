accessing
classFromEnvironment
	self flag: 'FIX: super ineficient'.
	^ self systemDefinition classNamed: self basicClass classNameFromEnvironment