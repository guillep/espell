class-maps
mappingOf: anObject

	(anObject target species = EPSimulatorExternalObjectHandle) ifTrue: [
		anObject target object == ASTBlockClosure ifTrue: [ ^ ASTBlockClosure ].
		anObject target object == RBBlockNode ifTrue: [ ^ RBBlockNode ].
		anObject target object == OrderedCollection ifTrue: [ ^ OrderedCollection ].
		anObject target object == SmallInteger ifTrue: [ ^ SmallInteger ].
	].
	^ codeProvider classForClassMirror: anObject
	"classMap 
		at: anObject
		ifPresent: [ :mapping | ^mapping ]."
	
	"If we don't have a mapping, maybe it's just a metaclass inside the class builder. We should do a better check but..."
	"classMap 
		at: (self environment at: #Class)
		ifPresent: [ :mapping | ^ mapping ]."

	"self error: 'mapping for class not found'."