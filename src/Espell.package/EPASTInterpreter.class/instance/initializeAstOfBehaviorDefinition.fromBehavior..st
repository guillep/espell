initialize-release
initializeAstOfBehaviorDefinition: definition fromBehavior: mirror
	definition methods do: [ :methodDefinition | 
		self
			initializeAstOfMethodDefinition: methodDefinition
			fromBehavior: mirror.
	].