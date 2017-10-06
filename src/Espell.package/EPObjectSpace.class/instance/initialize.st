initialize-release
initialize
	super initialize.
	
	"compactClasses := EPDictionary new."
	
	environment := EPSystemDictionary new objectSpace: self; yourself.
	mustRebuildSpecialObjectsArray := false.
	self withInternalSymbolTable.
	self withInternalCharacterTable.

	self initializeMappings.
	self initializeBuilders.