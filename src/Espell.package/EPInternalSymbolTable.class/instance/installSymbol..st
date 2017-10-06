public
installSymbol: aRemoteSymbol

	cache at: aRemoteSymbol asLocalLiteral put: aRemoteSymbol.
	^ objectSpace interpreter evaluateCode: 'Symbol intern: aSymbol' withTemps: { 'aSymbol' -> aRemoteSymbol }