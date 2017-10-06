special
copy

	"If we put everything in one line it sends the #mirrorOn: message to self O_o... bug?"
	| copy |
	copy := self copy: target.
	^ backend mirrorOn: copy