accessing
classNameFromAnyOrigin
	^ self className ifEmpty: [ self classNameFromEnvironment ]