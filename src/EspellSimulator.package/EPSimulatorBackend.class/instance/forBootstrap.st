bootstrap
forBootstrap

	self objectMemory
		allocateMemoryOfSize: 30 * 1024 * 1024 "10MB of old space"
		newSpaceSize: 50 * 1024 * 1024 "20MB of new space"
		stackSize: 16 * 1024
		codeSize: 0.
	"self objectMemory
		setHeapBase: self objectMemory startOfMemory
		memoryLimit: self objectMemory startOfMemory + (4 * 1024 * 1024)
		endOfMemory: self objectMemory startOfMemory + 16 * 1024."
	self objectMemory setCheckForLeaks: 15 - 6. "don't check become; or newSpace; soooo many rehashes in bootstrap"
	self objectMemory bootstrapping: true.
	self objectMemory lastHash: Object new basicIdentityHash.
	self objectMemory classTableIndex: 1024.
	self simulator thisClassIndex: 6. "we are in pharo"
	self simulator transcript: ThreadSafeTranscript new.