visiting
visitMessageNode: aMessageNode

	| replacement |
	replacement := self tryToReplace: aMessageNode.
	replacement ifNotNil: [ ^ replacement acceptVisitor: self ].

	^ super visitMessageNode: aMessageNode