testing
isClassMirror
	^ ({'PCMetaclass'. 'PCMetaclass class'} indexOf: self asClassMirror basicClass basicClass classNameFromAnyOrigin) > 0