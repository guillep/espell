*Espell
asLiteralInObjectSpace: anObjectSpace

	| espellGlobal |
	espellGlobal := EPGlobalBinding new
		                name: name objectSpace: anObjectSpace;
		                yourself.
	^ espellGlobal asLiteralInObjectSpace: anObjectSpace