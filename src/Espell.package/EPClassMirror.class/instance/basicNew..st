accessing
basicNew: aSize

	^ backend basicNewOn: self withSize: (backend smallIntegerMirrorOn: aSize)