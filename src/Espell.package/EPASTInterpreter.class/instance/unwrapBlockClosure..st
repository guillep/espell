private
unwrapBlockClosure: maybeBlock
	
	^ maybeBlock target object
	"| block |
	block := maybeBlock.
	[block isKindOf: ASTBlockClosure]
		whileFalse: [ block := maybeBlock target ].
	^ block"