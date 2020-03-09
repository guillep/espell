special-classes
dictionaryClass
	^ self interpreter environment bootstrapEnvironment at: (self interpreter codeProvider systemDefinition classWithRole: #Dictionary) name