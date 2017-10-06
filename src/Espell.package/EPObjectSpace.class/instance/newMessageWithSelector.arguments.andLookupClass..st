instance creation
newMessageWithSelector: selector arguments: args andLookupClass: lookupClass

	| message |
	message := self environment messageClass basicNew.
	message instVarAt: 1 put: selector.
	message instVarAt: 2 put: args.
	message instVarAt: 3 put: lookupClass.
	^ message