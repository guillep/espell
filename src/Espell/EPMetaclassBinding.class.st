Class {
	#name : 'EPMetaclassBinding',
	#superclass : 'EPLiteralBinding',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'as yet unclassified' }
EPMetaclassBinding >> asLiteralInObjectSpace: anObjectSpace [

	| theClass |
	"With these implementation each class side method will have its own class association.
	To save space we should cache them and share them"
	theClass := objectSpace classNamed: name asSymbol.
	^ anObjectSpace 
			newAssociationWithKey: anObjectSpace nilObject
			andValue: theClass classSide mirror.
]
