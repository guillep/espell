special objects
associationClass
	"The class of the fourth special object
	Smalltalk specialObjectsArray fourth class"
	^ associationClass ifNil: [ (self specialObjectsArray at: 4) basicClass ]