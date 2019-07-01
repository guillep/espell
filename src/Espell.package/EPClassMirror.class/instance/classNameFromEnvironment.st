accessing
classNameFromEnvironment
	
	^ self bootstrapEnvironment keyAtValue: self ifAbsent: [ #'' ]