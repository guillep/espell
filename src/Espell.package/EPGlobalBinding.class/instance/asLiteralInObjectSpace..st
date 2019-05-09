literal resolution
asLiteralInObjectSpace: anObjectSpace
Transcript show: 'loc ', objectSpace class asString  ;cr; show: 'arg ', anObjectSpace class asString;cr;cr .
	^ anObjectSpace backend interpreter codeProvider createGlobalBindingFor: self.
	"
Transcript show: 'loc ', objectSpace class asString  ;cr; show: 'arg ', anObjectSpace class asString;cr;cr .
	^ (objectSpace isKindOf: EPObjectSpace) 
		ifTrue: [  ]
		ifFalse: [ objectSpace createGlobalBindingFor: self ].
	"