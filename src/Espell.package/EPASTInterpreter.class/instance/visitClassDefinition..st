visiting
visitClassDefinition: anOzClassDefinition 
	
	anOzClassDefinition superclass acceptVisitor: self newClassLoaderVisitor.
	anOzClassDefinition sharedPools do: [ :class | class acceptVisitor: self newClassLoaderVisitor ].
	anOzClassDefinition hasTraitComposition ifTrue: [ anOzClassDefinition traitComposition acceptVisitor: self newClassLoaderVisitor ].
	^ anOzClassDefinition message acceptVisitor: self.