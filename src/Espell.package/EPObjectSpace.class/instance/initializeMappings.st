initialize-release
initializeMappings
	"self methodMapping: (OzMethodMapping new objectSpace: self; yourself).
	self methodPropertiesMapping: (OzMethodPropertiesMapping new objectSpace: self; yourself).
	self byteStringMapping: (OzByteStringMapping new objectSpace: self; yourself).
	self byteSymbolMapping: (OzByteSymbolMapping new objectSpace: self; yourself).
	self byteArrayMapping: (OzByteArrayMapping new objectSpace: self; yourself).
	self largeNegativeIntegerMapping: (OzLargeNegativeIntegerMapping new objectSpace: self; yourself).
	self largePositiveIntegerMapping: (OzLargePositiveIntegerMapping new objectSpace: self; yourself).
	self wideStringMapping: (OzWideStringMapping new objectSpace: self; yourself)."