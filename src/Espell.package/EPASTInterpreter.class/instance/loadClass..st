private
loadClass: aGlobalVariable

	"^ aGlobalVariable binding assoc bindingContext sourceEnvironment classNamed: aGlobalVariable name"
	^ evaluator environment createBehaviorFromDefinition: (evaluator environment definitionNamed: aGlobalVariable name)