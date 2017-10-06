initialization
buildCache

	objectSpace backend classes do: [ :each |
		cache at: each className put: each ]