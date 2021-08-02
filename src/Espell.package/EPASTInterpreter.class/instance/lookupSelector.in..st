private
lookupSelector: selector in: class
	| found |
	"This I think could be safe to remove"
	class = ASTBlockClosure
		ifTrue: [ ^super lookupSelector: selector in: class ].
	
	found := self
		lookupFrom: class
		until: [ :c | c includesSelector: selector ]
		ifNone: [ self error: selector, ' not found in ' , class name ].
	^ (found methods detect: [ :m | m selector = selector ]) ast