binding
bindingOf: aString
	(environment includesClassNamed: aString) ifTrue: [
		^ EPGlobalBinding new
			name: aString objectSpace: environment;
			yourself ].

	"If it is a temp or an instance variable"
	^ nil