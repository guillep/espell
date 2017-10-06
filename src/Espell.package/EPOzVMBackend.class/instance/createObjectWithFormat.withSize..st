bootstrap
createObjectWithFormat: aClassFormat withSize: aSize

	| instanceHandle metaclass metaclassHandle |
	"We create and initialize an annonimous class"
	metaclass := Metaclass new.
	metaclass
		superclass: Object
		methodDictionary: MethodDictionary new
		format: aClassFormat.
	
	"we mirror that class so we have complete control of it"
	metaclassHandle := self classMirrorOn: metaclass.
	instanceHandle := metaclassHandle basicNew: aSize.
	^ self mirrorOn: instanceHandle