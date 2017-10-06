binding-accessing
binding

	^ class isMeta ifTrue: [
		EPMetaclassBinding  new
			name: class theNonMetaClass name objectSpace: environment;
			yourself ] ifFalse: [
		EPGlobalBinding new
			name: class theNonMetaClass name objectSpace: environment;
			yourself ]