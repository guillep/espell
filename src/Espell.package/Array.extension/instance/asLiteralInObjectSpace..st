*Espell-Extensions
asLiteralInObjectSpace: anObjectSpace
	"Method only for literal arrays!"
	^ anObjectSpace 
		newArrayWithAll: (self collect: [ :each | each asLiteralInObjectSpace: anObjectSpace ]).