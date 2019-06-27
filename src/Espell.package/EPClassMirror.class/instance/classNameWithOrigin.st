gt-inspector-extension
classNameWithOrigin
	| nameInstalled nameFromEnv showWarningEquals showWarningEmpty nameToShow |
	nameInstalled := self className.
	nameFromEnv := self classNameFromEnvironment.

	showWarningEmpty := nameInstalled isEmpty and: [ nameFromEnv isEmpty ].
	showWarningEquals := nameInstalled isNotEmpty and: [ nameInstalled ~= nameFromEnv ].

	nameToShow := nameInstalled isNotEmpty ifTrue: [ nameInstalled ] ifFalse: [ nameFromEnv , ' [from environment]' ].
	
	^ showWarningEquals
			ifTrue:  [ 'WARNING: installed class name doesn''t match ', Character cr,  nameInstalled, ' [installed] != ', nameFromEnv , ' [from environment]' ]
			ifFalse: [ 
				showWarningEmpty 
					ifTrue: [ 'WARNING: class with no name' ]
					ifFalse: [ nameToShow ] ].