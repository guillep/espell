binding
bindingOf: aName

	^ EPGlobalBinding new
		name: aName objectSpace: objectSpace;
		yourself