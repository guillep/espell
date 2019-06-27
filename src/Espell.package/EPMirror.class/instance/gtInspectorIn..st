gt-inspector-extension
gtInspectorIn: composite
	<gtInspectorPresentationOrder: 0>
	^[composite text
		title: 'Mirror';
		display: [ (self basicClass classNameWithOrigin asString) ,' (',
				self asString , ')'
			];
		when: [ true ] ] on: Error do: [ 'NonClass Mirror (error while printing)' ]