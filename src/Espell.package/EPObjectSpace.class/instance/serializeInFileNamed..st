transformations
serializeInFileNamed: fileName
	self halt.
	"OzImageSerializer new
		inStream: (FileStream newFileNamed: fileName);
		serialize: (OzGraphTracer new objectSpace: self;yourself)"