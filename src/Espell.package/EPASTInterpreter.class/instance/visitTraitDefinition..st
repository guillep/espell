visiting
visitTraitDefinition: anOzClassDefinition 
	
	"anOzClassDefinition message receiver acceptVisitor: self newClassLoaderVisitor."
	anOzClassDefinition hasTraitComposition ifTrue: [ anOzClassDefinition traitComposition acceptVisitor: self newClassLoaderVisitor ].
	^ anOzClassDefinition message acceptVisitor: self.