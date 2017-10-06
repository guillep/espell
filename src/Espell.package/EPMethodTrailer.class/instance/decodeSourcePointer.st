decoding
decodeSourcePointer

	"Trailer is a source pointer"
	| msz |
	
	size := 4.
	msz := method size.
	data := (method byteAt: msz) - 251 << 8 + (method byteAt: msz-1) << 8
	 + (method byteAt: msz-2) << 8 + (method byteAt: msz-3).
	
