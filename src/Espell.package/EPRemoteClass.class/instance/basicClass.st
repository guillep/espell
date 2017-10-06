accessing
basicClass

	^ (environment metaclassForClassMirror: mirror basicClass)
		instanceSide: self;
		yourself