accessing
classNameFromAnyOrigin
	^ [self classNameFromEnvironment ifEmpty: [ self className ]] on:Exception do: [ 'Error getting class name' ]