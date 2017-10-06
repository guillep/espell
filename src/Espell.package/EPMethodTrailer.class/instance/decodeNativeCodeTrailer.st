decoding
decodeNativeCodeTrailer
	| bytes platformId msz pos shift srcPtr |
	
	msz := method size.
	platformId := (method byteAt: msz - 1) + ((method byteAt: msz - 2)<<8).
	size := 	(method byteAt: msz - 3) + ((method byteAt: msz - 4)<<8).
		
	pos := method size-5.
	shift := srcPtr := 0.
	
	[ | value | 
		value := method byteAt: pos.
		srcPtr := (value bitAnd: 16r7F) << shift + srcPtr.
		pos := pos - 1.
		shift := shift + 7.
		value > 127 ] whileTrue.

	bytes := ByteArray new: size - (msz - pos).
	
	1 to: bytes size do: [:i | bytes at: i put: (method byteAt: msz-size+i) ].
	
	data := Array with: platformId with: bytes with: srcPtr.
	