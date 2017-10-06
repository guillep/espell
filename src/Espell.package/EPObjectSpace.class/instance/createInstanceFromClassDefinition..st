primitives
createInstanceFromClassDefinition: aClassDefinition

	^ (self
		createClassWithFormat: aClassDefinition classSide format
		forInstancesOfFormat: aClassDefinition format) basicNew