gt-inspector-extension
gtInspectorIn: composite
	<gtInspectorPresentationOrder: 0>
	^composite text
		title: 'NonClass Mirror';
		display: [ self asString ,' (',
				(self basicClass className) asString , ')'
			];
		when: [ true ] 