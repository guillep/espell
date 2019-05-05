gt-inspector-extension
classNameFromEnvironment
	
	^ self bootstrapEnvironment keyAtValue: self ifAbsent: [ #'' ]